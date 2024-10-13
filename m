Return-Path: <linux-iio+bounces-10539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2D99BBB4
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 22:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047FC1F21434
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5914A639;
	Sun, 13 Oct 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="eNJHqYkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6JfPqJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB319460;
	Sun, 13 Oct 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851817; cv=none; b=oTnl/upSq6V1lWeBmNmcnA1RIByvj2r1ql+iUkoggyKLChFerOS1+hkYZHpHux8Pt9z1uVkvOTbYW/M1ZZon60eW8UHYbcR3JipKqtpCcazZjESBcueehzeFVZ9CXuUPrBebUjMSUkCboVaQNo9pH196ewAqh9jMdgE5IN4PmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851817; c=relaxed/simple;
	bh=I3ZvOIpSJQ2z8YMcdgnj0g2JjmGJCuyNvLzp0NlR66k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4jmm+c6YlwAWkjcC9C8s31yJiGWKmSd3pCwDWphEieI/odV/3tM6RsECHyNGCfelgnodH7k4Y/y6LANQzW4CBZfRiKdGZB0NjeAeywNzYwKcajJPH5v23nZjLsN5MdlffCjW+HHjaXTYCEURmoWVftiab9c+gIOuZvOAng2N70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=eNJHqYkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6JfPqJi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D0B6114008F;
	Sun, 13 Oct 2024 16:36:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 13 Oct 2024 16:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728851813; x=
	1728938213; bh=2nv2TObGx+Y3BqcdOr82bRwBAj1gHtmk3MEClsqSOBE=; b=e
	NJHqYkTHzAkbwcPfPe6Fq3lgnmdzQXYJwgZEPeC2Am2LanUUVwKtri5taZwMOrVB
	IMYdjovKRCCuiEsHGCR3IMRp9bSx8rDiLCzIBq8Q8LXhMDhphUB1OEOqI3LCItDJ
	J1QQP6LZKqPYu8y66xEoLUz5oFlPIh1MZSW4Q1FxhcFsZTCPSrOg+9+27mKBPo4g
	0X4gG7hOJ8CqnaMUDtdN2oYfDtWZjPWLpO44X7YVXQEZq9e8RXmeOyS86osm8NUd
	S29b0ki5zt3lgaVUC9L1dwCaGlMkdUEv0fVBis7rUfZPmpcxwqRbUi+TNRXE0Usc
	IReOiBWs0KJJccNVnsQlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728851813; x=1728938213; bh=2nv2TObGx+Y3BqcdOr82bRwBAj1g
	Htmk3MEClsqSOBE=; b=B6JfPqJiap8lYvQfAXj+HuwmY63D03wE5juN6FOIoS/6
	u7VYdc3s90sxqNK3CbWR+I5hlVtvqTVdxQWuRuaPWN/6TNT4pRVq1fWfuucvo3u6
	1ribkCLd4g2qIvjq+KrQzrOlCgqsfziY4/s42Aqyhvn5UbVZ4THz9H/AHv5iC4vE
	k9Ydvv4GyYk6ANAVqmlRr3eIcLQsmS1cNlq6uQIrtC+YwTTVfzD7NxWOAEoV0Fpq
	5fPoDEAVoqg45nbPJZs6u6bW6jx27+Yfe2nkqZw+/M1c+va4OPLwIATl2ptQewGD
	CDmAYaZPf2fkC5vrknuEqePx5Vp6Xx4XyDlLVsnC0w==
X-ME-Sender: <xms:ZC8MZ0MHJxdrXhxe1cp8YYHw89WSTeXR25cfpaJEQq8ZBKC-wOEybA>
    <xme:ZC8MZ69l3v_eOoeuM6NvUNTlNJqsAxGHa6OUVMn11EZXHlXHUhc2-ina8hxeoWKzf
    XN0iRBMMMxpUjj4fg>
