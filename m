Return-Path: <linux-iio+bounces-6728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8CF9136FE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12ABCB21612
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677012C530;
	Sat, 22 Jun 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="RqWk2u74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1+6E85p"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550212C476;
	Sat, 22 Jun 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719100181; cv=none; b=S4FiB4BZRu09qOikBBvD+t7465RK4cl4B8l8RVAH/Y/UFcHrL7ZSw/XFK8qLdyrmpSiUfKVT7KFoOU4zW1kHMjQPSFy6DV5ELF1sW/MVrHrST55ki8HetHG2lFZZTV2LLq4yv0Kb/GXE6BBWtPqftsdUxKDI/hoxIKqjS7sOM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719100181; c=relaxed/simple;
	bh=n8TOyY9QpsKAPLOdkcrhCleAAY6/GoJDfkxKl+txU5Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FQSmDEkcHiO1p3pWST5zHFzNmQTJK4y+HnKGu8u8f2AGRNXXdw5Ol1uMCAurfPPsRRFPNDilW2Inudqr6ZdAluvL7QaVipl5J+Nn1BSZQsNn2YpdtaB/CJEyxrx9jF6UIa2ZcxOG+v2kQbFkXahqBKlFOoAeTVzSwEl6+8a0Dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=RqWk2u74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1+6E85p; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7767611400BD;
	Sat, 22 Jun 2024 19:49:38 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sat, 22 Jun 2024 19:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719100178; x=
	1719186578; bh=n8TOyY9QpsKAPLOdkcrhCleAAY6/GoJDfkxKl+txU5Y=; b=R
	qWk2u744rGmsCwdpPW8e56cyJm/aRuRo5pGHd87gkchkqpjOKJWZ7tL+9rADKcsk
	7ECzQ01fxM8sb1linSOS/5nzs2+X58J3k+cMfazzGgd3cEsals1U/8H2IWfTMYTC
	17n00iApIoQKuP5moMZhnfG8XT+OiaqrT1+I/AXuxXnR1/fGsqDKqvhF4nn05Ete
	DzU3fUJi8z1szoc8gdb/o7O+LXK4+pvGP7XnudH8hHohndh+FH9uU4AUQAwSWoRD
	PAumW5glInZrMZJIF7OMO/fSBuLxl7tFieYSDElNN7FsQqt+KVYAi29b4a1ZJpNR
	EPjmQhWHn/P8KZMwicIlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719100178; x=1719186578; bh=n8TOyY9QpsKAPLOdkcrhCleAAY6/
	GoJDfkxKl+txU5Y=; b=C1+6E85pWaBWBQu8G8OvfjLUgyU2ryGaS0u4HxL0ZpfK
	ZtveALCYydNN9YX4lB+PZoGIvdDnV/1+XeDhZu2Lyhx0OqC4x1swKI/qk/vdvy76
	097NiTbQ2bvylBw99o1P2cG+zQo7U6dN9vHXBn+t+DQCJDAsf8iIj9fzU4UMWx+6
	13BX+ymKMb90vSU4yHmELMo8Q5nLPolZsF8OU3JPlm/i4/3w3kbM1kRddCm77a/D
	J/oQuXaeTIzKLbfjVsA3XK/lWLBp6Q68vMIo+atePJDFtgeW4LfPA8D0ENfHV3Qi
	STXX9eAVqjstkDrb7hTfsd9bkPmWO6WTqVKqHsb90A==
X-ME-Sender: <xms:EmN3Zn9Qbq3Cb9yQrmHvnVV1EtBT7FUSHggrylIsUiikv3HylMm_bw>
    <xme:EmN3Zjt8VJPvp5s-OAJVBOh6f2GeXZ61HiTRuN806CQ1tXWOCGI-jNleDrqwBGez2
    IaKfGNq_F5kIflq3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:EmN3ZlA_WkoYUgBBrEBkhlXUYc0suJnwbSD20vW8NxEXTOwduAb3dg>
    <xmx:EmN3ZjdB8r975Ookg4Ik51fv-f_Wrom0L0ySxs-Nn5XbO7ZGjkDWTA>
    <xmx:EmN3ZsPytG2qROweSkVJTPHj2LwP1J3aavNy1GxNWesSKPE5p_lQ9A>
    <xmx:EmN3Zlkr0a5S03XVrFZGuLK9V7D9R5hlqtqUOAN5IJnSLeck_MTUiw>
    <xmx:EmN3ZhsnC_bHkC8pt8ZnRbNG7dCvmb3eBZmLXBuU5CGlBrhv3vdJidib>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1D92DA60078; Sat, 22 Jun 2024 19:49:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c6b8b70e-e983-4412-8588-a815e95ecc67@app.fastmail.com>
In-Reply-To: <20240617220535.359021-7-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-7-macroalpha82@gmail.com>
Date: Sun, 23 Jun 2024 11:49:17 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Chris Morgan" <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, "Mark Brown" <broonie@kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Samuel Holland" <samuel@sholland.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, sre@kernel.org,
 "Chen-Yu Tsai" <wens@csie.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 lars@metafoo.de, "Chris Morgan" <macromorgan@hotmail.com>
Subject: Re: [PATCH 6/8] power: supply: axp20x_usb_power: Add support for AXP717
Content-Type: text/plain

On Tue, 18 Jun 2024, at 10:05 AM, Chris Morgan wrote:

Thanks Chris!

> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add support for the AXP717 PMIC. The AXP717 PMIC allows for detection
> of USB type like the AXP813, but has little in common otherwise with
> the other AXP PMICs. The USB charger is able to provide between
> 100000uA and 3250000uA of power, and can measure the VBUS input in mV
> with up to 14 bits of precision.
>

Can also confirm working on an H700 device with the AXP717, with detection of supplied current, voltage and presence.

Tested-by: Ryan Walklin <ryan@testtoast.com>

