Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51EE37A920
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEKO03 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:26:29 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:22557 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhEKO01 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 10:26:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620743106; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fXEyiC7haQ4PxZrmxtAFt8JswLRL2Zs9SPjT8O+qnqKAKBMTiY1rKtGH86QFvwKPA8
    ncfouHjBh++D8KQhrECq373eGMG6qIrG7Sq6XARkqJiEgYuETkI+txj6gZUJvBKwmWPi
    Z1hRXhMASbb42SzzXoxwR56H6vQQvn2MIr33/h9eDiM968k5qijTb0GId1QVIRvOkZKC
    OBcP6Wqi1dUhUpnRLxeoPn/NaBq6WN0U134ZuV8QyUPCB92mbwdSUG2YaZXv7cMBiEgL
    klshBiMMAa/i9N7v8NH4iJoOLJTpRdpsyHtHYOzx0MWMRpBxOeDmUyyqXxe9gBwZFHsb
    Lg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743106;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+OEbI4dqqC+pKMbkLN+QIOit0AL3vAKyVsLliHvX5Hc=;
    b=IpO2bRVZi5zq3zKc4D1C/F53+0aAFGrVxOSAkpltAIvAywXuIGIzfM73j4FrS0lfYW
    ctfk8bp/9ayY7l0QztakaFYW3kftClyNGDeShN4e4xd7RAR7dg1dFO+JaY5o4pk/BZp5
    sDf9OjEkBhGmuM/82ulLw1pfgbPEos86tS9NHmEwSKppxubJpW9PIY+D0AERBIQl2cXn
    ul6jw0qnf6fqRLDwI86xFffWQEt115onqwWkiI4AxcwBebAO+NxEZWmg09a1Iz5jd37H
    opxSJOuFx3gLdA7IoEdDwlg5UemG5gNaJAkpNol6bh/rx083opCciMlp5xRucxPmNb7r
    dS4A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743106;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+OEbI4dqqC+pKMbkLN+QIOit0AL3vAKyVsLliHvX5Hc=;
    b=SZ+r6Di6MMvGN35FE4IQZ5ve9CWTJfKNA+7BJLVElXQPojJz8f4bQDiNonvCYuMYOG
    Kk7L6QRy+oWxNLed7Fm5dMzQEtLeLaYZusLHXX6KRoEogUREN8X2RnjR4RQ6YMVMZB/C
    Cnaihvc7+2yfr5iup9ZVJlfKpbqhi0lfmBSKVg5332qBwdn/Gj7jwr7oIzIRUaTcOSbC
    gSyygOMiocv6kfx03xrQxvgDWE+ji4qdibMn49KdfK8Iu5Dq8d7fffC2NZW/3dFkb9aK
    +gJttCH7rRD0gXe49sQM/Zmugve4pyPX41B1GcSgH7LTEsnccmrj6vJ0F8AxkHQgOAwy
    LAeg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.7 DYNA|AUTH)
    with ESMTPSA id j06c13x4BEP60bn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 16:25:06 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 3/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Date:   Tue, 11 May 2021 16:24:02 +0200
Message-Id: <20210511142402.4457-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511142402.4457-1-stephan@gerhold.net>
References: <20210511142402.4457-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The KX023-1025 accelerometer [1] seems to be some mixture of
KXCJK and KXTF9. It has the motion interrupt functionality from KXCJK
but also the tap detection from KXTF9, and a lot more functionality.

The configuration register map seems fairly different at first,
but actually all register bits used by the kxcjk-1013 driver are
available at the same bit positions on KX023-1025. It's just quite
misleading because:

  1. The registers have entirely different names and are at different
     addresses, but the bits are mostly named the same (and mean the same).
  2. There are many more registers and bits used that are reserved on KXCJK
     to enable additional functionality.

Ignoring all additionally available functionality for now, the KX023
works just fine after setting up the struct with the correct register
addresses. The only difference that needs to be handled additionally
is that the KX023 supports two configurable interrupt lines (INT1/2).

For now only INT1 is supported so we route all interrupts used by
the driver there.

[1]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/kxcjk-1013.c | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index ab8c972e1a35..18a96828f6be 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -79,6 +79,45 @@
 #define KXTF9_REG_HYST_SET		0x5F
 #define KXCJK1013_REG_WAKE_THRES	0x6A
 
