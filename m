Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119751EF9D
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiEHTPD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbiEHR4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE4DFEA
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A76EC6127D
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A140BC385AC;
        Sun,  8 May 2022 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032333;
        bh=LUtFV/VpLeH2QZqdyJGIswKbijSeuCa4TOlOfFtP4Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjnJ6ZwkoDQSR+Hk/OATmUl8b+iNxK1SQ0Ok6PR3mdetYVfX+mUdEarA+6eDHaHk0
         Q1FJq4+tr8MqgViGbQdcSc7VUGfZtV/pvDTopGGluiXgIy5eynEs9F9VyXbWRYJ4+O
         63ucMHV+fT/jEi4rmJnxwlyHAUhefGHCrIJHv4/gIsLhP42/bToV78VrG1pHjQbsxy
         li4RbKfd3c73mTDbv7HRPNLpLzdkYJ8QiSpcNhm6IpcFq8Qj6uG9Iw3yLTcF8qGa3/
         TXUzmQ+rJhiXX/hgVXAn+fuDryMxKcdW+GgzG1DhpTgCX1W9xM6xyuMJ4MXD/V6jU9
         3B9wkqMvk8xqw==
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
Subject: [PATCH v2 25/92] iio: adc: max1118: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:05 +0100
Message-Id: <20220508175712.647246-26-jic23@kernel.org>
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

Fixes: a9e9c7153e96 ("iio: adc: add max1117/max1118/max1119 ADC driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max1118.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index a41bc570be21..75ab57d9aef7 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -42,7 +42,7 @@ struct max1118 {
 		s64 ts __aligned(8);
 	} scan;
 
-	u8 data ____cacheline_aligned;
+	u8 data __aligned(IIO_DMA_MINALIGN);
 };
 
 #define MAX1118_CHANNEL(ch)						\
-- 
2.36.0

