Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE31951EF9C
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiEHTPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiEHSCR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:02:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94584558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49F8EB80BA8
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA2EC385B0;
        Sun,  8 May 2022 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032704;
        bh=W9XDT+V3KiRP5mhazcu8AxHkS57sih/DWnzHi9JKOcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ridokq6KibJWAA60OTolUnPjx8tlleeCQlkqN7CuTHSBmbuZkQ8Qx03hcNCWENvm7
         gpINqmcZBvJmV6Ze2BSHFqhV9CkVWkjFb5Z84rIllpUrPe2JOGJdMmwqCGMWGYzb/d
         qCpNOrbdu81uA6jwWpjvquRcfp1DamcwMvVhu8MQpwRNhB2yqMYoVEnk3YMgtz+rL0
         sWfbB8J2Rp8NzHMwxHs8uBItJQs4l2H2h6XKuJbIxtqC1DhWFnVO7+KFliG1d0+dGl
         w8W7EEuQwwL0JjBRPkEuQLtWcvu8xweuBX/i7Z4IuvBL2hJc1/7Z58urmz/5B5bbpU
         lrmr5TTIfFyAw==
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
Subject: [PATCH v2 74/92] iio: gyro: adxrs450: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:54 +0100
Message-Id: <20220508175712.647246-75-jic23@kernel.org>
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

Fixes tag is inaccurate but unlikely anyone will be interested in
backporting beyond that point.

Fixes: 53ac8500ba9b ("staging:iio:adxrs450: Move header file contents to main file")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/gyro/adxrs450.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 04f350025215..f84438e0c42c 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -73,7 +73,7 @@ enum {
 struct adxrs450_state {
 	struct spi_device	*us;
 	struct mutex		buf_lock;
-	__be32			tx ____cacheline_aligned;
+	__be32			tx __aligned(IIO_DMA_MINALIGN);
 	__be32			rx;
 
 };
-- 
2.36.0

