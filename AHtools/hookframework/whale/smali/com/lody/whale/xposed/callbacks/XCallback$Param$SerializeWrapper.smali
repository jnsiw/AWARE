.class Lcom/lody/whale/xposed/callbacks/XCallback$Param$SerializeWrapper;
.super Ljava/lang/Object;
.source "XCallback.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lody/whale/xposed/callbacks/XCallback$Param;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SerializeWrapper"
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private final object:Ljava/lang/Object;


# direct methods
.method public constructor <init>(Ljava/lang/Object;)V
    .locals 0
    .param p1, "o"    # Ljava/lang/Object;

    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 95
    iput-object p1, p0, Lcom/lody/whale/xposed/callbacks/XCallback$Param$SerializeWrapper;->object:Ljava/lang/Object;

    .line 96
    return-void
.end method

.method static synthetic access$000(Lcom/lody/whale/xposed/callbacks/XCallback$Param$SerializeWrapper;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lody/whale/xposed/callbacks/XCallback$Param$SerializeWrapper;

    .line 90
    iget-object v0, p0, Lcom/lody/whale/xposed/callbacks/XCallback$Param$SerializeWrapper;->object:Ljava/lang/Object;

    return-object v0
.end method
