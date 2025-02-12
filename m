Return-Path: <linux-iio+bounces-15409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112DA31F3A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DD21888207
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D01FCFCC;
	Wed, 12 Feb 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R6fagGky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPf4LlXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19B1FC114;
	Wed, 12 Feb 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342535; cv=none; b=I9ZIsSt5CfrhmCTDrvR2XjT1F5UqXrZaQR4umttMC4SOtiOUPmqHZIxpFJuzX+QM0Wx5+8Jv/nO4bGOB1IIiFmqZKJc9lWur9rKEjIIM/FQ6u3pC2ZhAkBL+U/oWZ2WsyCMr9awtGQM4DOtLKA/CR0sPANoNlZYNwAoDANqin1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342535; c=relaxed/simple;
	bh=J9+lbUJeMTLyE3XBLqGE5vHG21bWIh11YuVz0u/YmE0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gE2O/xRaI3+s2iUYpaphIxbsXHOl1XBxWTV1iiaSKzDTTcc80gESv0Gwb6wh/ES1Q5liUkkPbep9V6ESWHwz32AK21kZAl9szZnHZd41eo1LL3Qib4EnMdER/rPS7pIiFy7B3oHdC83swcZF1ie0LNmuDSFumlPoxg4XeMh5rlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R6fagGky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPf4LlXq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C08CF11401BC;
	Wed, 12 Feb 2025 01:42:12 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Wed, 12 Feb 2025 01:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739342532;
	 x=1739428932; bh=NJ9jDy4M2IixYsn/6MZ1R985FuHiTyNQJDBfOGPI6og=; b=
	R6fagGky/QjAPTJ0If3NT0IY1nJPH+mFRhxVp2o3fb5mHb0/d84d9GACwjUDJzul
	3ztaAXX1Mh1xD0MAI+eL4QlCXfFSrF84oZsht6nYW7rByFaWDg3mK4YkOGpG3Y13
	MekidPb6llSl8tU3o5oLgtULErLx6+lrf0H3AGBNF8lCZj4RDlaymrYQiQsBA0N7
	kuJzmjPRXh0CnijQC0PI/QhgQtHEU/+E0ukYJlgInEmYwuJIOM93evLGADgwV9uF
	v7hUHnXnraxg9J21wPkB7T+nGDFMldf2ivMdEs6PTpu8wybe1NrPs1sVxRRjBWbf
	u5oWDgoGdiTYox9AjaqHeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739342532; x=
	1739428932; bh=NJ9jDy4M2IixYsn/6MZ1R985FuHiTyNQJDBfOGPI6og=; b=X
	Pf4LlXqnjrPYE/tDO1Lyt0yY7CB0MlDk6BzD0XRxr3JWAmA7qkbGkVfikCEdvuAC
	5wUH51GnsDCX0WBAc7FhDg4I8IumubNxKQJ2+Q3CazSB2Ueg7OWl8+tTQVi5uF23
	PIsFIsxFrWplj3aOoUCfgh+jGJzzJPgy62pWyExQxUSurlw5z3xLMZJ8h02iaKWL
	VpmFT96L1JbA94jFX7Nu/pzGdj+u0S3bc74hZ+wNqpH2lw9DirxShOsa3Wds0odk
	L01SSr/eVsZ6PLIOJrclMufOcYILHjbcbCBgaiIJ6C+gMIdnGWLK1EVhFMPv2xdL
	5TFhpp6D6c1zsXlphAczw==
X-ME-Sender: <xms:xEKsZ2r8mm7m77PEayUrozeecv6M6q2_Ku5VZw4F-QYtU_otYlrWsQ>
    <xme:xEKsZ0rRcjwS5fQwGI9xUOE_lj4dlEUNJ4UFEq2SxPeo-Wqyw1SjFh7r5SrD3EP4I
    xYMrt-GuLDjXmXVEYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehprhiivghmhihslhgrfidrkhhithhs
    iigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehrrggrghdrjhgruggrvhesihhnth
    gvlhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfi
    grlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgv
    vhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrg
    drfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
    ghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:xEKsZ7Pwg_gkg4C4aBYZpjULmsxBkPYr3ytvVD2BWRNO8dkxH0DyQw>
    <xmx:xEKsZ166Vb707-yYTgsBxm0wlxshnnsMSFEXemvr2xI130O6vGyU5g>
    <xmx:xEKsZ16S3J7IEDT1YmDsxiyZQIoXtqZeHwxkGusv--piAeOv9fGhMQ>
    <xmx:xEKsZ1hi-cIapV8d_E1f9j8qTCyFe-3MPhKKDr90CyLcNVGEBy72hQ>
    <xmx:xEKsZ9y87fhkDhiAzkLXIpLwfltWeNx6sOp-xJ8YoLmDRbMhTLO1hOqh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C2371C20066; Wed, 12 Feb 2025 01:42:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 07:41:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Raag Jadav" <raag.jadav@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org
Message-Id: <4ea5bd29-3d42-440b-bbea-203479116b48@app.fastmail.com>
In-Reply-To: <20250212062513.2254767-3-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <20250212062513.2254767-3-raag.jadav@intel.com>
Subject: Re: [PATCH v5 02/12] driver core: Split devres APIs to device/devres.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2025, at 07:25, Raag Jadav wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting devres APIs to device/devres.h.
>
> In particular this helps to speedup the build of the code that includes
> device.h solely for a devres APIs.
>
> While at it, cast the error pointers to __iomem using IOMEM_ERR_PTR()
> and fix sparse warnings.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  include/linux/device.h        | 119 +-------------------------------
>  include/linux/device/devres.h | 124 ++++++++++++++++++++++++++++++++++

Acked-by: Arnd Bergmann <arnd@arndb.de>

Splitting this out makes a lot of sense conceptually, though
I don't think it will actually help with build speed: In order
to see real benefits, we'd need to remove the linux/device.h
inclusion from other headers that are frequently included,
but those don't really rely on the devres interfaces.

    Arnd

