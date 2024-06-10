Return-Path: <linux-iio+bounces-6146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569390210B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA6D287299
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB907F490;
	Mon, 10 Jun 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WJJso2M2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0285770FF;
	Mon, 10 Jun 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020766; cv=none; b=MbhW1EAEBMzphYtF+71YYZq6KNyvxd2TKrGC9WBtfIQGQOS+0kFIS/K0jVaqV7YdHAcHx03ZvULAlq72+iTl/43rrVwm2aJNWm7hCYuXSywfGZcTQapm8ysxyIu9qTzfB/BA11VXLsmW7ynGplQntRqv7yd+LocVRqEAzYQLeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020766; c=relaxed/simple;
	bh=AQW3KRBl3PqmimCKD4Is8cPSYUyDWKvNDQSE5lbUNX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efNULUkFUXbDlVGY/94lh3N7VwaicOZ5ewohFsuQHZooTCldHfUzkcQW2ZrDSaKpvD/vTadEueNrZx/Khu1Li36N01BUKi/1s5DQrx7SWaYVVzmJQm0jIaeenhP4DRWj73pLxOEVuMlWbrwTr3ymAmRFcQbpTWXa+U3rxWxE12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WJJso2M2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 546AF1FB6C;
	Mon, 10 Jun 2024 13:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718020753;
	bh=/q4vYPFqxBCRHYZkSp6vEtxYFhA1GVHtEgKxwdr8R3w=; h=From:To:Subject;
	b=WJJso2M2zwVpu1htsxWWK7DbUfEaHQNtxGfSDiAyfXhsVBAuvNvC08u27I+mCVTjX
	 mw0lnayu6JcRsK3W+hfBx9ld2ClCCTDlPVXcptX7H0NcPgTxPKGUSaTUPXxNaRHKCO
	 I93CMRcL6maNOv/9TanGNXsiZrmkT553j5FZI74YZITfOhD0Rg8Pbs2XRxFiVaHcIK
	 UIlgcsfunswz2T0ws7qD0xSVo6Z9+141Psd8tYpal6rfNO1Ck+P0PtDCrHdoJikPYs
	 o09gzMxF3iVVRD1pc9XpdgnW65FKg+ko1XBMtHVfcGeuvV8AkEhLcYvuWbqdxrVyOR
	 tyq9BllrV2VIw==
Date: Mon, 10 Jun 2024 13:59:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240610115909.GA27057@francesco-nb>
References: <20240606163529.87528-1-francesco@dolcini.it>
 <20240606163529.87528-3-francesco@dolcini.it>
 <20240609115234.20e08840@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609115234.20e08840@jic23-huawei>

Hello Jonathan,
thanks for the review.

On Sun, Jun 09, 2024 at 11:52:34AM +0100, Jonathan Cameron wrote:
> On Thu,  6 Jun 2024 18:35:29 +0200
> Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > 
> > The ADS1119 is a precision, 16-bit, analog-to-digital converter (ADC)
> > that features two differential or four single-ended inputs through a
> > flexible input multiplexer (MUX), rail-to-rail input
> > buffers, a programmable gain stage, a voltage reference, and an
> > oscillator.
> > 
> > Apart from normal single conversion, the driver also supports
> > continuous conversion mode using a triggered buffer. However, in this
> > mode only one channel can be scanned at a time, and it only uses the data
> > ready interrupt as a trigger. This is because the device channels are
> > multiplexed, and using its own data ready interrupt as a trigger guarantees
> > the signal sampling frequency.
> > 
> > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> A few more comments inline. Some of these I missed in the first
> versions - sorry about that.  Takes a few passes to pick up
> on everything unfortunately.
> 
> > diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> > new file mode 100644
> > index 000000000000..ea0573f07279
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads1119.c
> > @@ -0,0 +1,850 @@

...

> > +
> > +static int ads1119_cmd(struct ads1119_state *st, unsigned int cmd)
> > +{
> > +	dev_dbg(&st->client->dev, "cmd: %#x\n", cmd);
> > +
> > +	return i2c_smbus_write_byte(st->client, cmd);
> I'm not a fan of tiny wrappers to add debug info.
> The i2c core has trace points that let you get to the relevant data. Better
> to use those for debug and flatten this code so we
> see the actual bus accesses inline.

Fine on removing the debug prints, we'll do.

However ads1119_cmd_rdata() and ads1119_update_config_reg() wrappers are
making the error handling in the caller easier.

Either we remove only ads1119_cmd/ads1119_cmd_wreg or we keep them all
for orthogonality. Both works for me, just let me know if you agree and
which option do you prefer. Personally I would keep them all without
debug prints.

> > +
> > +	return read_poll_timeout(ads1119_data_ready,
> > +				 data_ready,
> > +				 (data_ready == true),
> > +				 wait_time,
> > +				 ADS1119_MAX_DRDY_TIMEOUT,
> > +				 false,
> > +				 st);
> Over wrapped. Aim for closer to 80 chars.

I'll do.
Do you have any rules on the IIO subsystem driver? IOW is it fine to
have line slightly longer than 80chars if this improves readability ?

Francesco


