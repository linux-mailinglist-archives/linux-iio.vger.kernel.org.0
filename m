Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2644D34C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKInA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 03:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhKKIm5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 03:42:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB2C061766;
        Thu, 11 Nov 2021 00:40:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso5050559wmc.1;
        Thu, 11 Nov 2021 00:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sro5Y/3s4g8TJZzu3tk5+VEVjcf6f41NnmBfPjhYcdQ=;
        b=I+GUAZM4GQa/4pokPJE83280WPe1Ib6qb7ea9R6YJGxsLt+HiuJBSxV+ZI6Z81niYa
         247nHD2EgHLxcwe8Jj+pAcn7EdmqrDKZ0B+YOsGed0QtrJbrtZNPHy25oiwFvemwgDdT
         sKXH9IzplNPgL86vSgBb/4KGIey9wx9WLV6wIOz2oJpOZRusZNG0NWxkHdCp+97d3ypw
         OAbJ+gSi+tWupmKmUJaIOlTU914g17F8YSAx340FLCWdu0gk6WtO+gz0+icI5CBJA0eT
         Qt47Cdb/H73i38QWaybfNfkto++i4Ts7wToZWeSIqol4auS2Xdnvz0rgUVF9NlMwmZko
         TM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sro5Y/3s4g8TJZzu3tk5+VEVjcf6f41NnmBfPjhYcdQ=;
        b=WwBDMloHf+VWvy7fy2nf0xI7IJt37bjLM2Q5P8Z1/cNnzRXczOG7TYONvXuaEMw/sk
         LpbyHiVXJ+oln8uqVYzqXwr4AF5Ac/OjBE14Q+bo37BfadsMTSRJf3d5N8ivG6g1Xo0s
         tlhMFjNygQWwSe0IYvpmksghUCYSkdO3FJBY96EeNDVwLV1hr0/ub6MUEQL7253Xwe+V
         v3RZ/ORk5unc5/WfVynDfgW7VPUJ1PtnEWP6reVtcQijQtI67ugKrKcIlzZCDc1CdJWU
         0f83/OBLAK9FTpR1ihHfAMcOTejaxU9mKwCYrhLA0IS0lA0WRjO9J/IEkPX9yFx0/1Z/
         MVVA==
X-Gm-Message-State: AOAM5317gktW8IldxL9cPkA01QwuRPcYfaaSm94za3GArcud8UCoEsWL
        D91522OuH3kU7+IB/bR+J3s=
X-Google-Smtp-Source: ABdhPJxlFBxkUkWwaD+Bzflmms6wZ+6KQGQE9buzNyHJKnNy+I9rjjQwPi4d/GIujAwierG/1xVCiA==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr10982902wmc.187.1636620006925;
        Thu, 11 Nov 2021 00:40:06 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id l5sm2731027wrs.59.2021.11.11.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:40:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] iio: imx8qxp-adc: fix dependency to the intended ARCH_MXC config
Date:   Thu, 11 Nov 2021 09:39:54 +0100
Message-Id: <20211111083954.6286-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP
ADC") adds the config IMX8QXP_ADC for this new driver, which depends on
the non-existing config ARCH_MXC_ARM64.

Hence, ./scripts/checkkconfigsymbols.py warns:

  ARCH_MXC_ARM64
  Referencing files: drivers/iio/adc/Kconfig

Probably, the existing config ARCH_MXC is intended to be referred here.
So, repair the dependency to refer to that config.

Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8bf5b62a73f4..3363af15a43f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -532,7 +532,7 @@ config IMX7D_ADC
 
 config IMX8QXP_ADC
 	tristate "NXP IMX8QXP ADC driver"
-	depends on ARCH_MXC_ARM64 || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Say yes here to build support for IMX8QXP ADC.
-- 
2.26.2

