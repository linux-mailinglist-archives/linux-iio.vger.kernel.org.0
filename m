Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9274BD063
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiBTRav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:30:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiBTRau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:30:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3F2409F
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8435D60DBD
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED58C340E8;
        Sun, 20 Feb 2022 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378227;
        bh=wcHGt1/LHv6o5CFq7y7XtM3s3M/b3Ka0IIiyEcKD5yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctaEGgpEc70gWzTxDzxiJU3A/XcJTSbrxczKf8wPtsiCuqejS8G13txV7Fm4Hc9Mm
         /FANGwmjEKXuaX74nI/T+5Fy24K4gSQlVxuqAvQvN/wi7qf8IVrCuuhLjQrXgEFbpr
         I1ZW6Nln4hzEt86BxnYsb/92yNe//mhIbavMZ74f6PDqSKsj9tioYWeFVTCaGHSpUS
         6aoGw+X97KTIXfZAslBoqI8pDvR1YrZpeMpqmx/mUabNBgyC5KiDIhWp36Ritwxv1F
         CrWHbZ0j2iWvygrP8FRgx3B9hnVqSAT14PA/MfcQIMWp351e2PUMENSsfHQhb6l/rJ
         0aihk53oKQl0w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 4/5] iio: adc: adi-axi: Move exported symbols into IIO_ADI_AXI namespace.
Date:   Sun, 20 Feb 2022 17:37:00 +0000
Message-Id: <20220220173701.502331-5-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220173701.502331-1-jic23@kernel.org>
References: <20220220173701.502331-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c      | 1 +
 drivers/iio/adc/adi-axi-adc.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index dbfc8517cb8a..5a5f33f7bc8f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -474,3 +474,4 @@ module_spi_driver(ad9467_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ADI_AXI);
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index a73e3c2d212f..cf07d522925e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -86,7 +86,7 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
 
 	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
 }
-EXPORT_SYMBOL_GPL(adi_axi_adc_conv_priv);
+EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
 
 static void adi_axi_adc_write(struct adi_axi_adc_state *st,
 			      unsigned int reg,
@@ -224,7 +224,7 @@ struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
 
 	return conv;
 }
-EXPORT_SYMBOL_GPL(devm_adi_axi_adc_conv_register);
+EXPORT_SYMBOL_NS_GPL(devm_adi_axi_adc_conv_register, IIO_ADI_AXI);
 
 static ssize_t in_voltage_scale_available_show(struct device *dev,
 					       struct device_attribute *attr,
-- 
2.35.1

