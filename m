Return-Path: <linux-iio+bounces-21068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B7AEC94E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3733B8066
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB9264628;
	Sat, 28 Jun 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6rNXZTi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFA2192F5;
	Sat, 28 Jun 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130713; cv=none; b=abXNlxr3R5ZM7no5lvkFnK6G7bbSq+Nx+mvToaojOnyDcT3KBQvlHbyIOvivo34gB7QmD2tb7BSsuUSNd/VmUsHrfLBtGfopD8YMFSGJUZfKsP1PFaHFbi/gckcHG+0KnNDD2Cx9AqxAv04wrJiPS8WYJ01Y9ho56ZovnJD/U78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130713; c=relaxed/simple;
	bh=gbX/ADDRKHL1YSumcPD7An9QSnUCnzbwQpd1EUAejBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMQxU2gpLCwzXMWb98CDco5EoeeIuLFmeuB6WoX6co+ktibZXnpKPLwX7Qv8XWhrBabf1xcp4YshVDFssVSbdZRj/IkvvQlz+VaNBWjZv8t9BCPLctRQ0SPF4/XjWrUyiq671a+dV95/D5VznMxqa0VOEBDXwm0EvULO8CnlB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6rNXZTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B240EC4CEEA;
	Sat, 28 Jun 2025 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751130712;
	bh=gbX/ADDRKHL1YSumcPD7An9QSnUCnzbwQpd1EUAejBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6rNXZTi7ud19aYrGpHvFIT5bVPHvXcdZf/YBYoFr7zNOK5FGCvq0rQMMOrgSt5W0
	 JfUmfZTCjqfSY4K2ipwjg5mcPLQICN7u82z3sUksEyhqoyoHLhLMiSU1kdleTmtPs7
	 Z5CURrmEgAglj6MKjdl8rvi9UdH7YsJEHTkDxPaXwKQQLaqBqmPooC6kQeDicaE/Nq
	 UN16BHziESBPzF+eIpZm9ohQG70AETwrNkJ2lfKad41KeR/EOqkT9Qewr4tBh6vgZu
	 RCObK5H8BPBGO01jUURK1klYQh+VqlSMSj/JVyhGPN7xTphjwDAoqrOtrZee8qVLeQ
	 O3TbbkDsUDHsw==
Date: Sat, 28 Jun 2025 18:11:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Maud Spierings via B4 Relay
 <devnull+maudspierings.gocontroll.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Christian Heusel <christian@heusel.eu>, Linus
 Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <20250628181143.05d07d89@jic23-huawei>
In-Reply-To: <5fc05140-76cd-4f19-bbfe-e27e90f21983@gocontroll.com>
References: <20250527-st_iio_fix-v4-1-12d89801c761@gocontroll.com>
	<20250531180319.21365159@jic23-huawei>
	<5fc05140-76cd-4f19-bbfe-e27e90f21983@gocontroll.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 15:27:44 +0200
Maud Spierings <maudspierings@gocontroll.com> wrote:

> On 5/31/25 19:03, Jonathan Cameron wrote:
> > On Tue, 27 May 2025 08:36:08 +0200
> > Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org> wrote:
> >   
> >> From: Maud Spierings <maudspierings@gocontroll.com>
> >>
> >> Throughout the various probe functions &indio_dev->dev is used before it
> >> is initialized. This caused a kernel panic in st_sensors_power_enable()
> >> when the call to devm_regulator_bulk_get_enable() fails and then calls
> >> dev_err_probe() with the uninitialized device.
> >>
> >> This seems to only cause a panic with dev_err_probe(), dev_err(),
> >> dev_warn() and dev_info() don't seem to cause a panic, but are fixed
> >> as well.
> >>
> >> The issue is reported and traced here: [1]
> >>
> >> Link: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/ [1]
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> >> ---
> >> When I search for general &indio_dev->dev usage, I see quite a lot more
> >> hits, but I am not sure if there are issues with those too.  
> > 
> > For probe error messages I'd like to see them all moved over to the parent
> > device but more generally it may make sense to use indio_dev->dev
> > 
> > As per the earlier discussion I still wonder if we should harden
> > device_set_deferred_reason() against this condition just as a
> > defense in depth thing.
> > 
> > Anyhow, this is a good change in any case. Applied to the fixes-togreg-for-6.16 branch
> > that I'll rebase on rc1 once available.  
> 
> Hi, I've not seen this patch pass by in the stable tree or will this get 
> submitted for 6.17-rc1?

I'm just being a bit slow this cycle. I'll send a fixes pull request out
soonish then it'll go into 6.16-rcX and after that get pulled back into stable.

Jonathan

> 
> Sorry if I am being too impatient.
> 
> kind regards,
> Maud


