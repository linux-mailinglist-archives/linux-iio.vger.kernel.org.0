Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187E51801A
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiECIz2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECIz1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A921817
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B46276128D
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F185C385B1;
        Tue,  3 May 2022 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651567914;
        bh=h9r3d73XPxk1oBrIlOcP2R/gKealCiOCT99s4IAnug8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGSH71V2F/Ojvca6Mqn9fsuzqBNse1L38CnWZ4/LOYjLPqCWnDNO0PBIpH7udadpa
         nLmfo7XfoKfG99ooamnA013ovSrJR+Y9t3RplahO3IegR+jzPVUnmK6Nji1UcJlXQp
         BO2wQLrllx54q4zlh6V+jolAwWkGPBfEtJ3WftKLO+hfRuSOZ85t+V2hnbOe98y97G
         BsRVi13H2w4ZY4WyS5F+g3FAIGVeE/R78qN8qBiTOxi+gVfoqSFuku+ghoN/epxiuP
         5uPNcrlPeUREeF2Iimc2i8aS+wKWWQZwRXELjOw9JBQ16PyCc6VZUTor5YEMi7nuW2
         57+ZYv3hUi55Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
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
Subject: [PATCH 01/92] iio: core: Fix IIO_ALIGN as it was not sufficiently large on some platforms.
Date:   Tue,  3 May 2022 09:58:04 +0100
Message-Id: <20220503085935.1533814-2-jic23@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503085935.1533814-1-jic23@kernel.org>
References: <20220503085935.1533814-1-jic23@kernel.org>
MIME-Version: 1.0
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
---
 include/linux/iio/iio.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index faf00f2c0be6..30937f8f9424 100644
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
+ * to in turn include IIO_ALIGN'd elements such as buffers which must not share
+ * cachelines with the rest of the structure, thus making them safe for use with
+ * non-coherent DMA.
+ */
+#define IIO_ALIGN ARCH_KMALLOC_MINALIGN
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */
-- 
2.36.0

