Return-Path: <linux-iio+bounces-10808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C219A50D9
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 22:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D382848C0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 20:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA5192580;
	Sat, 19 Oct 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="PTn1vGhY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3ot/34l"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B081922DC;
	Sat, 19 Oct 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729371140; cv=none; b=isGe0SXFUr7LYLAsWu0IWkFOHhcsYdwygmsPulgMZ2dK+hXv3uWZ5LEFJqlkUou8fQgJrk0pG6VcQEIIgKVoCvuXQV0R3qMSddXmlbu01uvK8R7C4uyikU5dAVioWh5I3q8SmlpU4f2kfmYO3F1AgtcFSA3BxCs64uOmK1aRpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729371140; c=relaxed/simple;
	bh=aR63rpDIUsmXZ4/skOvXlLPjOa+pVW+qhvJgpyFru3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Es7vuTEgRYFCDaKhXWC984p90BX1XF9rttlPai0NaXFfUHrmsZuEGkEOcELxHG4WJXbPvtu5fF7Z5DCrcBWectjJUR9y/b7PWCeozteo7tu2lwWXzt5BZByLe+mu1tt7ihB3AVIiGWVO1jmgqWnMjvwbR8swp8ptFxZ3FypNJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=PTn1vGhY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3ot/34l; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AF7E9138022B;
	Sat, 19 Oct 2024 16:52:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 19 Oct 2024 16:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729371137; x=
	1729457537; bh=oi4PtmGUxCuG51OJh5aOK9DFbD1ZzJwjV1YK8/FiHa8=; b=P
	Tn1vGhYWGwJSWdBs3cdQcCsoMnVuOYo8aA7LxNTrOR+Lmp+OraembjkKAgtwVgC5
	EqpVSJybjN5p0lzAR5PqpvAVnkJjsZJg2NYkZkxEeQ9Zxj5RQGTQbaFjVNzyGJtx
	Qq4blIlVBJ2O3PkO/+EDl4F0p+9rNfjcrQoKip9EvHZV+OS8E/MUGMRI1hV7Bc5P
	q3mnG/NavEN+5uPvm/WI/Bi5GHy2xsNuxnnOrE8xzhbMMBhvLRSI6pJAPYXt5vXr
	Qv0nVT5/Bgc9cgB4AemaMTSVAv9+sSkHsnytG/iLJqgkK25AxGFR2aHtfRWAvx3I
	PoSqK6OiNf221LNuc38BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729371137; x=1729457537; bh=oi4PtmGUxCuG51OJh5aOK9DFbD1Z
	zJwjV1YK8/FiHa8=; b=b3ot/34lVqyJDeJLF9pTLs4+mHLzFcRvPck7gg+yTWa+
	5HToiocrDjjmptPePp2xFJKO9zvA0WbFXhxgNgl448KYgR+Qrk4uV0QFqTwtu8v9
	tlP5x2JGqDOtwLTTqheoSSKu8E2kLikS7iyp3BVbZHHpK58dN3KKJ5co7vVEbEls
	q0aNvnM02hREIjBBTvVT+0YfFMi2nfAXqx2Iku9jAXjXAZlRaxxm2Q3s5+JbAFex
	6Bf9M5yxKOrJjXInmZqjR15daEpvP/u2vNeP6vD7HBxk5Ql5VUjpyYVzNlrVcEo0
	Umh3KyT/HvSFOT1UeMqRPKf+F+Q1lAnYriCvoDKV9Q==
X-ME-Sender: <xms:ARwUZz-2IzGfLQyzipYGKQhoBB8ukONqTHMi6pJluwpDEk_zV_Aehg>
    <xme:ARwUZ_tO--2UcaTkHQoMR1bCyq1iSx0iXLKzWrYwkOBaVSpJ3_9P-QdGMNqevBLxh
    4Tw6M_LP0UyZVXrfg>
X-ME-Received: <xmr:ARwUZxB7uo36xt5oXh4TF8dj3PAA2M_Dit5pARVLdUgsHccdfEpQ9vwXMr6BZc0GbrBC0K-6aCFnANQK-VH4J_uuYTzTvuXnax0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepgfeugeeuieehffekkedtteffgfff
    ueeikedvfeeijedvfeeigfevhfeihfefgfevnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgt
    ohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphhhihhlmhesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopeguvghrvghkjhhohhhn
    rdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgv
    thgrfhhoohdruggv
X-ME-Proxy: <xmx:ARwUZ_cxmnrC8EhXkvT_rE9uqHBydzSHUTMB7bzd89KociDlcezk8g>
    <xmx:ARwUZ4P0gjqI4ekFNGqlasvVweY2mjLDWbxP3z5clz29jzb69acw7g>
    <xmx:ARwUZxlqGhU3Ywa13diruhij_hmwOMz___RYq4vxDToaXK5thzRZ1Q>
    <xmx:ARwUZys0O6dJ7N6X57LoYNF4hzS_I75EYhtkJSUJGFsqjpH3Bi9mUw>
    <xmx:ARwUZxk1c0JP5LWwGJejSuF0u2XIXswD_gA0ahuaX-HhPWwVX5_d1Hie>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:52:16 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 4/6] iio: imu: bmi270: Add support for BMI260
