Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1051EFA3
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiEHTPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbiEHSAN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:00:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE65558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF05EB80E48
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E53C385AF;
        Sun,  8 May 2022 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032580;
        bh=BJE+A0ljdqV7O9zRI8XJoYO0P9lUebI106coz3WpzrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uky0coHoC1OXcEK2a8OVL30bcQuQTxqySSpRxFtBoNCdav98vOQjmkMLM2E3PYui3
         MFjFCQpdW3WLw+3/6i22iKkyxNug0T+bmJsbeFqp8tO36kaAWTbzx8oIAR9K6bRdHO
         W+N3eDb3b3B9LtY2DsYKGQdwj2PfdZ8MFbeXIHPuICcehcjDZPAinhuN0YlpVTEp0D
         oK3D9gWz0fuS19jUB5eHCSy5BkpHWmXFABcwOZMWrB/w8OH8/pqpa7/1MR49D/KXfN
         c1edyJmQuHJo84O9XA0nI8NZXocKRimnKBgHLscfPZGvN1irUCWjTXhCZLh7aO+NYK
         XKR4wAdg8vS4A==
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
Subject: [PATCH v2 58/92] iio: dac: ad8801: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:38 +0100
Message-Id: <20220508175712.647246-59-jic23@kernel.org>
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

Fixes: 7f270bc9a2d9 ("iio: dac: AD8801: add Analog Devices AD8801/AD8803 support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad8801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index 6be35c92d435..919e8c880697 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -26,7 +26,7 @@ struct ad8801_state {
 	struct regulator *vrefh_reg;
 	struct regulator *vrefl_reg;
 
-	__be16 data ____cacheline_aligned;
+	__be16 data __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ad8801_spi_write(struct ad8801_state *state,
-- 
2.36.0

