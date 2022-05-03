Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5751802C
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiECI5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiECI5n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:57:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF735DD0
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5280B81BE6
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDD9C385B0;
        Tue,  3 May 2022 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568049;
        bh=UCgM/j0Xkhj1HqBdk6oBVY4FaPJC8EcwEtoutlNABXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzaZH6pWto/Cnq/AlJxeevKfQcyZ93KpWyMvrM/sydees+aQF9RmpRP4ZMXTO6RW5
         XOuWPpfWCYtMdjgE2ROYKDuEIgrEHWQ9nqoeaIg6e85hVXJQkMvGf6/UPruq6uia2Y
         B/EBEEHz7wXAUAl8964kGOZBEAPwpTPnBZ7rX3ajQNKHu76bHOfS7B6ZyWYExOy05B
         iB2vpA34YnGfi3gAT+duL/vpehSuYrCvfh3Qb7iCC4KhxTLzbG1Q7lji7p4pjYMEIh
         wSiDqEeelmPsWYGhtDQQuqBOG2n4hmA5anP7Q44v9J4offFUa4F9mprOR/5mN0Bqvp
         jG00cnFU3a80Q==
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
Subject: [PATCH 15/92] iio: adc: ad7766: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:18 +0100
Message-Id: <20220503085935.1533814-16-jic23@kernel.org>
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

Update the comment to reflect the fact DMA safety 'may' require
separate cachelines.

Fixes: aa16c6bd0e09 ("iio:adc: Add support for AD7766/AD7767")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7766.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 51ee9482e0df..f26115967bed 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -45,13 +45,12 @@ struct ad7766 {
 	struct spi_message msg;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 * Make the buffer large enough for one 24 bit sample and one 64 bit
 	 * aligned 64 bit timestamp.
 	 */
-	unsigned char data[ALIGN(3, sizeof(s64)) + sizeof(s64)]
-			____cacheline_aligned;
+	unsigned char data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_ALIGN);
 };
 
 /*
-- 
2.36.0

