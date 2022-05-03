Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F416E518048
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiECJAu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiECJAt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:00:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3B36154
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A429EB81BE1
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661D2C385A9;
        Tue,  3 May 2022 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568235;
        bh=nPC2DmqzAK3DSkF6N8/RDWmAUZv2g0RzReAvIkV4AkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5O9DY5Dxlbbt7ITGeIe9S3mVbVAKix/ToaYtURc68XXLC7QxYtRgf9sZ+4Wv2j6q
         dPSPnBI+mDGGFoomsfGjvfp74X7eNIEPxcXXrJhikcyqz8p3DMl9/cMPbJjfoXks88
         5FsGavyouym2coe39dZT3wOEofVE5jG1w/D1pie22SU2iqckRTxNraID9Y4mUBaD/K
         m7PW9KWopgbC0hU+8Fisua5jo9xbAt1EEQw5KA1wlGbWcrzcMaI7G+EIOUz2LML5dV
         +cxJQjoxODbwN5/BxlOueMvRGRF/Ety8mPFuogLY1A9t7Tmw8e2kQDqNwJPkdo0vqN
         pBEYxhA6wbyDA==
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
Subject: [PATCH 35/92] iio: adc: ti-ads131e08: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:38 +0100
Message-Id: <20220503085935.1533814-36-jic23@kernel.org>
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

Fixes: d935eddd2799 ("iio: adc: Add driver for Texas Instruments ADS131E0x ADC family")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomislav Denis <tomislav.denis@avl.com>
---
 drivers/iio/adc/ti-ads131e08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 0c2025a22575..fb490471ffb9 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -105,7 +105,7 @@ struct ads131e08_state {
 		s64 ts __aligned(8);
 	} tmp_buf;
 
-	u8 tx_buf[3] ____cacheline_aligned;
+	u8 tx_buf[3] __aligned(IIO_ALIGN);
 	/*
 	 * Add extra one padding byte to be able to access the last channel
 	 * value using u32 pointer
-- 
2.36.0

