Return-Path: <linux-iio+bounces-16221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EDA4AEC4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 03:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6816E5F0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 02:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AB6F30C;
	Sun,  2 Mar 2025 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq+B1Vpc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BBB13AF2;
	Sun,  2 Mar 2025 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740883493; cv=none; b=Je8B8XEAOGQ7bDnP4O+A3UZunFAjjNLlR6myW94KemevGqEd8UR18uAwx9M6ZJdZXNpm2TzEafB+zOBd+b0zoiVBCM54jDXcSZ7OG9p+TROV12FYovygNUV6kX9w/Ao86f+F4gnFLzE85eFOwVm7mo10gbKuD11B8mcD9xhis7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740883493; c=relaxed/simple;
	bh=G+2alXcQQeJKiXQVDp+o+8OioV+7Id2VP5GpWYu+a+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxdwVV0KqV7rd9X2TGZqHyKRsstumquLrJAaSYVxmzsuwqYMqhp6wXIrRe3k7LxJFuv8AIMRBOX54TRB0O+LTommpVNCPVuhRHoQeG70+tWl3UcWhP6wEDvlMjbbMrdYbqwFAQyFpGK7UYirDKeB0N9/MZyMQzQ6zD34gAffhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq+B1Vpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F6FC4CEDD;
	Sun,  2 Mar 2025 02:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740883492;
	bh=G+2alXcQQeJKiXQVDp+o+8OioV+7Id2VP5GpWYu+a+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aq+B1VpcOnZfU4uix8FTan/0Ovik/EeAEUfJRZeJ4Z5L8EscdTZ8Lo6IMYKCFxYnO
	 JNcwXmtwldEpVrxL/S/I7HKm8BMECtD34/PDeMzIb9eybaHhU3IdcJEUNA594h+YXp
	 Rmnhl4cYlSNj9U4B+8OxYNnYOL8GKNan87gpkpbW0QfKLai456n8PGHNV0NYGC5MNo
	 LTf1jJ9gsDCfqz4soGGQI51VUmMSCnXoh/LS1zqiU6TWAMzdk/bIqdoj1ZiPeuRfHZ
	 PrFlvfId4gYEq58Ih9PZgiIg99QgDNSw1mJ0gGzvr6Qk4zJsIFhrmkdrAR32fLuuRW
	 3macoJteXhUEQ==
Date: Sun, 2 Mar 2025 02:44:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/9] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250302024434.67ef4c90@jic23-huawei>
In-Reply-To: <125ab96e-1e92-4022-95fe-324cd47ce1d9@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
	<67b7713724d7591f6321a8f5dfef8cd711f38d34.1739967040.git.mazziesaccount@gmail.com>
	<20250223162807.41960b6b@jic23-huawei>
	<125ab96e-1e92-4022-95fe-324cd47ce1d9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 08:14:23 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 23/02/2025 18:28, Jonathan Cameron wrote:
> > On Wed, 19 Feb 2025 14:30:43 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> >> an automatic measurement mode, with an alarm interrupt for out-of-window
> >> measurements. The window is configurable for each channel.
> >>
> >> The I2C protocol for manual start of the measurement and data reading is
> >> somewhat peculiar. It requires the master to do clock stretching after
> >> sending the I2C slave-address until the slave has captured the data.
> >> Needless to say this is not well suopported by the I2C controllers.
> >>
> >> Thus the driver does not support the BD79124's manual measurement mode
> >> but implements the measurements using automatic measurement mode relying
> >> on the BD79124's ability of storing latest measurements into register.
> >>
> >> The driver does also support configuring the threshold events for
> >> detecting the out-of-window events.
> >>
> >> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> >> out of the configured window. Thus the driver masks the received event
> >> for a fixed duration (1 second) when an event is handled. This prevents
> >> the user-space from choking on the events
> >>
> >> The ADC input pins can be also configured as general purpose outputs.
> >> Those pins which don't have corresponding ADC channel node in the
> >> device-tree will be controllable as GPO.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>  
> > Hi Matti,
> > 
> > Some fairly superficial review follows. I'm travelling for next few weeks
> > so not sure when I'll get time to take a more thorough look.  
> 
> Yeah, unfortunately people are allowed to have other life beyond the 
> ROHM drivers :D
> Enjoy your journey(s) ;)

So far so good.  Hi from Shenzhen.  Obligatory pilgrimage to SEG market
done ;)

> >> +	/* Set no channels to be manually measured */
> >> +	ret = regmap_write(data->map, BD79124_REG_MANUAL_CHANNELS, 0x0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Set the measurement interval to 0.75 mS */
> >> +	regval = FIELD_PREP(BD79124_MASK_AUTO_INTERVAL, BD79124_INTERVAL_075);
> >> +	ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
> >> +			BD79124_MASK_AUTO_INTERVAL, regval);  
> > 
> > Where it doesn't make any other difference, align after (
> > 
> > If you are going shorter, single tab only.  
> 
> Single tab only? You mean like:
> 
> ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
> 	BD79124_MASK_AUTO_INTERVAL, regval);
> 
> Do you prefer that even if the variable holding the return value was 
> longer than 8 chars? To me it looks odd if arguments on the next line 
> begin earlier than the function on previous line:
> 
> longvariable = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
> 	BD79124_MASK_AUTO_INTERVAL, regval);
> 
> (Just ensuring I understood your preference).
It's hard to come up with an absolute policy / preference on this but
whilst I agree it looks a bit odd, I think it's easier to say one
tab as 'default' choice.  Obviously if it's really hideous for some
reason feel free to do something else ;)

Jonathan

