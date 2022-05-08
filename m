Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F151F016
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiEHTTF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiEHSBo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE85558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AAF16127D
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ECFC385AC;
        Sun,  8 May 2022 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032672;
        bh=ehkdyk1L11u4OWYtaku2Cm5Jmsv1a9e69aPy5nrsSEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qin3vyr5A2FxFQ2Suhfl6eWxwY/lDCaoGidoBfjRwo45lI/uR5CUmiGA3pQz+3wKn
         4l9ucYmbEJmCjHHcKGfGrp1FL39hQOHrspL5YpgOZUgLeDN6wg2KQkos+e22EUrWEx
         yus5oEEFVBmY8ifMs9LIrn20vV6dTWpTRPAevfU1tPF3zcSHpJurw3HnAqVYJKbadL
         f/3hDKUQb1smgSo++yOg+Sef6sVDoj3+cfgfEQHZPJ+SfA5xjjPeK76pC7Mvbmocuu
         qgOQpHhVu6RAN4h6dbGZiyrR/4M+haO9KiKutnJJOJErw+weQRB3eXHAX46tWyXLfE
         8tRltpnLXkUqQ==
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
Subject: [PATCH v2 70/92] iio: frequency: admv4420: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:50 +0100
Message-Id: <20220508175712.647246-71-jic23@kernel.org>
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

Fixes: b59c04155901 ("iio: frequency: admv4420.c: Add support for ADMV4420")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/frequency/admv4420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
index 51134aee8510..863ba8e98c95 100644
--- a/drivers/iio/frequency/admv4420.c
+++ b/drivers/iio/frequency/admv4420.c
@@ -113,7 +113,7 @@ struct admv4420_state {
 	struct admv4420_n_counter	n_counter;
 	enum admv4420_mux_sel		mux_sel;
 	struct mutex			lock;
-	u8				transf_buf[4] ____cacheline_aligned;
+	u8				transf_buf[4] __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct regmap_config admv4420_regmap_config = {
-- 
2.36.0

