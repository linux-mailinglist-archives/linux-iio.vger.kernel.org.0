Return-Path: <linux-iio+bounces-367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AF7F8DD7
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 20:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0587281459
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F82F842;
	Sat, 25 Nov 2023 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTzcUKjF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BD1EB57
	for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2023 19:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF474C433C8;
	Sat, 25 Nov 2023 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700939737;
	bh=5U6ilYOb9JOBKF6J2hmo2yKz7KIJBaspaNBWIMEXAHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTzcUKjFn88nrPC276FOv9e7ls8eMT58+rj30j/T4s2A7y3BkJMBbmH7QOYsaopqG
	 LY6qRwSxN5IgfrjsRcrHhFwV6XZt51lQWyev1EXhJUU5t4zIJ/Pti9u3uCujYw1rhG
	 TIRznnqXUt49PChQSzcOKOdbQN1x3kI7b4oBukIdo6d3+HwEVSCf7bCN+PpJc+wUJG
	 JDxpIlCLZM5KbsdJnaCXMS3wFVVxrCj2EU1GHNKd9V/9RnRUUJtGOpe3yUvWuVl6Pu
	 EvDhAVVIBcrRnnknE9+T+3JCPvTMVnpVzCGYZHkgG2Eqz91LFEgQmrtmC7zRKNQuAt
	 F22rScENy/EdA==
Date: Sat, 25 Nov 2023 19:15:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Angel
 Iglesias <ang.iglesiasg@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series
 pressure sensors
Message-ID: <20231125191529.2ed1ddfb@jic23-huawei>
In-Reply-To: <ZV3b5sUrGEj5ZOF0@smile.fi.intel.com>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
	<20231117164232.8474-2-petre.rodan@subdimension.ro>
	<ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
	<ZV2a213oidterHYZ@sunspire>
	<ZV3b5sUrGEj5ZOF0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> > > > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > > > +	if (ret == -EPROBE_DEFER)
> > > > +		return -EPROBE_DEFER;  
> > > 
> > > Oh, boy, this should check for ENODEV or so, yeah, regulator APIs a bit
> > > interesting.  
> > 
> > since I'm unable to test this I'd rather remove the block altogether.
> > if I go the ENODEV route my module will never load since I can't see any
> > vdd-supply support on my devboard.  
> 
> No, what I meant is to have something like
> 
> 	if (ret) {
> 		if (ret != -ENODEV)
> 			return ret;
> 		...regulator is not present...
> 	}
> 
> This is how it's being used in dozens of places in the kernel. Just utilize
> `git grep ...` which should be a top-10 tool for the Linux kernel developer.

As per my very late reply to previous email. Nope. This regulator is never
not present. It's just a question of whether the firmware tells us what
it is, or it is supplied with a stub regulator.


