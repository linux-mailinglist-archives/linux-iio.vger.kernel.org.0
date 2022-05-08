Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62B51EFAD
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiEHTPs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343565AbiEHSDv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:03:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0102B558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 11:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64680CE114E
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888F8C385B0;
        Sun,  8 May 2022 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032797;
        bh=3gXi9xDUm0BF9V/MR4Pm4CfJ1ut2/OWotlClKddHWZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gvft/P/CXAtNXZBO1/i8qyQI5IK9D3qqFcCOOFyc6XSgTzn//8ouKIQLQmvP2nmUs
         Gq4HyX3ID5IffsWudDmaEX+i2Hqyj3F3wO0VdIWPqD966LSPYu6fu4knMgLV6hXvpB
         Qp5q5ZBteLchw0uURYofGNi5NIo/on1BCQRUlbQXKMm9GIGAxi4kAo/V/VVNXzipjm
         qWIZ1JpM7NAR/kVALFHHuwfPSegm82yk5afeA1djGsNZ6f8Cpcp9fJ7orZa2c31JKu
         8KRb6XCWiBH23HPVyeyQsog2rkjWIlyRYjXv4/EhqR3hDDpQsOMVsbbBP5US87zT6y
         lvSLlAfdd1YvQ==
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
Subject: [PATCH v2 86/92] iio: proximity: as3935: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:57:06 +0100
Message-Id: <20220508175712.647246-87-jic23@kernel.org>
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

Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <mranostay@gmail.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/proximity/as3935.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 67891ce2bd09..ebc95cf8f5f4 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -65,7 +65,7 @@ struct as3935_state {
 		u8 chan;
 		s64 timestamp __aligned(8);
 	} scan;
-	u8 buf[2] ____cacheline_aligned;
+	u8 buf[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct iio_chan_spec as3935_channels[] = {
-- 
2.36.0

