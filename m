Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89E518052
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiECJB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiECJB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:01:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CAC36302
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1901B81AEC
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F83C385B2;
        Tue,  3 May 2022 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568303;
        bh=kH4OfT6BluApA/vIitrHwnr5GXk6JL5ZqnPVVgRO4zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnpwsnjjZZlEEra44o/gZM1BWoIiD9cc+BRE35wp3tb7ELjjC/h2glyjcrpHSzMbR
         ExXj+mRf1qio0paVVOh7WgyqnW8q2f1X99zBofYJuDGs8D3T1h2aykwhTgKkHhWzXT
         Mt4Klf3ExArNEKdXk7CTkjmZZ9XSJqZYlvX7wd8CVIj0hyfPXH2A1k4kKhvbD/xApb
         jp2WH2/MSV3sIilfA5OrbCI6LuDQhIGm1XNFAiKLxlc/hBJPFGq/67ET2CoaS7SPvQ
         vNwph1UcYaZQxOBHdkv+lO0DS9yW0OUtMtzGi/PWoIg0DD8w4M/zrDI1omdz1dOTOp
         lUMaDY1sPJeuQ==
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
Subject: [PATCH 42/92] iio: common: ssp: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:45 +0100
Message-Id: <20220503085935.1533814-43-jic23@kernel.org>
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

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/ssp_sensors/ssp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index abb832795619..33927e837022 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -221,8 +221,7 @@ struct ssp_data {
 	struct iio_dev *sensor_devs[SSP_SENSOR_MAX];
 	atomic_t enable_refcount;
 
-	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)]
-		____cacheline_aligned;
+	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_ALIGN);
 };
 
 void ssp_clean_pending_list(struct ssp_data *data);
-- 
2.36.0

