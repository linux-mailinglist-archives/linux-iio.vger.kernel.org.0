Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8637A432
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhEKKDj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 06:03:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:20936 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhEKKDi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 06:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620726994; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cruQWi6iQedZh2QAiAdIN6qhtYkIDkRiHNuH0i1TJ372djfUQj+zH+iIa0J9iUzdQx
    eWClUzF+uwm8bZBQPHbEXYt4fRNZS6ed+fxDRREW997ioGe4Ut4CGC1e7anALrp4JMQo
    Sb5Ma6OkLwzH/6YFSyyZQxbvCo6Iin1yvICB3LhCCCiNnOaYuT5XAly28BGJbo5WR+BD
    vsLY6RpLU0jm7Fve5TMRv3vFqMvDVIILSrEr9t2II0UR1EpOq81BItmmOdozLRF8DhoO
    O7T5L23IuhVZ4pJd1kxaGeHsb1H3k+xDjsMUNBl2wxq5Zh0UTlWEzW+ePkI10zN3frwn
    l7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726994;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=D6URkMLk8KPcvfEx/EmSnV297njs47xlSC2vdmlsg40=;
    b=tcic+vqhmMwbilx/kw/JnWdEwQSHuEev19e5vRFfnq02I1hJibjAyLDGU4HsqlEy2d
    MMjpU5aRXlcv25Lbs0rOyq1Qooge6dYl0ZKz9KsWVN0LUh16aS3/tP85/fEccOS4Y49O
    NNUCMaYIUY5sH7Rzx4L5DyxB+s+1la3zUdW33IvYV7t0+dOHY9HO2bx7P6dZUn459UxL
    T/96YBpZFJi6bhM2Lvv2+6sc0cf2IL4wDwppuJoVzuASXQeFSeTzaeMngBbVUTL7oell
    20l422OmsqvTWZxbCnBm8BBVPKnooZcMx+x+odlhK7J9NNr1sD03SuJdgB1GIqIObL5u
    ogZg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726994;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=D6URkMLk8KPcvfEx/EmSnV297njs47xlSC2vdmlsg40=;
    b=Y878TqWmeS343L7BKSPJEJLr+nGtI51wMK04iuC3UhvJIS3SmXKEaf05CvVyY9N3EK
    pzRbuXvQvhZMg3uura+0+AzSd2noqJaElPWSMPkJ9siop+8jhsN2xZ1NlCp9ChsL0FrF
    1Bo2BdAlMJ5Pb5Y7BUmZoISr2dwh/RFKCZHpDimI2xt1CCrboSdqY1PEd0/YpKASxNNl
    aczOTYdz497OQqmplUy/06s14xj6GJIUGLS+puopQwgnSR4Q7qcgEZfcLn7UzB1LrN20
    waxtcPhSOksyepy4ingx/TJ1/WGIh9Wtts+S+Ch9fdnLKQ5rm23YZ9O7sUu/8Rbl3Rz/
    2h3Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id R01591x4B9uX06H
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 11:56:33 +0200 (CEST)
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
Subject: [PATCH 3/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Date:   Tue, 11 May 2021 11:54:09 +0200
Message-Id: <20210511095409.9290-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511095409.9290-1-stephan@gerhold.net>
References: <20210511095409.9290-1-stephan@gerhold.net>
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
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/kxcjk-1013.c | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index e630419a11d8..20f3634d225d 100644
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
 
@@ -172,6 +220,19 @@ const struct kx_chipset_regs kxtf9_regs = {
 	.wake_thres	= KXTF9_REG_WAKE_THRESH,
 };
 
+/* The registers have totally different names but the bits are compatible */
+const struct kx_chipset_regs kx0231025_regs = {
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

