Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8620E5A5
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 00:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgF2VkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jun 2020 17:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgF2Sk3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90E423788;
        Mon, 29 Jun 2020 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593425160;
        bh=S/028/T4D/qxOGzfnD82RkUsGl9B5obM8ntirv37wV4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bxBHW4gXnKqLBK8or9GGXDtuPP5ZrAlrmdMO+Zn6Aij5ea7VVa+R9hPgMGy06aG3j
         mY6Rmf1yuC4smyM5Rs/xi/+nzi72DjrH1mGk9/55Mclf3i2CUzGyfG0ywyEZaBsmod
         +L9RtJ0iRC/a6WE5Sca7VBMX2r8VZr5ZKAa75sTM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: magnetometer: bmc150: Add proper compatible for BMM150
Date:   Mon, 29 Jun 2020 12:05:37 +0200
Message-Id: <20200629100537.20365-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629100537.20365-1-krzk@kernel.org>
References: <20200629100537.20365-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The compatible for BMM150 should not have "_magn" suffix because, unlike
two other Bosch devices, it is only a magnetometer.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Add compatible only for bmm150.

Changes since v1:
1. New patch.
---
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index fb45b63c56e4..876e96005e33 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -58,7 +58,8 @@ MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
 static const struct of_device_id bmc150_magn_of_match[] = {
 	{ .compatible = "bosch,bmc150_magn" },
 	{ .compatible = "bosch,bmc156_magn" },
-	{ .compatible = "bosch,bmm150_magn" },
+	{ .compatible = "bosch,bmm150_magn" }, /* deprecated compatible */
+	{ .compatible = "bosch,bmm150" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bmc150_magn_of_match);
-- 
2.17.1

