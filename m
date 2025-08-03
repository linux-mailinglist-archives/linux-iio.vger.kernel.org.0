Return-Path: <linux-iio+bounces-22234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE383B19526
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 22:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2179B7A4787
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97C1F461D;
	Sun,  3 Aug 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVPeNkQd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0D19258E
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754253501; cv=none; b=Uab882CGYFICtrW81qVOPHhgT7xn7C+EQEBrJN3L1rtJm01P3qSXTJ8p73K/QPzH446CnGXRY8x5piOGhZSTRUWHqsYLybhSCg6NMTE6AQh0ficDEsnhflEdTYBKZWHh0UlwuyTLzbh2pRbMQCaMf0D0NE9rodrTLEHjnHmcxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754253501; c=relaxed/simple;
	bh=F6EQ9viuOwYUComY2moLhGGie5+ZLE4a0d90tqmiQdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OD5u87Isc4lbQ8pIFqaalyNmBYxcni60XM5rfCDBjMUnz26kyUXDmyr/uxkDzm9Wnw9UP36B7E0hL5k3sxurxcc1bx9XOdnwS11EaszpE1+KbKr5C1aGyqTAHWPKbZnsTDkx85vwnah/xYIr78OGR4mgyk04gWDVlntzt193zwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVPeNkQd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af910372ab3so753772566b.1
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 13:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754253497; x=1754858297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIUEOqf/bMa5O0+Us5b3PylE3/IlVP9PpytASARWFxU=;
        b=bVPeNkQddVT4TnwO6wjhJmmAZOM/1DxkAQPUGvSNwS6ATiUZm4ZNVPR/6P+RlEe2X9
         nj6tCDas/5rqw/AQRExUuzgTaDXFHBDVmvgs6ds8edEbMjz4I4cEDltDFe9urIQ6q5ZP
         WZXGcn/vFZGMshB0dWEeM6Zqqlu/8ephGEvE449bDNVcJ3dgt13xlTvIZVGpkTiaFuwn
         jqhseAl0t9E5cudaBYCTAihBuIgpJ9BqBBQRlTvTS3ohJpw3hbPz+Fb1IBYsfmhpGVid
         t8J4gzbvxeUYtrZTFzHuW5GzbW4G/cgXE3FcHphrUYYmQV1gAUi2usVohoJnY3TWW4Hp
         EJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754253497; x=1754858297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIUEOqf/bMa5O0+Us5b3PylE3/IlVP9PpytASARWFxU=;
        b=N+9Wubgf+CRhoddN0IZXTpOUiL9fBJogyeHC/GoLGEbIaX0fHsgGgPfSpP/GwVCCKi
         Y+ByIKnIBKZiTyXrCclbSzGlzUbwQ6zB0FBKqoTM7afS2CbYwD3nzNSPAZVAB2m6Dttf
         qCO229lsll5RcqUEY6rWCglBZOF71rk3uEQgjrww85wTqht67EZ+7J0Lj4gQM6uEYXjd
         cwmHK4baMAlDMgf64hMXh8/tWZhDdgW/YLPD29qNGVt8JpckYjPc6QdDqMb9Ygyd1bxS
         EYBHMYQUU/6/YMZKKLy61b5ttryCU1I3vZyPldYnCWRF4NGl4zBzeDArYnSKO3Vt7VAW
         tLOw==
X-Gm-Message-State: AOJu0YwEtU9D8vmsZgNvOZO3grZOWJ0OYiFToPqwxPShO83cZBqxDK2G
	tjPCiZmJe1+I0RfGacvRnyRTrew2JGRHdap7qzHL6/qB+PJ/c3K0Pg971u9XaZgM7ma4+NCT/1O
	69fvJbuKlZwO5hG3fFGzFfhBQhm2UOJo=
X-Gm-Gg: ASbGncuVfm5veD8UFRZj7VaOeOTUP5gYdYk+E9dmWeLR4XHgTUo2/EWwm1TCzje9V+T
	k3jLr5rF5NguOjV+BY3rDtZm/i2qCDIKZKzkRZrgah64xRFw4cA1dh3zW+X9MSFNirBRcLl0Jxs
	rAnfPf6Ox0rBEX+nMsF/8U2oSaVOoNuiCwbbXIAtGiFKBM/XCCU0QgSdX1Pbf60OYcwyvuAxuCz
	wDRNu0iI84bf8boCLKVran2OMbYm7VzG9nIQp28NQ==
