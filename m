Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59351EFBE
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiEHTQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiEHSDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:03:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C470558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE43B80E75
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21359C385B0;
        Sun,  8 May 2022 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032758;
        bh=x/WE7UAUU2zfnPjJH5irvBf3GICl0zcPzuuUTNNUyZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyeAeNeq4hnhB226t9DvGKlypq+GSOTcIgImxHQruRV6eLnp4dml1Y16xsU4Y5N9x
         5ldiGzdJ5BweJq60I3grip7YpTtctx6/R7HRTSJgwJ1569hXo7uEcE5KnicZQL3uw6
         lmv+dbRHcCFMxF7+cLr1v9cxcmNEQA31DFuGo4bKfmWX+pzpgyzGRwyc/i0X0na4/6
         s+3au7rbqmXVf+4w/VA20ZNdqrD34rx/4JAmyXAgMpxlXZk6FqdKJ0myp0juv/9A2n
         ywYnQ/ezs+x3DDZ2bE7FLGw/jbT4Av3w003n+4+oJe7g0k8T3xr3hosHuQTOUmbYKb
         6+LCGpQHea6Rg==
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
Subject: [PATCH v2 81/92] iio: potentiometer: ad5272: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:57:01 +0100
Message-Id: <20220508175712.647246-82-jic23@kernel.org>
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

Fixes: 79e8a32d2aa9 ("iio: ad5272: Add support for Analog Devices digital potentiometers")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Phil Reid <preid@electromag.com.au>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/potentiometer/ad5272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index d8cbd170262f..ed5fc0b50fe9 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -50,7 +50,7 @@ struct ad5272_data {
 	struct i2c_client       *client;
 	struct mutex            lock;
 	const struct ad5272_cfg *cfg;
-	u8                      buf[2] ____cacheline_aligned;
+	u8                      buf[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct iio_chan_spec ad5272_channel = {
-- 
2.36.0

