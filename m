Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A945EB2C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCSHC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 14:07:02 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:59254 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfGCSHB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jul 2019 14:07:01 -0400
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7B752C6432;
        Wed,  3 Jul 2019 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1562177219; bh=aPToY7twoPc/frU4dp+Z2DD+iPJlG9FAsZ0bAsYXf04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j8ufLMJqJsEuP/4OP3alP0ja620IMh7DMJe4xw6oONMHuHLt9efUqnYTvwaRxyW/g
         +lFZFu1QHNrqzi4x4vazeTCYph2ZnAx/ba4Awljv/zJpN6FtgAy+sw5jCN0HjgnW+n
         6ul7a+hJiSbByBjHqXrPu2Dxg3lVRTUBQ4AnpTjM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vivek Unune <npcomplete13@gmail.com>,
        Hannes Schmelzer <hannes.schmelzer@br-automation.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 3/3] iio: light: stk3310: Add device tree support
Date:   Wed,  3 Jul 2019 20:05:59 +0200
Message-Id: <20190703180604.9840-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190703180604.9840-1-luca@z3ntu.xyz>
References: <20190703180604.9840-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree support for the stk33xx family of ambient light sensors.

Tested-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/iio/light/stk3310.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index b955183edfe8..185c24a75ae6 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -679,9 +679,18 @@ static const struct acpi_device_id stk3310_acpi_id[] = {
 
 MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
 
+static const struct of_device_id stk3310_of_match[] = {
+	{ .compatible = "sensortek,stk3310", },
+	{ .compatible = "sensortek,stk3311", },
+	{ .compatible = "sensortek,stk3335", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, stk3310_of_match);
+
 static struct i2c_driver stk3310_driver = {
 	.driver = {
 		.name = "stk3310",
+		.of_match_table = stk3310_of_match,
 		.pm = STK3310_PM_OPS,
 		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
 	},
-- 
2.22.0

