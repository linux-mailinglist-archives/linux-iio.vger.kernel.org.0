Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB5151802B
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiECI5g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECI5e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:57:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B135DE9
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9927CB81A56
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CD5C385A4;
        Tue,  3 May 2022 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568040;
        bh=nem98y3YJbF+X6WsRnQpMXvAhuEIpY19h6dWqMNoKAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFhAWdgFGMzudVvIyf5IEAJ2o9HravxPu9j279Gn+24i6sPxUFxUxF6igFUDPTeZg
         qnRaZ3XguV4kWQZrrHhHWH0Bk0spbqy3GU3tsSbU2cY0qkA20q+C5Ws/r7lidqtHHA
         Ifu8OVluXTcDedGUYETs97hy0/6QXkxFYxh9+t6OjMjrL6TVJEHtMJ4s118rYfJVS/
         0tv6c+JWuSLdClS5cnT+l+dyzRx7dvDY8W33UiTrKh+ibMhjYHti2ghflQAu4VFzrn
         yonVJ4H4S+a0V00v9BskS4TQfD8Bre8UMrLLLzDSDgkuepfzTrcm86y52fH57okihm
         w10odzx4PdDVA==
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
Subject: [PATCH 14/92] iio: adc: ad7606: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:17 +0100
Message-Id: <20220503085935.1533814-15-jic23@kernel.org>
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

____cacheline_aligned is an insufficient guarantee for non-coherent DMA
on platforms with 128 byte cachelines above L1.  Switch to the updated
IIO_ALIGN definition.

Update the comment to reflect the fact DMA safety 'may' require
separate cachelines.

Fixes: 7989b4bb23fe ("iio: adc: ad7616: Add support for AD7616 ADC")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 4f82d7c9acfd..f52aedb1ecf3 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -116,11 +116,11 @@ struct ad7606_state {
 	struct completion		completion;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers live in their own cache lines.
 	 * 16 * 16-bit samples + 64-bit timestamp
 	 */
-	unsigned short			data[20] ____cacheline_aligned;
+	unsigned short			data[20] __aligned(IIO_ALIGN);
 	__be16				d16[2];
 };
 
-- 
2.36.0

