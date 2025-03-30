Return-Path: <linux-iio+bounces-17348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC1A75AAA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE95188862E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7B1D63D6;
	Sun, 30 Mar 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdfT6JH8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8935973;
	Sun, 30 Mar 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348998; cv=none; b=EbnJqtguz5+9gDQUm9XOGOc5STE0HA9Ee69l/xSxbFOV75J1WXs0MSNOWTDNRMbSclphI3icQptLKWFChP8/CxrtPZh2b4rJeQPonsVixidFqS00uYa0pq1WrAS3GgEQrPB7zM2FhOd2cYixRqhxFIl9Y0XucUy8OeJxPwnCLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348998; c=relaxed/simple;
	bh=FTJ0vDMKBBzaCMUHsW6aS1lwvumacUsEATHIVqqD7hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvqp9+KjLPOrToavT9C/xDCN0LjJ/lT+RldN3HqqnJ68lm/c+bFkP810rH8X/Y3U9cry6G73xySnYeCqxSgZFN1YDC5qroClXArB5X4OTDkAKFtSA4YyL437oRSbbvgEtqp1HILl9PAh6e+KGO1XJb43ipUGfN+qwFrq/bQ4UPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdfT6JH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99098C4CEDD;
	Sun, 30 Mar 2025 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743348997;
	bh=FTJ0vDMKBBzaCMUHsW6aS1lwvumacUsEATHIVqqD7hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdfT6JH8o3I2bSBL35JE8GPR3JWZs7z0194qDGFO6qbXUhnFD7reDireTCi7pOHpy
	 XTlqkOaON8sxxibCAYUjp0yMO0YD+EvnK0odUvi9SIwyckNnxKgtJnuaKjUUBV/lSI
	 NgloaKoNLkgORBf4/aSUIA+hunDZdRs9zD8zwsqrWgZ3h+94a1Q7PbOAxD9SGVnRi1
	 /PTKuqW8Q7X7UG+0zL6C4bZp3phcIz451qIuJZUU0pcY7SNBsvKSkxP9ScVc8h7Wbp
	 kIsJx3+groNSvFPQoWvO1uU349NtnfsY4NOoEkFht3XqYC2dcet9vNek2GB+mpsDjL
	 +PjLWwzJsKYZw==
Date: Sun, 30 Mar 2025 16:36:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, rafael@kernel.org, ulf.hansson@linaro.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Message-ID: <20250330163627.152d76ef@jic23-huawei>
In-Reply-To: <2025032703-genre-excitable-9473@gregkh>
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
	<20250327153845.6ab73574@jic23-huawei>
	<2025032703-genre-excitable-9473@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 17:22:20 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 27, 2025 at 03:38:45PM +0000, Jonathan Cameron wrote:
> > On Mon, 24 Mar 2025 14:26:25 +0200
> > Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >   
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > 
> > > Hi,
> > > 
> > > Series adds some cleanups for the RZ/G2L ADC driver after the support
> > > for the RZ/G3S SoC.  
> > 
> > This doesn't address Dmitry's comment or highlight the outstanding
> > question he had to Greg KH on v3.  
> > I appreciate you want to get this fixed but I'd rather we got
> > it 'right' first time!
> > 
> > Also, please make sure to +CC anyone who engaged with an earlier version.
> > 
> > For reference of Greg if he sees this, Dmitry was expressing view that
> > the fix belongs in the bus layer not the individual drivers.
> > FWIW that feels like the right layer to me as well.
> > 
> > https://lore.kernel.org/all/Z8k8lDxA53gUJa0n@google.com/#t  
> 
> As this is a PM question, Rafael would be the best to ask.

Sure. Perhaps Rafael missed previous discussion, so I've messaged
him directly to draw his attention to the series.

Claudiu, please include all relevant people in +CC.  Don't trim
it down to those effected by a particular solution as has happened
here. +CC Rafael, Daniel and Ulf.

Thanks,

Jonathan


> 
> thanks,
> 
> greg k-h


