Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD0518039
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiECI7U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiECI7G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:59:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0498E2B26D
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF204B81BE5
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4B7C385B0;
        Tue,  3 May 2022 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568132;
        bh=votvr6jkxER1/Y3zpT0OlDP7ViaYazCfgmE9yMu/CGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imOEE+tt4inkHm6sx96Uom0hewRCEZBXVWIPG07qvQWjESEF/WJvy1YQ8bPsfkar8
         OPMkkwB/OQy+15nJIVboiTOvRurk2VL+CN4yOeP+cPbmCj3k15eShDnWIGFoxCV8s/
         BNhIhN6ABN1QGYNlda5VxjpH2tXfCy+VBmpp8DntIlcVs6S6eHo3UYCBH6zFYktb/w
         WTNIyyaqKXdPG48L2JLLRQz3z3ZQM2Tc1lKUi0JATBjUPJTFJX+vkZmXC4NaNX3uNO
         mRUa8ashcPjtbztGpYqJ4zjrMiZjv5GpeqVFjhBdJ3o2TwFlTz9ReRK8sPM0JFsxEo
         7V1jVIcSOhl0g==
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
Subject: [PATCH 24/92] iio: adc: max11100: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:27 +0100
Message-Id: <20220503085935.1533814-25-jic23@kernel.org>
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

Update the comment to include 'may'.

Fixes: a8e7e88df9ec ("iio: adc: Add Maxim MAX11100 driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/iio/adc/max11100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index eb1ce6a0315c..4766d45344f7 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -33,10 +33,10 @@ struct max11100_state {
 	struct spi_device *spi;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	u8 buffer[3] ____cacheline_aligned;
+	u8 buffer[3] __aligned(IIO_ALIGN);
 };
 
 static const struct iio_chan_spec max11100_channels[] = {
-- 
2.36.0

