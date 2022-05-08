Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823951F015
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiEHTTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiEHSCc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:02:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CC5F55
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28B55B80E48
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A995C385AC;
        Sun,  8 May 2022 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032719;
        bh=+BWXPdcZLVwvX6+4PRqN9e2x+gHPHOFeKc3pnlZgtfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3h4vaHZmCroCWyo3rb07fkHpXcNsFOLSknS3WqSDtchsLtG8UZO1hyAXqki50e7A
         F4EaGZ1OZJr6ebz6sl27YkssnyR4a7by5pOOTMbMXBAObhFVvtOGTIiObM+j0AeA2+
         zopV2JHnIZJ7Su47+tgFjdS7zLDTdy3pjP0lO+EDpIMxv/dPSfvNUu5h0V3sqBNYrj
         j80mQr5kaON8Z3bsJPdgrXNj2q5qYJ2nUs97xzMNoyfUMq21aooX1BjDFoi3c9WOPL
         4cX57d9rSPR0CMOslEhLUgqoRz+ELTS2Ac39jIZOa5Pu6j9h9inGMub7dTBZwhu6Kx
         tSDFpB6KYguZA==
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
Subject: [PATCH v2 76/92] iio: imu: fxos8700: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:56 +0100
Message-Id: <20220508175712.647246-77-jic23@kernel.org>
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

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Robert Jones <rjones@gateworks.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/fxos8700_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index ab288186f36e..423cfe526f2a 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -167,7 +167,7 @@
 struct fxos8700_data {
 	struct regmap *regmap;
 	struct iio_trigger *trig;
-	__be16 buf[FXOS8700_DATA_BUF_SIZE] ____cacheline_aligned;
+	__be16 buf[FXOS8700_DATA_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
 /* Regmap info */
-- 
2.36.0

