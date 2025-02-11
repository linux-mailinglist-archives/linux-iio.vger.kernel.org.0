Return-Path: <linux-iio+bounces-15334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB7A30871
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 11:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195B33A413E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118311F4288;
	Tue, 11 Feb 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="7jiT3OiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4dWhCRk"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A841F37BC;
	Tue, 11 Feb 2025 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269410; cv=none; b=rWSns3msUH0+KzC9o2xNjv2HJJ0xWZ1hgw1xiezNXG97uB8v39nqQ7QpRbz3Yqkfa30zwnO4t7tAGS9JSZehqZuNFSHW+u9kkKLt2zXCBR+m7phlt+3i/KDIdyCSIkvjuCk6bqMakFCyZzqAE12K5EcFgjHV1o8GNlynMSnbEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269410; c=relaxed/simple;
	bh=xGVNrU+Td07Sq/OfoziyU6CAIh+CFau93NGRqIkJUjg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bHeyZxm0yqDBIKnLM/sb52sdI0YgzT8ro3l3bgZSJz+lPXXMGia/3E+Saz6XmqrD2WwIFdVMddET87WA9roqh87Frq9xy+7QKj62K5636L87PhwRl8U6MUyHRQlrBd2Dq9UHpR0I+otxJAP+htHNLBJWHj/po0+4NkUw8nm+rtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=7jiT3OiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4dWhCRk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3235613801EA;
	Tue, 11 Feb 2025 05:23:28 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 11 Feb 2025 05:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739269408;
	 x=1739355808; bh=8OyYLNftrq4qsPpVbcCZjPTAkDXA++bvU6mWCFjEjgw=; b=
	7jiT3OiSpA32reTMzba8ong48JFOgVF1U6a/YhE+4hM+N4lPWP6VdAMdNJG4eqpW
	jy2ZuhgN8H4sARf6uwBwrUfOBu1EYIKmIgq/E5rSmLNchTlhwv3Qwui5NOMUKE77
	uuQHRJxqvlbIIUvsSvpIrfDt7VIX32RPC6LAEhr3R0N6+uwY+lggC2MYpfPglDAA
	x1cY0JNj9pgZT92ohW9w03Q7Oqp53okxso3H3D+dYMDiOAEYcY8CvIE1DggWn+7M
	LnYgWH19tkgs9IC0BJjs+6geR/ZvlQhiAEIp0j9nKZGPemiNzOhVypH7R5LgQRbE
	Ruvri524FrQeNymKKkhJGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739269408; x=
	1739355808; bh=8OyYLNftrq4qsPpVbcCZjPTAkDXA++bvU6mWCFjEjgw=; b=o
	4dWhCRkdj4qkaNqhhPfJvLUVKiW9tPyFpvdyy9b0EGiPkRcll+xQkcbrSPJ7aj7x
	0WLpuT6sDRveNwFp1OmHd+d68i0kuE+AfPp9SKs8bP3llOZ41o74GPbRHVmZZBPT
	cqz9T+R44zFDcyumuIhpLjdUu/QvXhb4z/4soGf+vBJX3dF5jGK6FjCS8Osf5WZO
	YaOr8zQeGgrxrH1seTBbcWm/eZCbqwa80f5meNvG/OJedAKPf6Pqdorl/26V8pxn
	UrNuCGuKhmxv9c/5Y0LxDu11S+EJaKnNuMTn17Dv4nzD6m24376CM7eDV3K285rR
	L+CAUxMCaiNPnvKR3XUeA==
X-ME-Sender: <xms:HyWrZ26wHeJmj1eYHHDJ_3ZWEa_xwAeSt6ZCS6aWQfgb7qDfoAM2Dw>
    <xme:HyWrZ9sAr9XdFcg7XJplGIdZ9q0Vb3LpTZsQL3ikp9EWV2eYAYPB3s0n2WxsHbqa4
    FmCG1BmSUquhX0hYkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdejhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:HyWrZ_5UbZd6U-PsEAdgo-UuxpcBhgDo44UH9H0ZQWE9eV-SlLTvDA>
    <xmx:HyWrZwWyp6B9-dwn-rssMz-baxnFh-3GaCaPG-BGfm2skTTAb0GcBg>
    <xmx:HyWrZ59d3gv-TbLJSalbb526wpA9l5YwAcQI5vgVAp71mgRA6mOjlw>
    <xmx:HyWrZ0mdiyFLSyGCoKVFrxDMPn4pJf2nuCY-ELIgdb46mVwJZNOS7w>
    <xmx:ICWrZ8EhdH1Y_BZY7xcGwPfx99z1LQ-8fLRW3OD5Qa3L5OxUSU3Xytjw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3E5D2220073; Tue, 11 Feb 2025 05:23:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 11:23:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "kernel test robot" <lkp@intel.com>, "Raag Jadav" <raag.jadav@intel.com>,
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
Message-Id: <279d9f32-a1c9-41aa-b15a-e1485877b2d5@app.fastmail.com>
In-Reply-To: <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com> <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
 <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
 <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 11, 2025, at 11:11, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 10:39:16AM +0100, Arnd Bergmann wrote:
>> On Tue, Feb 11, 2025, at 10:27, Andy Shevchenko wrote:
>
>> I don't mind moving that if it helps you, but don't see what
>> the problem is here. Is this missing because of a circular
>> #include list with linux/device.h including asm/io.h and vice
>> versa? If that is the root cause, then I assume there will be
>> additional problems either way until the loop can be broken.
>
> I don't see how. io.h already includes err.h, so whoever includes io.h should
> have that as previously.

I mean I never understood what problem you are trying to solve
exactly. From the log, it appears that the problem is an include
loop between linux/device.h, linux/device/devres.h and asm/io.h,
and anything that breaks the loop should work. Your suggestion of
stopping asm/io.h from including linux/device.h sounds like
the most promising here, but this should be possible regardless
of whether IOMEM_ERR_PTR() gets moved.

    Arnd

