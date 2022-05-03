Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED85518023
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiECI4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECI4p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:56:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A57035ABF
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE416B81A96
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78BC385B0;
        Tue,  3 May 2022 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651567991;
        bh=AD03ydEU+BaOTVySZHLdLUykv6lO6TuqENNKavTGzsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y11AYrjwJmTgXO+/8Ey1CvtHST/kg/o1gm+IUX4IMc+5HuSTMOO+qjFRG+V0IEyq5
         tivz1AB4SAa7W3DmfEDJ7F3zjJn85nay7C33rKFwxlUYiDvvZVq2o3zk1hRvwb+p64
         o+pJVUm2/vbAqvJA7ruXaSnBuafIRNtKxwuF39bpt+OXa3LqxkheO11SgoNi3lhuJU
         3XjqspRKhRrCPXR/PJGqlWJve19tkWVIPrLqIE9Q9Pd6YS8AVkGSFd/cDGN+AVAYCj
         rmWXTFvLxZQeDMBldoAfdM4/CIr6s50ynJfVtEgOemBwyEIva9RcsavMF4ygS+q2xx
         LAE2Vfe4MjUhw==
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
Subject: [PATCH 09/92] iio: adc: ad7266: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:12 +0100
Message-Id: <20220503085935.1533814-10-jic23@kernel.org>
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

Update the comment to reflect that DMA safety 'may' require separate
cachelines.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7266.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c17d9b5fbaf6..54fdb8fbb6a2 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -37,15 +37,15 @@ struct ad7266_state {
 	struct gpio_desc	*gpios[3];
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers live in their own cache lines.
 	 * The buffer needs to be large enough to hold two samples (4 bytes) and
 	 * the naturally aligned timestamp (8 bytes).
 	 */
 	struct {
 		__be16 sample[2];
 		s64 timestamp;
-	} data ____cacheline_aligned;
+	} data __aligned(IIO_ALIGN);
 };
 
 static int ad7266_wakeup(struct ad7266_state *st)
-- 
2.36.0