In-Reply-To: <20241019124013.0575e05b@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 19 Oct 2024 12:40:13 +0100")
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-5-justin@justinweiss.com>
	<20241019124013.0575e05b@jic23-huawei>
Date: Sat, 19 Oct 2024 13:52:15 -0700
Message-ID: <87sesrak8w.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 16:36:10 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Adds support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
>> driver. Setup and operation is nearly identical to the Bosch BMI270,
>> but has a different chip ID and requires different firmware.
>> 
>> Firmware is requested and loaded from userspace.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> Trivial comments inline and a discussion on whether my earlier
> don't use an array comment makes sense in this particular case.
>
> Jonathan
>
>> ---
>>  drivers/iio/imu/bmi270/bmi270.h      |  1 +
>>  drivers/iio/imu/bmi270/bmi270_core.c | 25 +++++++++++++++++++++++--
>>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 13 +++++++++++++
>>  drivers/iio/imu/bmi270/bmi270_spi.c  |  8 ++++++++
>>  4 files changed, 45 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
>> index 2e8d85a4e419..51e374fd4290 100644
>> --- a/drivers/iio/imu/bmi270/bmi270.h
>> +++ b/drivers/iio/imu/bmi270/bmi270.h
>> @@ -14,6 +14,7 @@ struct bmi270_data {
>>  };
>>  
>>  enum bmi270_device_type {
>> +	BMI260,
>>  	BMI270,
>>  };
>>  
>> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
>> index 799df78ec862..b30201dc4e22 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_core.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
>> @@ -11,6 +11,8 @@
>>  #include "bmi270.h"
>>  
>>  #define BMI270_CHIP_ID_REG				0x00
>> +#define BMI160_CHIP_ID_VAL				0xD1
>
> This one looks like a cut and paste error.

No, this was intentional -- I added the BMI160 chip ID here so it could
be checked later to avoid conflicting with the existing bmi160 driver. I
could add newlines before and after this group of _ID_VAL #defines if it
makes it clearer.

>> +#define BMI260_CHIP_ID_VAL				0x27
>>  #define BMI270_CHIP_ID_VAL				0x24
>>  #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
>>  
>> @@ -55,6 +57,7 @@
>>  #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
>>  #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
>>  
>> +#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
>>  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
>>  
>>  enum bmi270_scan {
>> @@ -67,6 +70,11 @@ enum bmi270_scan {
>>  };
>>  
>>  const struct bmi270_chip_info bmi270_chip_info[] = {
>> +	[BMI260] = {
>> +		.name = "bmi260",
>> +		.chip_id = BMI260_CHIP_ID_VAL,
>> +		.fw_name = BMI260_INIT_DATA_FILE,
>> +	},
>>  	[BMI270] = {
>>  		.name = "bmi270",
>>  		.chip_id = BMI270_CHIP_ID_VAL,
>> @@ -163,8 +171,21 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
>>  	if (ret)
>>  		return dev_err_probe(dev, ret, "Failed to read chip id");
>>  
>> -	if (chip_id != BMI270_CHIP_ID_VAL)
>> -		dev_info(dev, "Unknown chip id 0x%x", chip_id);
>> +	/*
>> +	 * Some manufacturers use "BMI0160" for both the BMI160 and
>> +	 * BMI260. If the device is actually a BMI160, the bmi160
>> +	 * driver should handle it and this driver should not.
>> +	 */
>> +	if (chip_id == BMI160_CHIP_ID_VAL)
>> +		return -ENODEV;

This is where that BMI160 chip ID is checked.

>> +
>> +	if (chip_id != bmi270_device->chip_info->chip_id)
>> +		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
>> +
>> +	if (chip_id == BMI260_CHIP_ID_VAL)
>
> Ah. My argument on separate IDs means you'd have to do it this way whereas
> I was thinking maybe a loop would be a better idea.  Ah well if we
> get a lot of supported chips, then we can rethink how to handle this.
> For now what you have here is fine and should deal with lack of appropriate
> ACPI ID mess.

I like the idea of separate structures, so I'll keep the if / else
here. I think it would be straightforward to change later without
conflicts if there are more supported chips.

I will change this to check against bmi260_chip_info.chip_id,
etc. instead of the constants, to make sure they stay consistent.

Justin

>> +		bmi270_device->chip_info = &bmi270_chip_info[BMI260];
>> +	else if (chip_id == BMI270_CHIP_ID_VAL)
>> +		bmi270_device->chip_info = &bmi270_chip_info[BMI270];
>>  
>>  	return 0;
>>  }

