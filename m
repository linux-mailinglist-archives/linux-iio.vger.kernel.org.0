Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C951EFA7
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiEHTP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiEHRz6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:55:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BEDFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 752E1B80E59
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D672AC385B0;
        Sun,  8 May 2022 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032325;
        bh=lpwoPBGOl7B9Dix91+TGJN/eEz4/XFIeVsfg/KVLFTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyb2DTDnKWzAQRPlx0F0knVdCpouZxspLwfHNVTahEmdaYu0Aho0AFwoYkjW/K7Yk
         EJ3YGZDR3EIvJAYobxa83cyJQHsSa+JChfR5/GVQ22uOMtq6ZCDIHkQ2bhEvgWWTnQ
         tnUgKyKOAyMRtcWVK1NAp/eZpkfpUE6YV4bdJfqemisxviseGBNdk5bER0O3+KPQBl
         eiF/ToGI6LQ69kzI4ya8I9UGPnXK7FeUYtTB296zqh3uhAyf8EdQr3Ud1nN+ksyqCH
         68snhyWij5R7SGp05vSb8b5vi7Ylg1rJu4D4OD5opl3YPfhaSMRuMEw2gmHL8xVpwq
         lKjZ9O8udqwYQ==
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
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 24/92] iio: adc: max11100: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:04 +0100
Message-Id: <20220508175712.647246-25-jic23@kernel.org>
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

Update the comment to include 'may'.

Fixes: a8e7e88df9ec ("iio: adc: Add Maxim MAX11100 driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Jacopo Mondi <jacopo@jmondi.org>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max11100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index eb1ce6a0315c..49e38dca8fe2 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -33,10 +33,10 @@ struct max11100_state {
 	struct spi_device *spi;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	u8 buffer[3] ____cacheline_aligned;
+	u8 buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct iio_chan_spec max11100_channels[] = {
-- 
2.36.0

