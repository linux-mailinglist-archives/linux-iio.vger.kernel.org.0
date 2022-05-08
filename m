Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D500451EFC9
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiEHTQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbiEHRyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:54:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F52DC3
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B84A8B80E5B
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA553C385B0;
        Sun,  8 May 2022 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032230;
        bh=2HVFKTmhz6gwZvJxBJ/IQGIhqeTXfcKyjspXKOhOF6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LF+PIxJoz18B2B0UkK5ba3e0bXkMJgk7AZFnUpYzNKq5iNuwz4B/9hfxS6eU8bfxg
         BbB3Z1hdpV1llDgdmVyfwhPCTHlSwzduA5tuklVFdfxhKM+OOhIkUBnsF+526bpqz0
         wO6aNy9Ba7C7NA1e6AGep51VxaSL17+6KebhypJU6E8fSFU2Hod9rKYJ0DQTC1tdXq
         J1TR0JSpcvCmQZI5LiEgn3PpgxJnfo+eryHsk2y+r2VDegE1+zhbg1MOUbcNTc6Nic
         nSdi2Qemrap/bBF3m7z6BzcSSbGnmPqrnmp3PFFqbwLHmZZy7N238NK5HKNrPnXQP1
         lmZ6SV+JqzSsQ==
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
Subject: [PATCH v2 11/92] iio: adc: ad7292: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:55:51 +0100
Message-Id: <20220508175712.647246-12-jic23@kernel.org>
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

Fixes: 506d2e317a0a ("iio: adc: Add driver support for AD7292")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7292.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 3271a31afde1..92c68d467c50 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -80,7 +80,7 @@ struct ad7292_state {
 	struct regulator *reg;
 	unsigned short vref_mv;
 
-	__be16 d16 ____cacheline_aligned;
+	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 	u8 d8[2];
 };
 
-- 
2.36.0

