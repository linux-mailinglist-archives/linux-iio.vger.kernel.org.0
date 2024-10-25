Return-Path: <linux-iio+bounces-11292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD159B08A9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618591C20C95
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9911415B130;
	Fri, 25 Oct 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="qS1ZsvmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YgsXXwcY"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEF157E99;
	Fri, 25 Oct 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870986; cv=none; b=hih2eUzgOjkWDgRqJjsuQgV6zmj93RQrHak+07cXfiC8J263Tgu/Q48UxBm8GlAyB9iDfTSn5i7CLLZhXfLCEpDY6qoKulHA2SfV+imSHZPwzoUWiDmwGwG8wmiv1G8s8khLiDCDEJkJB475Y9EMWXF6DMrLIuR3/9d5T78USAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870986; c=relaxed/simple;
	bh=892FnEDtSqvg3RuO2rPWKHGWLQaTsN2CZ93QHMrgkc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e63EDh2ewhgxo57Ui+QrFfXVZUHRUlJXGPR47NsgmtwOUWmQ8Fjr2cFY7ZGG/5/d1D3h+wA2c4qspyFJitAobMAKureG9r+KGputn0puQ9GAAp3h1SOoIzrRfxpDpOMevcZO67UmzHJ3Yh19CIwgKjdlzt7xI5ytG/gX1KQ7jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=qS1ZsvmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YgsXXwcY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CD32D13801B4;
	Fri, 25 Oct 2024 11:43:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Oct 2024 11:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729870982; x=
	1729957382; bh=ySWm63aAaQ5hTU7bDWqoK4X5fe19ScHre/li5yhiZF0=; b=q
	S1ZsvmY5mK8Rv3j82BjCuvhZ0MWDqwGG2ZSTI/PiqKGyqgh1RXOyyUZFpliu7hcj
	RDEqf6sjEFqRr1HDP85DasmHczJGokcqU/bkiOGLjpyvnwesEOBCicYSjFam80sF
	Vw4WiGz+0h8CxIVjg9sXgUVh4vMDEUghdkEBnqruCjFg7YqNmrKqNDjVmM1VXcLD
	cudRcBLr/QjYtr80tqpCoMfE2Qn3EYya0tj8ps3ZuBMYh+ut8BJb1EfZMy/adYvY
	J0NIK5P3BvxcADYkwObYVJDeJJ9SURpQHn+1smpYbH5cS+IYStvyaRiTGlQBTtKa
	WgtIuiPt1qiWuH56bXfYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729870982; x=1729957382; bh=ySWm63aAaQ5hTU7bDWqoK4X5fe19
	ScHre/li5yhiZF0=; b=YgsXXwcYzR1MJWCqBZpsIYskeeg+yMEAjp/C/gdRjkZp
	qGsZm3nM472s7gLPkaiECz6lEd5Kx9nd6TmVoKAlpv+rf/dE71vXky3CM+TobyCu
	GHClq2be+V3kQTfIXcvDjYmzH+TmN6uEjw8FAkM80BFHWlHb7HVI04h9zSA5i3/W
	S+GaTUj1GjfMaUjjPIsIbhxf0veISNIOEXum/14PQr8gM8EhPC+beG2AGjuKRS+i
	UBQFcE56O4vFtEA3+QpI/pAj1ps328wBynjZbD4PFZKYaMc5ez1aFjgOiy64ODJG
	Ov7zRM06ptxpL9X3pqbtz0SFXtr1PNQNbjdsu8Yq7A==
X-ME-Sender: <xms:hrwbZ69bN-Yp5C30rcSpcyqIWVr0H2GWjASsC3e_8DmvEI5MINnwDw>
    <xme:hrwbZ6tfO1HpUfMTQt5Q2pTv28ZXE1OqdqmcacSsZwWfY4hGfVt2UbBNV960ITA17
    -zrT6gAXPsQfh8izg>
X-ME-Received: <xmr:hrwbZwC2P2GipVaN_Ntn3Ea_7E-tCLTKpjf4E_WcCYohzAuUSHzcgx3mu6anA4nYSkQEF8WFlaB0otL1hJCIKL9_6KyjPbNuCIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    hffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhushhtihhnucghvg
    hishhsuceojhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhmqeenucggtffrrght
    thgvrhhnpeetfeeivdfhudduleffteevleeluedvvdehkeffheffieefuedugeeiudekff
    egleenucffohhmrghinhepmhihqhgtlhhouhgurdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhhihhlmhesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopeguvghrvghkjhhohhhn
    rdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hrwbZyfqh7KI7aM4_wKss2jM1WuQcm-57mz7oTmuFkpS96fROwKOPw>
    <xmx:hrwbZ_OAdQpk1uawai-hmd-eLoWc03PwKfzYPI0UaiqHRlleOruh4Q>
    <xmx:hrwbZ8nVzCBMlgiI8sXDWeXueNHN7yeU0EDBhQHdGIMSDAY1TMW9YQ>
    <xmx:hrwbZxsuM9UcFD9z_1V-7Qx4mOpQd4wzB5hnnSxtoomAuKzis2oDGg>
    <xmx:hrwbZznrQjN0nsi0mQenHOqmVgQKuw0IvhOcX0hPWvMvVSYu7Rl32tgW>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 11:43:00 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>,  Alex
 Lanzano <lanzano.alex@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
In-Reply-To: <20241022203417.30971eea@jic23-huawei> (Jonathan Cameron's
	message of "Tue, 22 Oct 2024 20:34:17 +0100")
References: <20241020220011.212395-1-justin@justinweiss.com>
	<20241020220011.212395-5-justin@justinweiss.com>
	<87msiwm90s.fsf@justinweiss.com> <ZxfYq1Eo2xhVhIei@smile.fi.intel.com>
	<20241022203417.30971eea@jic23-huawei>
Date: Fri, 25 Oct 2024 08:42:59 -0700
Message-ID: <878quc194s.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Tue, 22 Oct 2024 19:54:03 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Tue, Oct 22, 2024 at 08:50:43AM -0700, Justin Weiss wrote:
>> > Justin Weiss <justin@justinweiss.com> writes:
>> > ...
>> > I can't find any evidence of BOSC0260 being used, besides existing in
>> > the Windows driver. As suggested in an earlier review, I added it here
>> > to encourage people looking at this driver in the future to use the
>> > correct ACPI ID.  
>> 
>> Are you official representative of Bosch or do you have a proof by the vendor
>> that they allocated this ID? Otherwise we may NOT allocate IDs on their behalf
>> and has not to be added.
> Fair point. The provenance of the driver is a little disconnected from Bosch:
> https://ayaneo-1305909189.cos.accelerate.myqcloud.com/ayaneo_com/download/2023/UMDF2.0_BMI260_V1.0.23_5ID_signed_20H1.zip
>
> Justin, if you have contacts at ayaneo, maybe they can confirm if the IDs come
> from Bosch. Or maybe we can find someone at Bosch?
>
> Jonathan

I've asked around a bit but haven't been able to find a contact at Bosch
to help answer these questions. I also haven't heard back from AYANEO.

In the meantime, I can reorder the patches to add the triggers and
attributes first and leave the BMI260 support / ACPI ID additions at the
end.

I'll include the BMI0160 ID (and DSDT) in the patch adding the initial
support, since we know that one exists in the wild, and hold on adding
BOSC0260 until there's a way to move forward on it.

I'll also remove all ACPI IDs from the SPI driver since we haven't seen
them at all yet. If we get clarification on the correct ACPI IDs to use,
we can add it later on.

Justin

