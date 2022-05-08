Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8F51EFC1
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiEHTQj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbiEHSEK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3E558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 11:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B54B61262
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 18:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AA8C385A4;
        Sun,  8 May 2022 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032819;
        bh=3AXDyWRPE1qksmDlPW4/LWb3unKf8qa9y+leRrT6I88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osYteEqsV1hr7PlXFDfCIfc3Sqvm/b80OSbf8rgMcMmdFrKPiw/w1VD5XoiVnj35i
         MUujKsq2wA9WmsxaSGAvhZ6uXPlf0kn85ft+c1Mvu2Ui6uj2wA6Gy3lV6oNvmar3Ro
         Af58mCKON8W0x1mspyHfneoCPJudqxfDemc2SaOiilvsHOsBeg0IA8QgwlTmAOFqvo
         9L65l1n08ufMQcEIlNAEA0S43vnoRvnHVG1cxObWb1vHNMp1TH7cb9XwSxHG4rQ1bD
         Y+DDSMMnOJXNaaFkSc8yfGfNHMKh7NIJupdrBBkOJJl32RJcfNLtjDKyCi8Jnh3URH
         UAUPT81g2Bd4w==
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
Subject: [PATCH v2 89/92] iio: resolver: ad2s90: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:57:09 +0100
Message-Id: <20220508175712.647246-90-jic23@kernel.org>
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

Fixes tag is probably not where the issue was first introduced, but
is likely to be far beyond the point where anyone considers
backporting this fix.

Fixes: 58f08b0af857 ("staging:iio:resolver:ad2s90 general cleanup")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s90.c b/drivers/iio/resolver/ad2s90.c
index d6a91f137e13..be6836e55376 100644
--- a/drivers/iio/resolver/ad2s90.c
+++ b/drivers/iio/resolver/ad2s90.c
@@ -24,7 +24,7 @@
 struct ad2s90_state {
 	struct mutex lock; /* lock to protect rx buffer */
 	struct spi_device *sdev;
-	u8 rx[2] ____cacheline_aligned;
+	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ad2s90_read_raw(struct iio_dev *indio_dev,
-- 
2.36.0