X-Google-Smtp-Source: AGHT+IEYApncBI0lRNkARIN6vxezghJ5vKAEqFUZZxti++4dYN0QXfOM8gAu5IhACv/njLUIei2dbysoBVlP75xbprw=
X-Received: by 2002:a17:907:3cd2:b0:af9:3f53:ed1d with SMTP id
 a640c23a62f3a-af9408a1522mr762263566b.16.1754253496575; Sun, 03 Aug 2025
 13:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE> <20250803140802.36888-7-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250803140802.36888-7-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 22:37:40 +0200
X-Gm-Features: Ac12FXx8JR-GyH6hRlyc9TYkk3R-ZDOPthIpWQrwBgohnqDC_zlYJiu32h5Hei4
Message-ID: <CAHp75VdOFM5rpo7U0GMM74EsbKNHJH-gHU+Gq+kG5bwYUNbD0g@mail.gmail.com>
Subject: Re: [bmp280 v1 6/6] iio: pressure: bmp280: implement
 sampling_frequency calculation for BMx280
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:09=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.de=
> wrote:
>
> Report of the actual sampling frequency via sysfs is implemented based
> on the nominal measurement cycle time, depending on oversampling_ratio
> and t_standby settings.  If the device dependent table for the
> t_standby values is missing, the reported value is taken from the ODR
> table as before.

...

> +static void bmp280_calc_sampling_frequency(struct bmp280_data *data, int=
 *val, int *val2)
> +{
> +       unsigned int cycle_time_us;
> +       unsigned long freq_uHz;
> +
> +       if (data->chip_info->sampling_freq_tstby) {
> +               cycle_time_us  =3D bmp280_calc_meas_time_us(data);
> +               cycle_time_us +=3D data->chip_info->sampling_freq_tstby[d=
ata->sampling_freq];
> +               freq_uHz =3D 1000000000000L / cycle_time_us;
> +               *val  =3D freq_uHz / 1000000L;
> +               *val2 =3D freq_uHz % 1000000L;

units.h and other constant definitions are for a reason.

> +       } else {
> +               *val  =3D data->chip_info->sampling_freq_avail[data->samp=
ling_freq][0];
> +               *val2 =3D data->chip_info->sampling_freq_avail[data->samp=
ling_freq][1];
> +       }
> +}

...

>         case IIO_CHAN_INFO_RAW:
>                 raw =3D 1;
> +               fallthrough;

Oh, first of all, why is it here in _this_ patch?! Second, this makes
code harder to maintain and change. Think how to refactor to avoid
this. Or justify in the comment field of the patch (after '---' line)
why this is the best with the reference to what has been tried and
becomes worse than this.

...

> +/* must be the same size as the ODR table */

Instead of the comment, use proper static_assert() here somewhere.

> +static const int bmp280_tstby_table[] =3D {
> +       [BMP280_ODR_0HZ]        =3D       0,
> +       [BMP280_ODR_110HZ]      =3D     500,
> +       [BMP280_ODR_14HZ]       =3D   62500,
> +       [BMP280_ODR_7_5HZ]      =3D  125000,
> +       [BMP280_ODR_3_85HZ]     =3D  250000,
> +       [BMP280_ODR_1_96HZ]     =3D  500000,
> +       [BMP280_ODR_0_99HZ]     =3D 1000000,
> +       [BMP280_ODR_0_49HZ]     =3D 2000000,
> +       [BMP280_ODR_0_24HZ]     =3D 4000000,
> +};

...

> +/* must be the same size as the ODR table */

As per above.

> +static const int bme280_tstby_table[] =3D {
> +       [BME280_ODR_0HZ]        =3D       0,
> +       [BME280_ODR_110HZ]      =3D     500,
> +       [BME280_ODR_14HZ]       =3D   62500,
> +       [BME280_ODR_7_5HZ]      =3D  125000,
> +       [BME280_ODR_3_85HZ]     =3D  250000,
> +       [BME280_ODR_1_96HZ]     =3D  500000,
> +       [BME280_ODR_0_99HZ]     =3D 1000000,
> +       [BME280_ODR_51HZ]       =3D   10000,
> +       [BME280_ODR_34HZ]       =3D   20000,

Why not order by value?

> +};

...

For both, can you also utilize multipliers like USEC_PER_MSEC or so?
Or is it a different unit?

--=20
With Best Regards,
Andy Shevchenko

