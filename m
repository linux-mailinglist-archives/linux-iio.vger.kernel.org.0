Return-Path: <linux-iio+bounces-11663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926B9B711B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 01:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176CBB222B1
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 00:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAAD38384;
	Thu, 31 Oct 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="psq1dtEy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T488zIJV"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14653A7;
	Thu, 31 Oct 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334163; cv=none; b=Zqg+U83aAzC9gjFY0eU4Xy0fg2b4T70iS3aH4Dl9li37koYA5mPeM8uaytvqIpW+bs0W9AbxRGtIWoNxoeKe+jZESDbBOkNTRwLWAmLKg5Ss0yB4OagQqWiFHBfnKi5qE5u+MoYV7IoF7DNjT+LBzqlPbgZPl1zzAVIkW12Qmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334163; c=relaxed/simple;
	bh=mXzGNXOzoEpPANsKrOIIcMcCUBg6ySS5sQpL9j6eHwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=if32XmnOjH0ZJK+a6zpm4wB1dB4C76tasX/lQQQye3uWxlILTN7OHs87i0r4ryMJC5gFk9XI6FWwUdnJAmP6ff1mmtCkJ82iDQKPwUdDwGGRF8s4P3v3qUvW9KkwfXsNMGT82LZIVGeOpC/iyAjNhTYnINe3ai2jDRQIUvt5mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=psq1dtEy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T488zIJV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 10166114011B;
	Wed, 30 Oct 2024 20:22:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Oct 2024 20:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730334158; x=
	1730420558; bh=mXzGNXOzoEpPANsKrOIIcMcCUBg6ySS5sQpL9j6eHwc=; b=p
	sq1dtEyohfAF0pZGBiDIQQk8OQLqHw35qmi8Pvv9S+4+TqTxPvWfDNqSgMPj2+G3
	oiZnRNUQeXgGQ5XhGCLfbdlyleOd6ADfaXvTgkUH532ErGiMFst5FmIv2tUkHYrN
	g/hPkrOr4cDU33a8j91EvH+/egh81r6sDBG71BlNtF4cgOP51Ot9sMZhFFHO4kiE
	F+EWlkcQ7Tr4g6Xbjv7qO9C+tYOYYnVseH0jbKw1UNWwsEuWeJyoNvitlW+T41C7
	WO7D050FKxZO52P9CBUjv1JcNvuSJoLGqC/U++Xa8SGXUhZnBOLa7yNW1owwdn8t
	IqOhEvoUcoZdbF/DkPLYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730334158; x=1730420558; bh=mXzGNXOzoEpPANsKrOIIcMcCUBg6ySS5sQp
	L9j6eHwc=; b=T488zIJVHAc1m7tLA7Hi/TuO1NYBngJHw0EMzVgY5womohXZ6p4
	8c2i4nO0q88Gg+uSBE/trqJDrpA/5C36IzPQAd7Y1WQtCHSIhGT6Bc8UbFtSpd80
	vk0AnJ0YlwoDT/wVBVisEVMW8sm1bC2rD/c4DqhYPV1uxhDsDDM21YJx4NnwTIzM
	c/pTiVWTtKeLXZe//D5HNmKbiNJ4aZF7uQ61Yd54mdd8DPLDbnpBuP5NW7PWs9VA
	pFfvjsLo890XjKrkvmkW+FJ6H4H+Wi0eD4vGUFqVt4Qy6h29bQW9Qw/jhXB0HfVu
	UN7XBqzCibJzgxcTrETy2nBl9yoEggzPtcQ==
X-ME-Sender: <xms:zs0iZyXnnNTrqEKZCIIa8VOO4CJWot43KIc0SfsxM2GjXvieajLp5w>
    <xme:zs0iZ-nEi_LZ21p_yYcCh6MNpLC53uNDAxOHs2f1R_xDJTP_SDpqk8KqDSLzhPute
    32kC_feeTV0s69gig>
X-ME-Received: <xmr:zs0iZ2aFmGQj4bGXrViD0_jVV8BZG16-zUZfOMv8CSsU-U8MWlglPejCf6DDswdFnmbg6NlgQg0ywt6Vp234fEJLjdeyHt3m0mM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpefgueegueeiheffkeektdetfffgffeu
    ieekvdefieejvdefiefgvefhiefhfefgveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hphhhilhhmsehmrghnjhgrrhhordhorhhgpdhrtghpthhtohepuggvrhgvkhhjohhhnhdr
    tghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvges
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhiihhosehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgv
    nhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegtohhnohhrodguth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zs0iZ5XctY_SrqjklwQf19IP8Dh-X-AXzkYrKQhOGlzivlk3i8H0ng>
    <xmx:zs0iZ8mNPGBUbdVeqg2zQP2-3rPp_VUpXoNADYclZ8yeyDBebHjLUw>
    <xmx:zs0iZ-eQXeW1-n6bMPCOAu-TwPzhHtmzOc8hMw2gRn0CRlXxnCgOOg>
    <xmx:zs0iZ-HNlxIGaxNdaBR-VxIuXChUyHNQXv8NKENiQ38-Bu8LDJAGYw>
    <xmx:zs0iZ38Ixzg9ZB8fHZtL4bui3CWjtx3Vt0KGR6Xrd_5FU3Qc_ZeoCz7J>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 20:22:37 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v4 0/4] Add i2c driver for Bosch BMI260 IMU
In-Reply-To: <20241028201817.71bebfee@jic23-huawei> (Jonathan Cameron's
	message of "Mon, 28 Oct 2024 20:18:17 +0000")
References: <20241027172029.160134-1-justin@justinweiss.com>
	<20241028201817.71bebfee@jic23-huawei>
Date: Wed, 30 Oct 2024 17:22:36 -0700
Message-ID: <87a5elkto3.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> Applied with a few tweaks thanks to Andy's review.
>
> I'll push this out as testing to let 0-day poke at it before it goes
> into linux-next in a few days time.
>

Thank you, and thanks for all the help!
Justin

> Thanks,
>
> Jonathan

