Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BFC31BCDC
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBOPgu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 10:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhBOPfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 10:35:34 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902ECC061756
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 07:34:53 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c17so7220589ljn.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31Y+I//K5ayX8H8MCoVpsMUacRcgrZni1f1e2zl4UT4=;
        b=INz+DyDG3I20U0MGlbdf3KoRb/6XE+qu3w5060tX/Br4tPgtUVTBii30p9lqXFiVoZ
         tCHm0EWIqzaUTY5lZqVkx04WuNTITc4d1ASMYUj5y3Ots5X3BdyiWukUDOgzXqkmG5y0
         jrmJ4LpVy0oxaFZppOCPf79W3rz41HKbZ1FMHQvIPyrKybthRQQ78fXaY21JptwN9mrE
         Yoi5dLjBgYsc5MDQo+P3T3j5QUVKsVTVLq+nx+MHRjmEYJ0dpCG5JHz62mFdfiBKEeBR
         yrcYIN/8LYuve+3VmCAeYgGql2Jpy9kgR9XNZodyGRC0int4wRJ1CxI4F1ydldK46Mc7
         7I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31Y+I//K5ayX8H8MCoVpsMUacRcgrZni1f1e2zl4UT4=;
        b=fHPKzm0sthGi51g11u6HpGLxmzzCcjVjibbmQcik3MlRkglY0JEPHZCHjGZMV2OK6+
         2O0u8BoxESj4IlwgXUE2cqAT4cdfxsJpXk9Lv9XT/2WcmKMfqIdZdylKiAyKZRCmuv3W
         p+FEzf6VFKTXfPQ3S6fjCdUTIQrxRW5D481jElak88NX0+IVdBMEI6aXCKqJrQz2Pu+/
         Nenxi2RptQrXG4iEPUNlPPlQELBDa3tLmTxJbdbE7JGY22MVjofdDKeQpbmIl2jhTxhK
         pBfB3crEfJ+6dVC+fj0KBPZfArlAmH/lQsX7j3fwDOR6VZFRoSa0qBLXVk4jZeAgS4Vo
         XyqQ==
X-Gm-Message-State: AOAM5320V1vJRCAA8kaCm1Lzxddd1C+Rh+652u21CL3nSRfT3WnNJlVm
        iq2L7b84mtg8q6ZmIw0K3yGvwCR5msCazNsP
X-Google-Smtp-Source: ABdhPJwwE4W+aH2QMdMwQ5SkAoIRa4DGOIFV/IZUHcmtpQaK1bDaW/dOh33aHSesqhUYaqqLFTFz/w==
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr9818397ljl.53.1613403291924;
        Mon, 15 Feb 2021 07:34:51 -0800 (PST)
Received: from genomnajs.publikt.skane.se (host-78-76-89-148.homerun.telia.com. [78.76.89.148])
        by smtp.gmail.com with ESMTPSA id y25sm228846lfg.259.2021.02.15.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:34:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Gene Chen <gene_chen@richtek.com>,
        Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] iio: adc: mt6360: Include right header
Date:   Mon, 15 Feb 2021 16:34:47 +0100
Message-Id: <20210215153447.48457-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To get access to the big endian byte order parsing helpers
drivers need to include <asm/unaligned.h> and nothing else.

Cc: Gene Chen <gene_chen@richtek.com>
Suggested-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/mt6360-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index f57db3056fbe..6b39a139ce28 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -9,13 +9,14 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/unaligned/be_byteshift.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <asm/unaligned.h>
+
 #define MT6360_REG_PMUCHGCTRL3	0x313
 #define MT6360_REG_PMUADCCFG	0x356
 #define MT6360_REG_PMUADCIDLET	0x358
-- 
2.29.2

