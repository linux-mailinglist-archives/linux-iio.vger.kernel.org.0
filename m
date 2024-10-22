Return-Path: <linux-iio+bounces-10940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948999AB2BD
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 17:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8264B23AC3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FEA1B5829;
	Tue, 22 Oct 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="cKpqOwaY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMo1btuJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AD19F10A;
	Tue, 22 Oct 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612250; cv=none; b=lZKpYq1wuGAvem5Z3FiCwEZTkvLjC5jWovM4+WdssQ2O9c68Z/Uui1/cs2kg1eVK4p8dtjJiGkmHU3ipn74h8sm4mgTxtcfacJWRN6am3B3OPQ5GeaudYSo3B6pHcTwLLIzP4SOS4k8lzG2MloX3nkRU1KvOoADFyVXH9veIwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612250; c=relaxed/simple;
	bh=cH7N9Iioc5sodKfjcFQ0ldwrnpmsM/9oe5zEBOHQ3VQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXxMcHJfrE0Ml7HqLhHkBHtcqfNpz9A8/6l2g0EV7K76GGFTPs5C3Qd1s3Rn94mkBfST5GJN3JG3Ua3BgOWFZbkwVegE1nJ/V6AcZjl7xe5/p6ur1o4E7s8fqy3f1og9t6ottx8EnAwf7RwdrkADPBFVeZITQJ35dhA0qW4WaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=cKpqOwaY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMo1btuJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C99911400C4;
	Tue, 22 Oct 2024 11:50:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Oct 2024 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729612246; x=
	1729698646; bh=D2XGZV9l8QpA7cmw0CE94zEWL2lTk2YSPcvjOcyQfTo=; b=c
	KpqOwaYKmk3jnBJN1fqNddT6Vz9JET60GKTWHtjS3EbRZMCPuah9VN4/+/bXkBFx
	4G3p0BWLvCeM41nYzEH+v39huffAmF9HSTmMON+HGiTrCXz5P+hWAjwIbCr329f4
	PWaZ47hcVUURDo4AmyR5eU9JXRMfj0qtrDlb8rQNcigTCbFOi9GlThbVyvy6TD2a
	ooTeIo5fQ3weKuL9oc0F9HOJCpAx5keP15IqgfYiIa2kCSQ1k6gTwJQTETcjKX/q
	+ieFEFObMbpV67v22pdnnBKCjYxpYxu1pDDGTNTqytFTWrhE8jo7i4PJC4M6hoXS
	GfWiKFFDPZH6FYXpjgoDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729612246; x=1729698646; bh=D2XGZV9l8QpA7cmw0CE94zEWL2lT
	k2YSPcvjOcyQfTo=; b=BMo1btuJ6WTGhCa4exH6BVkwXp522l0sXhcaxWzpi+0n
	FP1bPlfiEFXmzW7fZfeulyiNxJzk4b3ueKONHeroiy9Hb/WeQ9fmyYfJMzndJwCM
	yYslT464WCEbm1PE3ItDSjFAquM/Y+OC7ehvdOctaB7h7FjBJMn4ZpKSW2MBqXVO
	zKWka4ERObaSBuN5M3jdDQ2YIE3hDLw7Y7ve8WQ9z50e6tsTKRBkHNqFvg0TtYbJ
	obPTw/lpBPkNE0jSX17XR8i7eqUvDCC7KPs67eKX9jGCVqi+GN1XuN8NrlMRb2oq
	KKAXooko7j4R05LnCecZLa5XspRkVk1oNWRuNQ6i6w==
X-ME-Sender: <xms:1ckXZ_cCyhjCSewn0AzkkEQT_Oe_00TZ3ui-fi89mQg9uXzxq0z7Dg>
    <xme:1ckXZ1NJV0IqkKecOmHDYpyfWiSpwtyx56NP_OXgyThF4BZ0qymipD2CL_M8otTFk
    3Gk7J2_nUufaXS8FQ>
