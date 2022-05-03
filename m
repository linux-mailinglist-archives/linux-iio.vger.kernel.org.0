Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6340E51805D
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiECJDM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiECJDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7A36302
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF0061301
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAFCC385A9;
        Tue,  3 May 2022 08:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568378;
        bh=H6c62zie9mcSMOO7m7x5NGfHroZCM0DQttAmMJAV7/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyDG/Xz1de8f5f/oOm/4RE4gc1b2n4FbelWBDxTs04nneU7j9X+6BkpYYxrgVgo38
         +aCaZcTRQq9h8aldtetKVK00Qw2WQRsv8MHfN+W2EVYqcw0jOV4MzX5jqD5u3XYdFN
         PAExWU5gkkOBS/a39BK0sH7ySGXs/rkDW6Li+avyXk6zqOEZujWVBB954tIYnT86Yk
         uAznwdfO/jEQE3GzbNhX8SAPbhtwuvaUpNdtc1cLUwTIjc60LG12UDBrk3BURokrXk
         0wacASSBXKX6lzIHvhvGLNS8t1duk8odRa6xuE0xRjimmREOWj0GVh9Yu78uxGqSzu
         4iY/5yCYgGjXw==
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
Subject: [PATCH 50/92] iio: dac: ad5755: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:53 +0100
Message-Id: <20220503085935.1533814-51-jic23@kernel.org>
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

Fixes: c499d029d805 ("iio:dac: Add ad5755 driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5755.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 7a62e6e1d5f1..90bc293528fb 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -189,14 +189,14 @@ struct ad5755_state {
 	struct mutex			lock;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
 
 	union {
 		__be32 d32;
 		u8 d8[4];
-	} data[2] ____cacheline_aligned;
+	} data[2] __aligned(IIO_ALIGN);
 };
 
 enum ad5755_type {
-- 
2.36.0

