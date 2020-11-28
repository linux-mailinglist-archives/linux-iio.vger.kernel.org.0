Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681162C748F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgK1Vtb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgK1TGz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:06:55 -0500
Received: from localhost.localdomain (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AEBA246C8;
        Sat, 28 Nov 2020 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606580743;
        bh=05mSPJnUTnmxcfBvZBO9a3LSl9kLzh0/TNk7myUgmIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPsXPi14NXFk4547RjZgxhX/+i6s17vch0zN378J0JAu8Wc7UNNrJH73ghl+4/2r4
         3LRPzs/rpeiC96k6Zv15MCCZkZ7gfXfu47z2ITbJugJajgGq4PjuTeQM8QA6qVz5bJ
         F2Qtvo1BB5dKnDtJDDqBh0oLIBokNpAU5bzBDOh0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio:health:afe4404: Fix naming of tx supply to match dt-bindings
Date:   Sat, 28 Nov 2020 16:23:34 +0000
Message-Id: <20201128162334.382837-2-jic23@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128162334.382837-1-jic23@kernel.org>
References: <20201128162334.382837-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This has always been inconsistent.  The binding naming is better
so lets us standardise on that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 87aec56e27ef ("iio: health: Add driver for the TI AFE4404 heart monitor")
---
 drivers/iio/health/afe4404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 61fe4932d81d..95547864fe8e 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -493,7 +493,7 @@ static int afe4404_probe(struct i2c_client *client,
 		}
 	}
 
-	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
+	afe->regulator = devm_regulator_get(afe->dev, "tx");
 	if (IS_ERR(afe->regulator)) {
 		dev_err(afe->dev, "Unable to get regulator\n");
 		return PTR_ERR(afe->regulator);
-- 
2.29.2

