Return-Path: <linux-iio+bounces-10747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F639A47EC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 22:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6B2824EA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72BE204083;
	Fri, 18 Oct 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="WwLAkxne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iz9A7XZZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58E40862;
	Fri, 18 Oct 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283284; cv=none; b=cerEHjrapUYC8BbMXYgVPgkAtml7NRF7XS3zShqcw4X1Y3o0qCcJV0K9+vbSSo3BvvOPh7azy2HgviNprJLfWMkZraydzon7EB5/5z4EbXjV2kI2Yl7noCGynMqggqoueQhHVD/sMZUzcdeEKTkIqGKR0dFdRKdo+JWWEjB3ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283284; c=relaxed/simple;
	bh=ZVhvqv3R+1MrUboZvyRAl/Dwq4yiUfLLcWFX3hoXp3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YyRrJ1e9mrNYmtSq77kNtzVhIwEKAWuEDzqlWvN+mmYFrN+24P8qEdvtm96Ntsc9mK0pn3hYbfUNtnF+gsXD28CLMCL096G+ZPEagBgxlNJkUSZpQTkD5Oblus4mJAkhjyhAUr5q9YhiSDzTU50RLA+YIY1tNRHjXspDx8TSLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=WwLAkxne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iz9A7XZZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40E651140077;
	Fri, 18 Oct 2024 16:28:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 18 Oct 2024 16:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729283280; x=
	1729369680; bh=7Ad1wosag+b1bUBZzzK6r3rBJSGkvCGF7JEu0gQdUbA=; b=W
	wLAkxneZ2RIj2uqJvlChmICpM3+ygisnyRz5stum7HruyAHCGAHlGWFcbubR/vGc
	srmwUGSwkC51DwmSr3DrMfB1nn4TRKbNOwdKWTSRpshdildqyhVasfzPr8oSABB+
	vFVtFotW2LXSm+p+0OvOYr8prGHJrRk9KEBxKyq90wXxw3vt2AzJ4yDLP+NM3j3G
	h49WU3Z3sJd8EkHb3HuN1FEO6qDFgbsgkTtDaDYVLa/2Z3YRXo7xoAIBEBq6rkq0
	O5Y9D8DN7M+gwcf1ev1/e6uZwfNdpItoQOOCMYT2JV9ZDH4yxO24yCJQXOnKjcCy
	NIjxnG56Ro+C06MwUNUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729283280; x=1729369680; bh=7Ad1wosag+b1bUBZzzK6r3rBJSGk
	vCGF7JEu0gQdUbA=; b=Iz9A7XZZbScpGDF5GcmnSrWBscYmWuX99udAVvPRcJjc
	zV9GpeK0qkr3czp2hMcg1ALQMen1wLsu6bprAHDaI8TXOeccsuQPCjREIE/mbSXl
	oresaWOHCDStFVgYbskbnJh63fAKN/ryU9HDQolfr6bkhM+Tq5g9mvlt6hOVt327
	cTH66HVOwvC9RoXB6NPp1/6VeY1joXDia+VtaZjxePCU/nBfG4mrzOcqWlUbh3IE
	10+FeG11C3dreujXjP/uMNkt5lJ6cUYi6Y57PF30MlncJ+NvBOk3TkD//bDoUtTf
	m4gT2RhsRO4PRhycSizwhXE/MhtzNwvfgjpxpRQq7w==
X-ME-Sender: <xms:z8QSZ3PX17g3WiPKDeUgYEl3z3GR-aFW1snACFdr4osO7GX2Xr1Cgg>
    <xme:z8QSZx8qcj_3ttYf4A39akVRYsefQGjqWYawdEuaqAUJ2SnZflxzs9EdTMjEPwmOB
    jlH4R7IkxjQtZ7VfA>
