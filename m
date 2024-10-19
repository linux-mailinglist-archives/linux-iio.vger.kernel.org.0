Return-Path: <linux-iio+bounces-10810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0799A50DE
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D658E2847EC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0D1925A4;
	Sat, 19 Oct 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="dqHT970T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdE2rGHn"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337E192590;
	Sat, 19 Oct 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729371170; cv=none; b=GDfR14HgpC0UPYQr8vZNNZnxzKuRf7SdXp8SDicsdLRq3JGFXkJ++Vwq3Q0csXUjDju7FK5TY95mCjJ/HR9uJRGYqs90Kuqf4HyYWVJd/qZ+jqX/AK4fWfe+GoLG3fRXxPKJFcPYY9GOQaXpEX8NQ38GxjlfmGVmd4UNtrho0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729371170; c=relaxed/simple;
	bh=RILFvJ1yN7ZOx3mxQgMiXLAeiX/lGY7Mf2wYswky2cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUle6gFyEAHfAYPeHUbbw/T8NkKUWq1jTU8af18OBFj1S9ehiM1C4HIv4UrixjBroEx3hAJcmb3SQBCGR4NzXyhmpS+Wuc25HOkHoYJumrcc9hSnMmIuO1DiSkY4wUKgT+nTdQZaRVfWF0q5IG9Jyss/E+rIGh4sRjE2iLvyino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=dqHT970T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdE2rGHn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E229B11400DC;
	Sat, 19 Oct 2024 16:52:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 19 Oct 2024 16:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729371167; x=
	1729457567; bh=8FqHG8aptUYyCqhU4kHt9RmDYElKUOHIxru8Xwnj2dc=; b=d
	qHT970T3ztsm3uBnB9Ykc3r+eXfy0exZndvQluHwIkxeAmK3voUAjO6na/mE0q6y
	iCDOFFv8d8+VfVoSuNFdQ1XZ8DDCg9POnejUbgrR2jqBFoBR8QlSeDezsuZnQSqy
	9yQia9MRr5n/RduOsmvmBKLppuDKTKzpeCrlGfnEDeDTWwswW8wmwha1N4aox6Ou
	ZsjBqRmif76E9LD49Zn5iFw9Wfn7tqKto7QvGv5WIeExi4gT7oIdwPVsfUEY4ZF/
	INFh6UyurajQ/Ly9QxLY2ytfOftIBLnYSQNTuywMv5hky/cn02zDBAMl+msyg9i/
	iSRm1BqInKHtJ64+k0fEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729371167; x=1729457567; bh=8FqHG8aptUYyCqhU4kHt9RmDYElK
	UOHIxru8Xwnj2dc=; b=VdE2rGHnan1NYUYdYGmCqHrB/jRbOwXnxLdW0xIL2xzs
	1pAeQ2LLnjqqEGky3qX3wFZvmm2DtI1BC4nmFRhAzDyPRwbkqAVF+D/jyipuw0E4
	w/W5tpbAfqrh9Zl0t4k/CCXHfVLaTcxeMox112yqMpiSDTnECjH5/PW7cfPDi1UJ
	2MiI1M7XDNs2K/0MCvC41bhujxy/cWt5nhnMCANRYvIcOq4UZaAUQj3BtkTJsHMi
	0JJoZD90CymN34iAPM+Qs8X/Wt6nSV8p5a4+NeHmyUm8JoxGZexJFeds+xvDAa21
	rZ/CRZuIjtrWBQDwriZwKp3ETIS0P4uXRCT4DxUsrQ==
X-ME-Sender: <xms:HxwUZ6mHmCGgi2YZu1TBjKMy8z0HiusnLOiiZpd1AdAdEIBjELICkQ>
    <xme:HxwUZx21lT2tXfMAXAeZywm1BY_nEH8UDNa1-mj050mLrymf70znWUuUx6p1iO5Zf
    bkXfPuO6G_TSP6A0Q>
X-ME-Received: <xmr:HxwUZ4qDks0UibuAM9Ow4i5TnfWBT87HNPKKDb4C0NTOsHQVVPLrfniYsWNsYKgmaJC7J3hFkfkTddpAuuj2xnENLEeBL7UeOic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudehjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:HxwUZ-lpq119Kb2aX8bt__paM7GnMF9MaCSE78nFfEyvH_sl98jxWA>
    <xmx:HxwUZ40yM9BayPGWtTRSc_880y5FtqucH3k5moUuEN0NV845CeJtBw>
    <xmx:HxwUZ1vQGQbQu4Vjb710esH3vlyaMvo3j1UwOHQJbRS_3eT0ycURUg>
    <xmx:HxwUZ0UKsTpeET_pHyN4B9fQUh0B0G8TUGp7ihK_krTQzD1K0QUX5w>
    <xmx:HxwUZ9uvAIjcHpgy7MX9xShTpGLohxsJZBQ8srqT_OeJEqtFFbKCZ2bD>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:52:46 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 6/6] iio: imu: bmi270: Add scale and sampling
 frequency to BMI270 IMU
In-Reply-To: <20241019124410.554c2817@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 19 Oct 2024 12:44:10 +0100")
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-7-justin@justinweiss.com>
	<20241019124410.554c2817@jic23-huawei>
Date: Sat, 19 Oct 2024 13:52:45 -0700
Message-ID: <87h697ak82.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 16:36:12 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Add read and write functions and create _available entries.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> Hi Justin,
>
> Just one trivial comment from me.
>
> Jonathan
>
>
>
>> +
>> +static int bmi270_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct bmi270_data *data = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return bmi270_set_scale(data, chan->type, val2);
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		return bmi270_set_odr(data, chan->type, val, val2);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
> Unreachable code, so drop this return.

Will remove in v3.

Justin

>> +	return 0;
>> +}
>>

