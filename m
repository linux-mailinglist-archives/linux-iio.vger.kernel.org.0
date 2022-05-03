Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB5518072
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiECJEn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECJEm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE012AAD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F34A6126D
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB33C385A4;
        Tue,  3 May 2022 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568470;
        bh=4I/dahFygrwDzrRUni0ggTB50Rl1eibjtsmXJ0NOILA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiUH5FgF5YwFjF/i8MM6j9dIgcEqoXTIw+f0Hh8HuH5TOwqpQ6z7+idMGT84bsMj7
         3k+ra6VbyDsIF8yI/DJBOWRh4ZvuWA6TCwNijzdZXYL5+MAzcZ0suNwHHNjpuQJHGG
         SpF0kCynuh+sHiKOYnm0AVzmWpfI5icTg2VSrd7UEwxtzl8mS06uLwQqS5uNM4iD0D
         hertwDl8ayz0GBw/U06yMuVv/YaYnYk2jO4/QmjnYaSKkuP5HBlLRB44V/HXMYngGp
         +6/Pp7sFAXYxa5Uv6oRQqKmodzK1ApchzMDqktH4wAczM8KkA+raOnEgo/8hBGaA4Q
         ZMnlXM0rUOBPA==
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
Subject: [PATCH 60/92] iio: dac: mcp3922: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:03 +0100
Message-Id: <20220503085935.1533814-61-jic23@kernel.org>
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

Fixes: 1b791fadf3a1 ("iio: dac: mcp4902/mcp4912/mcp4922 dac driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Welling <mwelling@ieee.org>
---
 drivers/iio/dac/mcp4922.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index cb9e60e71b91..5252cc93f693 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -29,7 +29,7 @@ struct mcp4922_state {
 	unsigned int value[MCP4922_NUM_CHANNELS];
 	unsigned int vref_mv;
 	struct regulator *vref_reg;
-	u8 mosi[2] ____cacheline_aligned;
+	u8 mosi[2] __aligned(IIO_ALIGN);
 };
 
 #define MCP4922_CHAN(chan, bits) {			\
-- 
2.36.0

