Return-Path: <linux-iio+bounces-15555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C2A37086
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38153B0C28
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05313DDAE;
	Sat, 15 Feb 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="UhxPIwY9"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E70170A1B;
	Sat, 15 Feb 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739650573; cv=none; b=XrTCb5DxRq6HpzdBDn7jUBeH0JcfXkAuRXmAI/puoLiajMcVX2sTsKO7gDFK19BIeJdYEFjDLN4Vq3B9q+TeXzepD6Ktc7DFVIFpPIMQoCXIv+g8KgclKsiIWbYAVfsZe05jnj8rCd9twyC+TcxzJdThmi5AgV70BE5DkCUPNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739650573; c=relaxed/simple;
	bh=WlbhtRtGYmtPNGje39iaRCjxdH8d7of9P4tp6NU4COQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BofRZ2wzWozd5lRm4hUOjNvfgA0M+NUPxQXOELsnmVt9NGbuojZtBq/EbLZSdNgSO+YZc4UJ1LRXeIimSKwx9lq7C+L936Y4zIElHvAxv4GwA3mKt5Hyd4QgTsVbXg/qLAUtIx1uuNo968RN4Z9awLVtFkb0bp7hICN2lX3BJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=UhxPIwY9; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 6107141A29;
	Sat, 15 Feb 2025 20:16:02 +0000 (UTC)
Date: Sat, 15 Feb 2025 15:16:00 -0500
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Julien Stephan <jstephan@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 6/8] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <54gp7mhpu5fgeeif5amajmcit4znuil2kikx43bcu6eujmq5wu@oxaq6fgmkuyr>
References: <20250208211325.992280-2-aren@peacevolution.org>
 <20250208211325.992280-8-aren@peacevolution.org>
 <Z6jAEEU2dqn_FJVp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6jAEEU2dqn_FJVp@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739650563;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=9aU3GtdyvnIFsX7EEuvTP5n0LC+5wNHQ+PxclHEEIGc=;
	b=UhxPIwY9S/cJsjrbo7Y7Jbp8fUaTByXNtTY9daK6nCgyrAVRT/LqrCjd9PIK20mNGpI+Sb
	FyoQ4aPFr+Gu5e6hm1lrVo5zf0SOTy7mJ8vMS9HehLOI0GNQBSn015MMTSx2lbhaBwB32O
	GE4DT4Me4PlvRlOFVApH7v3WxkKD1H8=

On Sun, Feb 09, 2025 at 04:47:44PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 08, 2025 at 04:13:24PM -0500, Aren Moynihan wrote:
> > Using dev_err_probe instead of dev_err and return makes the errors
> 
> Use dev_err_probe()
> dev_err()
> 
> > easier to understand by including the error name, and saves a little
> > code.
> 
> I believe this patch will make more sense before switching to local 'dev'
> variable. Then the previous one will have an additional justification as
> the "struct device *dev = ...;" lines in some cases will be added already
> by this patch.

That will only be added in one spot, and I skipped updating the dev_err
calls in the previous patch that this patch rewrites, so churn shouldn't
be an issue. That also makes it trivial to reorder them, so I guess it
can't hurt.

> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > -	if (!indio_dev) {
> > -		dev_err(&client->dev, "iio allocation failed!\n");
> > -		return -ENOMEM;
> > -	}
> > +	if (!indio_dev)
> > +		return dev_err_probe(dev, -ENOMEM, "iio allocation failed!\n");
> 
> We don't issue the messages for -ENOMEM.
> 
> If it's in the current code, add a new patch to drop this message and return an
> error code directly.
> 
> ...
> 
> > +	if (ret < 0)
> 
> Perhaps, while at it, drop these ' < 0' parts where they are not hinting about
> anything.

Sure, I can add patches for these, although continuing to rebase this
series is getting a bit cumbersome (perhaps just because I haven't found
a good workflow for it). Would I be better off reordering this so the
refactoring patches come first and can be partially merged?

Regards
 - Aren