X-ME-Received: <xmr:ZC8MZ7TdwDdXgHd3d5EP5L7zKvusCvvU5PKa5D9SYYQCAcTJzK4ZG7sEf8McK3BNuhYbIJHFRH0ajLtQbACQpciK2gNsOKEFUt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepveevveduuedtheeghedvueeiudet
    heekhfelfeffgeehjefhudelgfejhffffeeunecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehj
    uhhsthhinhesjhhushhtihhnfigvihhsshdrtghomhdpnhgspghrtghpthhtohepjedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhesmhgrnhhjrghrohdrohhr
    ghdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpdhrtghpthhtoheplhgrnhiirghn
    ohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:ZC8MZ8uJIcNF5fXb8VqRG1LzfFCp3lQrZ1NWkPq9RV0oidqg0XOoXg>
    <xmx:ZC8MZ8fRe4R6jQ2opYwpyiDz6fB406lf2f50grJGFiX-csHKnpv6FA>
    <xmx:ZC8MZw24ix2M7pgMno0BNPZcry-MFKUKCN2Lzy4M-e5CnmuWobkPpQ>
    <xmx:ZC8MZw-dcoAUISVaFjR9YPowpf3JKm4BLL3CZk1Hgt3L-jOUysEAqg>
    <xmx:ZS8MZ6u5-FnjB4trWzj6-9LR5Euyn9ZdrJ0p3iITv3n6MROnZtxMPVJe>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Oct 2024 16:36:51 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 1/3] iio: imu: Add i2c driver for bmi260 imu
In-Reply-To: <20241013161457.506c2296@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 13 Oct 2024 16:14:57 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-2-justin@justinweiss.com>
	<20241012120830.338aca19@jic23-huawei> <874j5grafd.fsf@justinweiss.com>
	<20241013161457.506c2296@jic23-huawei>
Date: Sun, 13 Oct 2024 13:36:51 -0700
Message-ID: <87jzeboi3g.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

>> >> +static const struct acpi_device_id bmi270_acpi_match[] = {
>> >> +	{ "BOSC0260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> >> +	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> >> +	{ "BOSC0160", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> >> +	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },  
>> >
>> > Sigh.  That's not a valid ACPI ID or PNP ID.
>> > (Well technically it is, but it belongs to the Benson Instrument Company
>> > not Bosch)
>> >
>> > Which of these have been seen in the wild?
>> > For any that are not of the BOSC0160 type form add a comment giving
>> > a device on which they are in use.  
>> 
>> I know of the BMI0160 (this seems to be the most common way the BMI260
>> is identified on handheld PCs), and the 10EC5280 has been seen in the
>> wild, as described here:
>> https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/
>> 
>> I have not personally seen any devices using BMI0260, but I'll add
>> comments to the BMI0160 and 10EC5280 entries with some examples of
>> devices that use those IDs.
>
> Drop any we don't have evidence are out there.
>
> Do we have any confirmation from Bosch (or products in the wild) for
> the structurally correct BOSC0160 etc?  Those would normally have
> to be tracked by Bosch as allocated for this purpose.
>

I haven't seen any reported, but the Windows driver INF has all five of
these entries listed. I don't see any evidence of the BOSC0160 or
BOSC0260 being used other than that Windows driver file.

BMI0160 seems by far the most common, with some appearances of 10EC5280
(some AYANEO devices, possibly some GPD Win Max 2 devices) and BMI0260
(OrangePi NEO).

>> 
>> >> +	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },  
>> >
>> > What's this one?  There is no such vendor ID.
>> >  
>>
> ...
>
>> >>  
>> >>  static const struct of_device_id bmi270_of_match[] = {
>> >> -	{ .compatible = "bosch,bmi270" },
>> >> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },  
>> >
>> > If the bmi260 supports SPI, should be added here as well. (I've no idea if it does!)
>> >
>> > Or is this because you can't test it?  
>> 
>> Yeah, it was because I can't test it, the BMI260 does support SPI. I can
>> add entries here, though.
>> 
>> Should the ACPI match entries from I2C also go here? All of the devices
>> with mismatched IDs seem to use I2C so there might not be as much of a
>> problem here.
> We want the incorrect formatted ones to be as hard to use as possible to discourage
> them going into new products.  Can't do anything to solve the i2c cases
> but definitely don't want to allow them for SPI as well if no evidence
> of products where it yet matters.
>
> If we have confirmation from Bosch of the BOSC forms, then those I would like
> in the SPI drivers as well (to point to the correct option for anyone using
> this in future!)
>
> Jonathan
>  

Agreed. Since we don't have confirmation of the correct values here or
any that are in use, I would be OK either adding the single BOSC0260
entry (as a guess, which may or may not be used) or leaving it out
entirely until an entry is needed.

Justin

>> 
>> >>  	{ }
>> >>  };
>> >>    
>> 
>> Thanks again,
>> Justin

