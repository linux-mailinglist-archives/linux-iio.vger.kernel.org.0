Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7C460806
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbhK1R1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358648AbhK1RZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:25:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E7C061757
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 09:19:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BB5B80D29
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B1C53FCB;
        Sun, 28 Nov 2021 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638119995;
        bh=+fof/5humV10YTTwLAW5OWhDsMSWe1Grf91GDZivsUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK/yuKKTfTttzxhwnhgPDYKdncxfGXBouQVxY5ddGDCIqb5uxm8VGizgDXD9ebL8e
         7wtx7OzLDbIFyLprY1YW/jSnOStlftQsQlSS0YI/tFJZvcrTwyQw3froSVA6SPge94
         HhLNDdDQojQo2U/Rak6hW/W9PixuTz3iSBhWSMmoFIhxAEaBnaGiK4/Jl6qprnfl9n
         E30XMKXJaUlfXt9eRWuabgLTzTXG2VNPRTxzjHTmy6zUBeCiOgI7E8ykcI5XwMftDX
         f4VVRxQDmdho/YjiF6ZvJyHk3VEtjm+bsSHT3uLUqCLwwwgaHolhN6j7pTAcbX/4y5
         08NMKUfO3qa5g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 01/12] iio:accel:bma180: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:34 +0000
Message-Id: <20211128172445.2616166-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cast to a uintptr_t rather than directly to the enum.

As per the discussion in below linked media patch.

Link: https://lore.kernel.org/linux-media/CAK8P3a2ez6nEw4d+Mqa3XXAz0RFTZHunqqRj6sCt7Y_Eqqs0rw@mail.gmail.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 09496f358ad9..d8a454c266d5 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -938,7 +938,7 @@ static int bma180_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	if (client->dev.of_node)
-		chip = (enum chip_ids)of_device_get_match_data(dev);
+		chip = (uintptr_t)of_device_get_match_data(dev);
 	else
 		chip = id->driver_data;
 	data->part_info = &bma180_part_info[chip];
-- 
2.34.1

