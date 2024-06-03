Return-Path: <linux-iio+bounces-5715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF218D8ABD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D51C21FBD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632D13B297;
	Mon,  3 Jun 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAUiB4zD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371946A4;
	Mon,  3 Jun 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445468; cv=none; b=KN4JLeqNzHVTR1t5x0pZi/R7kLqChtnIIjb2RkQ/Hn6RpeleYOuKbXzGxZHRHlf9avMVrQSCv0aqLNCdngb2fPGSgJIueQo/mkRkNOhFN5bLHFQI4ZPmmEZ1IPLfUOt1GSZgGuWTFk2hoRkAM1mYh8a2dT4d895SkulgjxBdup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445468; c=relaxed/simple;
	bh=ZUOP9PSrARPnDqbSPue2KgCqb/TojcCqEcsIYquZPWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjeSjrK5V16fzS1bWXcie31oi4du647eS9t5FDI7b7fhk3vI8nUAX4fgVXq2Kv55nb9tGkdtm1shVJLo+oyN1AwqPrJIBag6AGQ/RAdJcvkPOMUyWLc8CBmQMeSG3WHbk1octhBT/roj4gSC3nGMonVKnj45WXso9cBYffDA7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAUiB4zD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD4C2BD10;
	Mon,  3 Jun 2024 20:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717445468;
	bh=ZUOP9PSrARPnDqbSPue2KgCqb/TojcCqEcsIYquZPWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NAUiB4zDMI/JVqLko9RJT0BZaqhKnNLIhwc191pw+phDUCvA8EIClHXBbG7kvvioj
	 Xikw000YiDSr3hhtxMcwo8zd29d7C2Wk+f1OI8tKzdUf3Dkl4VhZHMeRHHl4ULXtS7
	 PL6eNZblfXPeeJn6lZyDprgpidbpP/dbj/85d+d/JPcjw+dqP1NeOD5L+JuLGmS23D
	 YOLO7s6j+xtmIcx1ObRrvz/t2YODrh/7tKQWeC5PgqVGbmSJdymZ2fQBDSqUSGMNQH
	 aGaZ0vUGZO3Bzk+l1fXlQBz1JJVYDrSE9Fwfdhtyrj1smnbEp9ph1POq0yXEcTKlSO
	 81QLlrBonkLHw==
Date: Mon, 3 Jun 2024 21:10:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240603211056.3d297018@jic23-huawei>
In-Reply-To: <9bcf9ed6-dcba-4e23-9845-a81cf39a3153@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
	<20240531-iio-adc-ref-supply-refactor-v1-1-4b313c0615ad@baylibre.com>
	<20240601134828.68c3acba@jic23-huawei>
	<9bcf9ed6-dcba-4e23-9845-a81cf39a3153@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 08:36:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/1/24 7:48 AM, Jonathan Cameron wrote:
> > On Fri, 31 May 2024 16:19:32 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> This makes use of the new devm_regulator_get_enable_read_voltage()
> >> function to reduce boilerplate code.
> >>
> >> Error messages have changed slightly since there are now fewer places
> >> where we print an error. The rest of the logic of selecting which
> >> supply to use as the reference voltage remains the same.
> >>
> >> Also 1000 is replaced by MILLI in a few places for consistency.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > Ouch diff didn't like this one much and it is a bit hard to read.
> > 
> > One case where I think this has an unintended side effect.
> > See below.
> >   
> 
> ...
> 
> >> @@ -1219,74 +1211,54 @@ static int ad7192_probe(struct spi_device *spi)
> >>  	 * Newer firmware should provide a zero volt fixed supply if wired to
> >>  	 * ground.
> >>  	 */
> >> -	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
> >> -	if (IS_ERR(aincom)) {
> >> -		if (PTR_ERR(aincom) != -ENODEV)
> >> -			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
> >> -					     "Failed to get AINCOM supply\n");
> >> -
> >> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "aincom");
> >> +	if (ret == -ENODEV)
> >>  		st->aincom_mv = 0;
> >> -	} else {
> >> -		ret = regulator_enable(aincom);
> >> -		if (ret)
> >> -			return dev_err_probe(&spi->dev, ret,
> >> -					     "Failed to enable specified AINCOM supply\n");
> >> +	else if (ret < 0)
> >> +		return dev_err_probe(&spi->dev, ret, "Failed to get AINCOM voltage\n");
> >> +	else
> >> +		st->aincom_mv = ret / MILLI;
> >>  
> >> -		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
> >> +	/* AVDD can optionally be used as reference voltage */
> >> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
> >> +	if (ret == -EINVAL) {
> >> +		/*
> >> +		 * We get -EINVAL if avdd is a supply with unknown voltage. We
> >> +		 * still need to enable it since it is also a power supply.
> >> +		 */
> >> +		ret = devm_regulator_get_enable(&spi->dev, "avdd");  
> > 
> > What happens if the entry simply isn't there in the DT.
> > Previously I think the regulator framework would supply a stub whereas
> > the devm_regulator_get_enable_read_voltage() returns -ENODEV so isn't
> > caught by the handling and I think it should be.  
> 
> Ah, yes so:
> 
> if (ret == -EINVAL || ret == -ENODEV) {
> 
Yes I think.


