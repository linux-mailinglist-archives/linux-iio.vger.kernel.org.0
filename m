Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAA37A431
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEKKDj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 06:03:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:35736 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhEKKDi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 06:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620726993; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MdSjCUL0KA/7URMIbrXCQ1qoNioxsT+PHAzU1Ht8XmPiDj8cFxnG7i9mgaIqzAEFPS
    YYfykXMo09aJxogkCSeDGtB6x6MQ9HIkdzwgqTLmQBJZdgm8M0hP8Rrg6YyKOuiumgbu
    dAVGaV92phbIhesRzlIg4zrXMHQjtVkmj5Jx3+joORoteP7JCKgBI3SuDDsSLa3xZgF6
    6njH6fLqlj/vPCq1GzY8pXRVEGQNQp0CSF+qfNTsGW1zpWXgT2Kcjlqea9uSXWEpiE+4
    eS/3YRyixPxYcZ7tvX2cbLrujgXgzPfHd5CsT/1WMxqCmXtBj/jdssiz8owwP8x2IQQG
    BnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726993;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OIrOsCBTcWW+UagC5pY5GF8vfXZFZhbPSCUGf5W1+Y8=;
    b=QrY9GDWhJ6vz4ZMzZJL42mhowAJ5EghYJreYQgtyZ8I5JwryEEMyxeBN4bLrT5micR
    AeIMDe4f0vMzIrku0KSsX40VGuClRjfS8MOr+D14x4YFjWXDobbrtr0UiQQPz5u/UXNn
    bXzpL+JezOd+olPPi6YsVLmrLApIDnK9uGOZN5PI01qInhjAPON/x+inaLwYgnQmwdkc
    kjJtRyZIGBUfvx+vkbgHe5OXnKELvomzIx8m1MlofD441U0C6WXYboXUZI6uLmtMEdY8
    44qEL32AHz5m8m5k1LfIP5an8ERjH5V3Lq2/xFZL4PbJWoUto/cHGrrxhLzkpTtlC38V
    Xppg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726993;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OIrOsCBTcWW+UagC5pY5GF8vfXZFZhbPSCUGf5W1+Y8=;
    b=G5FL4RU1iY41jkqlM+bv7U8BiwkuDJWMowKDFBXsfU6AXVGopZWk2D5A9I8h2OY+K7
    pJ03XhG6S9UM7hAjDWk4Q+W+9E7yxCL0knqJl28fLopt4SPABVbbcBUE2NOyr07yKkii
    btMhK5I6vKvxuDVpw6glWNTxCxF00r07F406rjoWEVsaUmc8DRVcfmvQ5jupnXciJLPH
    uasqLENMWiuCfVf1gxtpfYJvr9anc1QKZqJXsZu3NwWtU+/7+flklpX3TW4BcLvLIGki
    xNM/Gm3L0JfGsJqeExvMp7ho9ngcPg4bUTF6tMznirk4QZW2nvRnfkjhTfKey2owuI8A
    5ojg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id R01591x4B9uW06G
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 11:56:32 +0200 (CEST)
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
Subject: [PATCH 2/3] iio: accel: kxcjk-1013: Refactor configuration registers into struct
Date:   Tue, 11 May 2021 11:54:08 +0200
Message-Id: <20210511095409.9290-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511095409.9290-1-stephan@gerhold.net>
References: <20210511095409.9290-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Most Kionix accelerometers seem to use fairly consistent register bits,
but the register addresses are not necessarily the same. This is already
partially the case for the KXTF9 (added in commit 1540d0106bcb
("iio: accel: kxcjk1013: add support for KXTF9")), which has some
registers at different addresses.

However, it's even much worse for the KX023-1025. All register bits
used by the kxcjk-1013 driver seem to be fully compatible with KX023,
but it has most registers at totally different addresses.

In preparation to add support for KX023-1025, move the fixed register
addresses into a struct so we can change them for KX023 more easily.

Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/kxcjk-1013.c | 124 ++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 283e6a3feffc..e630419a11d8 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -51,13 +51,15 @@
 #define KXTF9_REG_TILT_POS_CUR		0x10
 #define KXTF9_REG_TILT_POS_PREV		0x11
 #define KXTF9_REG_INT_SRC1		0x15
-#define KXCJK1013_REG_INT_SRC1		0x16	/* compatible, but called INT_SRC2 in KXTF9 ds */
+#define KXTF9_REG_INT_SRC2		0x16
+#define KXCJK1013_REG_INT_SRC1		0x16
 #define KXCJK1013_REG_INT_SRC2		0x17
 #define KXCJK1013_REG_STATUS_REG	0x18
 #define KXCJK1013_REG_INT_REL		0x1A
 #define KXCJK1013_REG_CTRL1		0x1B
 #define KXTF9_REG_CTRL2			0x1C
-#define KXCJK1013_REG_CTRL2		0x1D	/* mostly compatible, CTRL_REG3 in KTXF9 ds */
+#define KXTF9_REG_CTRL3			0x1D
+#define KXCJK1013_REG_CTRL2		0x1D
 #define KXCJK1013_REG_INT_CTRL1		0x1E
 #define KXCJK1013_REG_INT_CTRL2		0x1F
 #define KXTF9_REG_INT_CTRL3		0x20
@@ -133,6 +135,43 @@ enum kx_acpi_type {
 	ACPI_KIOX010A,
 };
 
