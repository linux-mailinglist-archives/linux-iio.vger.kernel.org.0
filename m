Return-Path: <linux-iio+bounces-10531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C899B7FE
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 04:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EFB1F2287C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8D1849;
	Sun, 13 Oct 2024 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="UL9QTdkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2DwG9ng"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DE231C82;
	Sun, 13 Oct 2024 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728787013; cv=none; b=cl/tNjHCyIoyBhDssTnunrQPUIMj5B8e62iDhCiADnhsJLt6qPQdPxecEa3bsbOX6cpXhfCx2IyfsUfrVKv+e07K9zLP00+ZS5ceWJQl7zqWBINjSALAthhwy9dswWxQk8ccSuVvJibyMn4c6MjXGaz2k65OFUAj3K1i3JLkiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728787013; c=relaxed/simple;
	bh=vMMKAplKyUTUcrkikgOqTTozdmCMFowvezd5EgVehjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSMEaV08UFyfM8cm5RbFLen7l2DzEBN7ZRsGvPdsAUJJeAulMvRdfV0ko9EJA8HlzfuGRDpncoSgc+McY7MHdkRv+sK07V2LG8OPWMUANcoAwZezI2UKp/Q1sMHMZdPAayPiE3ZlHyCewMBENFDhp0wgGHvFhKQgsON+HHEyn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=UL9QTdkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2DwG9ng; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C986C11401CA;
	Sat, 12 Oct 2024 22:36:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 12 Oct 2024 22:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728787009; x=
	1728873409; bh=d7/FJiZKS5xOjRfb4VlbMojz10lKKCat2lgObu0fi70=; b=U
	L9QTdkA/4RZT4smn1qCZkb21vlX+2HlxbKJcTq5WgHd1xycCnSANd1FFQbAk2yq9
	pe3Tr61MRZStvJ6MG26HoMk7MrX+F8eeao0LyJpwMU2PpVMQnkefi6aZp9r56cxc
	exFP1e0zWUdH7ug6jUeIOoxx/nA9q3Vgpmevc4avGTUtHGqE3fIeNLXWsdrtFmkh
	xMiyCJ7x7aVn04x60Covppx2Odb/9hNPlqLCZ/k5y+BfqF5Xj6QeideBxc/hokW8
	7mtT8etw8WWV/W+BA/XzLyw65XaZCyNTINTM+95rg/feTZRnAzjAwX/V6h1fimFA
	jL6qBEvlg71QmxRhAgKJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728787009; x=1728873409; bh=d7/FJiZKS5xOjRfb4VlbMojz10lK
	KCat2lgObu0fi70=; b=F2DwG9ngF+o1zmMTgXEvvvUpRWQBPOALylAofrNzVExI
	tZ6WtIF0PZk/OBkHAKkG/RALF2YR423ZANmnyvNCl8GRuQWgjwjVMDawRTAcfaYp
	yNWrm+9SJzCftJcEds58x3uXIlryga8ZdyoRSR2hvSNhW3eimHxA20/eGwkTKNwI
	WXjMPhiRHrcfODXj2UlSghzkErxGZshrxfa7gwunzUmOqObllFK23Q5ez2ATJkqA
	wFzRn6E8VSm7oRlgCHFm7+9GtWal3xW1WgFecOWgrUX+R+1i5AQfo9fokPGI7eK7
	cla/CsN3cTt7yGrjkO63a5Fj93oVpAq7plBesfdipQ==
X-ME-Sender: <xms:QTILZ5QrcYFTcvW9tOlhDp0zXMobL4pQnYKEVCPtK4x1UyT0y4UZBw>
    <xme:QTILZyyivJbww5vd9sUEsI8Kk9HcWRuEqbY_B9qQWnnL_OWWw_NpzXJRleNrhf1l8
    vG3roU0v4Y2Mms5cw>
X-ME-Received: <xmr:QTILZ-3s9EcES0SwItu2SCfxLT4rDGNVf-bVF4XNu-1JEph_yWgjHVwcicQRRjWIcs9BNpiln-wr9VLjSgAm76M1v2Uuil2H3mk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeevveevudeutdehgeehvdeuieduteeh
    kefhleefffegheejhfdulefgjefhffefueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhu
    shhtihhnsehjuhhsthhinhifvghishhsrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhmsehmrghnjhgrrhhordhorhhg
    pdhrtghpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehlrghniigrnhho
    rdgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:QTILZxA7heWpz6d1GU9Yv2VNBfJcRbiBjY9Sy8EDhQ2pBAB8yHUyxQ>
    <xmx:QTILZyhKzvvmNzjEwcj67LdKT_0IMAP9f1VxCFuNfNiaQZva9iyEYQ>
    <xmx:QTILZ1ofPBvoXd5FgpngyCaEyBySveVFK9S1Sn_lerE11pIR8D_oQw>
    <xmx:QTILZ9jGWQJK5a5Ss0Ahr_CMT4lvGP1NGJswruI3TxHyk_q-Dm8eRQ>
    <xmx:QTILZ2gPg6307X_Ovx1-v6pvcOyMrr15uakDsJcBdocobwIGESVDwuDk>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 22:36:48 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 0/3] Add i2c driver for Bosch BMI260 IMU
In-Reply-To: <20241012115743.4a878daa@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 12 Oct 2024 11:57:43 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241012115743.4a878daa@jic23-huawei>
Date: Sat, 12 Oct 2024 19:36:47 -0700
Message-ID: <87frp0rao0.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for the review! I really appreciate it.

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 11 Oct 2024 08:37:46 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> The BMI260 is the IMU on a number of handheld PCs. Unfortunately,
>> these devices often misidentify it in ACPI as a BMI160 ("BMI0160," for
>> example), and it can only be correctly identified using the chip
>> ID. I've changed the driver to fail if the chip ID isn't recognized so
>> the firmware initialization data isn't sent to incompatible devices.
>
> So just to check, is the firmware always specific to an individual chip?

For these devices, yes. The BMI160 does not have firmware initialization
data. The 260 and 270 have different firmware data from each other.

> Normally we strongly resist hard checks on mismatched IDs because they break
> the option for using fallback compatibles to get some support on older
> kernels for newer devices, but if the firmware is locked to a
> device then that is a good justification.  Fallback compatibles in DT
> will never work here.

The specific problem I'm trying to avoid with this hard check is the
situation when a device actually has a BMI160, this driver matches
"BMI0160", and sends the BMI260 firmware data to a BMI160 chip.

I suppose this driver could target this situation by only failing to
probe if it detects the BMI160 chip ID. That would imply that the device
is a BMI160 and should not be handled by this driver.

Then, as you suggested in another response, the driver could check the
other chip IDs individually. If the driver detects the 260 chip ID, it
would send the BMI260 firmware and so on with the 270. Otherwise, it
would use the chip_info found by match_data. This would at least handle
the problem we see in shipped devices while keeping it flexible for the
future. I'm happy to make those changes if they make more sense to you.

There's an older thread here that provides more background about the
DSDT confusion:
https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/

Justin

