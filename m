Return-Path: <linux-iio+bounces-24132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B670FB58FEE
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE73A4E03
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7332820AC;
	Tue, 16 Sep 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0QVOMsq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813722A4E5;
	Tue, 16 Sep 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009737; cv=none; b=b7To01SFECFZ8GrL4NsmiUJK8J4SfrtlOTO9+C6OGFzEQL7vTrEq1fq41f25el84hP62MdcA6JKdFLKihx0WBqxbk9cGiArzpwuWHW3gZbqi3vXxQNtKbky765RL6c+9/kNG1/1ADbAtkzSlUEcofHWKidh72r7RFx9HC7GTQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009737; c=relaxed/simple;
	bh=s9H96yzOvyDhrCT9H89TpRBnZBcfroxAOZERsxRauhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFDhNkVydxmzDgKMieY7xA0pLt05liNEQvswqaV97W7ue7eOZlRbJpAjGyIflPgGHBHFS26PSAMhdgbxWdx09xXKqXQSkOTFvEaQRF22OsbN97cHKZUE38ufqqEtotRuZ4/H0iJC/cySX8YqugKHY9sHS1FLUYJ33raJ7Cekqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0QVOMsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EA5C4CEEB;
	Tue, 16 Sep 2025 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758009737;
	bh=s9H96yzOvyDhrCT9H89TpRBnZBcfroxAOZERsxRauhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0QVOMsqj8KA4c5DncyUHwMj20jefIUJOeFoUsgi/kembFr7xhduup9gUz4UJFlCa
	 XbV5Gv9//DkqFOpjIpNB91noZR4Hg/p4C+KwnX8yLrjZ8YYXlFt3NrOpsn5ln8dV65
	 DfjJD2oLIOs+RCk3R6Ihhe/GLYvqGjIMkzBMcohIE69eN+UdVECIj8ToUEujHT3CQM
	 ipv2pHcgr1rSCy9nJyk4iuFMZN+CcNTv8X1jwKTSkW1GFDjnKeGhkIoTL9588N2igA
	 N9XPJmQ9Sr89ex7FoDHobUNEYXm8/4kRtF/h5c4d+0BWxhQIqmoTo3I6ABR9dqH3GZ
	 9RA6g/PteR6ig==
Date: Tue, 16 Sep 2025 09:02:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250916090206.02f601be@jic23-huawei>
In-Reply-To: <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
	<20250915-bd79112-v5-2-a74e011a0560@gmail.com>
	<aMge0jYwYCiY72Yb@smile.fi.intel.com>
	<20250915211321.47865d3d@jic23-huawei>
	<c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 07:52:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 15/09/2025 23:13, Jonathan Cameron wrote:
> > On Mon, 15 Sep 2025 17:12:34 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> >> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:  
> >>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> >>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> >>>
> >>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> >>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> >>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> >>>
> >>> The IC does also support CRC but it is not implemented in the driver.  
> >>
> >> ...
> >>  
> >>> +static int bd79112_probe(struct spi_device *spi)
> >>> +{
> >>> +	struct bd79112_data *data;
> >>> +	struct iio_dev *iio_dev;
> >>> +	struct iio_chan_spec *cs;
> >>> +	struct device *dev = &spi->dev;
> >>> +	unsigned long gpio_pins, pin;
> >>> +	unsigned int i;
> >>> +	int ret;
> >>> +
> >>> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >>> +	if (!iio_dev)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	data = iio_priv(iio_dev);
> >>> +	data->spi = spi;
> >>> +	data->dev = dev;
> >>> +	data->map = devm_regmap_init(dev, NULL, data, &bd79112_regmap);
> >>> +	if (IS_ERR(data->map))
> >>> +		return dev_err_probe(dev, PTR_ERR(data->map),
> >>> +				     "Failed to initialize Regmap\n");
> >>> +
> >>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> >>> +	if (ret < 0)
> >>> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");  
> >>  
> >>> +	data->vref_mv = ret / 1000;  
> >>
> >> I still think moving to _mV is the right thing to do.
> >> There is no 'mv' in the physics for Volts.  
> > 
> > I'm not disagreeing with this review but I'm also not going to hold a
> > driver back for that given timing is pretty much such that I merge it
> > today or it sits a cycle and this one is very near...
> > I'll get fussier on this once we have written up some guidance and may
> > well send a patch to modify existing recent cases like this one!  
> 
> As I replied to Andy, I am disagreeing with this. I hope we won't start 
> renaming variables with capital letters :(
> 
> >>  
> >>> +	ret = devm_regulator_get_enable(dev, "iovdd");
> >>> +	if (ret < 0)
> >>> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
> >>> +
> >>> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
> >>> +	data->read_xfer[0].len = sizeof(data->read_tx);
> >>> +	data->read_xfer[0].cs_change = 1;
> >>> +	data->read_xfer[1].rx_buf = &data->read_rx;
> >>> +	data->read_xfer[1].len = sizeof(data->read_rx);
> >>> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);  
> >>  
> >>> +	devm_spi_optimize_message(dev, spi, &data->read_msg);  
> >>
> >> And if it fails?..  
> > I've added the following and applied the series.  
> 
> Thanks!
> 
> > Note I'm cutting this fine so if we get any build issues or similar
> > it might well get pushed back to next cycle yet!
> > 
> > diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> > index b406d4ee5411..d15e06c8b94d 100644
> > --- a/drivers/iio/adc/rohm-bd79112.c
> > +++ b/drivers/iio/adc/rohm-bd79112.c
> > @@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
> >          data->read_xfer[1].rx_buf = &data->read_rx;
> >          data->read_xfer[1].len = sizeof(data->read_rx);
> >          spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
> > -       devm_spi_optimize_message(dev, spi, &data->read_msg);
> > +       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to optimize SPI read message\n");
> >     
> 
> I am not really sure under what conditions the 
> devm_spi_optimize_message() could fail. It might be enough to print a 
> warning and proceed, but I don't think returning is a problem either.

No. Don't proceed on an unexpected failure whatever it is.  That's
storing up problems that may surface in a weird way later that is much
harder to debug.

Jonathan


> 
> Thanks a lot for going an extra mile and taking care of this!
> 
> Yours,
> 	-- Matti
> 


