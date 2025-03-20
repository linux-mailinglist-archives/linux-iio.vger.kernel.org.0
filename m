Return-Path: <linux-iio+bounces-17147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6471A6A1E5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D61016FDEF
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAA21CA12;
	Thu, 20 Mar 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4+Ekbc2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C6219314;
	Thu, 20 Mar 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460912; cv=none; b=irEezFf6WcBN6VSG6Y2GMZcqL3kRHTXa7kdfL8QFcFn/0XbpUPlYnc1G0Xo31S8XpxxIQE1baDVzuIMMeX7c0eMmr8ALPK/t9GTD5/dGI+gGtcrJGE/ni8VXmqzoreZUQ6SKbAxZHX3wpT6mQMoY7PoaJqBbXeYTIUvfgJrJ1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460912; c=relaxed/simple;
	bh=i7sIthTZh5Ux9SoBhNZClmo1bhyB2SHe6MT3XxrIePw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdr7sn6waBFBAdatk1W8Z3fuHuLuCf0qgiASpVqX42kvWQR9nHheq6Kh1JluSL6hBQzI05IdRVOiWiGxSoVSI6Xu4rL7rmNMG7Fc3If9myM4feuYrRpHxLCRwcZWYbvMuPyq7ZJErUU5nQ0RsMHvrjWlYAIt1IHgCFpocxfoOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4+Ekbc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD80C4CEDD;
	Thu, 20 Mar 2025 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742460911;
	bh=i7sIthTZh5Ux9SoBhNZClmo1bhyB2SHe6MT3XxrIePw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4+Ekbc2Q6navfZCq9Hecs1a3IT3LctFFfX9OIF8j2+6Mx00MZIDoIiy4LgvdIAI9
	 W+9uVd+2xE55fYLyh6m5CGjQjEvuqF5oMA1uYVXROnKwPlNDs+I3l0ibizVOPWdayq
	 pa0U4LQ0NmAfXuZ/0BDJ+MtD98GdACNBf1W94hrH61OY1cF3fh9aKQTTMN90alnP4A
	 KrGgDmWzW/ZTvAlWobba9pV+XCCMOGhUSVt5edk+EzQUELQiZjSDOZ59Aj+NBZfAso
	 rqWylQcbVYPY938eW3D3gdhQCyvMGRy4tlK0ZapVyHhIOqKbLZNAAjbPKK0/e7T3TH
	 kpaxPiI2yGSRw==
Date: Thu, 20 Mar 2025 09:55:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sergio =?utf-8?B?UMOpcmV6?= <sergio@pereznus.es>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: bh1750: Add hardware reset support
 via GPIO
Message-ID: <20250320-banana-chowchow-of-acceptance-62685c@krzk-bin>
References: <20250319161117.1780-1-sergio@pereznus.es>
 <20250319161117.1780-2-sergio@pereznus.es>
 <9b8b74d5-ac63-4990-acc9-dbc3bd2f89f6@kernel.org>
 <e4ffd13f-1452-4f18-8d80-f63b391f2545@pereznus.es>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e4ffd13f-1452-4f18-8d80-f63b391f2545@pereznus.es>

On Wed, Mar 19, 2025 at 11:40:27PM +0100, Sergio P=C3=A9rez wrote:
>=20
> El 19/03/2025 a las 20:15, Krzysztof Kozlowski escribi=C3=B3:
> > On 19/03/2025 17:11, Sergio Perez wrote:
> > >   struct bh1750_chip_info {
> > > @@ -248,6 +253,24 @@ static int bh1750_probe(struct i2c_client *clien=
t)
> > >   	data->client =3D client;
> > >   	data->chip_info =3D &bh1750_chip_info_tbl[id->driver_data];
> > > +	/* Get reset GPIO from device tree */
> > > +	data->reset_gpio =3D devm_gpiod_get_optional(&client->dev,
> > > +									"reset", GPIOD_OUT_HIGH);
> >=20
> > Mess indentation.
> Regarding indentation, I'll fix it in the next version to ensure consiste=
ncy
> with kernel style guidelines.
> >=20
> > > +	if (IS_ERR(data->reset_gpio))
> > > +		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
> > > +							"Failed to get reset GPIO\n");
> > > +
> > > +	/* Perform hardware reset if GPIO is provided */
> > > +	if (data->reset_gpio) {
> > > +		/* Perform reset sequence: low-high */
> > > +		gpiod_set_value_cansleep(data->reset_gpio, 0);
> > > +		fsleep(BH1750_RESET_DELAY_US);
> > > +		gpiod_set_value_cansleep(data->reset_gpio, 1);
> >=20
> > So you keep device at reset state. This wasn't tested or your DTS is wr=
ong.
> The BH1750 reset pin (DVI) is "active low", meaning the device is in reset
> state when the pin is at 0V. When the pin is at high level, the device ex=
its
> reset and operates normally.

I read this after responding to your binding change, so this confirms
what I saw in datasheet and is contradictory to your response to the
binding.

First,  your binding should say which pin it is in the description.

Second, it is active low...

>=20
> According to the datasheet (can provide upon request), the reset sequence
> should:
> 1. Pull the reset pin low to enter reset state
> 2. Wait (minimum 1=C2=B5s, I use 10ms to be safe)
> 3. Pull the reset pin high to exit reset state
> 4. Leave the pin high for normal operation
>=20
> My implementation follows this exact sequence, so the device is NOT left =
in
> reset state. The initialization code:
> 1. Sets the pin to 0 (device enters reset)

I don't think you get how GPIOs work. 0 means logical zero, so GPIO is
not active, not the actual signal level.

> 2. Waits
> 3. Sets the pin to 1 (device exits reset)
> 4. Leaves it at 1, which is the normal operating state
>=20
> I've modified the YAML description to remove "active low" to avoid
> confusion, as the implementation is correct for this hardware.

You have wrong implementation.

Best regards,
Krzysztof


