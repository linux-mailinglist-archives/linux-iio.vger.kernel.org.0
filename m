Return-Path: <linux-iio+bounces-15360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B6A3158D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14792167A91
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7026E63D;
	Tue, 11 Feb 2025 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc45PBjv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D626E621;
	Tue, 11 Feb 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303004; cv=none; b=dz+2RR8/RuP7Y61E6bIDzQow9UgXvhvcGP3kVJtC36V+QTkyzjPwSvgE/d5Bx+C8xtw9BxyyjN7Hpg3zAnqcv7rJmn5DogydYDlyQCYbtmykPRLy8oem61j//9KEpKfZ9wS7jwbEvqjYuIMpl+B65xMnyiSlvRh+4GjMbuHaAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303004; c=relaxed/simple;
	bh=4XexGdXOFontIM3mZHXhRS5GhmgTqewPXUiq3Nnpcv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feOo9lt6k7IrU0RTe/woCFZndQH0cyU9tHKujAFLZ57S36VLrCZLAc7IMmZrfOvvZI3lthbQzMa6Z4p1w0PpRyXcZeN/hF7JVzxw3O6fRVYTuyf9QF2PK+PTOWH/xMtKVQFlr5pcNcRGym052VZRSS6FdI+UN3EAur+s/KtfDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc45PBjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ED1C4CEDD;
	Tue, 11 Feb 2025 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739303003;
	bh=4XexGdXOFontIM3mZHXhRS5GhmgTqewPXUiq3Nnpcv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nc45PBjvGQuGiQdegIj/KYY+yjskkhFbpH0To6q7d5/f+ptYUkoC8PP0Iy+jr0a8Q
	 /CZAR1B/5zdN0GbXuhriso1RVenKrD4zrKtAuNw5odKzhKdkFZY7PtscbyOYMiqACn
	 QLFbHf4KQmfbxRbmerlFZ1wKiG964H+y+IpD2ovHgPel/W5aX3QsID3LiWjhJHR1MP
	 eK2xKahGlO95MsKGc0kamhS7drzJ/kxK1whZ0gdQd0eFt9LiwRVX6gV0H39aVkvsHn
	 luMcrVz1P55xcjif7VDKYZe4ltCyd+1vrOyyq1ZcJLNuBAnnOoigHGpdfLMqYZAM7I
	 db76zwJNX/Eeg==
Date: Tue, 11 Feb 2025 19:43:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aren Moynihan <aren@peacevolution.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Kaustabh Chakraborty <kauschluss@disroot.org>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, Julien Stephan
 <jstephan@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Ondrej
 Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 6/8] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <20250211194311.5255f25b@jic23-huawei>
In-Reply-To: <Z6jAEEU2dqn_FJVp@smile.fi.intel.com>
References: <20250208211325.992280-2-aren@peacevolution.org>
	<20250208211325.992280-8-aren@peacevolution.org>
	<Z6jAEEU2dqn_FJVp@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 16:47:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

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

I'm not sure I follow this one comment.
The only line that has struct device *dev =  added in this patch is
replacing an existing client->dev lookup that could have been pushed
to previous patch if this patch ordering was maintained.

For dev_err() to dev_err_probe() the number of references to dev
is the same after all. The only additional justification this patch
makes is some longer lines that using a local dev pointer shortens
again.

> 
> ...
> 
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
I'd be fine with that dev_err() dropped in this patch as long as the
description mentions it.
> 
> ...
> 
> > +	if (ret < 0)  
> 
> Perhaps, while at it, drop these ' < 0' parts where they are not hinting about
> anything.

That would be a separate patch and indeed makes sense to me as well.

Jonathan

> 
> > +		return dev_err_probe(dev, ret, "device_register failed\n");  
> 


