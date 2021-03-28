Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A334BF6C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 23:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhC1Vqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhC1VqI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 17:46:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957AAC061756;
        Sun, 28 Mar 2021 14:46:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q26so10739498qkm.6;
        Sun, 28 Mar 2021 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nurCGhllYuU/wCSSD1tx5ENa5/ZM3WiCimEU92yo5mA=;
        b=NAsqRwYWvgsABxBVaWknl63rKOMQqBiR8K7ofw0h2qPS+yz18qJFuUtsnSidaK5QNm
         JRz3HpuX9B5uoe8vtBSKqIrK/tnXi4Lw6FtflfTLU21clyqD3xFi0+Go37Pb6pPLxFEX
         ipCA+WYoxIPSb3JvAK0Fcqsvk07552gHOyEfhZwwMVxXQYXxDAJ+yy7PSp/ab6OulKvt
         /kwvCQxgxysZFbRfjxP670V03q2adNEUpNqYnuXowEPczdElwUstSN2DnLqhZL9Do/u6
         X0AzxbXXLmNVDikdj+PNEXmJvqlAC+VyvTZ0wojyAV/GbXRO1qPP09b14EsKaosGT49j
         BSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nurCGhllYuU/wCSSD1tx5ENa5/ZM3WiCimEU92yo5mA=;
        b=VkuJNcDNt0HRbYzP+3DFw5ng+N6zTb3S6JmR0XjS3VpmCNVOo5LHWRJYp8+bKktEqU
         td1904iyF2XU2cXmpYseyzxn9zGNni3yQZ7ECUm72iQr2crLT+PX6uj5nUi9xl13Vr1v
         NtBM6LBCgqqaTy585fUMP1/3D/vIgyAfdtWeP4DtwSVHzn44fyEi1JJ4C6bLrkgqV4db
         I1RzqwXPgWS2/xP8pXfJqTGgeCKfqt3+Nu0U6/TARJhTPhqn8OueWIE54W9OBpPOQzB6
         AOP7EOylBSZh+Gmbr+vANNuDQoClVB6NrK/T2F6ls6BIxhlGrOjcymT0D0l2QO0QYm0J
         2KYA==
X-Gm-Message-State: AOAM531dTKiYG+63fhRuuhL7/G5dtZT5xU5LFTuMQ0XJfBrxtarqmJeD
        9MbcHslOp6ak0xxN60h76/A=
X-Google-Smtp-Source: ABdhPJztGz3eBXrpwtqxwqZlQF0fcu+NAN8yfih3FTT+DyKio26a6WhovXfDFoRE2b9S7J5yU1YtGQ==
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr23173651qkl.469.1616967967950;
        Sun, 28 Mar 2021 14:46:07 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9e91::1002])
        by smtp.gmail.com with ESMTPSA id h8sm9680692qta.53.2021.03.28.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 14:46:07 -0700 (PDT)
Date:   Sun, 28 Mar 2021 18:46:04 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: ad7923: use devm_add_action_or_reset for
 regulator disable
Message-ID: <49a7c0436ca1186313dbccf3d810d0cf38cb5b37.1616966903.git.lucas.p.stankus@gmail.com>
References: <cover.1616966903.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616966903.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds a device-managed action to handle disabling the driver's regulator on
device detach.
This slightly simplifies deinitialization and enables further conversion of
the driver to device-managed routines without breaking the init order.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/iio/adc/ad7923.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index a2cc96658054..3418ef6f0857 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -293,6 +293,13 @@ static const struct iio_info ad7923_info = {
 	.update_scan_mode = ad7923_update_scan_mode,
 };
 
+static void ad7923_regulator_disable(void *data)
+{
+	struct ad7923_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
 static int ad7923_probe(struct spi_device *spi)
 {
 	struct ad7923_state *st;
@@ -340,10 +347,14 @@ static int ad7923_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7923_regulator_disable, st);
+	if (ret)
+		return ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 &ad7923_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -353,20 +364,15 @@ static int ad7923_probe(struct spi_device *spi)
 
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
 	return ret;
 }
 
 static int ad7923_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7923_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(st->reg);
 
 	return 0;
 }
-- 
2.31.0

