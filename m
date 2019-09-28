Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACC2C0F00
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2019 02:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfI1AfR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Sep 2019 20:35:17 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:4652 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI1AfR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Sep 2019 20:35:17 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 20:35:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569630915; x=1601166915;
  h=from:to:cc:subject:date:message-id;
  bh=TAaIQrNrlHpHXTlhnOmvtGHU4z3it1xGbWOJk5Kgq0s=;
  b=DPVX64slK41d20rEYKGNY2WKjwGNP0Fg/NQAJxj1+vUXx98PZGpXDHmv
   uDMj3NS614j4loqf8oxKoGbD1Y/jGj6HwMCgbZK/wiYdl5kNP0SyDcFhA
   hbyIqmnHigcE9QHl8L13q3FMb+hdk56cobZhIwQFFJSkI5onD4En8smmy
   0nIVOEBOR/UDYfhpo1EskJBaKfTLKDnc3X3xWHC3lb/184RuGYY73Dalu
   ZXfNgKiqKxok0umMkETMTRUMrB7d3IbGKuxJx6OiQECwDR4z9IwCsNseZ
   Eoq4cmE0cxplAVoL0DMs6l2HJi5RKqcN1i0PF7smKbAuqpQwr/V9ZsY8f
   A==;
IronPort-SDR: 6nCXp6EivM6FmnfQ82wxTWgRsSsjLBPQjvVlEpe33ntDD9uW+qoER5i5lZ98zoa5vrdmMa4dMC
 Vn3SR7WfyBwqthaGbVDAx4FJSqno5Ia8xrSkhrifSpUbAluUVtYVsDYt5nwWJkC/h6nCh8KGYO
 mwvHBLOzxuw3yqmwUEojWbJZT/yUUuHtct/KHLQ4KGzVpUpLYqVT9eabI1PZ/hBcFBaTd75zwE
 +dE5WD+enHvCkuvZ3LAMkfxhXT7OxpsN5CHpyUGSk8jm7rdubVacxjGznuraH+VAdRkMiRloTT
 vA4=
IronPort-PHdr: =?us-ascii?q?9a23=3A98l4ZRVApDDcoVmj/LThRoso+QPV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxyCt8tkgFKBZ4jH8fUM07OQ7/m7Hzdfqs3Y+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLuMQbg4RuJ6gsxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipEAoO9dIsPFOsBPeBXr4LguVUAtAa1BQetBOzxzj9Hm2L90ak03u?=
 =?us-ascii?q?g9FA3L2hErEdATv3TOtNj7NLkcX/27wqfLyjvOdO9a1Svn5YTUaB0tve2AUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02SpozkPjKV1vkNs2+G5OdnVeOuim4npBtwojSz2sshhJ?=
 =?us-ascii?q?LEhp8JxVDe7yl23ps6JcChRUN9fNWqE4NQujmEO4dqRs4uWWJltSYgxrEYpJ?=
 =?us-ascii?q?K2czIGxIkjyhPcc/CLbomF7xb5WOqPLzp1hGhpdKy+ihqo80WtxevxXdSu3l?=
 =?us-ascii?q?lQtCpKiNzMu2gI1xzU98eIVONw/lyk2TaTzwDT7fxEIVwsmarbNZEhxrkwm4?=
 =?us-ascii?q?IWsUvZHy/2nFz6jLeSdkk54+So5fnrb7Hlq5OGOI90jQb+MqsqmsOhG+g3Lg?=
 =?us-ascii?q?8OX22D9eS90r3s41H5Ta1UgvEqlqTVqpPXKMQBqqKnHgNY3Zwv5wu7AjqlyN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLej4DPa+g1SjijZry+zaMrDvGZjNM2TMkK37cb?=
 =?us-ascii?q?lj9kFc1RI/zcpD6JJMFrEBPPXzV1f1tNzZCB85LgO1z//mCNV80YMTQnyPAq?=
 =?us-ascii?q?CHP6PIq1OI5fwgI/OKZIALvDbxMf8l5+ThjSxxt0UaePyY3IkXdXfwSuV0I0?=
 =?us-ascii?q?yYOSK3qsoKCyEHshdoH7+is0GLTTMGPyX6ZKk7/DxuTd3+AA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EtBwAiqI5dh8bWVdFmhXxMEI0ehXJ?=
 =?us-ascii?q?RAQEGiyYYcYV6iiwBCAEBAQwBAS0CAQGEQIM6IzgTAgMJAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhShLoEDPIwlM4h?=
 =?us-ascii?q?xAQkNgUgJAQiBIoc1hFmBEIEHg25zh2OCRASBLwEBAY1whyuWSQEGAoIQFIF?=
 =?us-ascii?q?4kwcnhDmJO4s/AS2KKJxqAgoHBg8jgUaBek0lgWwKgURQEBSBWg4JFY4tITO?=
 =?us-ascii?q?BCI49AQ?=
