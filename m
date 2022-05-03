Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43451807A
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiECJFn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiECJFl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:05:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4819C2E
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F49DB81AEC
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275AAC385A9;
        Tue,  3 May 2022 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568527;
        bh=oQcmqylFB91K7l0dhVmtsNwaSNmXTk1+DyriF1ZjgJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LilpYdWnFY/S4vfDzcSwZTlVPY8znsn0hmWx2Hp85F5yVCrka1lyDGSZa0LA7fr4s
         N/5+Yak3NzeKSuasCVrqnf7r+IXZq3OcdNIEFrt1yuwyMjfX3YbPsuZzdSk5OTJl0I
         YADpTSzO+KVSQsH5PPG2UzOE0wqsp8eIfh1/Zf+VUEP7KvjOXkyVn4eF0FLb2ipuR0
         j1GV8SPebSeejm8fX42aSVzflG4XbnqC9XaWFNUB6JcX8l/WYO/UZNWtz9veTZpw0e
         8/CGHQjriQLkaUU0SYX4bRuXurp1LB7wiMR80Du0wGwahckdhPETMfEHPhSgWkwDRf
         lDkIcbETqI4Vw==
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
Subject: [PATCH 66/92] iio: frequency: adf4350: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:09 +0100
Message-Id: <20220503085935.1533814-67-jic23@kernel.org>
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

Updated help text to 'may' require buffers to be in their own cacheline.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/adf4350.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index be1218d86291..eba8616fc295 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -56,10 +56,10 @@ struct adf4350_state {
 	 */
 	struct mutex			lock;
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
+	 * DMA (thus cache coherency maintenance) may require that
+	 * transfer buffers live in their own cache lines.
 	 */
-	__be32				val ____cacheline_aligned;
+	__be32				val __aligned(IIO_ALIGN);
 };
 
 static struct adf4350_platform_data default_pdata = {
-- 
2.36.0

