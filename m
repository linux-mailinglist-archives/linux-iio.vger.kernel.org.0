Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CE51F003
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiEHTSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbiEHSA3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:00:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87284558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B81CB80E45
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C5AC385AF;
        Sun,  8 May 2022 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032595;
        bh=2TUFj7n/efCQ9Dk1kDid94woSiwXkA1KxXrjt+kS/NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uc2kNDAVRpnqBGoh1YxezyAUalW05VKn3DJYtoHyB92mp6vD0sBGxvttoJ5dGRc5r
         q1U4ulfmHY9V189BqfSsf5e8oEJs20uQ3x/EyYXcJqvsuTdeF0odZNVUFVXjAXuOPo
         0rMTR1yxKLpDEhLop9uyGMp2skWw8A0ETO44YA5aOi/1CstyCzLLbLCX+4WbZ9VLRf
         +ZN5bi4iQbgWdZ1bB9Zgaar6YIjAPDFGNzLd6vECwNJYZcmJfxAe66/C2o3UivYYFq
         g45XvnM9UtgH3EjoRZAiKgGEhHjlC7SHDvg7z5M0MSZZtgnt6b9pwyKGpo27WmsGO8
         WdsEaMBqvgZAw==
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
Subject: [PATCH v2 60/92] iio: dac: mcp4922: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:40 +0100
Message-Id: <20220508175712.647246-61-jic23@kernel.org>
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

Fixes: 1b791fadf3a1 ("iio: dac: mcp4902/mcp4912/mcp4922 dac driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Welling <mwelling@ieee.org>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/mcp4922.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index cb9e60e71b91..6c0e31032c57 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -29,7 +29,7 @@ struct mcp4922_state {
 	unsigned int value[MCP4922_NUM_CHANNELS];
 	unsigned int vref_mv;
 	struct regulator *vref_reg;
-	u8 mosi[2] ____cacheline_aligned;
+	u8 mosi[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 #define MCP4922_CHAN(chan, bits) {			\
-- 
2.36.0