X-IPAS-Result: =?us-ascii?q?A2EtBwAiqI5dh8bWVdFmhXxMEI0ehXJRAQEGiyYYcYV6i?=
 =?us-ascii?q?iwBCAEBAQwBAS0CAQGEQIM6IzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIK?=
 =?us-ascii?q?YVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhShLoEDPIwlM4hxAQkNgUgJAQiBI?=
 =?us-ascii?q?oc1hFmBEIEHg25zh2OCRASBLwEBAY1whyuWSQEGAoIQFIF4kwcnhDmJO4s/A?=
 =?us-ascii?q?S2KKJxqAgoHBg8jgUaBek0lgWwKgURQEBSBWg4JFY4tITOBCI49AQ?=
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="10651194"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2019 17:28:11 -0700
Received: by mail-pl1-f198.google.com with SMTP id q5so2615825pls.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Sep 2019 17:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5TzNbCB6im2bWtNvAjp9ds0IpKiNbjs0dzM5n1GDW5Y=;
        b=hu9htt2EdsMOH1h/9+mCE+ztOfuSwYdbito5KKZHv14Kuy9PLDTuYUzgZ1pDJ049oA
         LWN6SAtdIfPMgF0Fh0hgfA2hCxQrzRYvv2s39nhHASYKe5/aRHIFiXMI0N55pRgv3/n/
         bUpKjJvv5+TEzr9nleFLR39sT6G8GpT7OR7axLie9dHxl1akD8hVR3ZxHPB8g8Evnf48
         FbUDXYQRdp1lcmiI8L9uF7ZXz/cXrWVCS5lZdt+D/hXBNbi/cw01TTYjJT7H74tykWGw
         x/eDkHqWsnAdYfyQg30V0KXhR/THK3uDqePr69f9tuPLag3DU0uAOYYfgzF4njT+rO7j
         OFYg==
X-Gm-Message-State: APjAAAVKEXUgk4sIOqhfko4h8lITjJr939ZUn5aw7PG31zlWUt00dbU+
        vAnpXY/i90PhHhRMR92mVXmHbxVTwmJKyaR5RhoI3Qyrl6f+CleM4JiKeKWG+45fPb/q7lBYAbm
        hclB3ff4Rz//FG8FmjNJBbQ==
X-Received: by 2002:aa7:9794:: with SMTP id o20mr7869531pfp.8.1569630489410;
        Fri, 27 Sep 2019 17:28:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZO38LKJW4wkfyAvREDNgDGgsGnvGUuysM1wKez8wkjAb6Ao/r93FnGs/LBCi1PNvs9qnNnw==
X-Received: by 2002:aa7:9794:: with SMTP id o20mr7869510pfp.8.1569630489164;
        Fri, 27 Sep 2019 17:28:09 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id z25sm3612636pfn.7.2019.09.27.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:28:08 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: imx25-gcq: Variable could be uninitialized if regmap_read() fails
Date:   Fri, 27 Sep 2019 17:28:51 -0700
Message-Id: <20190928002852.28329-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function mx25_gcq_irq(), local variable "stats" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement, which is
potentially unsafe. The same case applied to the variable
"data" in function mx25_gcq_get_raw_value() in the same file.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index df19ecae52f7..dbf3e8e85aba 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -74,7 +74,10 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
 	struct mx25_gcq_priv *priv = data;
 	u32 stats;
 
-	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+	int ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+
+	if (ret)
+		return ret;
 
 	if (stats & MX25_ADCQ_SR_EOQ) {
 		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
@@ -121,7 +124,10 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 		return -ETIMEDOUT;
 	}
 
-	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	int ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+
+	if (ret)
+		return ret;
 
 	*val = MX25_ADCQ_FIFO_DATA(data);
 
-- 
2.17.1

