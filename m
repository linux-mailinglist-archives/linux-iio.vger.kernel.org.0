Return-Path: <linux-iio+bounces-15322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34DA304A0
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 08:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E756D3A4FE5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58D1EDA32;
	Tue, 11 Feb 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sMNLxJoO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3PrASUn"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794951E5B99;
	Tue, 11 Feb 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259431; cv=none; b=tFu7n5snpImcH7OCZX4mMK7gRTwQhEPgVDKYcOb5Z7SW5tBrMFNts8+lOBR0WKGnWbSbWwvj66Ze+niJd8LAjOdJv/Bw8szP4fpftFBJXq3d+bmBGFkM+kcAX5BlpWBLTIVjUidF6LNnO3hDGSKnd27bIFHS6fBLfqQU5YtFNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259431; c=relaxed/simple;
	bh=DrE5VvGmUMugsbU7+khXZE2WAcu+eIw10jA8iDZj2j4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g2PMHitjZJscmn4YsokyIkkFhljfJegcjYlDRK2/3ibbNBN+ea4xGZUPF92NcKKhDdtqVIqvfjSja8cm2YsjocQRBS92MuhuDB9HJ8K7bcJP/GkoSYm818z0zLFvxIIxZgJiHS2RgzKR6VxaQ75/Yw1QNkHuvE8E2t/xYGO6Ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sMNLxJoO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3PrASUn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 621D511401C3;
	Tue, 11 Feb 2025 02:37:08 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 11 Feb 2025 02:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739259428;
	 x=1739345828; bh=znUeiowfjiS4zFeHT0A4IPaer583HuycpFbIPbnWhFA=; b=
	sMNLxJoOJjcDGL/GDNPyovxAgmRYGCXW8dGfAOMtDLAHhd1NeuzW+l6TcRZJUjrQ
	NSbpUy5x9hP1CsErAYlzmZABNoBrDsehM8vzfc6ItXP1Hu7qKlQ3Zo/9esGAU3hN
	/3lh2vOJTZg93rr6QeRquRnDIBwW9ixt+E/wp5k65xggJUNMU05fuXdNuPU3/+LE
	y8C7khe3BYqvlZjsNM8RYfcFUg/57SojkgHtTKbFzSINt1kugiPRCUCHVjOJ5p5Y
	1+9wbu9AWScusqY42mdvfvzaVIMRaop6bNnOZZhWcs3wf92N7SSG9nrE0dJ/47YJ
	fBQv9+O4unGcN9gXJXqrsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739259428; x=
	1739345828; bh=znUeiowfjiS4zFeHT0A4IPaer583HuycpFbIPbnWhFA=; b=L
	3PrASUnzdNzVdRTF+MnhOhxI7OQfjHae8oaQWTWtWmC5edizDoQz1hcAUIrNqWZq
	NwmqgrZ68IzrLzqxrBBMRgHKV0RreyZbJUyYQLuDqU1DKod4WkcZa+lMoL0L/e+J
	iafmwXGp6VEz3jK0bMqS+PGla65Gc0q/R20HdFyirOOzCID0oJ6Sg7ZEmUG0OWpk
	ToPQt1Fws0JmaG/Wjb1EpaO5AFiM/DDztsRUVL5RDXuctZITURcdp/MtHSJFm4lL
	pdMyJlXAQTF0S016lpJ2Vs+AUagfWXpPT3LT4MAfjoyAEPTZRG39SpuYHgvLw+D5
	sgjleOrKV53g5WakvVp4g==
X-ME-Sender: <xms:I_6qZ1ckZjtXKPSWwiJV1FG59uv3zLq1r0lARt_v0MXgvoCO2jpbCg>
    <xme:I_6qZzO_TUn_gQsg9FTPGneuD26Ry3S13EGFzP-ljYJqt1TOzilSP4LHF-cGZah9m
    uGim2WDq8pJVGReq6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehprh
    iivghmhihslhgrfidrkhhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehr
    rggrghdrjhgruggrvhesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrvg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:I_6qZ-iSRoTxQV9ltzT1BmYpzHsQEtk6iHzU5JGmyY1GBUD15BOylA>
    <xmx:I_6qZ-9ozJz_b77BRmlfLS9JSnzBYv9n71HtSOLdpD9YY-Q51dNVcA>
    <xmx:I_6qZxss56NY0uXH7OXQLzb5cAK9Ns4N2MqnIP1EZEUiJJbcGvhzWA>
    <xmx:I_6qZ9Gl2A4ou3EQcFiN-j8eN79o4SclFO4X7gqQpd5xuDYQv-ij7Q>
    <xmx:JP6qZ1RJkzZG1PZINfYwT1hkKW4hklM4hcrIJRp0NFpDX_z-glquoKjp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA8C02220072; Tue, 11 Feb 2025 02:37:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 08:36:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "kernel test robot" <lkp@intel.com>
Cc: "Raag Jadav" <raag.jadav@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, lgirdwood@gmail.com,
 "Mark Brown" <broonie@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org
Message-Id: <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
In-Reply-To: <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com> <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 10, 2025, at 16:23, Andy Shevchenko wrote:
> +Cc: Arnd
>
>
> TBH I have no quick idea how to address this. It seems that io.h 
> includes device.h
> for no reason (but I haven't checked that carefully). OTOH, we need only
> IOMEM_IS_ERR() definition which can simply be moved from io.h to err.h 
> as the
> former includes the latter and the definition depends only on 
> compiler_types.h.
>
> Arnd?

Removing linux/device.h from asm/io.h is probably the right step,
it really has no business in there and no other architecture
includes it. I don't see an IOMEM_IS_ERR() definition, do you 
mean EEH_POSSIBLE_ERROR?

Most of asm/eeh.h probably shouldn't be included by asm/io.h
either, my guess is that we can get away with the
eeh_{s,}{b,w,l,q}{_be} helpers, eeh_memcpy_fromio() and
eeh_check_failure(), which have no dependency on 'struct
device' in the header.

Removing a giant header inclusion from another one likely causes
build regressions in drivers that should have included the
header (linux/device.h or something included by that) themselves,
so ideally there should be some separate build testing of
powerpc kernels.

      Arnd

