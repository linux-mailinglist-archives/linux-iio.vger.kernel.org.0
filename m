Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A453518099
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiECJJH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiECJJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1595122BF0
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A678E61357
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36B7C385B2;
        Tue,  3 May 2022 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568731;
        bh=VE/2SA4W7Q33z2InonY83WkwktFvl38di5S6fuYRKBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtYk1Bbm5i7wSMis7vpZVResWuDG7SIldRJKrz2zLwFrCZhg0uolct+w2GaswD59P
         OJRRnmgmIVPkeAdssyvdoGH0F+75wuaHmQ99R9Mcf+JJWBnPMYVuTxHQwvGGQbBXHu
         E201+bYPL5JOId8Dir5xdPqyByTRo6l7u1UXntzjqhML+SMpOIyfLIfLtdhM1uMhVW
         SQk5i7rNSJw1f4BX8+oQiN2okeDWgtGX2MzpWuCxKVR6jwkmUNYOMlX4DnCocmiS3z
         cpio16XxaSYSrf7oaccK7sK+Zq86Be3f25OGlDmktxUmlZIBR8wqlKZfGM/LnPLzTr
         82FK7WpyJ5zsg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
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
Subject: [PATCH 88/92] iio: resolver: ad2s1200: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:31 +0100
Message-Id: <20220503085935.1533814-89-jic23@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503085935.1533814-1-jic23@kernel.org>
References: <20220503085935.1533814-1-jic23@kernel.org>
MIME-Version: 1.0
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
IIO_ALIGN definition.

Fixes tag is probably not where the issue was first introduced, but
is likely to be as far as anyone considers backporting this fix.

Fixes: 0bd3d338f61b ("staging: iio: ad2s1200: Improve readability with be16_to_cpup")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/resolver/ad2s1200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 9746bd935628..c568d2990141 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -41,7 +41,7 @@ struct ad2s1200_state {
 	struct spi_device *sdev;
 	struct gpio_desc *sample;
 	struct gpio_desc *rdvel;
-	__be16 rx ____cacheline_aligned;
+	__be16 rx __aligned(IIO_ALIGN);
 };
 
 static int ad2s1200_read_raw(struct iio_dev *indio_dev,
-- 
2.36.0

