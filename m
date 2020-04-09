Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770A31A359E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgDIOOQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 10:14:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35405 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgDIOOQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 10:14:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id c12so3884416plz.2;
        Thu, 09 Apr 2020 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uI5Y7Iz6wEdm5rxqvMay0aecrVsycJlfiKALlRK1TEY=;
        b=DOQ42rXPfTNch2EjG+zaAiC7Z4dYLn+EmfLBr0Br2LYseg2VIUP6RIgbsVqoyNc1Yp
         +RFegdSut8BIZPelJWPF/9PNZzfYSWC3bd9ivsnI8Ma0LjI3MrccBYARLmFSZncP7jEy
         oV2XSnO+AsJGgsZo7+1AdWaanMxTbzfeVEXPfckFTH4/ohQRAqrhEyujmPS72LuFrd+Z
         2fdDnZ79A4AW3ZK7ViAab0wNqsJhNHf1LXRhAm5ibCz+jNJnFGKj8NN6zvGq2prA8gzB
         F80kzViXZwTOuvoAn+kVKU5aa8Iy5ovUw3R4QVTJXbke/nZXT2Fw2F3H3CvdeLnbUd7A
         xVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uI5Y7Iz6wEdm5rxqvMay0aecrVsycJlfiKALlRK1TEY=;
        b=H5wYGFCC7wIthAKIse5FIWcr/vP25OCdNklaeW55VFWj+OjJyUDwvoWiAzcOj4+K/h
         XaF7roTiOSSX6H6QCJXcb04Tl7TNmVMrZRkObnqgCBK2/PbLPAGWN7KKhY471rHRT7GO
         77xsCO/aMp0L4il9dhjZWtRXzrHaL5D2NMX5FcioqgfGmxxEkWZQe8u4sq4sOqGyjicS
         bsdl1XcdhlRnrinPn1yX09XsM1MaOgWvZok60A9n4gIUk8Pn37S5IK5/UVANyVTNiGlL
         +CYyylF8dVPaKtG33y6R3kGKFr8YBElvw7hTiu1nYyPKa53EhVD7DpnhFSwlSZqqP4uK
         nppw==
X-Gm-Message-State: AGi0PuZXxmBMfS8PMHGmOf8yV418Nl1o/9lXZ+5fLI7R3iiIReHSusgF
        mfcxLA5/MZWF3egzDWFzpFo=
X-Google-Smtp-Source: APiQypL7mQ0rjhq7MJ8igG0FzbTjMHziSp4qVWjwRDmloGrVOGwRZhiAOXJzZTtsK53nMr4lTDoGKA==
X-Received: by 2002:a17:90a:2489:: with SMTP id i9mr11116184pje.183.1586441655752;
        Thu, 09 Apr 2020 07:14:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:700:a20f:d50:b01b:c4e4:35ad])
        by smtp.gmail.com with ESMTPSA id j4sm1285354pjy.34.2020.04.09.07.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 07:14:14 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
Cc:     aishwaryarj100@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: Use devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 19:43:30 +0530
Message-Id: <20200409141331.30882-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the helper function that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 176e1cb4abb1..0f2c1738a90d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -496,7 +496,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 				struct iio_dev *indio_dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
-	struct resource *mem;
 	void __iomem *base;
 	int ret;
 
@@ -508,8 +507,7 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
 	indio_dev->channels = sun8i_a33_gpadc_channels;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mem);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.17.1