X-ME-Received: <xmr:z8QSZ2QhaEOWXL8KnORL7jIh3GFcvWk_0v2JFY9g4pqxc5nDj1kqYC_SDPoXSdXh2yzHB655HdZ1orSh8sOo88icjqU4geDk4Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepveffhfelvdejjeefkeetleejhfev
    hfeiveegtdeiveefhedtgeegieefleeivdefnecuffhomhgrihhnpehmihgtrhhoshhofh
    htrdgtohhmpdhkvghrnhgvlhdrohhrghdprgihrghnvghordgtohhmpdhgphgurdhhkhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhsth
    hinhesjhhushhtihhnfigvihhsshdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhi
    hidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    epjhhitgdvfeeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z8QSZ7t7aQabCA0QB462rQ-K0JSxISToJPXDUSvks6_AMBUVJJrxVw>
    <xmx:z8QSZ_d0u_at5Ghb-DHQGpahAJeOgn1Tj6EQSNg8hOtNTaoHz8tWnA>
    <xmx:z8QSZ31Tgf9-dLybE-Wwz7TFF81a4_9HHUPmKbP01NYhES3DZvrKDw>
    <xmx:z8QSZ79r7Mrs9WpxC0K18Gxs1YaYszEa-CbHkwxmnIHIKvrdumnLtA>
    <xmx:0MQSZ3T_BQpBgDlVXLWI3MuZ7PRYARqWGx10fOEDveeaikpV-3-EQp-f>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 16:27:58 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
  linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org,  Lars-Peter
 Clausen <lars@metafoo.de>,  Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI IDs
In-Reply-To: <20241018185105.41a2db06@jic23-huawei> (Jonathan Cameron's
	message of "Fri, 18 Oct 2024 18:51:05 +0100")
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
	<20241018185105.41a2db06@jic23-huawei>
Date: Fri, 18 Oct 2024 13:27:57 -0700
Message-ID: <87sestcg1e.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 17:57:32 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> The commits in question do not proove that ACPI IDs exist.
>> Quite likely it was a cargo cult addition while doing that
>> for DT-based enumeration. Drop most likely fake ACPI IDs.
>> 
>> The to be removed IDs has been checked against the following resources:
>> 1) DuckDuckGo
>> 2) Google
>> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
>> This gives no useful results in regard to DSDT, moreover, the official
>> vendor IDs in the registry for Bosh are BSG and BOSC.
>> 
>
> I'm nervous about Bosch drivers in the wild given recent report
> from Justin
> https://lore.kernel.org/linux-iio/87jzeboi3g.fsf@justinweiss.com/
>
> Justin, I couldn't find the driver you were referring to for the bmi160,
> is it online somewhere?

Yes, the BMI160/260 Windows driver is on this page:
https://ayaneo.com/support/download

It's at the very bottom, under "AYANEO Universal Gyro Driver." GPD also
has a copy inside their driver pack under the "Drivers & BIOS" tab here:
https://www.gpd.hk/gpdwinminifirmwaredriver, but the download is often
at capacity unless you're signed into Google.

> Also if you have other bosch drivers could you check for these + bmc150
> IDs Andy is proposing dropping in:
>
> https://lore.kernel.org/linux-iio/20241018145805.2181682-1-andriy.shevchenko@linux.intel.com/

Unfortunately, the 160/260 driver is the only one I have. I wanted gyro
support in Linux for a handheld PC I bought, and it was the IMU that
happened to be inside.

Justin

>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/iio/gyro/bmg160_i2c.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
>> index 672d0b720f61..a81814df5205 100644
>> --- a/drivers/iio/gyro/bmg160_i2c.c
>> +++ b/drivers/iio/gyro/bmg160_i2c.c
>> @@ -39,8 +39,6 @@ static void bmg160_i2c_remove(struct i2c_client *client)
>>  
>>  static const struct acpi_device_id bmg160_acpi_match[] = {
>>  	{"BMG0160", 0},
>> -	{"BMI055B", 0},
>> -	{"BMI088B", 0},
>>  	{},
>>  };
>>  

