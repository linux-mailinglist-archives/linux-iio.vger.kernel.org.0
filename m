Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74EB518082
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiECJG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiECJG0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:06:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9394D1BE93
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F56B81CA7
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFA1C385A4;
        Tue,  3 May 2022 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568572;
        bh=Fhlt/qW9Zs05subZawmiNh/9N1h+Q4FBt6IzKaoNDdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKe7+fNUs2JXAtJcicnxwTXj8DbzXwWR+vRT5KgjNYAAWV3yAowi+xHc4bIQQuhWb
         SkY4izmUlmi1Y5sa8DMDACDLD7mxnNJQWn4LSr9UttJWv4PJV4wJraQ96cVmRkDJ6U
         OmSywfsaIuLE0WGp/o9jsRvCfZO2VwHJ+2/8prgXOvyAi/5qR5KdmQP1MgznxKoLWw
         nmBbvqXNItyAoc4EbQ4dnHVWTCfN/zOqbw2UYQ1HUWuynZ7NzHQNutM48i4rfOEeTx
         v7LNjv7jTIrVM23BrVdbYSZbS78SQaduH7BlNfL1C9QZRnr6n7/KB43XvV9x3FIchp
         XxOdhk4grygJw==
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
Subject: [PATCH 71/92] iio: frequency: adrf6780: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:14 +0100
Message-Id: <20220503085935.1533814-72-jic23@kernel.org>
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

Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 8255ffd174f6..788de3b05e3a 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -86,7 +86,7 @@ struct adrf6780_state {
 	bool			uc_bias_en;
 	bool			lo_sideband;
 	bool			vdet_out_en;
-	u8			data[3] ____cacheline_aligned;
+	u8			data[3] __aligned(IIO_ALIGN);
 };
 
 static int __adrf6780_spi_read(struct adrf6780_state *st, unsigned int reg,
-- 
2.36.0

