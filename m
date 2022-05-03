Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389DE51809C
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiECJJe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiECJJd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:09:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2DA22BF0
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83730B81CA7
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA01C385B2;
        Tue,  3 May 2022 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568759;
        bh=OMXv4W90qHtgOaXeSLQQJLpz4PychbUbHGw5M9Mzm8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESHHJHUYv7S07nkA4QsllWinnzeJrX97x/S51PkgPBN+JjOkSNXCuz7NcWM5GeBBq
         pb9Wdc9a9taSQ4jc1hQdHXyxLuzhPgpV8mLSYkjRTq/SUpFBwLXYxaXE737A+XB4X8
         c9Zozrw1AdUgJjSr8MYylBoDjdsEUJv255quVu7G1yPEq6J3gF9BwYf9AxelyUdJw+
         F+6s0aqAZxDd5YYQu/okLZNp1E7pD+da7AG8vZPgEmTwnNs12IgLmnz1obrTuSlhHF
         PRET5Xz23DZWqUeMCx+Z2X2V71qhsaIByikHHNbQaExNJZZxpW2yCzTYvxZPM9ukk/
         AuYPx07AogAIA==
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
Subject: [PATCH 91/92] iio: temp: max31865: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:34 +0100
Message-Id: <20220503085935.1533814-92-jic23@kernel.org>
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
IIO_ALIGN definition

Fixes: e112dc4e18ea ("iio: temperature: Add MAX31865 RTD Support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Navin Sankar Velliangiri <navin@linumiz.com>
---
 drivers/iio/temperature/max31865.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
index 86c3f3509a26..e68cda4d25dc 100644
--- a/drivers/iio/temperature/max31865.c
+++ b/drivers/iio/temperature/max31865.c
@@ -53,7 +53,7 @@ struct max31865_data {
 	struct mutex lock;
 	bool filter_50hz;
 	bool three_wire;
-	u8 buf[2] ____cacheline_aligned;
+	u8 buf[2] __aligned(IIO_ALIGN);
 };
 
 static int max31865_read(struct max31865_data *data, u8 reg,
-- 
2.36.0

