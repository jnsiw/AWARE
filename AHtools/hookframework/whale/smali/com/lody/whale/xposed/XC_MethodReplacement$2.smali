.class final Lcom/lody/whale/xposed/XC_MethodReplacement$2;
.super Lcom/lody/whale/xposed/XC_MethodReplacement;
.source "XC_MethodReplacement.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lody/whale/xposed/XC_MethodReplacement;->returnConstant(ILjava/lang/Object;)Lcom/lody/whale/xposed/XC_MethodReplacement;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$result:Ljava/lang/Object;


# direct methods
.method constructor <init>(ILjava/lang/Object;)V
    .locals 0
    .param p1, "priority"    # I

    .line 81
    iput-object p2, p0, Lcom/lody/whale/xposed/XC_MethodReplacement$2;->val$result:Ljava/lang/Object;

    invoke-direct {p0, p1}, Lcom/lody/whale/xposed/XC_MethodReplacement;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected replaceHookedMethod(Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;)Ljava/lang/Object;
    .locals 1
    .param p1, "param"    # Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 84
    iget-object v0, p0, Lcom/lody/whale/xposed/XC_MethodReplacement$2;->val$result:Ljava/lang/Object;

    return-object v0
.end method
