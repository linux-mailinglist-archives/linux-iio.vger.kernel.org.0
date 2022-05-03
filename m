Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B61C518098
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiECJJG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiECJI7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F122B03
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73137B81C97
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C40C385A4;
        Tue,  3 May 2022 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568721;
        bh=qU0ktlzZKkPQeJ/knCRThD7oesOqnuxEnesVQiJ1yIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mdcjw8IEflCJi8NV+z4fNYyeOuUyGRxs06JKtcETOKpue87PmPDMeNy5FsnykIEJd
         ol8gFIOA9duXQDmp5r2ZarKzHccM3QFGRj/C6bJI0SjGBmi7QevvlNZvpwFno1lDAS
         TCgqB229TG0PytHD/c53bJD93v+zfNtJRJEY8nZxKzewF0+lQzF0H9LvW3srk5/6Cu
         MBLziGQyW2SXOj7DY0DDafcQxyZMzLt1fTuW9KVfvTNg3DvphE4NtXpQgFnIWMT1QU
         SLToMe+nDim3kH53mFaqf1cjtDWH0RItUwmEIvrY1lXdo8rbtPmki0VA4sCscM7qGN
         lStbSLi5V5qtQ==
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
Subject: [PATCH 87/92] iio: proximity: vcnl3020: Drop unnecessary alignment requirement for i2c device
Date:   Tue,  3 May 2022 09:59:30 +0100
Message-Id: <20220503085935.1533814-88-jic23@kernel.org>
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

I2C does not by default use buffers directly for DMA so there is
no need to ensure they are DMA safe.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>
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

