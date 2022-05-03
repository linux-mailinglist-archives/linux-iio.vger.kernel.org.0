Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3451803B
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiECI7U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiECI7R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F122DD5B
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9828CB81BE9
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D23C385B3;
        Tue,  3 May 2022 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568142;
        bh=NVv3Sup2Gh4TtjUUTxM5mU3w5irBaqRQooRtwe82l1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6LnshQ7XWuAdsNf/5LHNfq7eRtdKzOOsuCfLAAK0N8njZoM2Vhse8pf4/aF4Yqh9
         q0yBAu2sM1eg+QHFF1xkESURO+TwkC77FlLwv5oOGxau8fodCtQ5Lst0Dlb2ViNxJr
         QfJQQBPWODGM16/1/Z3tkjDKDCsvLHTi6FqQLx2escJnsR5RB5ctXhHsT1T5PzKMQk
         yFVIlC6dpST7wQc1YuzOI4hZ0I4kdJiMtlj94gMD7a8Aa70j5HK6kCyxzpfOF9DhIP
         UQKIJJ54wpf8tr30RtDgAs3ZMVrV6Mnzt1zDAIyFvD1oOaY4hmx/9tRla2dBVrnOkC
         X8Qb4Snypox5g==
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
Subject: [PATCH 25/92] iio: adc: max1118: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:28 +0100
Message-Id: <20220503085935.1533814-26-jic23@kernel.org>
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

Fixes: a9e9c7153e96 ("iio: adc: add max1117/max1118/max1119 ADC driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/max1118.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index a41bc570be21..6520acaa6938 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -42,7 +42,7 @@ struct max1118 {
 		s64 ts __aligned(8);
 	} scan;
 
-	u8 data ____cacheline_aligned;
+	u8 data __aligned(IIO_ALIGN);
 };
 
 #define MAX1118_CHANNEL(ch)						\
-- 
2.36.0

