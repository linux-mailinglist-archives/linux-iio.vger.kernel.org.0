Return-Path: <linux-iio+bounces-24720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D8BB8F43
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED303B5778
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12DA26463A;
	Sat,  4 Oct 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Simk+xBl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289A219A7D;
	Sat,  4 Oct 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759590278; cv=none; b=T8Gz5qH1nwdbftBPNpxB7JCKgVYgH05ahW6MbV5Vq1CpcFofSOxGWFwfbUMqAnZJeyzu2tpkXQ+hOmPlpSKLYBejjMoy+XxT9+rH9p5wEx1UZcKZa8GvP+D9RCC6SaHD8McMQfFN6IjNNBl+lIt0Cr1ADlcP+2dSs8k/HJF0zHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759590278; c=relaxed/simple;
	bh=bf3OC0hTB6fwqL92PcIlHCfEcVUddtNpNJA4+tkepfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtY9ONmMb7Ryrt0Cu2L5Ny5bQtsuesQKTHMpcEgQ3Sj3aXm9NbB0Kml1E4a0OhbM+DI/o4WuXpiH58XdADb8Ix1rk/kWUk8wPw+XGCdRJQ5hcWSKyy5gd6is+2irOhSCLCicoW07jZWol3UMSFmZU8UcZb8+1esjIjAkPnCFIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Simk+xBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAF2C4CEF1;
	Sat,  4 Oct 2025 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759590278;
	bh=bf3OC0hTB6fwqL92PcIlHCfEcVUddtNpNJA4+tkepfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Simk+xBlAhQ3YFxT+NFeZlE6Ip52kTAdzkzcS4FUOoGJ3l1QUudnurybyXERSUyhc
	 KLYq6u17fdA1hrnvlDunEwOkrpapOR0lS+vglKHpTKTcmowDW0tkiqgv13d2EnISq7
	 x9YjN4BTIFgqQWC7djMYDRQMXAAV1Hgf3YPDXicbqZWocQ9adRiWt7f7vdxoT3mQHI
	 L6psNzix2CsDhCPF1nJ6QSRGvl+alywkLgUhL9KVGhTpaUyUV/SD6h6GkNOw1N4fBz
	 +UkFQhqWCanF02Coz6Q3fjpgYPJlgaCKDaaWKG7CujIFWa8CtxsiaVVrKW7GDx70U6
	 TFpnVEfIyN0Pw==
Date: Sat, 4 Oct 2025 16:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v12 2/3] iio: adc: max14001: New driver
Message-ID: <20251004160426.7876286b@jic23-huawei>
In-Reply-To: <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
	<476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Sep 2025 02:59:37 -0300
Marilene Andrade Garcia <marilene.agarcia@gmail.com> wrote:

> The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-ran=
ge
> binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
> more features, like a binary comparator, a filtered reading that can
> provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> comparator that triggers the inrush current. There is also a fault feature
> that can diagnose seven possible fault conditions. And an option to select
> an external or internal ADC voltage reference.
>=20
> MAX14001/MAX14002 features implemented so far:
> - Raw ADC reading.
> - Filtered ADC average reading with the default configuration.
> - MV fault disable.
> - Selection of external or internal ADC voltage reference, depending on
> whether it is declared in the device tree.
>=20
> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> ---
>=20
> Hello maintainers,
> Thank you for reviewing v11 and for your suggestions.
> I believe I have addressed most of the requested code changes in this v12.
> There were some discussions about a few of them, and I tried to follow the
> path that you seemed to agree with.
>=20
> I have one remaining question related to the max_register attribute of the
> regmap. The register regions that can be accessed are 0x00=E2=80=930x0c a=
nd
> 0x13=E2=80=930x1a. As suggested, I used max_register to set the upper lim=
it of the
> register region that can be accessed (0x1a). Beyond this address, there is
> a reserved region that should not be used (0x1b=E2=80=930x1f). However, t=
here is=20
> also a reserved region that should not be used between addresses 0x0d=E2=
=80=930x12.
> Should I use something to mark this region in the regmap?
regmap allows specification of which registers readable and which writeable.
If this is a concern then you could do that.  I'd not worry too much though
as those regions are only accessed by the debugfs interface and that provid=
es
many other foot guns!

Just one trivial comment to add to David's more detailed review and questio=
ns.

>=20
> Notes:
> As suggested by Andy, I have chosen to use the code "if (ret =3D=3D -ENOD=
EV)"=20
> rather than "if (ret < 0)" on line 312, because it produces a slightly sm=
aller
> max14001.o file compared to the other approach (10640 bytes vs. 10648 byt=
es).
> Additionally, as mentioned, it is more explicit check.
>=20
> As suggested by David, I added support for SPI_LSB_FIRST, and I also used=
 a
> union to avoid clang compiler warnings related to casts between __le16,
> __be16, and u16. Thank you for the code examples.
>=20
> I tested it on the Raspberry Pi modified kernel version rpi-6.12 with
> Raspberry Pi 5 hardware, using the MAX14001PMB evaluation board, and it
> seems to work fine.
>=20
> Main changes since v11:
> - I think I fixed the alphabetical order in the files pointed.
> - Fixed small issues in the include files.
> - Removed the mutex since regmap has a lock mechanism (also removed the=20
> mutex include).
> - Added support for SPI_LSB_FIRST in case it is used in a device tree fil=
e.


> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000000..52584c24fb08
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c

...


> +static int max14001_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct max14001_state *st;
> +	int ret =3D 0;

Set before use I think in all paths below. So can drop init here.

> +	bool use_ext_vrefin =3D false;



