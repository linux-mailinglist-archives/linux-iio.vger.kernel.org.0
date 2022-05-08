Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115051EFB1
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiEHTP4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbiEHSC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D770558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DD30B80E5C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0DFC385B0;
        Sun,  8 May 2022 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032743;
        bh=8ujw263cRvevAritDYmfSjf5OqYXE/cVT+iuKR6UrY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4aveleV07OCFaemY0PjByGhwGQQjdXJCxuFsJg0aiiaz79eNYJj82cfHIiBEwYkO
         g2s6qU4YrGUZ00n8s8a18wqHINoqfEeFHATlzoxIdgi1Yr+4OHnv/9QGL8SilBULyy
         cKEj/EwuaqrtLPiBqd8JbCH1Qnn+Izur+PLE/6zVY9vNj/I0P79Qww4jIeGntpy086
         CCBYpW8wg52EI99QtwyakWjJPxWV9HZs+5hZLlS7B0ngG3LJ/8RoyVLUsXHiBnOkPN
         BVLIaws8sro0trVsuJZYC/yVmjGL3H8KdTXRZythTtdgbhMjF67qQAre8xjwJPJHxj
         j/TgzeAqCWCig==
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 79/92] iio: imu: mpu6050: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:59 +0100
Message-Id: <20220508175712.647246-80-jic23@kernel.org>
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

____cacheline_aligned is an insufficient guarantee for non-coherent DMA
on platforms with 128 byte cachelines above L1.  Switch to the updated
IIO_DMA_MINALIGN definition.

Fixes: 6b0cc5dce072 ("iio:imu:inv_mpu6050 Fix dma and ts alignment and data leak issues.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index c6aa36ee966a..32b58b797d57 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -203,7 +203,7 @@ struct inv_mpu6050_state {
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
 	unsigned int suspended_sensors;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] ____cacheline_aligned;
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
 /*register and associated bit definition*/
-- 
2.36.0

