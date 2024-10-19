Return-Path: <linux-iio+bounces-10809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D569A50DC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038A81C2148A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702B19259D;
	Sat, 19 Oct 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="UumvRo7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBb7F4DQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C741922DC;
	Sat, 19 Oct 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729371154; cv=none; b=nNHFG0oGcjHyhoADt7xoKIjhHVqaO9c8E1QMLBQvXXRN2WwdCe7NRk875iFN3xs8sdzfL3f+JwPpn0hGCBEwmy0HTEC0n8mtwYtIm2s9UzxY23KYWdhu5zo3lRRbtj5W7FnSRzPzrAbihaXXrmnSVrA+khsJqIlQmefp8IHyT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729371154; c=relaxed/simple;
	bh=AlGq/z/iUcy9YdZAZcUlh6PGH+HE55CAqPbTch1xylI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7T4DY+tPPANz0fk/83Rx8ZL2L5Cn4HeZAo96BpX6hsnpL6yjPyFoaJv+qpzf5VfF44/GYCmcXbg2Xxjdaf+d3q976QI0WadzlDgWwXEZwFjCrluJslmoiA48JnN15OO+CcOPzI11LzzLOPsxrJPw0pK1s2ExY2r2d9gPMV+y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=UumvRo7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBb7F4DQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C10311400DC;
	Sat, 19 Oct 2024 16:52:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 19 Oct 2024 16:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729371152; x=
	1729457552; bh=89Tk6iZSJPqABZljtaHQqca3mb8ck26VSnjBk0eIfK0=; b=U
	umvRo7c6Ls3lBIwzbpB4pG9gDYC5f5s6sdtMOEpMn7PZDuq4yb/7K8cn1Kx5EQ8r
	Vy+Yuju6Whnt4txu0bpvdME6eztPhranH1+XEjiDBcMlvFYwW1swAOxj2bdjrjAq
	B0S3cS7fxlbX0gGgMtf/OEn1Wh4ihf4hkd3M/pL16xlkV5KNLPmbNzgFCRNqR4pG
	nifgdd9fMInUrGqECUUGpv/mEaI6jQK/P8V8TKzTsXEb0QWVKWwXGFlxmqf8lA5R
	YgkOnOeagDyQo1J+PJPJM/XsOU/d5wmQDYY8OZr6QMLsmAe5Vs3Ln67FFPiZ6qdp
	Fl9Y2os9ZM5sI1882xs/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729371152; x=1729457552; bh=89Tk6iZSJPqABZljtaHQqca3mb8c
	k26VSnjBk0eIfK0=; b=CBb7F4DQ/V1NPu8fBqzlN/xf0YPORi5P5H9SCwmHXfuW
	gfnTuAFBbg/pGSyFCxTOzhshufBYX3jELo9VL2jKQ+doFfVinFYexUyNmD0ViTY3
	tmpFbo5sd3HRPOd0C3zvYznzwG2QgkSh38aWZh6jM6dAskkhFpMlaRnFZuPU7ha1
	O6MoS0Mk+xxqc4bGxTNepZ9sHQfq5zB9MRaQY2268+j3T8owPUVKaMle7HC4yIG0
	41SoI2JNFRE8RpUSCqwcBcNcyCqYv28YEXwP6dWD3zAb6B18A63BvstxhD/7XHsu
	l4TOdyhX9SbYu9eR47IYMkL7cBfoCicuYBa8y/triw==
X-ME-Sender: <xms:DxwUZ7vXRIkwzk36-M5MYYTHc9xLKht5eDIP24j7rC9lb_VKjK3gIg>
    <xme:DxwUZ8f4e55iijbLoLXMjX6T-hpwssCvYo9hPIu5T5hfO9xgqLkZ4krIXiAY5ffg4
    vz8fwYmk6zDNDPr9w>
X-ME-Received: <xmr:DxwUZ-wOIL0ZJYwPupUCK0p-iL0_EGpXzycrmp3GvanQdeRsogULq4FW_jhDm_FjDY291ieNXxa_kKGbv4ZZ36Svt1utnQl7mCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudehkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:DxwUZ6POgQLz2_5P4JMvxw5eGwsFGESZgZTVeUggH-gSLSXoDHogag>
    <xmx:DxwUZ78xc8VViPw_R-aezasPZrYNrn_-vtefzljiDPEDRdbAw4DN9Q>
    <xmx:DxwUZ6VkuI-ebUTHfYMRSHoaoVUaC42nli-F5x6rlmD108GUvdk9xQ>
    <xmx:DxwUZ8epqCwqPYsN0lublvcTtQXuPVWIyr74aniX3DUB1rGjqKUYog>
    <xmx:EBwUZ6Xq9KdYWxKDSRk2q4dnOKj-k7b4ElfSSozXWVYklBa12IqyOzIx>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:52:30 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 5/6] iio: imu: bmi270: Add triggered buffer for Bosch
 BMI270 IMU
In-Reply-To: <20241019124151.54ecaf2a@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 19 Oct 2024 12:41:51 +0100")
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-6-justin@justinweiss.com>
	<20241019124151.54ecaf2a@jic23-huawei>
Date: Sat, 19 Oct 2024 13:52:29 -0700
Message-ID: <87msizak8i.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 16:36:11 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Set up a triggered buffer for the accel and angl_vel values.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> Looks good. One trivial comment inline.
>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/imu/bmi270/Kconfig       |  1 +
>>  drivers/iio/imu/bmi270/bmi270.h      |  9 +++++
>>  drivers/iio/imu/bmi270/bmi270_core.c | 56 ++++++++++++++++++++++++++++
>>  3 files changed, 66 insertions(+)
>> 
>> diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
>> index 0ffd29794fda..6362acc706da 100644
>> --- a/drivers/iio/imu/bmi270/Kconfig
>> +++ b/drivers/iio/imu/bmi270/Kconfig
>> @@ -6,6 +6,7 @@
>>  config BMI270
>>  	tristate
>>  	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>>  
>>  config BMI270_I2C
>>  	tristate "Bosch BMI270 I2C driver"
>> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
>> index 51e374fd4290..844d70a7d32e 100644
>> --- a/drivers/iio/imu/bmi270/bmi270.h
>> +++ b/drivers/iio/imu/bmi270/bmi270.h
>> @@ -11,6 +11,15 @@ struct bmi270_data {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>>  	const struct bmi270_chip_info *chip_info;
>> +
>> +	/*
>> +	 * Where IIO_DMA_MINALIGN is larger than 8 bytes, align to that
>
> maybe larger than 8 bytes
> on x86_64 I think it is 8 bytes exactly, though I could be remembering that wrong.

Got it. I'll change this to "... IIO_DMA_MINALIGN may be larger than 8
bytes, ..." in v3.

Justin

>> +	 * to ensure a DMA safe buffer.
>> +	 */
>> +	struct {
>> +		__le16 channels[6];
>> +		aligned_s64 timestamp;
>> +	} data __aligned(IIO_DMA_MINALIGN);
>>  };
>>  

