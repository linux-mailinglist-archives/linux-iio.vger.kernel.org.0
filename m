Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ACD51801D
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiECIzs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECIzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699D20BFD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BB82B81A56
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8875C385B0;
        Tue,  3 May 2022 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651567932;
        bh=k8lrlU1EJFTuTAIMI9l2v+LwrJS7ciXRC7FdaIeuPSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be5axW7J4Y/iaOGSSCLQsWZedJwL4d8Dvpc1EmaRdujJodKUpN4UcRRcOJmHf36mt
         ZOIkltyiyK5177gPGPyYkO/RFYS4Ubt25JpDuINzXEHfVLmzK4FvtLxGkMxaiancGe
         FzK+J4NYsI3WwEyNse6hL/bmmlcp2CQlIX61v8VYPsVWE23n5h7ekvrXbizXZM/MyS
         L3oBJqO+FII1c81myP/uiynkgiqgP3SSCp1ZoVbix7BCZynN+ztFTXbEXBiOz17wA2
         WP/c+56zK+qqVuda7HFf8S3bUoPZ+LVyp8yedQDgEOrJXMNUNAEl924haTKQQwxgqS
         e1stKfPQT30EQ==
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
Subject: [PATCH 03/92] iio: accel: adxl355: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:06 +0100
Message-Id: <20220503085935.1533814-4-jic23@kernel.org>
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

 ____cacheline_aligned is insufficient guarantee for non-coherent DMA.
Switch to the updated IIO_ALIGN definition.

Fixes: 327a0eaf19d53 ("iio: accel: adxl355: Add triggered buffer support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index e9c10c8c32f0..50513db39ee8 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -177,7 +177,7 @@ struct adxl355_data {
 			u8 buf[14];
 			s64 ts;
 		} buffer;
-	} ____cacheline_aligned;
+	} __aligned(IIO_ALIGN);
 };
 
 static int adxl355_set_op_mode(struct adxl355_data *data,
-- 
2.36.0

