Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260A1460951
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbhK1T1F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:27:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47716 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357602AbhK1TZF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:25:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEB9861117
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE542C004E1;
        Sun, 28 Nov 2021 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127308;
        bh=p7DxunBj5Nu7WENvxPEOo9sSOmiNKBWzT9kbs22b2l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVMnTg/C0MqeynGxg3Ly/DoQr9GlhCeJLcsRjsaL0E57PuDikzCwF6hjQETadZHR3
         +pnZ5UuLTCRRRX9aVTw8eh9epnPnbvr+f4WhWefG57B72OUf1ZrMfrjhgh7E7PyqCo
         IuQXhG7XtuY/Im2mPzmXIZTRtF5d1TYevyNyGWHYHcQJhaBcgtTvtiqBFKa6SVOLaA
         6q2SonFehIp3bLrc61r+ARK1hWfROWtzE9+ggcRTwgMO8/rasW2osfPil2xrapmb+1
         nokUUzwGs0eysmp1Zy5A3P0CUPTR1/ZK7Oe02wCnwcb1gIUHk+E1bWNXzDuC/Q40vm
         cq74N3+uCqMUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 03/12] iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
Date:   Sun, 28 Nov 2021 19:26:26 +0000
Message-Id: <20211128192635.2724359-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver never used anything in the of specific header.
It just wants the struct of_device_id from mod_devicetable.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/iio/dac/dpot-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 5d1819448102..83ce9489259c 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -30,7 +30,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.34.1

