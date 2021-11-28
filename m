Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA664607FC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358683AbhK1RZO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56198 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbhK1RXO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7F76102B
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA2CC53FC1;
        Sun, 28 Nov 2021 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638119997;
        bh=dAgNzqHkJOWXo8Dl6zzENKKi5uFTUN6ntrGZcyd7uwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZf4/3YoKs7pXLlQwyxgxRb5kS9vcrwX7FenwZ8TQ12ptoBxLff+kOMyluHj2u82O
         g60sPwZ495bxiO5ltmu3sdJ7T1W9/5r16I12ZMPftfSjU+xh7MSGSNM8oK5F2GpGyk
         7EXWPNpu2GgVful6Ui7M6D8xEMrrx0cL4GRtc8U3f223shDzVYs6PfqYqCkuU6dego
         WE6qV2eHKltT5L4G5qQPNsAATbrqYvTmQR72mPr1uIkguwiJqkcIj+E/TtN7UZ7k8B
         P85FRLOdhmaKG+ydqrnf1A6vsvuVRLejawYYvzpVz8RBd+fy36w9ZMQYpSfn7nGeKH
         y/AbNmrusoTeQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 02/12] iio:dc:ina2xx-adc: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:35 +0000
Message-Id: <20211128172445.2616166-3-jic23@kernel.org>
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
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 352f27657238..3bea3ade6ff1 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -971,7 +971,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	}
 
 	if (client->dev.of_node)
-		type = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
+		type = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		type = id->driver_data;
 	chip->config = &ina2xx_config[type];
-- 
2.34.1

