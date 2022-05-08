Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2416151EFB2
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiEHTQB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbiEHSDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98C5FBC
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F896129B
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A5C385A4;
        Sun,  8 May 2022 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032790;
        bh=Ro/0sJtpPddUt4j3C+sOPGiH3GXgP/ZIqTow1LTGIbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JySX9uaeSj6qUpT3a+jOSlHLCJSmBHW3NrpOUCt80JAWBakNknRr2GZkxj7N6cvtw
         xG86P9utrVtI04Z2v2svJ82ZURyfkWsU6Jr8UwVNYLQshrx9szHNnMI4VIvjfXayeo
         2BIAliNGq9w4mCH6tbyOia0LuSbGtK9gEOoAD7YY6OVorGdNmY8lVzaVjj1hwWRFwj
         8MCgU2o2TJxUWLHX5ibqV7w0Q50lMrw5d+EBhHwao2BLe4PfLgpXbBd/sSazgII6tC
         +d+ei4NVrLjBXEWR88nQFt+exU3Efebpk8suq5nMTyK+VTEGxSJ7SKuxdFHAcyInLE
         R3O7WqR3trRgQ==
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
Subject: [PATCH v2 85/92] iio: pressure: dlhl60d: Drop unnecessary alignment forcing.
Date:   Sun,  8 May 2022 18:57:05 +0100
Message-Id: <20220508175712.647246-86-jic23@kernel.org>
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

I2C doesn't use the buffers directly for DMA so there is no need
to enforce alignment.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomislav Denis <tomislav.denis@avl.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/pressure/dlhl60d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index ade73267d5eb..5f6bb3603a8b 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -47,7 +47,7 @@ struct dlh_state {
 	struct dlh_info info;
 	bool use_interrupt;
 	struct completion completion;
-	u8 rx_buf[DLH_NUM_READ_BYTES] ____cacheline_aligned;
+	u8 rx_buf[DLH_NUM_READ_BYTES];
 };
 
 static struct dlh_info dlh_info_tbl[] = {
-- 
2.36.0

