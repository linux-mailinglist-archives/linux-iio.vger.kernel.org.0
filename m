Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49051808D
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiECJH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiECJH2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F41BEA4
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421AE61259
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3B3C385B1;
        Tue,  3 May 2022 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568636;
        bh=w+VfPYd9WkpPK3s+Ftfter3H3ZY22JJBLNLTVx/wEU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUgDvJVcK6f8KSTutVIO2u+azZ4gaNyj5fJPce350/drgF4JCUfabX5u9xI0IGY2V
         Vzadp6It0t425h01wL1pYc7hUHBCHwucmFOWwK3V5T/5lzfBzvHwKRhVE+y4hcoaMt
         cnVE7Cx9HwJJhyHdyfbBksVgJ0qwoOocaki3iTw0rGps5vo5RUwZDMSUxeObz67ZED
         VezxHm41WYuH0u3clPVPhzjZZ/0l3+pkcniQSX3fYzqxVDfc5M51I2KXj+F7WPehN1
         X8r0ArMyOOPxK/G11yaugy1QotFWsR5If6+K1ZWTVilzEl+62UcCrX8TJc0g3AVwv6
         zXfdQaSkHVmIA==
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
Subject: [PATCH 78/92] iio: imu: icm42600: Fix alignment for DMA safety in buffer code.
Date:   Tue,  3 May 2022 09:59:21 +0100
Message-Id: <20220503085935.1533814-79-jic23@kernel.org>
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

Second fix for this driver due to different introducing patches.

____cacheline_aligned is an insufficient guarantee for non-coherent DMA
on platforms with 128 byte cachelines above L1.  Switch to the updated
IIO_ALIGN definition.

Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index de2a3949dcc7..56545638bfcd 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -39,7 +39,7 @@ struct inv_icm42600_fifo {
 		size_t accel;
 		size_t total;
 	} nb;
-	uint8_t data[2080] ____cacheline_aligned;
+	uint8_t data[2080] __aligned(IIO_ALIGN);
 };
 
 /* FIFO data packet */
-- 
2.36.0

