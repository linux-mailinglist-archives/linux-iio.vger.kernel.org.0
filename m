Return-Path: <linux-iio+bounces-12102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65A9C3439
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 19:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF051C209A4
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F913C683;
	Sun, 10 Nov 2024 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="YaCXOLZ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CC132132;
	Sun, 10 Nov 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731263932; cv=none; b=c0tJ15maFD8i8dYZo9d9xhm9ea/1El8+A2re2Mo6ilb1eafNY4DO3XUj4qdAbwHL0jDPck4ebUDOoHkscyxjKvUjczXhzFYESairxFgWfOBUUclY3BskR6AKxJA9oz0d5DngALNopmpyoG3btq1qTF8bGKYghIuoOC6+5WuMKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731263932; c=relaxed/simple;
	bh=PsBg7Ce1DYJDfWfovTedXuQXSEUBe+bUODMBThwdmPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaKkJ17zVXCQhJPIVcEtkKbk8dl9QWagLtM5CBZIT58rd8bbnHSdg2q5r+4mZLxgfKqF6YizBAHwlCvahb/vR5P1T7Ym3LcrlyGNoPNMmz8bmD72i6fRDW6qhZ+62yD2jgtlH9AeVtZNof2pz5ikkM5SykYyeUeKPUdxEKOraCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=YaCXOLZ6; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 7ED404C930;
	Sun, 10 Nov 2024 18:38:42 +0000 (UTC)
Date: Sun, 10 Nov 2024 13:38:39 -0500
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with
 devm callbacks
Message-ID: <mlvzaskgxqjfu6yiib2u7m3pczsifsluc4mqnzy6w3xzxblvm6@xrxvvruzftn2>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-7-aren@peacevolution.org>
 <ZyiGiK6bSd_d0VQ6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyiGiK6bSd_d0VQ6@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731263923;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=Qy4vL7Aa/N0uJPCViG8PBJ+nuYrVrBC0UAvzWwrOHL0=;
	b=YaCXOLZ6I9KETZJhjAINjNnyvKBf5znCzqyzCvW4Gt6yAj5JjKSUvVMbRxsmAL17MFKNpI
	W+YoXyfVwq8Jnn5gFd/1msRzP8Ge43ZWspuzVa/ObWb/dmOzhX8EyBxwxa6YRKbM/cepxI
	mLCuNzWmXaiUdXgUFFEzx6RHq990McU=

On Mon, Nov 04, 2024 at 10:32:08AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 02, 2024 at 03:50:37PM -0400, Aren Moynihan wrote:
> > Using devm callbacks helps to make the ordering of probe / remove
> > operations easier to reason about and removes some duplicate code
> > between the probe error path and driver remove.
> 
> Where is SoB?

Oops that got lost in a rebase

> ...
> 
> > +	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
> 
> Why not simply 'dev' as in below call?

I was trying to avoid refactoring the entire function to replace
&client->dev with dev, I'll add a patch for that to the next revision.

> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to register cleanup function\n");
> 
> ...
> 
> > -	mutex_init(&data->lock);
> > +	devm_mutex_init(&client->dev, &data->lock);
> 
> Missed error check, otherwise what's the point?
> 
> 
> Also can add a temporary variable for 'dev'.

Yup, fixing... I need to read the docs / function type more carefully
sometimes.

Thanks
 - Aren

