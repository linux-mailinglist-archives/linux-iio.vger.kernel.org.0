Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22F640F20A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 08:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbhIQGNH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 02:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245122AbhIQGM7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 02:12:59 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A5C0613CF
        for <linux-iio@vger.kernel.org>; Thu, 16 Sep 2021 23:11:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so62998993qkd.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Sep 2021 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zwfeLGWcGDafTQfqNliurZp8teU/yYhkf3GW28JYz+0=;
        b=XM1DlrAUXX2ajvUBnMZhB99NjvFhfz+ZGq/7y3SKrZpGYit5SzYCLoZx+1fd1Pg2OM
         CE/DbVbB2zZOnd5RWwlYnvAIN/0FZuFvCYMAI3FUkH9+/WHs5czJ0XzDCRQOpbNttkDV
         rzNjCdkEp3wvo4sWkksIcRpcsW3Lpa4/N4OeJL02V5hrqG39IyQJLBkSwhLLcjvNJf1P
         J33Z8VNQpjjPrqBYeac07pb5MmLB0B8MJ5t+DBo6UEAJOnLuMozpyMAijqsFw2f6JbS1
         kjf8/RoduSl/18uPTMCiFBlHPGodsfgn0U2c6pVB8BmGNGic9LVrNxfbRPmKqI20Z1nX
         qACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zwfeLGWcGDafTQfqNliurZp8teU/yYhkf3GW28JYz+0=;
        b=FTUfCPNv9FjPtqBZZSMkNo+sDVz6SlSkBBUM0NGBrMBNH+DDGcIAYVDkW+thFPOQAq
         NMDP3ISEDH+DfQyYuVPE8COMwo7tLKMLss5GD4NKzntIPuygjjEBmqN4CbsubwunRSzl
         RwLB5drIFC/XkhG8xNufsyq/jUXfwCNLF5WkWcwV88lezwuG7iqPe0bgFtvYsu1IIqrn
         T1nOROO0ORFw04T7puGTCumkSfG6IJQqCq9Cn5V85BVOOqOvL2BYpTg93VDdKT0L28mE
         494CmbIZIwBrb0NdWwSN1a9aRRKf9SppyShCBSzepahO14ko6wXA643GDDZHsRWhB3bJ
         /+vA==
X-Gm-Message-State: AOAM532tYF30dGUohs+xl6NVf3rhsv48CShXnzUL0vl771wZv3/jk78C
        VPXJdDgObfz9SvKScPZLPyDVCb7O+XauE22HDk0ovQ==
X-Google-Smtp-Source: ABdhPJx6RzYNzo1jNBe3N3oA2ojvmyemjqyjcW1MLw7H9/OVIjCsIqeL5PNY5fZLW55/k0Aj9lw0rd78dTvNRFgK+Smr+Q==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:4655:: with SMTP id
 t82mr11189168yba.289.1631859096878; Thu, 16 Sep 2021 23:11:36 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:03 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 5/6] mmc: sdhci-of-aspeed: build kunit tests without
 structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit.

Turn it off.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/mmc/host/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 14004cc09aaad..2ab083931f8fd 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
 obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
+CFLAGS_sdhci-of-aspeed.o		+= $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
-- 
2.33.0.464.g1972c5931b-goog

