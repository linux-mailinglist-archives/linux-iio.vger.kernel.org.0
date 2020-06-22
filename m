Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770CB202F9B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 08:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgFVGBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 02:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbgFVGBY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Jun 2020 02:01:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFAB23B43;
        Mon, 22 Jun 2020 06:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592805684;
        bh=6nLebhv8dk5YD7pf6tUTXOzj3cAi77aTsIEqJh8azO0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W5FFWSIF0uo3SPQSMbOCS4IowYdkQjbfH8v6L/vBnHps1lGVs+Rbn4jFDvXtIzuAy
         Gv5glWnJMFS3+Z2o07O+cO2GDW2a6r4bs1XYhQ/DUbVvoe3viZtU8YcNQVPq5JheeW
         0z0AN5IzbsmJxvSetj6YJB9ldNbd+/WgCUiX8OzQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: magnetometer: bmc150: Add proper compatible BMC156 and BMM150
Date:   Mon, 22 Jun 2020 08:01:10 +0200
Message-Id: <20200622060110.23192-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622060110.23192-1-krzk@kernel.org>
References: <20200622060110.23192-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The compatibles (except BMC150) should not have "_magn" suffix and
BMC156 is compatible with BMM150 so use just one compatible.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch.
---
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index fb45b63c56e4..038618da99f3 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -57,8 +57,9 @@ MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
 
 static const struct of_device_id bmc150_magn_of_match[] = {
 	{ .compatible = "bosch,bmc150_magn" },
-	{ .compatible = "bosch,bmc156_magn" },
-	{ .compatible = "bosch,bmm150_magn" },
+	{ .compatible = "bosch,bmc156" },
+	{ .compatible = "bosch,bmc156_magn" }, /* deprecated compatible */
+	{ .compatible = "bosch,bmm150_magn" }, /* deprecated compatible */
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bmc150_magn_of_match);
-- 
2.17.1

