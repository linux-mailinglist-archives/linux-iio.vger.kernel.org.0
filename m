Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0547E224127
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGQQ4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGQQ4B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABDAC0619D5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so11926828wrp.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0NdwY9SbjwHcTXsovlQ3v7LbQPLWjEb4KHf8LUGjbY=;
        b=sOXt9VbPlc5N0UZ4A4vCRWgtuBbT/N0Cs1uY6oUQWBDzdCPYc9I3EUBsJ95AWLQQsu
         GbjmozZBJ4upGfnc1kkJk2MjNUqZU2a1ffzF8z/w2Fs+iuvoyVfBx+Gx+qdGqhT2LAQA
         mxZPTYpRDMTmJMnqhoJVNVqXJ0dwiQ8FZ4b3GmnGn2To1L2WMslwLpjP7IZ9VbghGxqa
         gzzBN1Diq5Epf+1OTF3zOHVeiq85oExuTc8CfHdmBoNPC1IHwdipDyJ5qQMHDDguiCu4
         87MbEySCThUvuSCjBgDqYRBg0NXqbuPn8MdGHj/va7T6rUxlxbrMwFxaj3TJDy7DkGaI
         5kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0NdwY9SbjwHcTXsovlQ3v7LbQPLWjEb4KHf8LUGjbY=;
        b=MKV9n6W4kj4TFQ65GDj4xnMJW8yzXY4Fy8wKoetRx8CM33DkjMM94MywXvnnbxW1S5
         edhCV5eQq87rRVVidXqZBsQmNhr38P7Dboupozk5DV8cW53Yi5IAHZ8DBzthtdJAnEvx
         HiV8qQL1/k9e7gtpigMs/tTPD2Q2Lzirm0++K7+qNhGEzB7QjedaKDZOo86N+0YXqsaw
         +OyXb/EfrFB6r+s+Fb4fNgvSaUFAbNx/iATC4wGerGCFON0ROmttcWRzu2LP6oDkxOrB
         y+Zut/Ltz7VJGM/ROVrD9d9Y14Df9X5msrYlw5xHDhNvXcCoY+oS40dzI99ukc5NV0oi
         T2IA==
X-Gm-Message-State: AOAM531GURf9E2O+BPm0bR26A6Zj4S/K3hhWIE3sjwXYBnC8/3CeCDv6
        A35VM/isdb7XeQxlrAkHRXVWdQ==
X-Google-Smtp-Source: ABdhPJwgRPbtjNyvrRZZorKrXJsoK0TE02TWb6iUUdarbMSRUJWwlu4GZ6e7rfb/OwhWQRKDjbkOFg==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr12302586wru.158.1595004959310;
        Fri, 17 Jul 2020 09:55:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:55:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rachna Patil <rachna@ti.com>
Subject: [PATCH 01/30] iio: adc: ti_am335x_adc: Remove a couple of unused 'read' variables
Date:   Fri, 17 Jul 2020 17:55:09 +0100
Message-Id: <20200717165538.3275050-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ti_am335x_adc.c: In function ‘tiadc_buffer_preenable’:
 drivers/iio/adc/ti_am335x_adc.c:297:21: warning: variable ‘read’ set but not used [-Wunused-but-set-variable]
 297 | int i, fifo1count, read;
 | ^~~~
 drivers/iio/adc/ti_am335x_adc.c: In function ‘tiadc_buffer_predisable’:
 drivers/iio/adc/ti_am335x_adc.c:346:21: warning: variable ‘read’ set but not used [-Wunused-but-set-variable]
 346 | int fifo1count, i, read;
 | ^~~~

Cc: Rachna Patil <rachna@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ti_am335x_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9d984f2a8ba74..93b67bb165044 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -294,7 +294,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
 static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	int i, fifo1count, read;
+	int i, fifo1count;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN |
@@ -303,7 +303,7 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 	/* Flush FIFO. Needed in corner cases in simultaneous tsc/adc use */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++)
-		read = tiadc_readl(adc_dev, REG_FIFO1);
+		tiadc_readl(adc_dev, REG_FIFO1);
 
 	return 0;
 }
@@ -343,7 +343,7 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	struct tiadc_dma *dma = &adc_dev->dma;
-	int fifo1count, i, read;
+	int fifo1count, i;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
@@ -358,7 +358,7 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 	/* Flush FIFO of leftover data in the time it takes to disable adc */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++)
-		read = tiadc_readl(adc_dev, REG_FIFO1);
+		tiadc_readl(adc_dev, REG_FIFO1);
 
 	return 0;
 }
-- 
2.25.1

