Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7A851EFFB
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiEHTSb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbiEHRzW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:55:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBBDFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC2E06127D
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA92C385A4;
        Sun,  8 May 2022 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032290;
        bh=l2HqcEz2f3e6Yupv/L+8WFWmrIAvRHSPy0G39uH4FbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWZwDCp5Y06vdfzDG/xFAewpmYMrAzn21rGyAY9ljtIkxAgSa4qg2RiKZdrC8BWEX
         zq3XLIBrOpE5OhLU76VrY8WIWcAsoI8Zh7fZUP6FuuBG/DexnlYy7D5zgGHWQUgsDl
         yhY8RUSgyszaYLIbPb9ZHMvBAcH7xRVJQ5hVgb9oxl9pITyczut4rfWd84S/6PCRCv
         HogeJUsDPLGDvbXCZhgwVjUmMC+SHHaJWjl83VKzneWcZdXbTM6zvIly8+5eddWh19
         QRsOUWEgE/rnYeBJK7x/KCWZRoDV8rA1O1JkHw5ZFkVr8305x/CXmi48B365pVusNS
         qbeJcqcydQRiA==
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
Subject: [PATCH v2 19/92] iio: adc: ad7949: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:55:59 +0100
Message-Id: <20220508175712.647246-20-jic23@kernel.org>
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

Note the fixes tag predates some changes to this line of code so
automated application of this fix may fail.

Fixes: 7f40e0614317 ("iio:adc:ad7949: Add AD7949 ADC driver family")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7949.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 44bb5fde83de..ed4c1656ca75 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -86,7 +86,7 @@ struct ad7949_adc_chip {
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
-	u16 buffer ____cacheline_aligned;
+	u16 buffer __aligned(IIO_DMA_MINALIGN);
 	__be16 buf8b;
 };
 
-- 
2.36.0

