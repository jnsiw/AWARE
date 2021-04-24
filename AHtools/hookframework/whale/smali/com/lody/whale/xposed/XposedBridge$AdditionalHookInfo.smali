.class final Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;
.super Ljava/lang/Object;
.source "XposedBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lody/whale/xposed/XposedBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "AdditionalHookInfo"
.end annotation


# instance fields
.field final callbacks:Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<",
            "Lcom/lody/whale/xposed/XC_MethodHook;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<",
            "Lcom/lody/whale/xposed/XC_MethodHook;",
            ">;)V"
        }
    .end annotation

    .line 342
    .local p1, "callbacks":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<Lcom/lody/whale/xposed/XC_MethodHook;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 343
    iput-object p1, p0, Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;->callbacks:Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;

    .line 344
    return-void
.end method
