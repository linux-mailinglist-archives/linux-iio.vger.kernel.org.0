Return-Path: <linux-iio+bounces-14809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FABA24918
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE98164EDE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42F1ADC6F;
	Sat,  1 Feb 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EppRzHBu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C634A3E;
	Sat,  1 Feb 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413971; cv=none; b=YTgos9kmLCWcOQIpRysHEiV3IrmaqSHnlB6+pnstUvQAGeJPcj0gKMiFzdUDJv7hq3ydZGxyAViCwPt3SNn5HGzyZ+7AxAmkUPZ0IiQo7+IBM8FVhE0lhKYaRESCdZF2bHWgyfK+WdW3VU96MZ7Qrwq0EtNWCMfy7oNzUbKsz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413971; c=relaxed/simple;
	bh=7ko/gQUGt0pizGv4D1amPrClqwB81WnRx5o5PwUX/x8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dztp0DPcwrJS1WG7DXYOVCcWQS43xl9dI5nKy9nDTU2oOt8Gpxr6ERAeXLa1iZF/lzkeBSra0XdjGgWQgLov25jwZUR5p72L62Yycg3WX/e/D87r4+G2vDvgGkOBHQAiBRfel+txE2U09OCSeguOGkB30RxTy0f4oCAavlkiW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EppRzHBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6729C4CED3;
	Sat,  1 Feb 2025 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738413971;
	bh=7ko/gQUGt0pizGv4D1amPrClqwB81WnRx5o5PwUX/x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EppRzHBuNDbnUhTthJlTexKX37xf80XHABBRneVyeZM1cxBQORR7mVi+r/jBBMIaM
	 c8sRXLMF41a635MSBk1QaAFGSd9J2kxPrwCDZH6VrTOM+2RFg7EcRSpar4VOW1yjKt
	 Jd4MKZYnVXQr71prex5I3ZGdWAe/P/h3mOp93GmGuKOLsRWXWnoEeQOzZIEjKF39dU
	 aQ9/bOi5qEsCBx8QZEknphdEfnCBgWbfZ6adjxMDFEUKv+WEi+Zyem093AhhzSaC9j
	 b62gMYM+7dK9a8VwA6Klc0kHSOgIAk/q0U4Y9vBHAsS9wYzfJkbAMNRoDlbTGk6NZK
	 eafamWqbrngLQ==
Date: Sat, 1 Feb 2025 12:45:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
Message-ID: <20250201124554.7e64d016@jic23-huawei>
In-Reply-To: <2715ead8-cf6d-4b44-b6e3-343cb6489eca@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
	<4ad45123-134a-4544-ad0a-24371105d96f@lunn.ch>
	<2715ead8-cf6d-4b44-b6e3-343cb6489eca@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 14:51:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/31/25 2:38 PM, Andrew Lunn wrote:
> >> So I'm proposing that we add a gpiods_set_array_value_cansleep()
> >> function that is a wrapper around gpiod_set_array_value_cansleep()
> >> that has struct gpio_descs as the first parameter to make it a bit
> >> easier to read the code and avoid the hard-coding temptation.  
> >  
> > This looks reasonable.
> > 
> > How do you plan to get it merged, since you cross a lot of subsystems
> > here.
> > 
> > 	Andrew  
> 
> Since these are mostly small changes and most of the touched drivers aren't
> seeing much action, I think it would be OK for as much as possible to go through
> the GPIO tree.
> 
> We might need an immutable branch from that though since I know that iio: adc:
> ad7606 is currently being actively worked on.
Looks good to me (subject to requested name change from Bartosz)
I'd suggest an immutable with patch 1 then up to each subsystem
maintainer to pick that up or wait for next cycle.

Always hard to predict what else will get worked on at this stage
of a cycle.

Jonathan


> 
> If there are any patches leftover that don't get acked to go through the GPIO
> tree, I can resubmit them after the next kernel release cycle since none of
> this is urgent anyway.
> 


