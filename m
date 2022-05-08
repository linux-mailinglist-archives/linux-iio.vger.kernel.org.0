Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864051EFA0
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiEHTPG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbiEHR4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:56:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F29DFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68598B80E3F
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453BAC385A4;
        Sun,  8 May 2022 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032362;
        bh=fNzmzD6E7MgMUkFG6wsEsOcnhIbPOGw0dwtI54dqPbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m21GDBzLprRl+HKkxSNxSa7WAfNQZKM/Vk5iaJ3uj3xpBXZBzkSM+w/95z7SO8Xli
         gXdenkkTu3aso//DpB4y5tiJoVdXmITi++f6/5Dc8snQTz8/ecJeiDn3NbDV7KjOE8
         bfcJqxDbPN2YXljomIM7iYFBRTcu94riO3FNfgBS05lC01oqo/X/YLEKaiCKHpZ5Bs
         iqsPVYTnASZy23cv61d1f8LcEjlCss2dUi5FoBoJMUoZpT2sHY9PMGBuTjUBTMAXCD
         InLnhMHDvWQErvcc8BJ2m+yRR5gycRIsSCLvfSL7MKC08BvnfCTNYuXhA6KXK4ZK+C
         KeCnnx9QlG0+g==
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
Subject: [PATCH v2 29/92] iio: adc: ti-adc084s021: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:09 +0100
Message-Id: <20220508175712.647246-30-jic23@kernel.org>
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

Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mårten Lindahl <martenli@axis.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ti-adc084s021.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index c9b5d9aec3dc..1f6e53832e06 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -32,10 +32,10 @@ struct adc084s021 {
 		s64 ts __aligned(8);
 	} scan;
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache line.
 	 */
-	u16 tx_buf[4] ____cacheline_aligned;
+	u16 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
 	__be16 rx_buf[5]; /* First 16-bits are trash */
 };
 
-- 
2.36.0

