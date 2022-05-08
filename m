Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C451EFC2
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiEHTQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbiEHR6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E4DFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F357DB80E3F
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B945C385A4;
        Sun,  8 May 2022 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032459;
        bh=aH8YNNperI/poj9AmCgtkKVQL+tLzbatlbBWI76El0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duVcheFmG6mRurPr1TQyNMv31omvf5tEZxciveYD13M4ySTSkCuF1R1QaSTok1Aog
         8QJh4K6ar/RJ/CfEVQdogvI1w6LuCgsGoNWBLOCmLgNvUP2oFC+6Db6OfQ8E6WMxWn
         gUx4uAIM5/gQ7rf9YzCz+u96gpsmTjNGWn2IQr9uM/whwwUjsIldjCA1tU9nNZOkmX
         lBJZ4VKfOgWXMwIsM/wcKXZcBTqPxisQTsqbnxBOCwGats5SMt4Yx2aUtjIM3MknNv
         1QJxa8Q08SILbkQJkIqKUdqF77Ex++3o9zrD36uw114rEeRWDrirw5TG4Sv9ayMBoX
         Kmp9ArUNLn9TA==
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
Subject: [PATCH v2 42/92] iio: common: ssp: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:22 +0100
Message-Id: <20220508175712.647246-43-jic23@kernel.org>
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

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/common/ssp_sensors/ssp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index abb832795619..f649cdecc277 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -221,8 +221,7 @@ struct ssp_data {
 	struct iio_dev *sensor_devs[SSP_SENSOR_MAX];
 	atomic_t enable_refcount;
 
-	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)]
-		____cacheline_aligned;
+	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
 };
 
 void ssp_clean_pending_list(struct ssp_data *data);
-- 
2.36.0