X-ME-Received: <xmr:1ckXZ4gi7zQInhY4ffkEM27XQxGr_I_3uAPluLqu0nY9wesTn40GAeGRfkyQU6otzWXcZEhq13FF9fHiBr0v-HRpezNted2yeQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeugfduvdektdeuhfetiefgheeguedt
    ffethedvleehhffgjeehfeefieejfeelveenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgpdgsmhhivddrpggtrhhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhmpdhnsggprh
    gtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhiirghn
    ohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhlmhesmhgrnhhjrg
    hrohdrohhrghdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1ckXZw9QG20qEOU9FzmF_POYpwL3UfAcHGPQ5Du2TsT69tjEv36DpA>
    <xmx:1ckXZ7tUpgpFlZUoA4z5ZkTFgAf5JSlmGOBDgJNeTMOpI4zrRTnknw>
    <xmx:1ckXZ_GxPMCK2TCLLw6n9DYmJ6vNtQwDMHWONTvHS2KIMklLOkv4Ig>
    <xmx:1ckXZyPbf9wZIZd0nr694mcs5ntrHJcFcwEDGU4EOJBEyu-6WLuLTQ>
    <xmx:1skXZ0HqtA7kS6NDn76CiEwpfcOyekAvO7KD5gSFS12MAHbWojq3HYql>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 11:50:44 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>, Alex
 Lanzano <lanzano.alex@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
In-Reply-To: <20241020220011.212395-5-justin@justinweiss.com> (Justin Weiss's
	message of "Sun, 20 Oct 2024 15:00:08 -0700")
References: <20241020220011.212395-1-justin@justinweiss.com>
	<20241020220011.212395-5-justin@justinweiss.com>
Date: Tue, 22 Oct 2024 08:50:43 -0700
Message-ID: <87msiwm90s.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Weiss <justin@justinweiss.com> writes:

> Adds support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
> driver. Setup and operation is nearly identical to the Bosch BMI270,
> but has a different chip ID and requires different firmware.
>
> Firmware is requested and loaded from userspace.
>
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> ---
>  drivers/iio/imu/bmi270/bmi270.h      |  1 +
>  drivers/iio/imu/bmi270/bmi270_core.c | 28 +++++++++++++++++++++++++++-
>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 13 +++++++++++++
>  drivers/iio/imu/bmi270/bmi270_spi.c  |  8 ++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 93e5f387607b..d8f6d7cf47fc 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -20,6 +20,7 @@ struct bmi270_chip_info {
>  };
>  
>  extern const struct regmap_config bmi270_regmap_config;
> +extern const struct bmi270_chip_info bmi260_chip_info;
>  extern const struct bmi270_chip_info bmi270_chip_info;
>  
>  int bmi270_core_probe(struct device *dev, struct regmap *regmap,
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 5f08d786fa21..24e45d6f0706 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -11,6 +11,11 @@
>  #include "bmi270.h"
>  
>  #define BMI270_CHIP_ID_REG				0x00
> +
> +/* Used to prevent sending incompatible firmware to BMI160 devices */
> +#define BMI160_CHIP_ID_VAL				0xD1
> +
> +#define BMI260_CHIP_ID_VAL				0x27
>  #define BMI270_CHIP_ID_VAL				0x24
>  #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
>  
> @@ -55,6 +60,7 @@
>  #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
>  #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
>  
> +#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
>  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
>  
>  enum bmi270_scan {
> @@ -66,6 +72,13 @@ enum bmi270_scan {
>  	BMI270_SCAN_GYRO_Z,
>  };
>  
> +const struct bmi270_chip_info bmi260_chip_info = {
> +	.name = "bmi260",
> +	.chip_id = BMI260_CHIP_ID_VAL,
> +	.fw_name = BMI260_INIT_DATA_FILE,
> +};
> +EXPORT_SYMBOL_NS_GPL(bmi260_chip_info, IIO_BMI270);
> +
>  const struct bmi270_chip_info bmi270_chip_info = {
>  	.name = "bmi270",
>  	.chip_id = BMI270_CHIP_ID_VAL,
> @@ -157,8 +170,21 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to read chip id");
>  
> +	/*
> +	 * Some manufacturers use "BMI0160" for both the BMI160 and
> +	 * BMI260. If the device is actually a BMI160, the bmi160
> +	 * driver should handle it and this driver should not.
> +	 */
> +	if (chip_id == BMI160_CHIP_ID_VAL)
> +		return -ENODEV;
> +
>  	if (chip_id != bmi270_device->chip_info->chip_id)
> -		dev_info(dev, "Unknown chip id 0x%x", chip_id);
> +		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
> +
> +	if (chip_id == bmi260_chip_info.chip_id)
> +		bmi270_device->chip_info = &bmi260_chip_info;
> +	else if (chip_id == bmi270_chip_info.chip_id)
> +		bmi270_device->chip_info = &bmi270_chip_info;
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index 394f27996059..3d0d8f3e8b63 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -32,11 +32,23 @@ static int bmi270_i2c_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id bmi270_i2c_id[] = {
> +	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info },
>  	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
>  	{ }
>  };
>

The ACPI IDs with device pointers are here:

> +static const struct acpi_device_id bmi270_acpi_match[] = {
> +	/* OrangePi NEO */
> +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
> +	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
> +	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> +	/* GPD Win Max 2 */
> +	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },
> +	{ }
> +};

I pulled DSDT device excerpts for the GPD Win Mini (which uses the
BMI0160 ACPI ID, even though it has a bmi260) and the OrangePi NEO
(which uses the BMI0260 ACPI ID).

I couldn't find a shipping device with a bmi260 using the 10EC5280 ACPI
ID. Some prototype devices with the bmi260 may have used them:
https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/

I can remove that ID from this changeset for now.


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

    OperationRegion (CMS2, SystemIO, 0x72, 0x02)
    Field (CMS2, ByteAcc, NoLock, Preserve)
    {
        IND2,   8, 
        DAT2,   8
    }

    IndexField (IND2, DAT2, ByteAcc, NoLock, Preserve)
    {
        Offset (0x74), 
        BACS,   32
    }

    Method (ROMS, 0, NotSerialized)
    {
        Name (RBUF, Package (0x03)
        {
            "0 1 0", 
            "1 0 0", 
            "0 0 1"
        })
        Return (RBUF) /* \_SB_.I2CB.BMI2.ROMS.RBUF */
    }

    Method (CALS, 1, NotSerialized)
    {
        Local0 = Arg0
        If (((Local0 == Zero) || (Local0 == Ones)))
        {
            Return (Local0)
        }
        Else
        {
            BACS = Local0
        }
    }

    Method (_STA, 0, NotSerialized)  // _STA: Status
    {
        Return (0x0F)
    }
}


