.class public abstract Lcom/lody/whale/xposed/callbacks/XCallback;
.super Ljava/lang/Object;
.source "XCallback.java"

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lody/whale/xposed/callbacks/XCallback$Param;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lcom/lody/whale/xposed/callbacks/XCallback;",
        ">;"
    }
.end annotation


# static fields
.field public static final PRIORITY_DEFAULT:I = 0x32

.field public static final PRIORITY_HIGHEST:I = 0x2710

.field public static final PRIORITY_LOWEST:I = -0x2710


# instance fields
.field public final priority:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    const/16 v0, 0x32

    iput v0, p0, Lcom/lody/whale/xposed/callbacks/XCallback;->priority:I

    .line 31
    return-void
.end method

.method public constructor <init>(I)V
    .locals 0
    .param p1, "priority"    # I

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput p1, p0, Lcom/lody/whale/xposed/callbacks/XCallback;->priority:I

    .line 38
    return-void
.end method

.method public static callAll(Lcom/lody/whale/xposed/callbacks/XCallback$Param;)V
    .locals 2
    .param p0, "param"    # Lcom/lody/whale/xposed/callbacks/XCallback$Param;

    .line 104
    iget-object v0, p0, Lcom/lody/whale/xposed/callbacks/XCallback$Param;->callbacks:[Ljava/lang/Object;

    if-eqz v0, :cond_1

    .line 107
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/lody/whale/xposed/callbacks/XCallback$Param;->callbacks:[Ljava/lang/Object;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    .line 109
    :try_start_0
    iget-object v1, p0, Lcom/lody/whale/xposed/callbacks/XCallback$Param;->callbacks:[Ljava/lang/Object;

    aget-object v1, v1, v0

    check-cast v1, Lcom/lody/whale/xposed/callbacks/XCallback;

    invoke-virtual {v1, p0}, Lcom/lody/whale/xposed/callbacks/XCallback;->call(Lcom/lody/whale/xposed/callbacks/XCallback$Param;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 112
    goto :goto_1

    .line 110
    :catch_0
    move-exception v1

    .line 107
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 114
    .end local v0    # "i":I
    :cond_0
    return-void

    .line 105
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "This object was not created for use with callAll"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    return-void
.end method


# virtual methods
.method protected call(Lcom/lody/whale/xposed/callbacks/XCallback$Param;)V
    .locals 0
    .param p1, "param"    # Lcom/lody/whale/xposed/callbacks/XCallback$Param;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 120
    return-void
.end method

.method public compareTo(Lcom/lody/whale/xposed/callbacks/XCallback;)I
    .locals 2
    .param p1, "other"    # Lcom/lody/whale/xposed/callbacks/XCallback;

    .line 127
    if-ne p0, p1, :cond_0

    .line 128
    const/4 v0, 0x0

    return v0

    .line 131
    :cond_0
    iget v0, p1, Lcom/lody/whale/xposed/callbacks/XCallback;->priority:I

    iget v1, p0, Lcom/lody/whale/xposed/callbacks/XCallback;->priority:I

    if-eq v0, v1, :cond_1

    .line 132
    sub-int/2addr v0, v1

    return v0

    .line 134
    :cond_1
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v0

    invoke-static {p1}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v1

    if-ge v0, v1, :cond_2

    .line 135
    const/4 v0, -0x1

    return v0

    .line 137
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    .line 14
    check-cast p1, Lcom/lody/whale/xposed/callbacks/XCallback;

    invoke-virtual {p0, p1}, Lcom/lody/whale/xposed/callbacks/XCallback;->compareTo(Lcom/lody/whale/xposed/callbacks/XCallback;)I

    move-result p1

    return p1
.end method
