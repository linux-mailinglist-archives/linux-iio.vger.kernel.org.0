Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29F2518090
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiECJHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiECJHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:07:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B81BEA4
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9B78B81BE9
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D95C385B2;
        Tue,  3 May 2022 09:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568655;
        bh=VAhpmlMeH2aApDfe/0axsTpA1LC4LtU6ooNWbXK4evE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmCOOiEMI04eVouaL/RbcjedPW97kPupxhgoebmivqbgoSkAfbq3jW1GlwZzYUUjd
         ZJcPW+74zF9sKQ0IA7ubrTsEEQlipS7i+QT9aHgOHYgHUHjgIw35AkLbn6bE1kvtDS
         BxiOx/kL2mjCauXEb5RDKZiVxePxzYmg6Vk8cndbKGHBVRufmO3diqeJ/talla5yXq
         STtl0Et68yK0OUKIzoktvWbYfLwGjaFGuLifI0nmB3z65NCmpNPxyzy91saWC/ujoD
         o2ASJtbMuyo0NUmqzARcQJdLWdMFpP9RGiCZPtvhhcu9eFoQXsOr3+ED7njX91f7ED
         /2XhhdpABa9cA==
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
Subject: [PATCH 80/92] iio: potentiometer: ad5110: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:23 +0100
Message-Id: <20220503085935.1533814-81-jic23@kernel.org>
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

Fixes: d03a74bfacce ("iio: potentiometer: Add driver support for AD5110")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 drivers/iio/potentiometer/ad5110.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
index d4eeedae56e5..29f9a9037077 100644
--- a/drivers/iio/potentiometer/ad5110.c
+++ b/drivers/iio/potentiometer/ad5110.c
@@ -63,10 +63,10 @@ struct ad5110_data {
 	struct mutex            lock;
 	const struct ad5110_cfg	*cfg;
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers live in their own cache lines.
 	 */
-	u8			buf[2] ____cacheline_aligned;
+	u8			buf[2] __aligned(IIO_ALIGN);
 };
 
 static const struct iio_chan_spec ad5110_channels[] = {
-- 
2.36.0