OrangePi NEO:

Device (BMI2)
{
    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "BMI0260")  // _HID: Hardware ID
    Name (_CID, "BMI0260")  // _CID: Compatible ID
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

    OperationRegion (CMS2, SystemIO, 0x72, 0x02)
    Field (CMS2, ByteAcc, NoLock, Preserve)
    {
        IND2,   8, 
        DAT2,   8
    }

    IndexField (IND2, DAT2, ByteAcc, NoLock, Preserve)
    {
        Offset (0x74), 
        BACS,   32
    }

    Method (ROMS, 0, NotSerialized)
    {
        Name (RBUF, Package (0x03)
        {
            "0 1 0", 
            "1 0 0", 
            "0 0 1"
        })
        Return (RBUF) /* \_SB_.I2CB.BMI2.ROMS.RBUF */
    }

    Method (CALS, 1, NotSerialized)
    {
        Local0 = Arg0
        If (((Local0 == Zero) || (Local0 == Ones)))
        {
            Return (Local0)
        }
        Else
        {
            BACS = Local0
        }
    }

    Method (_STA, 0, NotSerialized)  // _STA: Status
    {
        Return (0x0F)
    }
}

> +
>  static const struct of_device_id bmi270_of_match[] = {
> +	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
>  	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
>  	{ }
>  };
> @@ -44,6 +56,7 @@ static const struct of_device_id bmi270_of_match[] = {
>  static struct i2c_driver bmi270_i2c_driver = {
>  	.driver = {
>  		.name = "bmi270_i2c",
> +		.acpi_match_table = bmi270_acpi_match,
>  		.of_match_table = bmi270_of_match,
>  	},
>  	.probe = bmi270_i2c_probe,
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> index 7c2062c660d9..7f42ed74023b 100644
> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -65,11 +65,18 @@ static int bmi270_spi_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id bmi270_spi_id[] = {
> +	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info},
>  	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
>  	{ }
>  };
>
> +static const struct acpi_device_id bmi270_acpi_match[] = {
> +	{ "BOSC0260",  (kernel_ulong_t)&bmi260_chip_info },
> +	{ }
> +};
> +

I can't find any evidence of BOSC0260 being used, besides existing in
the Windows driver. As suggested in an earlier review, I added it here
to encourage people looking at this driver in the future to use the
correct ACPI ID.

Thanks,
Justin

>  static const struct of_device_id bmi270_of_match[] = {
> +	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
>  	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
>  	{ }
>  };
> @@ -77,6 +84,7 @@ static const struct of_device_id bmi270_of_match[] = {
>  static struct spi_driver bmi270_spi_driver = {
>  	.driver = {
>  		.name = "bmi270",
> +		.acpi_match_table = bmi270_acpi_match,
>  		.of_match_table = bmi270_of_match,
>  	},
>  	.probe = bmi270_spi_probe,

