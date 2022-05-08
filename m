Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC251EFE0
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiEHTRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbiEHSD4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17A558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 11:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB82E6128E
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 18:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21823C385AF;
        Sun,  8 May 2022 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032805;
        bh=MqfuWBy+UOjoIgppdOJg3MAw204MEnmRqo9dMleoeW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fcs1hd93sbUFgcD2+klSvdbapUyOy+QCrTVUESorsPVkXgI4QsSMzRDkIAEhJlITP
         Aw1BhR4T65vpZoFOTZf+9PHc/yA2b4PQELBTNb7nhJDUjDu9q9W2ZVbZKaOT892eG7
         mly59MN1a2ul9skKrqwHapaKg9VJBbaT7CEkG1zugmELs+1izJCaGizIMxcHPZQADq
         Xzfa1S2wolmv6Zar3JxolX+pUJhdCQE1+KbmkPTcfMR/wRw1WSQyZMj9Hbd5im5iN9
         Q8L1fN+qGUnb+EUXK4l4Em1UcjLaietZohh+D9Az/HfIkupRTrYZPrmW0jKzJhXq6u
         QfJNwYsGJT7mw==
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
Subject: [PATCH v2 87/92] iio: proximity: vcnl3020: Drop unnecessary alignment requirement for i2c device
Date:   Sun,  8 May 2022 18:57:07 +0100
Message-Id: <20220508175712.647246-88-jic23@kernel.org>
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

I2C does not by default use buffers directly for DMA so there is
no need to ensure they are DMA safe.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/proximity/vcnl3020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index ff83638db16f..cbc8400c773c 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -71,14 +71,14 @@ static const int vcnl3020_prox_sampling_frequency[][2] = {
  * @dev:	vcnl3020 device.
  * @rev:	revision id.
  * @lock:	lock for protecting access to device hardware registers.
- * @buf:	DMA safe __be16 buffer.
+ * @buf:	__be16 buffer.
  */
 struct vcnl3020_data {
 	struct regmap *regmap;
 	struct device *dev;
 	u8 rev;
 	struct mutex lock;
-	__be16 buf ____cacheline_aligned;
+	__be16 buf;
 };
 
 /**
-- 
2.36.0