+struct kx_chipset_regs {
+	u8 int_src1;
+	u8 int_src2;
+	u8 int_rel;
+	u8 ctrl1;
+	u8 wuf_ctrl;
+	u8 int_ctrl1;
+	u8 data_ctrl;
+	u8 wake_timer;
+	u8 wake_thres;
+};
+
+const struct kx_chipset_regs kxcjk1013_regs = {
+	.int_src1	= KXCJK1013_REG_INT_SRC1,
+	.int_src2	= KXCJK1013_REG_INT_SRC2,
+	.int_rel	= KXCJK1013_REG_INT_REL,
+	.ctrl1		= KXCJK1013_REG_CTRL1,
+	.wuf_ctrl	= KXCJK1013_REG_CTRL2,
+	.int_ctrl1	= KXCJK1013_REG_INT_CTRL1,
+	.data_ctrl	= KXCJK1013_REG_DATA_CTRL,
+	.wake_timer	= KXCJK1013_REG_WAKE_TIMER,
+	.wake_thres	= KXCJK1013_REG_WAKE_THRES,
+};
+
+const struct kx_chipset_regs kxtf9_regs = {
+	/* .int_src1 was moved to INT_SRC2 on KXTF9 */
+	.int_src1	= KXTF9_REG_INT_SRC2,
+	/* .int_src2 is not available */
+	.int_rel	= KXCJK1013_REG_INT_REL,
+	.ctrl1		= KXCJK1013_REG_CTRL1,
+	.wuf_ctrl	= KXTF9_REG_CTRL3,
+	.int_ctrl1	= KXCJK1013_REG_INT_CTRL1,
+	.data_ctrl	= KXCJK1013_REG_DATA_CTRL,
+	.wake_timer	= KXCJK1013_REG_WAKE_TIMER,
+	.wake_thres	= KXTF9_REG_WAKE_THRESH,
+};
+
 struct kxcjk1013_data {
 	struct regulator_bulk_data regulators[2];
 	struct i2c_client *client;
@@ -152,6 +191,7 @@ struct kxcjk1013_data {
 	int64_t timestamp;
 	enum kx_chipset chipset;
 	enum kx_acpi_type acpi_type;
+	const struct kx_chipset_regs *regs;
 };
 
 enum kxcjk1013_axis {
@@ -309,7 +349,7 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -320,8 +360,7 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 	else
 		ret |= KXCJK1013_REG_CTRL1_BIT_PC1;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -335,7 +374,7 @@ static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -353,7 +392,7 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -364,9 +403,7 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 	ret |= (KXCJK1013_scale_table[range_index].gsel_0 << 3);
 	ret |= (KXCJK1013_scale_table[range_index].gsel_1 << 4);
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1,
-					ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -400,7 +437,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -409,8 +446,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	/* Set 12 bit mode */
 	ret |= KXCJK1013_REG_CTRL1_BIT_RES;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL1,
-					ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
 		return ret;
@@ -421,7 +457,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_DATA_CTRL);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->data_ctrl);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
 		return ret;
@@ -430,7 +466,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	data->odr_bits = ret;
 
 	/* Set up INT polarity */
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
@@ -441,8 +477,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	else
 		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEA;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
-					ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->int_ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
@@ -497,10 +532,9 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
-	int waketh_reg, ret;
+	int ret;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_WAKE_TIMER,
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->wake_timer,
 					data->wake_dur);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
@@ -508,9 +542,7 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 		return ret;
 	}
 
-	waketh_reg = data->chipset == KXTF9 ?
-		KXTF9_REG_WAKE_THRESH : KXCJK1013_REG_WAKE_THRES;
-	ret = i2c_smbus_write_byte_data(data->client, waketh_reg,
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->wake_thres,
 					data->wake_thres);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_wake_thres\n");
@@ -539,7 +571,7 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
@@ -550,14 +582,13 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
-					ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->int_ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -568,8 +599,7 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -599,7 +629,7 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
@@ -610,14 +640,13 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
-					ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->int_ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -628,8 +657,7 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -701,7 +729,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_DATA_CTRL,
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->data_ctrl,
 					odr_setting->odr_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing data_ctrl\n");
@@ -710,7 +738,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 	data->odr_bits = odr_setting->odr_bits;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL2,
+	ret = i2c_smbus_write_byte_data(data->client, data->regs->wuf_ctrl,
 					odr_setting->wuf_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl2\n");
@@ -1113,7 +1141,7 @@ static void kxcjk1013_trig_reen(struct iio_trigger *trig)
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_rel);
 	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 }
@@ -1166,8 +1194,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
-	int ret = i2c_smbus_read_byte_data(data->client,
-					   KXCJK1013_REG_INT_SRC2);
+	int ret = i2c_smbus_read_byte_data(data->client, data->regs->int_src2);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_src2\n");
 		return;
@@ -1234,7 +1261,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_SRC1);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_src1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_src1\n");
 		goto ack_intr;
@@ -1257,7 +1284,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	if (data->dready_trigger_on)
 		return IRQ_HANDLED;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
+	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_rel);
 	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 
@@ -1378,6 +1405,19 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	} else
 		return -ENODEV;
 
+	switch (data->chipset) {
+	case KXCJK1013:
+	case KXCJ91008:
+	case KXTJ21009:
+		data->regs = &kxcjk1013_regs;
+		break;
+	case KXTF9:
+		data->regs = &kxtf9_regs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = kxcjk1013_chip_init(data);
 	if (ret < 0)
 		return ret;
-- 
2.31.1

