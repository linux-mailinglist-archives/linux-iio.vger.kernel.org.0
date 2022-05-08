Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB251EFC7
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiEHTQx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbiEHRxP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:53:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF9DFC5
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FE7EB80E3D
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB7C385A4;
        Sun,  8 May 2022 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032161;
        bh=y6gFQ9PnCZtZ9MTi3H6R5+HUma80eEm383aXmVIpIZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkz4n2fOfQFmb3ypskupUhDKhKSqM3mME8X4/TQuzIz5vrLzgl4lKQOmcRhM0+JrZ
         itJIUWZToUvGKweRHCluLW00Db8YybrAFyteoWubmfy6ujQD0uKDtiISdSBAslS8H6
         NlxT4Ji2xm4fcHP6Wdjzd6I6iMPHEfbNPZgTdKYKrdI8kdvPM2dG/8sml2no57BtF1
         Kh0q/ca6Tbu/i9F//N8CRZEPz2bMewZMLmoRQYGJDbRfneNmnJhERBj2ng57nHlopl
         DwaIbaHv/VA4sqGBHqTTCAR2Wf+JPZEqaXHEntaKXufmZGTeqsDh8Po+yEOS0vaG+T
         N4noRYuDGWO6w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Lazar <alazar@startmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/92] iio: core: Fix IIO_ALIGN and rename as it was not sufficiently large
Date:   Sun,  8 May 2022 18:55:41 +0100
Message-Id: <20220508175712.647246-2-jic23@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508175712.647246-1-jic23@kernel.org>
References: <20220508175712.647246-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Discussion of the series:
https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.com/
mm, arm64: Reduce ARCH_KMALLOC_MINALIGN brought to my attention that
our current IIO usage of L1CACHE_ALIGN is insufficient as their are Arm
platforms out their with non coherent DMA and larger cache lines at
at higher levels of their cache hierarchy.

Rename the define to make it's purpose more explicit. It will be used
much more widely going forwards (to replace incorrect ____cacheline_aligned
markings.

Note this patch will greatly reduce the padding on some architectures
that have smaller requirements for DMA safe buffers.

The history of changing values of ARCH_KMALLOC_MINALIGN via
ARCH_DMA_MINALIGN on arm64 is rather complex. I'm not tagging this
as fixing a particular patch from that route as it's not clear what to tag.

Most recently a change to bring them back inline was reverted because
of some Qualcomm Kryo cores with an L2 cache with 128-byte lines
sitting above the point of coherency.

c1132702c71f Revert "arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES)"
That reverts:
65688d2a05de arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES) which
refers to the change originally being motivated by Thunder x1 performance
rather than correctness.

Fixes: 6f7c8ee585e9d ("staging:iio: Add ability to allocate private data space to iio_allocate_device")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c   |  7 ++++---
 drivers/iio/industrialio-core.c |  4 ++--
 include/linux/iio/iio.h         | 10 ++++++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index a73e3c2d212f..099be9d47223 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -84,7 +84,8 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
 {
 	struct adi_axi_adc_client *cl = conv_to_client(conv);
 
-	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
+	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client),
+				  IIO_DMA_MINALIGN);
 }
 EXPORT_SYMBOL_GPL(adi_axi_adc_conv_priv);
 
@@ -169,9 +170,9 @@ static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device *dev,
 	struct adi_axi_adc_client *cl;
 	size_t alloc_size;
 
-	alloc_size = ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
+	alloc_size = ALIGN(sizeof(struct adi_axi_adc_client), IIO_DMA_MINALIGN);
 	if (sizeof_priv)
-		alloc_size += ALIGN(sizeof_priv, IIO_ALIGN);
+		alloc_size += ALIGN(sizeof_priv, IIO_DMA_MINALIGN);
 
 	cl = kzalloc(alloc_size, GFP_KERNEL);
 	if (!cl)
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..b4218f3b1ac2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1640,7 +1640,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 
 	alloc_size = sizeof(struct iio_dev_opaque);
 	if (sizeof_priv) {
-		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
+		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
 		alloc_size += sizeof_priv;
 	}
 
@@ -1650,7 +1650,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 
 	indio_dev = &iio_dev_opaque->indio_dev;
 	indio_dev->priv = (char *)iio_dev_opaque +
-		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
+		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index faf00f2c0be6..c4ce02293f1f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/slab.h>
 #include <linux/iio/types.h>
 #include <linux/of.h>
 /* IIO TODO LIST */
@@ -657,8 +658,13 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
 	return dev_get_drvdata(&indio_dev->dev);
 }
 
-/* Can we make this smaller? */
-#define IIO_ALIGN L1_CACHE_BYTES
+/*
+ * Used to ensure the iio_priv() structure is aligned to allow that structure
+ * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
+ * must not share  cachelines with the rest of the structure, thus making
+ * them safe for use with non-coherent DMA.
+ */
+#define IIO_DMA_MINALIGN ARCH_KMALLOC_MINALIGN
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */
-- 
2.36.0

