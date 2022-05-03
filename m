Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8453E518074
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiECJFF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECJFE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:05:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8712AAD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24ED4CE1D7C
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484AC385B0;
        Tue,  3 May 2022 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568489;
        bh=WxispHWvlGsxkZ9qEZbGd2XZ74iNBDL72F6E07p6jF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xaic3e63np8XbeSmXvEztE40fG31oBoIpOx48WXT24pxSrL4803/+n2NniXSVnnXY
         ZVWXzOcngJ53cB1HxyhkYqXEm1hFWEY9g2gptCS8GHuEiQPtQJ2w933RMpT9R9nuc7
         JvlYqOkCv3y8ZTNLE9hd7YJKm+ZUb4rrZfcsAQBPKT4zx588zwtHgm/IB4/tp/H8gs
         EDhXa82yVXl3aZbaW3Fz9D3O2CbnWD6nTYxd5nMA29fiDBj/mue0vrMrcUWXA99XLc
         cql+DL2BS4Vw+rQuO5ilWpwpDGjBEHejC5D+lJcXan/70AKY+zQaWVv2Zx9ErayIV9
         NRYaNwuPbfiUg==
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
Subject: [PATCH 62/92] iio: dac: ti-dac5571: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:05 +0100
Message-Id: <20220503085935.1533814-63-jic23@kernel.org>
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

Fixes: df38a4a72a3b ("iio: dac: add TI DAC5571 family support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/iio/dac/ti-dac5571.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 0b775f943db3..0a13df8101b4 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -52,7 +52,7 @@ struct dac5571_data {
 	struct dac5571_spec const *spec;
 	int (*dac5571_cmd)(struct dac5571_data *data, int channel, u16 val);
 	int (*dac5571_pwrdwn)(struct dac5571_data *data, int channel, u8 pwrdwn);
-	u8 buf[3] ____cacheline_aligned;
+	u8 buf[3] __aligned(IIO_ALIGN);
 };
 
 #define DAC5571_POWERDOWN(mode)		((mode) + 1)
-- 
2.36.0

