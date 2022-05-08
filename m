Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8451EFA2
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiEHTPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiEHRx4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:53:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEEDFC5
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12C2CB80E4A
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2C7C385AC;
        Sun,  8 May 2022 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032202;
        bh=LvGt7gI4Gk3UAsgYBGnesSWvcmpRmjjUNMKeAZu4ayM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZO9LR5bLas2XJEs2ZX7SUNLjGtLEAUpRT6R6mbvw9oEcbLrumlCaEasGxM0Q8OJX
         LrtnQ2+sLN3eZUt2Vg84ebSXqlLl8R/HUBSyPWONzl1oLnbczDwaaIYXSyfSIjAYmM
         GCcHIkAmURnhCiqpnBIH7OTywLt8R/PPq+fC+GBhRsKMWf0APbsKv4Rg5wkVsRXWxd
         PBJuhNWrc9lEYpVaS54sQET6ExjtLqhW+Qachl3NSPsb+dLfNlrb3wcPNqfxV3JfJM
         KlpskWDao/fwMtxOHt0rPA/QNq9uWIrYSWs+Wm8tNIMhCuPeWrsoiudGZUa//Yb/rK
         f8aY0cn01P6kA==
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
Subject: [PATCH v2 07/92] iio: accel: sca3000: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:55:47 +0100
Message-Id: <20220508175712.647246-8-jic23@kernel.org>
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

____cacheline_aligned is insufficient guarantee for non-coherent DMA.
Switch to the updated IIO_DMA_MINALIGN definition.

The second alignment marking is left in place to avoid doing more than
the simple fix in this patch.

Fixes: ced5c03d360ae ("staging:iio:accel:sca3000 merge files into one.")
Fixes: 152a6a884ae13 ("staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/accel/sca3000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 83c81072511e..2eecd2ab72dd 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -167,8 +167,8 @@ struct sca3000_state {
 	int				mo_det_use_count;
 	struct mutex			lock;
 	/* Can these share a cacheline ? */
-	u8				rx[384] ____cacheline_aligned;
-	u8				tx[6] ____cacheline_aligned;
+	u8				rx[384] __aligned(IIO_DMA_MINALIGN);
+	u8				tx[6] __aligned(IIO_DMA_MINALIGN);
 };
 
 /**
-- 
2.36.0

