Return-Path: <linux-iio+bounces-15328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC368A30751
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CB918868B7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C81F150E;
	Tue, 11 Feb 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lsj6qQ2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1ytzOyC"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820481BD9D2;
	Tue, 11 Feb 2025 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266780; cv=none; b=Rcbpz1aGHIV0NBZD5mRpGJ0GxfCPJZtFeaHpYku9blTu7DTw4Cp3YWwTkoEON7rGbjNQ1aXofQkJjbpPbnWZ6SidciSDpvtq/JNfOA/+aytw8ua0yCh45OHGCNHxSRIjTicwGlm5DMFZ6bppf1ppzkgq5RZNh4NorsRXsOKe5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266780; c=relaxed/simple;
	bh=D7zD+p56S2uJb050elc6uqiirJAnWzqABI0Tvvzm1PA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oTesMPf0cWHK+obo3MABEZRKuV6hDRuLS2fBffG9LaRnIwcUYzbjukOyhHgeNCvu4tSEyw8sO2h2c3K0rGS85zVU4CJA5SKXazSf1OS9TAm9b9d3asVZsNqKz5lxlvCody/aq5OVFjI2SI/RKeIzXoLj1oEfr5d6/i7WfShsJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lsj6qQ2q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1ytzOyC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EB3C11401C8;
	Tue, 11 Feb 2025 04:39:37 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 11 Feb 2025 04:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739266777;
	 x=1739353177; bh=MRQlTKoPQh1fnUMrZpxRpmFtfnl/gO3GS5ESXGTQf9U=; b=
	lsj6qQ2qXspoZnGD8qrPMhDUL/HUPuBpDp4TCziuY7Y5F87+Lwm3k4R9LRuKFTkj
	7R+hw7HxwG0/fBtr6Pbf1Ro4Cx/h6vRCwc7RU/yM4Dqwn30CJBwnf8G6hopQa7kV
	NbLR3Ysi5mqtwM3x8b9ZwJL3aWu8xQ8xBLKmf5f25fSOGEHuvi8Q8UcSYjSy7amI
	2qoWJ/j1jm8O/WFq/eP614xiNQpav50zcEM4t22xnwylN9YJ8WnUlZ1CkWCk/Gg1
	Cz8NdkCw7uft+UrbHZCTWsTQOXmQ2tC5alroV/OSuv/OdgguJINN/LhNdVfVuVZa
	bx6qFKfx/Zyi6ygnzc80gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739266777; x=
	1739353177; bh=MRQlTKoPQh1fnUMrZpxRpmFtfnl/gO3GS5ESXGTQf9U=; b=O
	1ytzOyCDn20E6j7konLb1nk6LSPBYbqzOwh9s6Q/7yTh8fkTLsmbq1dKTRMSLTMF
	bmcFT0CY/Bz0SBtFFLmjYFxb7bPXyCTwEJiX0ogs+o5OPNFYsr9Nrn0DgXhsfxkX
	m7YK0Df8uG6upe5Dr+6o5usDu4lAyBwc13Y+tmi/Us006zFljxES+gAx3gTuX5uO
	j8lfVYvjDQlduG+RTXEGxSueejGUUt1/9qHtoU6ETlmT/BnPKv3rr28fW55Ta+9K
	bR08jsuuaNh8mdNhGBtu1KbJnqkUurD8OzkBKcyHuTfljGfNRdZzPmkBFlFUEQSy
	fgd+bi871QbpOaNNmBmRg==
X-ME-Sender: <xms:2RqrZ5ri0pdyHuTglNDXJaIrJ6PjjOH7ZycWO8L_Q9ifnE6wXzOfEw>
    <xme:2RqrZ7rzTtZ_p2NN4MMxlPmdwbftiJ0gfsU1DTIQcUzY6avFmWuI-c0EM6wAo6Otn
    NZ_RpOcye_Pb7XFMZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdeiiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:2RqrZ2M6byFl_gSVcMJ1iAp4gInXGYPnbasVHiO1gMSRM7PQGGg9bw>
    <xmx:2RqrZ046-ByUStylR_CWHsyeELFY0fsOFwqdAlEsI69cndmDLFsapw>
    <xmx:2RqrZ46rPvrMkzd8y0lewlZLxwsdWGjBQ6VOrHe_RiNpzhP7GUvn3A>
    <xmx:2RqrZ8g7n6Y20_Pg4nstPsse4Zu24VzSG3TUTcPNjO6VjizmQpCCag>
    <xmx:2RqrZ-sqGxff7huGPCRZoM_ZWT-reuMfETwhqqkj1M_2GbLBP77xVnoh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0E152220072; Tue, 11 Feb 2025 04:39:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 10:39:16 +0100
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
Message-Id: <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
In-Reply-To: <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com> <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 11, 2025, at 10:27, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 08:36:47AM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 10, 2025, at 16:23, Andy Shevchenko wrote:
>> >
>> > TBH I have no quick idea how to address this. It seems that io.h 
>> > includes device.h
>> > for no reason (but I haven't checked that carefully). OTOH, we need only
>> > IOMEM_IS_ERR() definition which can simply be moved from io.h to err.h 
>> > as the
>> > former includes the latter and the definition depends only on 
>> > compiler_types.h.
>> >
>> > Arnd?
>> 
>> Removing linux/device.h from asm/io.h is probably the right step,
>> it really has no business in there and no other architecture
>> includes it. I don't see an IOMEM_IS_ERR() definition, do you 
>> mean EEH_POSSIBLE_ERROR?
>
> The definition is in the generic header and patch here relies on
> that definition to fix the sparse warning. The simplest solution
> is to add another patch that simply moves the macro from
> linux/io.h to linux/err.h.

Ah, IOMEM_ERR_PTR(), not IOMEM_IS_ERR().

I don't mind moving that if it helps you, but don't see what
the problem is here. Is this missing because of a circular
#include list with linux/device.h including asm/io.h and vice
versa? If that is the root cause, then I assume there will be
additional problems either way until the loop can be broken.

>> Most of asm/eeh.h probably shouldn't be included by asm/io.h
>> either, my guess is that we can get away with the
>> eeh_{s,}{b,w,l,q}{_be} helpers, eeh_memcpy_fromio() and
>> eeh_check_failure(), which have no dependency on 'struct
>> device' in the header.
>> 
>> Removing a giant header inclusion from another one likely causes
>> build regressions in drivers that should have included the
>> header (linux/device.h or something included by that) themselves,
>> so ideally there should be some separate build testing of
>> powerpc kernels.
>
> I believe this might be far out of scope for this series due to potential
> fallouts here and there. But would be good to have it separately.

It certainly gets towards yak-shaving, but it does look like
the best solution. It really depends on how much breaks -- if there
are only a couple of missing #include statements, I can see those
get merged early as a bugfix or as part of another series. If there
are a lot of them, it is probably not worth it.

     Arnd

