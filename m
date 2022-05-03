Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1AA518030
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiECI6M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECI6M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:58:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA0235ABF
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E051ECE1E6A
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01184C385B0;
        Tue,  3 May 2022 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568077;
        bh=jPaTbN7zS3YqH2CKXzG9E3+WEnIfp3lOcul6gklYLl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHGtynp3Bs1GncFswKjB12h4k07/idCwyBlQUn9HBQ9dydYx8/m8O8hEKaIgRY467
         n2d4S1VghSkkOSn0XieDHoNdG811A/EQe8ow2nso4QyJZdb+T6fRMWYvVBLPCdltQh
         lxvOWB4NsgIVdmRcJBDnHUDVkEDQcaYlDJAvMjMNm1I8u0ZA6DZbUXoj3L8B1bFxXg
         6s7mkVX9+52tn/NqzfCOtDV11dwAHTY14H6Yj5yzhsLgAgtkKSDgFz2M3ulGVnNUlg
         GpLmYBC6TRBf0CPNU6Cip5sMt3JpBx4miqmr87uR2v57XGyJigbA0a/5mO922hMYBM
         47caHHymDnhHw==
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
Subject: [PATCH 18/92] iio: adc: ad7923: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:21 +0100
Message-Id: <20220503085935.1533814-19-jic23@kernel.org>
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

Update the comment to include 'may'.

Note that some other fixes have applied to this line of code
that may complicate automated backporting.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 0eac259db28f ("IIO ADC support for AD7923")
---
 drivers/iio/adc/ad7923.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 069b561ee768..596244bccd20 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -57,12 +57,12 @@ struct ad7923_state {
 	unsigned int			settings;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 * Ensure rx_buf can be directly used in iio_push_to_buffers_with_timetamp
 	 * Length = 8 channels + 4 extra for 8 byte timestamp
 	 */
-	__be16				rx_buf[12] ____cacheline_aligned;
+	__be16				rx_buf[12] __aligned(IIO_ALIGN);
 	__be16				tx_buf[4];
 };
 
-- 
2.36.0

