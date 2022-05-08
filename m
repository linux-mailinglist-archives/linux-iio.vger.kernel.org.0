Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9751EFC6
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiEHTQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbiEHR6U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:58:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884BDFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73DC8B80E3F
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3456FC385AC;
        Sun,  8 May 2022 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032467;
        bh=yb7PNrF3/V2CXO10Fydyl7aki75teK+3kHkpMqAV0d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmJPi81SLLd2evmNm8dLq2POeqVMxDmtMWewAIGFZN1oxX7LgjwNBCx7coE4Goge2
         qvPvK14aBWzyAC9ZuPFfv4Dpe9p/paMGfjff20emIjrjN3gFJyQq7GB+O5t53wYDVy
         r/v8u4OOrNRO/IevtkoEVMRc60/Mdj+8UP5Nx0Y8/4Stdvfn9JmYnuNhpI+uOxhnya
         5K1CnT1uu4xzBU4O6+6re09iUkH2+Pu/uVhSiR/T5d/ZqnsWMwQ2cUa5aZT1ew/04r
         +Chogl9gQJgFhJ7eYrHgZXh9W9xHR4+hJ+532U3P/86MLAlWqlzR6h2ctGm4zBsHH3
         s87zsuOUDbZjQ==
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
Subject: [PATCH v2 43/92] iio: dac: ad5064: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:23 +0100
Message-Id: <20220508175712.647246-44-jic23@kernel.org>
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

Fixes: 6a17a0768f77 ("iio:dac:ad5064: Add support for the ad5629r and ad5669r")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5064.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 27ee2c63c5d4..e3b1add34f46 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -115,13 +115,13 @@ struct ad5064_state {
 	struct mutex lock;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
 		u8 i2c[3];
 		__be32 spi;
-	} data ____cacheline_aligned;
+	} data __aligned(IIO_DMA_MINALIGN);
 };
 
 enum ad5064_type {
-- 
2.36.0

