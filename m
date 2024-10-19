Return-Path: <linux-iio+bounces-10806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2BF9A50D4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F109B2191F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B11922F3;
	Sat, 19 Oct 2024 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="YrgLADPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+bQ6PPU"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B215C15E;
	Sat, 19 Oct 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729370950; cv=none; b=Na1JmgbD4EcebMAj17vATX+5Pv76qj5tIFrlEQwxNhOrdLS9BHgxXg5OEYnuwAnQn9/VpvpoesclIpv/NweA7drZ4sMEKi53kB889O3B9DJD90kNIyTkDR0Qe7XNVZ25JmBMn/2RYsXU10TtQVi7iZXKY8sqW5hDuXh6nSJtwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729370950; c=relaxed/simple;
	bh=wU1gtZH3OND6Bb/TJAcxxaR248qRJyS8kvLg7wSohjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AL/jOZWS+y9pkr14OGndSC9SNQGStWDE25Iw4XPQaawV5krFzACNXDz9TyjqeTg1Rkkw3a/x9ols7y0UM2h4pbdfAJEtK9DQF7de4SjMqD32dUs9OxlD5JA1X22oLsPFS3E713TZUPcyHZ3nCcHAvAjaFi9A9Wvpx1KvvzgRr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=YrgLADPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+bQ6PPU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E62F911400EF;
	Sat, 19 Oct 2024 16:49:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 19 Oct 2024 16:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729370946; x=
	1729457346; bh=3g+Z8Lj9PqDMz7hWu8P3zL/ESZzkB+Cubp76re/2bfY=; b=Y
	rgLADPzHG5otkBjxSagNwifSq1Ct/tgTmDZ1lOsm14A7NXq80I7UPbeJB+oyh2G+
	mVBTGXasqW/+jyySaTDF4HCjt88qL1I7wg+9ukdqJAkHSSeMn4jMK147h6xBNfL6
	NldxnwwbQL4+8t3U5u/BPOTkNSN4rOQP+tDLowLLQju3VeX05NqRAfS0Gnzhft1B
	h62r1pJ5tOBNT6df9pMXrTDfDyF81dVAkXcBkEJgaL09luUZACKQMCATCbkfI/Cn
	QtETzSr/ZfE9TLjb0n+nyyOnD8O+SZYc+ReYDu1maZ20+oiKNr55hYosch19S2LK
	f27B+6Z0a1h/ojxT4tHoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729370946; x=1729457346; bh=3g+Z8Lj9PqDMz7hWu8P3zL/ESZzk
	B+Cubp76re/2bfY=; b=m+bQ6PPUsulIxIIaWFZa/Dbf7yaH8b2HK4s5EKhhK8q+
	05FTxrnySqiBE9FJlICgNRyE5kjruO+hRkkX7h28Rn5bigijbSWN0YY0pCLCf5fj
	pnmHQYSvJ1M7GATujKNODZBaoPT2m1GcaDZghyHu6Bgu+DcoLH3zvztinU6MJZi4
	TpySrv5vIdeH4Ff568dz/cajpipIxN4IPwiUQcv87oZw5B0ASLXH9wSfkPr2Tlqq
	/QegqCnv/jyjhDFsOpBTG8+uYo8DQ88GQ///ulOnqA4NQMjiZ3iy4odv99Y68lz+
	gvzP4zRhd8f0VY+YFtgVOeRcyekXJpcygS1QUWTGtw==
X-ME-Sender: <xms:QhsUZ-M-ve5L4RVdNcpw9t-OIFtvQODqV0yE7R3mZ0PAMTj9Hy23Qg>
    <xme:QhsUZ8_UTcipcg9Q1DmEtVdOrgIDbAJURiDjN8QHRNv8L1VDoeFydTc7fn4KR7FJW
    dYpMAcHwRVUiX_ehQ>
X-ME-Received: <xmr:QhsUZ1Tuid4itpKVrwJtqVSgEWqQYz8TNisMpWzycAZUtBfNw-GW8VOPTuInFeiipOoNkLIuzL5LwWqH9rZsruFX0xfmHmT0oao>
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
X-ME-Proxy: <xmx:QhsUZ-tdLX-Rol1qRVR3SOxPQbB-XWWgrQ8CdWFPI29luc0sNxNicQ>
    <xmx:QhsUZ2fjmYNNhF7qqhCzJArBYpx-5YUF-ovfC6DzIjNiFNVvrfAvqQ>
    <xmx:QhsUZy35rsD4NOyk__x1NZv4p0XxBetvlX7-4sp8X2Or5P7jrE6_vA>
    <xmx:QhsUZ68XeGzzHoe5xu8OBw7RzVLlLMIIajcbyhhg07gkahQDkvVnqA>
    <xmx:QhsUZy2xWVEtNCJ9HZ4pAUSRRsZWkeCf0zXJKIeQVzLIshSusxtmgdZN>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:49:05 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 2/6] iio: imu: bmi270: Provide chip info as
 configuration structure
In-Reply-To: <20241019123339.155c046c@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 19 Oct 2024 12:33:39 +0100")
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-3-justin@justinweiss.com>
	<20241019123339.155c046c@jic23-huawei>
Date: Sat, 19 Oct 2024 13:49:04 -0700
Message-ID: <875xpnbyyn.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 16:36:08 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Prepare the bmi270 driver to support similar devices like the bmi260.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> One thing in here.  The enum ID thing tends to end up costing more than
> the benefit it brings, so for newer drivers preferred option is separate
> structure instances rather than an array.

That makes sense to me, even considering your comments on patch #4. I'll
switch to separate structures here and keep the if / else in that later
patch.

Justin

>> ---
>>  drivers/iio/imu/bmi270/bmi270.h      | 15 ++++++++++++++-
>>  drivers/iio/imu/bmi270/bmi270_core.c | 18 +++++++++++++++---
>>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 11 ++++++++---
>>  drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
>>  4 files changed, 45 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
>> index 8ac20ad7ee94..2e8d85a4e419 100644
>> --- a/drivers/iio/imu/bmi270/bmi270.h
>> +++ b/drivers/iio/imu/bmi270/bmi270.h
>> @@ -10,10 +10,23 @@ struct device;
>>  struct bmi270_data {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> +	const struct bmi270_chip_info *chip_info;
>> +};
>> +
>> +enum bmi270_device_type {
>> +	BMI270,
>
> Whilst quite a few drivers do it this way, over time we've found that it's
> much easier to just skip the array of structures and have independent ones.
> Increase the extern lines to one per supported device, but removes
> need for an enum here and generally gives slightly more readable code.
>
>
>> +};
>
>>  };
>>  
>>  static const struct of_device_id bmi270_of_match[] = {
>> -	{ .compatible = "bosch,bmi270" },
>> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
>
> After dropping the enum this just becomes &bmi270_chip_info
> and later you'll add bmi260_chip_info etc.
>
>>  	{ }
>>  };
>>  

