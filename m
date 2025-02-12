Return-Path: <linux-iio+bounces-15408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D3A31F04
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0433A283C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2020103A;
	Wed, 12 Feb 2025 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lBou2fQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqkrGnDx"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72091FF1A6;
	Wed, 12 Feb 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341974; cv=none; b=khfQ2KJovA+9qOzjGpbB+g0D36qgb7c0GMEU1+OSEnikOfraOIrcvUA1VYC7Y+zjAIN4BCPhSR6X25AvvoXB+ySQmdhUfuC+chRNRyFENPHGEuFUqJvdHo+N/q+Ym6n3Rbvwad8jjqQltpErHtAjl2hJdJzEx8wWdGPCkzjNLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341974; c=relaxed/simple;
	bh=d1MFYpO1khpcTJ8tD41CEzxUpyAuaVGNE4yTQWgzgWQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EwwVKultv6V44+OUQRBar39WZwhicByTM603dbKSGYftyYfRWjhPBv74sykDo6qFk9aj6CZPTpRt3E38IWEu/vwdPxaYD17RA4iKPfSs8Ga33WFwJmjsbZuMn13s47vPcnbIR9b0JkTM8I8FBPwMeomGLdQUwceswMX8miWpbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lBou2fQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqkrGnDx; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 65D181140160;
	Wed, 12 Feb 2025 01:32:50 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Wed, 12 Feb 2025 01:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739341970;
	 x=1739428370; bh=d1MFYpO1khpcTJ8tD41CEzxUpyAuaVGNE4yTQWgzgWQ=; b=
	lBou2fQPHZqkGHZUlw84+FBqQmhbL74C9wNs9fnTMdvmz/UwLSNYDBxPI1B8nPGw
	HG+xmqyuEJSQ+wTqodoG6a6QPGnn/QhUo5upWDaTvY0XPFMCm5C/clDz2fUIi47Q
	vb/qNuWSOwmKzQTWTm/op6M4w/40v0rWZPNoxUtR9MF2RVwhJuzOyGxZTJueCe0T
	BhGTqvXPO4BmNAGNjizuHOuqYi7w8L5TQXGjRf46zeDUIBHyC/9btoKtIpRiydBr
	xdgS4UvJu+Spgbi97D7DYNjXU4yL6OqL1ul9Sksd/PJ3XsfF/xtHOzaczA9Hnemy
	l2uWkaSWp9IYfwFh6qEw8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739341970; x=
	1739428370; bh=d1MFYpO1khpcTJ8tD41CEzxUpyAuaVGNE4yTQWgzgWQ=; b=f
	qkrGnDx+JQerBv4lAOHKIYxXkp3TtfM1/wO5p6vle6QXA4fh2t6MYt/WBYQvMTF/
	80WmX5ys0q/cWddSKcfsLbHjAnMcRzegnAxPQIXPxSGrpRweGBhIRVFfeVQ/cfdv
	w7gdpm4hOsmVLqgTjF6nh+KPhzErVtimlcR0wW4koaFZlMd8EU1+nmlD1sl6e947
	Qw9TIPCrquTMm90NnHGFBvWROkIEvoKR/p5Zj6sYkvxCBgdM8/tm/5i44OhB/+2F
	y+Bd10Oc61F+sW4IP81S/8YgJ+WGZD/NG+zkqC1S5InlZvltmpgdIRhAs7PfmqdG
	KlOdiT2utIdt4tl/53AUA==
X-ME-Sender: <xms:kUCsZ2Ia-wYU-Nq1Z2MEKURXaiwbf2GFbN9aXePZz2584YrKmknUtw>
    <xme:kUCsZ-Jj7Ch08Z7gYuZNYG_BpNB4Yd3F3A-KkQqiaDTrmmAVRiII9Uom-a030_EEA
    SJ_Xj6v5c5KWGJoIdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedujecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:kUCsZ2vrG9bMr04h7DWCKGXnNTA2JhM5Wlsh_g80mpcpHNN4Aw3l-w>
    <xmx:kUCsZ7bK7FRi2EZpe5N7RtGFOSErxpfOlDGU5e6S2RPo62LMHSk7qg>
    <xmx:kUCsZ9aX_dYxaphYNKUVDPQduyv5BBH4QMLpdwwU_bKAEYT7EMg9Ug>
    <xmx:kUCsZ3CGkm7ldlrm0plXQnR7uPgcR4a98wgZD9_KydrHMd-ony_8Fw>
    <xmx:kkCsZxSpZ1seMJ4zX1WU1mU_17f8NVCGWixuE1CCAx35sevIjB5BNMGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96F191C20067; Wed, 12 Feb 2025 01:32:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 07:32:29 +0100
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
Message-Id: <40de787e-db78-4af9-bf30-f3714e71fd42@app.fastmail.com>
In-Reply-To: <20250212062513.2254767-2-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <20250212062513.2254767-2-raag.jadav@intel.com>
Subject: Re: [PATCH v5 01/12] err.h: move IOMEM_ERR_PTR() to err.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2025, at 07:25, Raag Jadav wrote:
> Since IOMEM_ERR_PTR() macro deals with an error pointer, a better place
> for it is err.h. This helps avoid dependency on io.h for the users that
> don't need it.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

