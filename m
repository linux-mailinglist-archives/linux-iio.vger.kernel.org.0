Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B185A51F01A
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiEHTTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiEHR65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:58:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138B0DFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC52AB80E4E
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4410C385AF;
        Sun,  8 May 2022 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032504;
        bh=jT6gQtXpkZSPYV6zXkCkUvpzQXQ53iDqRPb6s9aOVYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlbDUTVTLOtU0uGUlxNMELhqgZgy1K8zkxS7xteXdtZOyKwKHjvT6JFi+4TGUuFHi
         VOdCxPBGO+wVJXTtKwcF6iIqi7cQKjFGfVuNb1nmnK4QTe/CtukPY/yIlZwoKkLsf0
         ZMvhE6uedq6BInfkycAAgs5TUBQqpaUMw3Eg3C4Mw3Ab9lCx5lKdlzkWNwTPkFzGYi
         Pb0j8GsJui0OaGdI1vmV21+WwIyzLF0sPA3+nkha4gSriVxB56ZKgk/fc+c419xFV/
         jfjxwQCI09z0hOdxwsyKBzSsQ8KmTMoAn4mUJq30bEMU7doXHmHhLN7U1sUMaRdzbY
         j+S0TvsfQo0og==
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
Subject: [PATCH v2 48/92] iio: dac: ad5592r: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:28 +0100
Message-Id: <20220508175712.647246-49-jic23@kernel.org>
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

Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5592r-base.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
index 2a22ef691996..cc7be426cbc8 100644
--- a/drivers/iio/dac/ad5592r-base.h
+++ b/drivers/iio/dac/ad5592r-base.h
@@ -14,6 +14,8 @@
 #include <linux/mutex.h>
 #include <linux/gpio/driver.h>
 
+#include <linux/iio/iio.h>
+
 struct device;
 struct ad5592r_state;
 
@@ -65,7 +67,7 @@ struct ad5592r_state {
 	u8 gpio_in;
 	u8 gpio_val;
 
-	__be16 spi_msg ____cacheline_aligned;
+	__be16 spi_msg __aligned(IIO_DMA_MINALIGN);
 	__be16 spi_msg_nop;
 };
 
-- 
2.36.0

