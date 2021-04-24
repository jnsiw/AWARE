.class final Lcom/lody/whale/xposed/XposedHelpers$1;
.super Ljava/lang/ThreadLocal;
.source "XposedHelpers.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lody/whale/xposed/XposedHelpers;->getMethodDepthCounter(Ljava/lang/String;)Ljava/lang/ThreadLocal;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/ThreadLocal<",
        "Ljava/util/concurrent/atomic/AtomicInteger;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1760
    invoke-direct {p0}, Ljava/lang/ThreadLocal;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge synthetic initialValue()Ljava/lang/Object;
    .locals 1

    .line 1760
    invoke-virtual {p0}, Lcom/lody/whale/xposed/XposedHelpers$1;->initialValue()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v0

    return-object v0
.end method

.method protected initialValue()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    .line 1763
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    return-object v0
.end method
