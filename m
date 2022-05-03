Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E651804E
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiECJB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiECJBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DB36175
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAECD6134B
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64129C385C2;
        Tue,  3 May 2022 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568273;
        bh=TYzAvVm2ivargEWlAHa9bkYLp2mkvaTW3UJSAz5Z0j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4CLva1SkUTV9/MeHUhy5ZZnr18GF7P4kxD59V3UujHSTYtMUkejYVf3KL/vCA4Qh
         97z/+gOGvmstoe+97SqQRvWcrbRXWye2/QjpTpxg/t6z+6AkxSfJMNDzS/vdIh7j1E
         QLRP3YJmJ8F6pZl1J8y17NgJ86qaCMBEjWccwHs0jKX39Nl10mKqRfGI9NCyAySvya
         ij354Cz/hpLDadsLXL0U5JPs/ckP643sDO/a7rVDE4DyG9FiDJduo3QGcIdW+UGdzy
         va908K4FoO8q6OupRjUKPvblFe9wesLdaT4VRfeuQm2sSyXhynfkFTbvfG2F5Rhr6U
         s8/6rF3/TEmoA==
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
Subject: [PATCH 39/92] iio: adc: ti-tlc4541: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:42 +0100
Message-Id: <20220503085935.1533814-40-jic23@kernel.org>
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

Update the comment to include 'may'.

Fixes: ac2bec9d587c ("iio: adc: tlc4541: add support for TI tlc4541 adc")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-tlc4541.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 2406eda9dfc6..b418fc47dc8f 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -37,12 +37,12 @@ struct tlc4541_state {
 	struct spi_message              scan_single_msg;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 * 2 bytes data + 6 bytes padding + 8 bytes timestamp when
 	 * call iio_push_to_buffers_with_timestamp.
 	 */
-	__be16                          rx_buf[8] ____cacheline_aligned;
+	__be16                          rx_buf[8] __aligned(IIO_ALIGN);
 };
 
 struct tlc4541_chip_info {
-- 
2.36.0

