Return-Path: <linux-iio+bounces-11871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B29BA692
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7D81F219F0
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DC187879;
	Sun,  3 Nov 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="pLlGFQaC"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9B17DFE4;
	Sun,  3 Nov 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650280; cv=none; b=ff8nwkncRm652FX7GTdpW2uE1ZCbCSkRH4nsgDEelRv/C6PwPUSJWhZNqHb6YbjQ2QU6514uo+Jk9xncNrS8gZo5Qesnz87QZ/Y0v3ROnvu8JyfCSyDhxn4nYQ0ypSoVOlS0l4TY580dyZLWsBAeZVAcPz7UyBAZu5tRFngWMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650280; c=relaxed/simple;
	bh=NxDS9O+723j2rQWp5co1wAaa/RB6x3JY6rfjUVcqhKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+AMS2o0hjWYBqYJwP06M8A0k3O2rwqvAme5YLji3sb1r/XUB/G3n17Z3S/gbbhUiSGzc+n3n1AnTDpLr6TubGsjvFBXKs8vCE/SM19bNgirIdN8OqU95+75+JoFhHLJEq6t/yOjdEgNTk0I4IcAVZ6mqKqO+FjIZ1PUWBcje7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=pLlGFQaC; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B0D134C745;
	Sun,  3 Nov 2024 16:11:15 +0000 (UTC)
Date: Sun, 3 Nov 2024 11:11:13 -0500
From: Aren <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <cx5bvcqfabsptn37uzscooh73j73dsoqadmfaibzxrzjk3byx4@ofwu7qa6ht4f>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-9-aren@peacevolution.org>
 <20241103112933.60f96f97@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103112933.60f96f97@jic23-huawei>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730650277;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=3q7IWRD1gpOW1Lskvc4rjHRf5AbTOTI6oSgYSMbB074=;
	b=pLlGFQaC+RM79asWpic5KogsiEgd7rRKglcrwIATo9BlHDxXN1CfmqzAZDL+ATwdbmOjG5
	pUiNx1bIU1/iU751En6NAr5vmzF7xDI64tGRkfacCUOIKoqq8QVCqJvvXKAuasXuQer4Jw
	F9P2J+OeRh+nMCaavLqn3ENg6jl+zCc=

On Sun, Nov 03, 2024 at 11:31:03AM +0000, Jonathan Cameron wrote:
> On Sat,  2 Nov 2024 15:50:39 -0400
> Aren Moynihan <aren@peacevolution.org> wrote:
> 
> > The vdd and leda supplies must be powered on for the chip to function
> > and can be powered off during system suspend.
> > 
> > This was originally based on a patch by Ondrej Jirman[1], but has been
> > rewritten since.
> > 
> > 1: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > 
> > Notes:
> >     Changes in v4:
> >      - fix variable declaration order in stk3310_resume to match the rest of
> >        the driver
> 
> For this Andy was asking for consistency.  Generally we don't insist on a
> particular ordering in IIO drivers, but we do prefer them to be the same.
> Your new ordering is inconsistent between resume and suspend.  Whilst
> existing code may be inconsistent, you can still pick most common ordering
> and use that for your new code.
> 
> If the existing driver is inconsistent then feel free to tidy that up but
> do it in a precursor patch so there is a consistent style for you to then
> carry on.

Oh right, the order of declarations in stk3310_suspend also needs to be
flipped. Is that simple enough that you can fix it when applying this?

Apparently I was being dense, I checked the rest of the driver to see
what it did (it's consistent about putting shorter lines & ones without
an assignment first), and fixed the case Andy pointed out to match that,
but failed to check the rest of the patch.

Thanks
 - Aren

