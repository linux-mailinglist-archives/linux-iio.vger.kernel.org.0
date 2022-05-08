Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A7551EFF4
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiEHTSZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiEHRza (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:55:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6CDFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6395B80E5A
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5464C385AF;
        Sun,  8 May 2022 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032297;
        bh=EbmcmnmvG/3cvJZUaL1AvjWZebNy09ApuXYOhXg9cj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Byhwb8Y9FSKrcQNn3y9a3lcjdnfHbmEDNqMUS6qaToyc4iFLyxNpkN3ZZ8XGT1fFH
         8CIgN7Lv9KPCS3ntHxACHqPX1MFrQG6klfNar97lnzkpUwK9995L0huwfWv0WA/8tD
         pSLyXTMQ6tkzq0628XuTbDQ4/jmLgASlcJSvhGVkPluSgxFXIrn2InG9pBPT8q4vF+
         jrpBJrqQnzpn1iK3T28cWaZXKuoBeQi88hemLBN6PD3sHx9+KymX516yHcVCe3XHIS
         Oc+cevB0TznFRayk+6BdK2Yg7wVh05GAk2TK7hquXk935LzsdnbvdKJj94+Xp0YLds
         Qp80y7xTX9KRg==
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
Subject: [PATCH v2 20/92] iio: adc: hi8435: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:00 +0100
Message-Id: <20220508175712.647246-21-jic23@kernel.org>
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

Fixes: 72aa29ce0a59 ("iio: adc: hi8435: Holt HI-8435 threshold detector")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/hi8435.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 8eb0140df133..771fa12bdc02 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -49,7 +49,7 @@ struct hi8435_priv {
 
 	unsigned threshold_lo[2]; /* GND-Open and Supply-Open thresholds */
 	unsigned threshold_hi[2]; /* GND-Open and Supply-Open thresholds */
-	u8 reg_buffer[3] ____cacheline_aligned;
+	u8 reg_buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int hi8435_readb(struct hi8435_priv *priv, u8 reg, u8 *val)
-- 
2.36.0

