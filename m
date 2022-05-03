Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08EB518097
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiECJJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiECJIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80198DE4
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0792D61357
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183EBC385B1;
        Tue,  3 May 2022 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568711;
        bh=jY2MaLUibDxv+r82/k9lqoRPwb6qIHU86LKAoM7J2zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9NcUuXW0TSHf/euVgIkGSdPYGlPzz2QO2vT3jZDifAFV8p4mBaB1R2itmi9GBRDi
         f56zWtB/6C54F2EyKniKN3KLHkUIPGY3ytlev3LgVXGM+k9PBG35AZ0Zf8J09RIz9l
         KyseEZXK5XKDJR0DhHELqV23yMAFekmUIOIsZeqErNAP0MtPoIYiqW3a+Dh9t/xHTv
         tv4eDbKlyoBofxjgqkjzSmTYAuWrv6je8QcUSxb5U65T1M+q9Ds9yOKPr+nfQ5RZRJ
         Vf+Ppk4OY1DcirCs/0DPtikm7OCkuI8IW3LZw4yncFzwhEhPLsr31yO7C9Wun8HP5L
         oHKxA6KZs/7hA==
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
Subject: [PATCH 86/92] iio: proximity: as3935: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:29 +0100
Message-Id: <20220503085935.1533814-87-jic23@kernel.org>
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

Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/as3935.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 67891ce2bd09..e4a6d0de47f4 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -65,7 +65,7 @@ struct as3935_state {
 		u8 chan;
 		s64 timestamp __aligned(8);
 	} scan;
-	u8 buf[2] ____cacheline_aligned;
+	u8 buf[2] __aligned(IIO_ALIGN);
 };
 
 static const struct iio_chan_spec as3935_channels[] = {
-- 
2.36.0