+/* Everything up to 0x11 is equal to KXCJK1013/KXTF9 above */
+#define KX023_REG_INS1			0x12
+#define KX023_REG_INS2			0x13
+#define KX023_REG_INS3			0x14
+#define KX023_REG_STAT			0x15
+#define KX023_REG_INT_REL		0x17
+#define KX023_REG_CNTL1			0x18
+#define KX023_REG_CNTL2			0x19
+#define KX023_REG_CNTL3			0x1A
+#define KX023_REG_ODCNTL		0x1B
+#define KX023_REG_INC1			0x1C
+#define KX023_REG_INC2			0x1D
+#define KX023_REG_INC3			0x1E
+#define KX023_REG_INC4			0x1F
+#define KX023_REG_INC5			0x20
+#define KX023_REG_INC6			0x21
+#define KX023_REG_TILT_TIMER		0x22
+#define KX023_REG_WUFC			0x23
+#define KX023_REG_TDTRC			0x24
+#define KX023_REG_TDTC			0x25
+#define KX023_REG_TTH			0x26
+#define KX023_REG_TTL			0x27
+#define KX023_REG_FTD			0x28
+#define KX023_REG_STD			0x29
+#define KX023_REG_TLT			0x2A
+#define KX023_REG_TWS			0x2B
+#define KX023_REG_ATH			0x30
+#define KX023_REG_TILT_ANGLE_LL		0x32
+#define KX023_REG_TILT_ANGLE_HL		0x33
+#define KX023_REG_HYST_SET		0x34
+#define KX023_REG_LP_CNTL		0x35
+#define KX023_REG_BUF_CNTL1		0x3A
+#define KX023_REG_BUF_CNTL2		0x3B
+#define KX023_REG_BUF_STATUS_1		0x3C
+#define KX023_REG_BUF_STATUS_2		0x3D
+#define KX023_REG_BUF_CLEAR		0x3E
+#define KX023_REG_BUF_READ		0x3F
+#define KX023_REG_SELF_TEST		0x60
+
 #define KXCJK1013_REG_CTRL1_BIT_PC1	BIT(7)
 #define KXCJK1013_REG_CTRL1_BIT_RES	BIT(6)
 #define KXCJK1013_REG_CTRL1_BIT_DRDY	BIT(5)
@@ -119,6 +158,14 @@
 #define KXCJK1013_REG_INT_SRC2_BIT_XP	BIT(4)
 #define KXCJK1013_REG_INT_SRC2_BIT_XN	BIT(5)
 
+/* KX023 interrupt routing to INT1. INT2 can be configured with INC6 */
+#define KX023_REG_INC4_BFI1		BIT(6)
+#define KX023_REG_INC4_WMI1		BIT(5)
+#define KX023_REG_INC4_DRDY1		BIT(4)
+#define KX023_REG_INC4_TDTI1		BIT(2)
+#define KX023_REG_INC4_WUFI1		BIT(1)
+#define KX023_REG_INC4_TPI1		BIT(0)
+
 #define KXCJK1013_DEFAULT_WAKE_THRES	1
 
 enum kx_chipset {
@@ -126,6 +173,7 @@ enum kx_chipset {
 	KXCJ91008,
 	KXTJ21009,
 	KXTF9,
+	KX0231025,
 	KX_MAX_CHIPS /* this must be last */
 };
 
@@ -172,6 +220,19 @@ static const struct kx_chipset_regs kxtf9_regs = {
 	.wake_thres	= KXTF9_REG_WAKE_THRESH,
 };
 
+/* The registers have totally different names but the bits are compatible */
+static const struct kx_chipset_regs kx0231025_regs = {
+	.int_src1	= KX023_REG_INS2,
+	.int_src2	= KX023_REG_INS3,
+	.int_rel	= KX023_REG_INT_REL,
+	.ctrl1		= KX023_REG_CNTL1,
+	.wuf_ctrl	= KX023_REG_CNTL3,
+	.int_ctrl1	= KX023_REG_INC1,
+	.data_ctrl	= KX023_REG_ODCNTL,
+	.wake_timer	= KX023_REG_WUFC,
+	.wake_thres	= KX023_REG_ATH,
+};
+
 struct kxcjk1013_data {
 	struct regulator_bulk_data regulators[2];
 	struct i2c_client *client;
@@ -308,6 +369,22 @@ static const struct {
 		{0x05, 5100},
 		{0x06, 2700},
 	},
+	/* KX023-1025 */
+	{
+		/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
+		{0x08, 1240000},
+		{0x09, 621000},
+		{0x0A, 309000},
+		{0x0B, 151000},
+		{0, 81000},
+		{0x01, 40000},
+		{0x02, 22000},
+		{0x03, 12000},
+		{0x04, 7000},
+		{0x05, 4400},
+		{0x06, 3000},
+		{0x07, 3000},
+	},
 };
 
 static const struct {
@@ -483,6 +560,17 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 		return ret;
 	}
 
+	/* On KX023, route all used interrupts to INT1 for now */
+	if (data->chipset == KX0231025 && data->client->irq > 0) {
+		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
+						KX023_REG_INC4_DRDY1 |
+						KX023_REG_INC4_WUFI1);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Error writing reg_inc4\n");
+			return ret;
+		}
+	}
+
 	ret = kxcjk1013_set_mode(data, OPERATION);
 	if (ret < 0)
 		return ret;
@@ -1414,6 +1502,9 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	case KXTF9:
 		data->regs = &kxtf9_regs;
 		break;
+	case KX0231025:
+		data->regs = &kx0231025_regs;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1633,6 +1724,7 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxcj91008", KXCJ91008},
 	{"kxtj21009", KXTJ21009},
 	{"kxtf9",     KXTF9},
+	{"kx023-1025", KX0231025},
 	{"SMO8500",   KXCJ91008},
 	{}
 };
@@ -1644,6 +1736,7 @@ static const struct of_device_id kxcjk1013_of_match[] = {
 	{ .compatible = "kionix,kxcj91008", },
 	{ .compatible = "kionix,kxtj21009", },
 	{ .compatible = "kionix,kxtf9", },
+	{ .compatible = "kionix,kx023-1025", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kxcjk1013_of_match);
-- 
2.31.1

