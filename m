Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2D14335B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 22:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgATVVT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 16:21:19 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38584 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgATVVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jan 2020 16:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kW9dkyFBPi+l/UtuEQfJCB6bv7j45VQfHWVLdC4M4eo=; b=haqFFIAtTJUKI1R4fnqqUPZOm
        Lkb1q0CBTfvhOrOBbaj5pHRG39q3CURLhKIz3NiRxH4QaO1WGTolLSJX2KF1vEXjmeXcp8tg3gZdq
        UHrb3inXvGuOHgujPKCmZb5v0EDHOujJ4Lcmb0rv4eK0Ni4tcBXSLmuYy3jYt8xQwOAo0=;
Received: from p200300ccff0880007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff08:8000:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iteTo-0006vs-Km; Mon, 20 Jan 2020 22:21:05 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iteTn-0007WH-QI; Mon, 20 Jan 2020 22:21:03 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH RFC v2 3/3] mfd: rn5t618: add ADC subdevice for RN5T618
Date:   Mon, 20 Jan 2020 22:20:56 +0100
Message-Id: <20200120212056.28806-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200120212056.28806-1-andreas@kemnade.info>
References: <20200120212056.28806-1-andreas@kemnade.info>
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

RN5T618 has an ADC but RN5T567 has not, so
we need separate subdevice lists for both.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Untested, IMHO only acceptable with a Tested-By

 drivers/mfd/rn5t618.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 6828fd40b0a1..d37d7a31cf26 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -21,6 +21,7 @@
 static const struct mfd_cell rn5t618_cells[] = {
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rn5t618-wdt" },
+	{ .name = "rn5t618-adc" },
 };
 
 static const struct mfd_cell rc5t619_cells[] = {
@@ -30,6 +31,11 @@ static const struct mfd_cell rc5t619_cells[] = {
 	{ .name = "rn5t618-wdt" },
 };
 
+static const struct mfd_cell rn5t567_cells[] = {
+	{ .name = "rn5t618-regulator" },
+	{ .name = "rn5t618-wdt" },
+};
+
 static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -203,16 +209,32 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (priv->variant == RC5T619)
+	switch (priv->variant) {
+	case RC5T619:
 		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
 					   rc5t619_cells,
 					   ARRAY_SIZE(rc5t619_cells),
 					   NULL, 0, NULL);
-	else
+		break;
+	case RN5T618:
 		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
 					   rn5t618_cells,
 					   ARRAY_SIZE(rn5t618_cells),
 					   NULL, 0, NULL);
+		break;
+	case RN5T567:
+		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+					   rn5t567_cells,
+					   ARRAY_SIZE(rn5t567_cells),
+					   NULL, 0, NULL);
+		break;
+	/*
+	 * Should not happen because we come here only with a valid device
+	 * tree match, so variant contains any of the above.
+	 */
+	default:
+		return -ENOENT;
+	}
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
 		return ret;
-- 
2.11.0

