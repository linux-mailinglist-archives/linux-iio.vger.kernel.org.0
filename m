Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6C51EFA9
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiEHTPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiEHR4n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:56:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572EDFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FAAFB80E3F
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99467C385AF;
        Sun,  8 May 2022 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032370;
        bh=T5pwX6o44Wr8PyyefbNocyJqyKPsQ4Y7W4rONivg8x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJ4AQUpSDPFl1p52Cbs5gxxHoNvJjGToE4JR9qHakol363o3jpM2jeyHjbUSktK7+
         90VPW1FIh2uRP6Lt920sMVVdPLB+MG5IE+QWOiLU3yT1OdObkZYGm6p5uXpCcLd7rX
         jDmAPnO08mfTSTRwjp5ENEJ1T4glzixSDnfsFBuyeScfZp9KOViJsWjPpAjY8WJQMw
         vc0kiOJa4Dy7QkA/3lBZDrZXnqL0ZcanJIJCwEjfb8Ua6a5DvACXzSV5VDYcD103s6
         3Es1OClmPZTD78ahbBljvbREyjJPsZKfLL30gk/E9NO69FlQ9pno07lOZX9gBZRtwG
         43gO+hcBtO7EA==
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
Subject: [PATCH v2 30/92] iio: adc: ti-adc108s102: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:10 +0100
Message-Id: <20220508175712.647246-31-jic23@kernel.org>
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

Dual fixes tags as two cases that were introduced in different patches.
One of those patches is a fix however and likely to have been backported
to stable kernels.

Note the second alignment marking is likely to be unnecessary, but is
left for now to keep this fix simple.

Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
Fixes: cbe5c6977604 ("iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio buffers.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ti-adc108s102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index c8e48881c37f..c82a161630e1 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -77,8 +77,8 @@ struct adc108s102_state {
 	 *  tx_buf: 8 channel read commands, plus 1 dummy command
 	 *  rx_buf: 1 dummy response, 8 channel responses
 	 */
-	__be16				rx_buf[9] ____cacheline_aligned;
-	__be16				tx_buf[9] ____cacheline_aligned;
+	__be16				rx_buf[9] __aligned(IIO_DMA_MINALIGN);
+	__be16				tx_buf[9] __aligned(IIO_DMA_MINALIGN);
 };
 
 #define ADC108S102_V_CHAN(index)					\
-- 
2.36.0

