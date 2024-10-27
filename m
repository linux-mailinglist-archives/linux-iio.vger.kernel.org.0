Return-Path: <linux-iio+bounces-11406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF969B1F63
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 18:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0534B2117C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38117E472;
	Sun, 27 Oct 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="baogTKWQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKRVWrUy"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971417C9F8;
	Sun, 27 Oct 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049716; cv=none; b=Kp37noRv80yZdZsZqhmYsBQuG5tAjBK/HlJQPCc/e7xf89CngY3QzaXls54DG1zS3czXEUEs+t40qV20P7fGmLm8+KmgPeO99ADAtKKiW7sxD52TxW2q0DXJDcU08DwhuFYyICFxQ7z3Mkzzn17gEUw6SJ3Fixs3Q7meBq0KLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049716; c=relaxed/simple;
	bh=mZli/58Bf8b2rVFGCQQ5z0QEq2d90jadrU+ROb/40TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fppkjrTtz2UQ96YqZjz2OqHwnZxU5TSvBkc+UpXNTv/4dkO6kuQcMfKqPQAX7r/6nt8JNXZAZj9NCaOuN0FPrQM/GKtdpETRET/lSG+c2H4HQq/J9fVPSlGYrL1lkpnif1Uoi41jV0i74kqTq6N0yNgPX1EraHVzVOnNgxNWXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=baogTKWQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKRVWrUy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0320325400A4;
	Sun, 27 Oct 2024 13:21:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 27 Oct 2024 13:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730049712; x=
	1730136112; bh=HZ0f4dodd217AkGZBJ4uwjooGTB/NPsDwvhotzR1ZOw=; b=b
	aogTKWQ9MqVrjOh/u0IijpEnBp/BT/RtM+EIFoSX7oaSHROmpWPPQL/ell9hp+Jv
	Up1HDCYeBvrjcPL5gD63ZFnDBxjCo/cyBYiVqj11GkV315yCEivX5IPWwZ/I85Yx
	YncMBYr6BcPimzd4xAf7eax090cy6iYFFjatqpGR4InBU0sAD899VD3tm4oUVM1S
	EWtI38ZGLTlX2mKL5IH6AFy9bPsWxuyWLINy9d9ZGESmR5IT3NKUu7vBma3PZn7r
	98nf+gMY92YEMwiiMm8VstMmN+HYzz3ioDK12ltXeFjUdX0Utbxd9AkLfcjOpg5k
	7rQdEKu4dl/D8q4dDUY8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730049712; x=
	1730136112; bh=HZ0f4dodd217AkGZBJ4uwjooGTB/NPsDwvhotzR1ZOw=; b=C
	KRVWrUyYOk00Y4ZfyUBSkAQI6Rki9PC5X2v8NilCOFbIaXkypcbAT4VpaDznp52h
	Xp7PEyc+U2Rpj4GBE22fuvG9ri02T+UpeQhQz5M0qxzYrUtYGsTumkuYCnLbh5R6
	PuX+ENbodQNLqrWHF+D33YSEuEpODKnBI011LJJ6skMmd8uy0n7FpfOVZtUDeRn9
	Npeq+wedC9lmBeBoPm7C1nlJZyNTjKBkS8G6BQby3agszAS9zG2dIMAMFMwDx4+k
	ScNu/zO06coBtya4SuGUibdC6v8FJERgyeXQOWHrkt9ptVw1i2H1v7ISC01peTn6
	sTL3sYKnvRekPjvDZqx6g==
X-ME-Sender: <xms:sHYeZxgU_XWYYEQnUSMtFxOK2W2gHxaQ5g7NGRD8c-FK24e5DmuG8Q>
    <xme:sHYeZ2A65Tqdat2VTS1MozpyKRDhgCsBdxs6OPnDtMDEyUtDuAzr7mdxelY-ccZl2
    bPh00wvVNoMgwGPWg>
X-ME-Received: <xmr:sHYeZxFz7A07CUQiYctzIEoXHxqtmV5q7iQR_Sqd0sOoxoGRJ60dnB00wkQjHgzIATnIdEcYaBiHZOTuxQVhjz36H-7GD37MXTB3kUet-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepfeeuvdehieefleeiiedugfefleei
    uedtveevkeeigeeiudfhleeluedvkeeiveelnecuffhomhgrihhnpegsmhhivddrpggtrh
    hsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhu
    shhtihhnsehjuhhsthhinhifvghishhsrdgtohhmpdhnsggprhgtphhtthhopedufedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhiirghnohdrrghlvgigsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehrohgshheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgu
    rhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sHYeZ2SwnXMfUJwq52yY0X7EzybAtRhKTg3Qh196OiqmKgKhEpDLsw>
    <xmx:sHYeZ-y2EXdo8vbGYGl7CnoYK_KvM9uY6lexyQf-Ns5mXOuBHT5uFQ>
    <xmx:sHYeZ86GWWd_PX4KEwEIJc65Zszwn3Gjdlzp9rM2iOQ_BJX_UP2Dpg>
    <xmx:sHYeZzwLwcw4bk3MHL_EK92OEhPAtlg2k8bkALmJ1WmSUM5jtlDylQ>
    <xmx:sHYeZygDcd-mbAoGwmQ-KWLUevUlRxt7kB7E3VL4e9zF-w6veQIR8TxC>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 13:21:51 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v4 4/4] iio: imu: bmi270: Add support for BMI260
