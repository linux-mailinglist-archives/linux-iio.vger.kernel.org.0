Return-Path: <linux-iio+bounces-10805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A469A50CF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 22:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4965F1F24922
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDF1922E3;
	Sat, 19 Oct 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="PqS/dubz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Afb50izW"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD33149E00;
	Sat, 19 Oct 2024 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729370902; cv=none; b=jLR09jbPoJ6QNruOFHDhnfs/JzgDa+4wsQ18GwvPRDnPQIf59WFF1sgaMvlqWmz/Vk3YU0MYATklkW7jbxm3jZ9AvaSfhSFiYKiqPPdzNBUR6DSHQ/0snLpHB+iit/VThcxoVXeUvUcXctoT0vOpmFnb0FcsQG3/PyiwhJfPlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729370902; c=relaxed/simple;
	bh=pFX982s9lDFHQTGuFybaGYW6BkEW1ifOItMP1AQ2o+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S/dEHOz3YH3ilN7DttYy872+CQogjQVdSyh1dM7RC+fXGY7eQthKUU4PflBlhgF4nwHvNdZMRYEinxhzrl8IR7XuQVVeA+HPRsma8qsczT4+9wmOIchTH/r720GPLqPMIp5qLZXHwQ4tVTOzljlArjwcPd7qgWXIwSIDKEFhEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=PqS/dubz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Afb50izW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 854F311400FF;
	Sat, 19 Oct 2024 16:48:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 19 Oct 2024 16:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729370898; x=
	1729457298; bh=KaptA6w0mVT1BTgQT18FHu6FA9nL/jkHoCKfQfYTj08=; b=P
	qS/dubzkCgaXw8YxrpmgVT/DDRmqVjfy2IPgxrKDcGhp0H7MhIq61TWivTaNdikl
	vE0k0tbqjr9SDyw5WrkS4PXHtg2C6H6/s8qz83VupY8rmJ9tHIK4r61AsxRBvcQC
	MNdCmiPmnaYtVUyESXNiZ9HbFX60HAOhryWPJ+4o48NY/jmBlI9fvqZPyjjGg/g/
	tJRcg8iiLzUBYxb0N6pEGENCoOsyKocppCLgoJo0F3x2Ev4Kt9OjISPQMoR2DVwv
	At+HuxWqhi9rh7EF4CyBcGz01CyAIwfsQ9Yc0YL5sEEBiOvkJUKHvDANBzPLd/5M
	OZcZGziMkiXQLccOKoVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729370898; x=1729457298; bh=KaptA6w0mVT1BTgQT18FHu6FA9nL
	/jkHoCKfQfYTj08=; b=Afb50izWdKfn8De1tZRX6j0cn6PX4sFmva768w+GOGlx
	A257IzpCKFBjwL+EYqjYdwxuejUsejwWn3Pn3W6DrzYjGequm4VqSsbSF57IYf1u
	J4e9KPiKstpos8K4JARHb1nyEywd0plFk7S17h7tPTpnpthKpCMbq/NqDeYbrnpR
	2acdZMitYTMNradIr/lSCW8Wf8f/F5QoB6WZ3ikVjCd7rrLL585u77NmwzROA9cV
	wCmlFZ9Ti0rBa3efDrQHPH3gGFowOh6HZpY/imPxmnNoJj1BJA3jH79t/yR9k+0H
	VbdmcQ4qr2H/Sa2wbspCclQiKHi5bpF03LTfBajD7g==
X-ME-Sender: <xms:EhsUZ6koaYTQz91BY9aRJUN8G1BO6ZWh6bQv34niE8hNkR2qW9pngw>
    <xme:EhsUZx1CEC2YeGYxZraQsXj51noESgRk6hs47OohBBucoP6uaYT1NrI1GOn3_EVeE
    kLEQTl64vKnEr-kuA>
X-ME-Received: <xmr:EhsUZ4qMbtv35jVlRy0DzH0M2DY0nqv9UwneGt3LRRgXXaLMW-himZItYp9_MtnF2y8vwSWf_Gm7IHoLP7ejouXKYg7mEziELwQ>
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
X-ME-Proxy: <xmx:EhsUZ-k-cUC-LgGkJbYUxacn2BTJBe4fzOJmAW0_F_Jx2_4L9mPsew>
    <xmx:EhsUZ43jzHcaesKxdbFyO4CwEz95oKGsyRGyXNhEUpdimp6xFBF3vA>
    <xmx:EhsUZ1stkKM31nTjrY4Jyq-DGhqwXtbCLBcRWUR_fH9b-hiqlEOpqA>
    <xmx:EhsUZ0WjpFldRRFhbIj4btA9CYscEYZzVrGjCrs1z2QYBCU0rsw8aQ>
    <xmx:EhsUZ9tMyJNKv7FXsGcXDNUPQDq4spJ7k1OaM24ovVkc5m5SxheDvKqx>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:48:16 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 1/6] iio: imu: bmi270: Use INFO_SAMP_FREQ instead of
 INFO_FREQUENCY
In-Reply-To: <20241019123005.096f03c3@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 19 Oct 2024 12:30:05 +0100")
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-2-justin@justinweiss.com>
	<20241019123005.096f03c3@jic23-huawei>
Date: Sat, 19 Oct 2024 13:48:15 -0700
Message-ID: <87bjzfbz00.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 16:36:07 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Use IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY
>> to match the BMI160 / BMI323 drivers.
>> 
>> Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
>
> Whilst this gets rid of the wrong attributes, they still aren't
> wired up to anything either way so a read will always return an error.
>
> For now, the fix is drop the bit and bring it back in a patch
> that adds the read_raw handling for the sampling frequency
> (patch 6 I think).

Makes sense. I'll remove both SCALE and FREQUENCY here, because neither
of them are wired up right now.

Justin

>> ---
>>  drivers/iio/imu/bmi270/bmi270_core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
>> index aeda7c4228df..87036f352698 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_core.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
>> @@ -122,7 +122,7 @@ static const struct iio_info bmi270_info = {
>>  	.channel2 = IIO_MOD_##_axis,				\
>>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>> -		BIT(IIO_CHAN_INFO_FREQUENCY),			\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>>  }
>>  
>>  #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
>> @@ -131,7 +131,7 @@ static const struct iio_info bmi270_info = {
>>  	.channel2 = IIO_MOD_##_axis,				\
>>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>> -		BIT(IIO_CHAN_INFO_FREQUENCY),			\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>>  }
>>  
>>  static const struct iio_chan_spec bmi270_channels[] = {

