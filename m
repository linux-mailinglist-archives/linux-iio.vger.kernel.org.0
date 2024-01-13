Return-Path: <linux-iio+bounces-1629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475882CD72
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jan 2024 16:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC210B20E1A
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jan 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B115CB;
	Sat, 13 Jan 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WizAQhfL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB015C8;
	Sat, 13 Jan 2024 15:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF633C433F1;
	Sat, 13 Jan 2024 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159414;
	bh=pKcx3wTCQYng+Kv7vvezxSHDwuPxEoWM17nLr50fmSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WizAQhfLBVQzV48MKcpKgYwxYuk9nvP9OGKZNwdP6CXjfkd9Jfpx0oniSilyAty9n
	 tpiPpt3CwtrVBnFYtUtgrg7KRzQuRrZmNB8EJHoQdH+HFzA+YY+gebPyBfaO8V6amM
	 2gO5CeFS09XYM+zKvSqLotFXjw+F4iV8li3sskKnB+lqWKPXybc8UbE5DGsHKGERna
	 3bFH4Rwu3B1cuyMe/sYQYBhzkmyXBxBDiKL8f+ycbWHRmImFYv5lK6cr8D6xdNgiwF
	 xH2WMYkRsLzAGNQR7PbJytyxgrq9o5GpTcK48xM2PZXa/bfFwYRkl/s2qb5O7pDgsw
	 k5Sl6lsbqeHOQ==
Date: Sat, 13 Jan 2024 15:23:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Amit Dhingra <mechanicalamit@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct file entry for AD7091R
Message-ID: <20240113152329.61db1b79@jic23-huawei>
In-Reply-To: <ZaCRV6Qw1KlIFt3I@debian-BULLSEYE-live-builder-AMD64>
References: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>
	<ZaCRV6Qw1KlIFt3I@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 22:09:43 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/06, Amit Dhingra wrote:
> > File entry has driver/iio/adc two times. Fix the file entry
> > 
> > Found by ./scripts/get_maintainer.pl --self-test=patterns
> >   
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied to the togreg branch of iio.git.  I'm not rushing this in as
a fix so it can wait for the next merge window.

Thanks,

Jonathan
> 
> > Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
> > ---  
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 35147477e8e4..ff61be50e82e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1128,7 +1128,7 @@ L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  W:	http://ez.analog.com/community/linux-device-drivers
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> > -F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
> > +F:	drivers/iio/adc/ad7091r*
> >   
> Oops, must have accidentaly bumped the paste key at some point.
> 
> Thanks,
> Marcelo


