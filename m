Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B03518021
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiECI41 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECI40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:56:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5F920BFD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32D09B81BE0
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68350C385B1;
        Tue,  3 May 2022 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651567972;
        bh=4tsRDGAcD+68l8OlJcHhJp9KeN7ffiYjsAH1rSx2e44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iG6OmtQf8DOfgsLZ63IusHs41pQ3Nijq3LqMFqZDvV+LLpVsVhETNZ2/Xnl1JhMrH
         4P8Q/pRimcAOFXSnv0v5tNe6Pln1TRxJi9J/0asFNuHEAqO7+I3iTI/WS726QWyobC
         pBdZQ+3kNoLvvxxSAksydS4KUAfJ7rfOUeNrElz1G6I0Noyj8SCZvhwObbs3+MAB52
         wuP9h8KiQIYYFXlgMbJeo0E7P1K2si6yutAswDWt6q9l7gTW2gVPj+4Xq5/qwEC59z
         kSDI1tV4/5mhKNimMd+m2pBmpmRwx0dBLxF/CCDS6NRF4RktkrlEOdEkxyAkDO2S8h
         TsS9fFvacJehg==
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
Subject: [PATCH 07/92] iio: accel: sca3000: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:10 +0100
Message-Id: <20220503085935.1533814-8-jic23@kernel.org>
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

Fixes: ced5c03d360ae ("staging:iio:accel:sca3000 merge files into one.")
Fixes: 152a6a884ae13 ("staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/sca3000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 83c81072511e..a8897b684210 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -167,8 +167,8 @@ struct sca3000_state {
 	int				mo_det_use_count;
 	struct mutex			lock;
 	/* Can these share a cacheline ? */
-	u8				rx[384] ____cacheline_aligned;
-	u8				tx[6] ____cacheline_aligned;
+	u8				rx[384] __aligned(IIO_ALIGN);
+	u8				tx[6] __aligned(IIO_ALIGN);
 };
 
 /**
-- 
2.36.0

