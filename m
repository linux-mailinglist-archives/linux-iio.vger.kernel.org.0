Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444E11A89E7
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504181AbgDNSmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504176AbgDNSmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:42:11 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D582074D;
        Tue, 14 Apr 2020 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889730;
        bh=Qr/sUzlLBeiS7flY0fWa67V38Y7Io0QddHUGCTBCdz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wuUYtJ8paNt9+xhemECaglrMTbULZRC3febZULUIXOEiWsg4QK5aWc8ZGoaPPMyM1
         vbMRkqPzAmaIgAaJ0eyO+O7No7q2RDMvoAOsb8PLgboJRFTsqVoi3ZWLXXJRhqriDD
         lY6lBJKDmwnd2K9ZmWb9Oyd3+ES5cRI6QdRnhHCg=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 2/3] iio: chemical: Add OF match table for CCS811 VOC sensor
Date:   Wed, 15 Apr 2020 00:11:46 +0530
Message-Id: <20200414184147.4857-3-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414184147.4857-1-mani@kernel.org>
References: <20200414184147.4857-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add devicetree OF match table support for CCS811 VOC sensor.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/chemical/ccs811.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 1500e4b0dfbd..3ecd633f9ed3 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -549,9 +549,16 @@ static const struct i2c_device_id ccs811_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ccs811_id);
 
+static const struct of_device_id ccs811_dt_ids[] = {
+	{ .compatible = "ams,ccs811" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
+
 static struct i2c_driver ccs811_driver = {
 	.driver = {
 		.name = "ccs811",
+		.of_match_table = ccs811_dt_ids,
 	},
 	.probe = ccs811_probe,
 	.remove = ccs811_remove,
-- 
2.17.1

