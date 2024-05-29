Return-Path: <linux-iio+bounces-5425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632418D2E0C
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B821F2526A
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21383167260;
	Wed, 29 May 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="h4x4CSEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUzHnTTF"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F482209D;
	Wed, 29 May 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967451; cv=none; b=iVp1ELe8rTYyPoytBLyp60DsUTwJdBlWeKy5GURkKvDDHSyuptlJNeSCUNJUHbaj5kPZ2/iFGwJFs1gANk6tCQZOAcHNTsTmY0Cj/QZin0rZFgyBZRMcM0mfNwECuiUAXnGALtj8zvpL2kh4c5CDb675QrxcgLrOUOZYgTuc+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967451; c=relaxed/simple;
	bh=BiLRi+Tm9dHBabsoQiYKbpEETDYvhOr2pvI35tWBrHI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Tn+uZ45PeTFpstoQHp8fueEpdW7dg1xEFdTrtMe4fxSuDEYDvYINl5AyET4kyTCStKk7jQEry2feIDwscFY/pV83KbCIZ16pkemHudk9fwkc5LnG+UygtaojMkfnw86Olhgx1ANNsnxbCjgDLF26Fxdp7vOsuhGTzbz6NtjGTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=h4x4CSEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUzHnTTF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4CDF413800A9;
	Wed, 29 May 2024 03:24:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 03:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716967449;
	 x=1717053849; bh=Gf0qo7ee/AEBpbdOcGj06T/gtZe+ynU8fDYYUQNiucM=; b=
	h4x4CSEtTHwuht1dS/NJgvp65UnTU41dpZW4e9sLOU8xqutZITW+d+RxXo76OzuD
	ChMjh0GFEzyVlosguBditusdEipRU71hIsyXVbYmbR5niPhsdD7QRRm8Po1tlQFJ
	ErZkhR4dY/uWkL2ONPkARrIeRdhTO9FCSA6jXog8sby4JvuPNVcTKZ9Yelxdlzgv
	Vd+HZYCj0bSF/I6NiZZd0yIYZgl/yAdY5+lhH24UDDwqsw38hfrXt2bi4EAZttSJ
	IcfJAJ08vi4FObI4fjbV/wlfiJ4GFN7U+NY2x7ZDdVMZSfI6k9Y/OvQ6wi0IWnjF
	mX55VNS3jPEHpQ3HaDZBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716967449; x=
	1717053849; bh=Gf0qo7ee/AEBpbdOcGj06T/gtZe+ynU8fDYYUQNiucM=; b=R
	UzHnTTFdk3oWiRf9YxJEMrpM7NmWEpEQorOLXKOP1+MH0EFg0AuZDM0INP2I+YIi
	kexZXQfu7rXWFpV8hclGsy+CKG/aelT8BYNhCzwfHM1U3qsdDQPIJIciUtt+nMMx
	4wDKDoiGZXrnGyDGauzW8JY87iqccW5jGVOz4n3D8NFg0pnCUkY2UqL449iAobdk
	Zw1sfgqDnkczVnrA3UHPcLwfFz7lsm07e13nH+64Hg8tvXZe7i5tF8OpRjK5M0ME
	RJAtNvB5rezU8QOnUCSw7F3q8SnXp94tH+NKlB1tU7lzLbX3rybW6OxinYszTv4M
	0SRvUcfW/ZIr+TLsMW9cw==
X-ME-Sender: <xms:GNhWZupp2ySFefzGEQi7Mz223B4lYgMtQlReU1C0bNUS3uTMRVuL3g>
    <xme:GNhWZspwQqoKL1ODI5vwLP08p_iyEllD159sdd1i2xewrmuuIhNDbgDTG8Yz24f-0
    2qNR7qdDdBLQMzpepg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GNhWZjPaN01USRLJH2GN7MSCqQXRMmKwYxGm14gM5E7wN8KPPmUBIA>
    <xmx:GNhWZt4lubTFMPwxPAMw8etb0OR-hH_d2FqnII8OceZrtfaOjQ-4dA>
    <xmx:GNhWZt5XxvPjGFegJQ7C-RbtbJa1yYcO8JXSqupTxotoaKgijXbC2w>
    <xmx:GNhWZth58wPWGgCPthdDvIGW8LtY-ku1wHr3BTabRMQMgagCPt7-XQ>
    <xmx:GdhWZiF6-9rsoR2QapE_JSgmTlxz0pnmbAdcwpp2rXbZkymtvM_k2ex1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D889BB6008D; Wed, 29 May 2024 03:24:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <81ec1d1a-d8de-47e4-a5d4-eeaaf1e806a2@app.fastmail.com>
In-Reply-To: <539a815398a3c991c1bc1a53967fbcba282dfe3b.camel@gmail.com>
References: <20240528121304.3695252-1-arnd@kernel.org>
 <539a815398a3c991c1bc1a53967fbcba282dfe3b.camel@gmail.com>
Date: Wed, 29 May 2024 09:23:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Dragos Bogdan" <dragos.bogdan@analog.com>,
 "Anshul Dalal" <anshulusr@gmail.com>,
 "Andrea Collamati" <andrea.collamati@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad9739a: drop COMPILE_TEST option
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024, at 09:20, Nuno S=C3=A1 wrote:
> On Tue, 2024-05-28 at 14:12 +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> Build testing without SPI results in a warning:
>>=20
>> WARNING: unmet direct dependencies detected for REGMAP_SPI
>> =C2=A0 Depends on [n]: SPI [=3Dn]
>> =C2=A0 Selected by [m]:
>> =C2=A0 - AD9739A [=3Dm] && IIO [=3Dm] && (SPI [=3Dn] || COMPILE_TEST =
[=3Dy])
>>=20
>> There is no need for this particular COMPILE_TEST option, as allmodco=
nfig
>> and randconfig testing can just assume that SPI is enabled separately.
>>=20
>> Drop it to avoid the warning.
>>=20
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
> Only for my understanding. When does COMPILE_TEST makes sense to add?

The most common use is to enable building a driver
that is platform specific on x86 allmodconfig
or on randconfig, e.g.

config LPC18XX_DAC
        tristate "NXP LPC18xx DAC driver"
        depends on ARCH_LPC18XX || COMPILE_TEST
        depends on HAS_IOMEM

Since ARCH_LPC18XX is only visible on arch/arm, the
driver would never be build tested on anything else
without the ||COMPILE_TEST.

      Arnd

