Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA1518080
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiECJGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiECJGP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24319C2E
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B5261307
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2880C385B0;
        Tue,  3 May 2022 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568562;
        bh=Ysnp6df9y0j0sWUgTd0LRze5Sb22RByTuKGgjtyPgTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXZBIeyBlPxFv893jDb2lxhw6sWnOZdd1Hysln3MvV+kaoU+LO+3IsVokMOmzfm1t
         +jXWkCUDWAu4HVJGitv698ZyW5KOHvun/WIYCHfwtxgVZtrfYcfu61fAzYZOkVCocM
         oRsJvgfMSUP0N/kIjNHt3AAlXwsWF3wXZIhZBB1PfaXd/MNc0v162YsoP43IlwRmcj
         bYgim4W4GkufC1rcbvFPnZ2A84sUoYK874thoPLdGK7zU/9G5A1TBy9u3oWyuxXepD
         0+V1RIehfaFt4TVdCGy1vQ3HIsVI1eaK6nZ8piai4lc+CqOUTlF/0O2Ax4EX2LhcIH
         7Z2NWRa4ZIU8g==
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
Subject: [PATCH 70/92] iio: frequency: admv4420: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:13 +0100
Message-Id: <20220503085935.1533814-71-jic23@kernel.org>
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

Fixes: b59c04155901 ("iio: frequency: admv4420.c: Add support for ADMV4420")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/frequency/admv4420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
index 51134aee8510..71c1af6fd56b 100644
--- a/drivers/iio/frequency/admv4420.c
+++ b/drivers/iio/frequency/admv4420.c
@@ -113,7 +113,7 @@ struct admv4420_state {
 	struct admv4420_n_counter	n_counter;
 	enum admv4420_mux_sel		mux_sel;
 	struct mutex			lock;
-	u8				transf_buf[4] ____cacheline_aligned;
+	u8				transf_buf[4] __aligned(IIO_ALIGN);
 };
 
 static const struct regmap_config admv4420_regmap_config = {
-- 
2.36.0