Date: Sun, 27 Oct 2024 10:20:25 -0700
Message-ID: <20241027172029.160134-5-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027172029.160134-1-justin@justinweiss.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
driver. Setup and operation is nearly identical to the Bosch BMI270,
but has a different chip ID and requires different firmware.

Firmware is requested and loaded from userspace.

Adds ACPI ID BMI0160, used by several devices including the GPD Win
Mini, Aya Neo AIR Pro, and OXP Mini Pro.

GPD Win Mini:

Device (BMI2)
{
    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "BMI0160")  // _HID: Hardware ID
    Name (_CID, "BMI0160")  // _CID: Compatible ID
    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
    Name (_UID, One)  // _UID: Unique ID
    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
    {
        Name (RBUF, ResourceTemplate ()
        {
            I2cSerialBusV2 (0x0068, ControllerInitiated, 0x00061A80,
                AddressingMode7Bit, "\\_SB.I2CB",
                0x00, ResourceConsumer, , Exclusive,
                )
            GpioInt (Edge, ActiveLow, Exclusive, PullDefault, 0x0000,
                "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x008B
                }
        })
        Return (RBUF) /* \_SB_.I2CB.BMI2._CRS.RBUF */
    }
    ...
}

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      |  1 +
 drivers/iio/imu/bmi270/bmi270_core.c | 28 +++++++++++++++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  9 +++++++++
 drivers/iio/imu/bmi270/bmi270_spi.c  |  2 ++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 6173be929bac..fdfad5784cc5 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -29,6 +29,7 @@ struct bmi270_chip_info {
 };
 
 extern const struct regmap_config bmi270_regmap_config;
+extern const struct bmi270_chip_info bmi260_chip_info;
 extern const struct bmi270_chip_info bmi270_chip_info;
 
 int bmi270_core_probe(struct device *dev, struct regmap *regmap,
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 27e501a15095..938cf14d46bd 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -14,6 +14,11 @@
 #include "bmi270.h"
 
 #define BMI270_CHIP_ID_REG				0x00
+
+/* Checked to prevent sending incompatible firmware to BMI160 devices */
+#define BMI160_CHIP_ID_VAL				0xD1
+
+#define BMI260_CHIP_ID_VAL				0x27
 #define BMI270_CHIP_ID_VAL				0x24
 #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
 
@@ -64,6 +69,7 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
 enum bmi270_scan {
@@ -86,6 +92,13 @@ static const unsigned long bmi270_avail_scan_masks[] = {
 	0
 };
 
+const struct bmi270_chip_info bmi260_chip_info = {
+	.name = "bmi260",
+	.chip_id = BMI260_CHIP_ID_VAL,
+	.fw_name = BMI260_INIT_DATA_FILE,
+};
+EXPORT_SYMBOL_NS_GPL(bmi260_chip_info, IIO_BMI270);
+
 const struct bmi270_chip_info bmi270_chip_info = {
 	.name = "bmi270",
 	.chip_id = BMI270_CHIP_ID_VAL,
@@ -546,8 +559,21 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read chip id");
 
+	/*
+	 * Some manufacturers use "BMI0160" for both the BMI160 and
+	 * BMI260. If the device is actually a BMI160, the bmi160
+	 * driver should handle it and this driver should not.
+	 */
+	if (chip_id == BMI160_CHIP_ID_VAL)
+		return -ENODEV;
+
 	if (chip_id != bmi270_device->chip_info->chip_id)
-		dev_info(dev, "Unknown chip id 0x%x", chip_id);
+		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
+
+	if (chip_id == bmi260_chip_info.chip_id)
+		bmi270_device->chip_info = &bmi260_chip_info;
+	else if (chip_id == bmi270_chip_info.chip_id)
+		bmi270_device->chip_info = &bmi270_chip_info;
 
 	return 0;
 }
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 394f27996059..6bd82e4362ab 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -32,11 +32,19 @@ static int bmi270_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi270_i2c_id[] = {
+	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info },
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 
+static const struct acpi_device_id bmi270_acpi_match[] = {
+	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
+	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	{ }
+};
+
 static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
@@ -44,6 +52,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
 		.name = "bmi270_i2c",
+		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_i2c_probe,
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 7c2062c660d9..b1fd9fc5dc98 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -65,11 +65,13 @@ static int bmi270_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmi270_spi_id[] = {
+	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info},
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 
 static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
-- 
2.47.0


