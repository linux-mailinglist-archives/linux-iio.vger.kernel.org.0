Return-Path: <linux-iio+bounces-926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D5E8133DC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 16:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C496B1C219D5
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5615B5D1;
	Thu, 14 Dec 2023 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KclSK1B1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307A126
	for <linux-iio@vger.kernel.org>; Thu, 14 Dec 2023 07:03:53 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso111035411fa.0
        for <linux-iio@vger.kernel.org>; Thu, 14 Dec 2023 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702566232; x=1703171032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdds0ORz8v+5B0f4PxBAIWXX7DWm0YzECYB8nL+ZDRg=;
        b=KclSK1B1CcPLhM0aUywjXMEsqXYJjb83l6nM+NlX87fmak/R33YXfUuh3E6TAOaa/g
         NiUZqE2lxir3Wl2lGEa9cEa0VoVf+PcnOsDTjuvFnSxt5hpdnvPwaEFHXKOUlgQZDToW
         9qO5hQM8R6Ns4bcVujuk6I3BGXOxYrhUJT24RqB35RPqNs0rS2AfNhTaSeCBHTXoRjUU
         kz1HaBrMKSRiATXdecZ+9CRBeXmppUVcy0+dlnDNk7UBQoKnk0/r+NT68aVxI/GsEVxr
         qzvq0gNLFamrpTkjCqTv9GkYZ5UHhHDOv4rtuWCatZDpa+gwT/FebYUsChVJSYUcsm1h
         T4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566232; x=1703171032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bdds0ORz8v+5B0f4PxBAIWXX7DWm0YzECYB8nL+ZDRg=;
        b=TQdtpHg3jFWl42a88o5Qvanfja1KSIW8X39oOP7TvZW16n6KALG1mjrt4MNsFc0som
         CVXh3WCyAWf73a6ziQ/XMov0z/aZdfDLucx4h/ws0v50tNQcAeYPv5Jz3oPfI6sp/pHd
         eTLLBWob+DoyQSaIJasCxv4oRuVU0RnVF83ZFVA6PQblnQ1ySbL1l7EIUpY3PfnHW8Eh
         XpZvlx0HDjFH4tBTWGuphjm/Yva0kSX/aaxFZsI5poz9m4EGHTANJfp1muxLrEPReN5a
         T8FGjcOGe9OwI8UfewjfU9KREyVpK8sRTyWe0Oyb0kxjPrgzSa+Tm4mUxjduc/QyJVzd
         7JaA==
X-Gm-Message-State: AOJu0YxoJhT7yOenPdsw5Ygt/eLCEDedSP3dYr2SbEPoK4Z8PpH/AhPR
	QOFuOeLshTuDUq4UbAh1sqjWRvm0mcAqQsfmNxpotQ==
X-Google-Smtp-Source: AGHT+IFmyI386iLiUHPlW4WwtKlMnA6myG4ZHBLhXxLLf/cnJZpar+DOGncWRfIpEZelwC7WbFhYsO1g5sBePkgkHrc=
X-Received: by 2002:a05:651c:c1:b0:2cc:479d:2d15 with SMTP id
 1-20020a05651c00c100b002cc479d2d15mr255200ljr.81.1702566231864; Thu, 14 Dec
 2023 07:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com> <20231214101415.0000060c@Huawei.com>
 <CAMknhBF9GtbOP_M2q8DrrMOePFOaQzGxqcS2P8OHjtGN-Z27Vg@mail.gmail.com> <20231214123613.00002b69@Huawei.com>
In-Reply-To: <20231214123613.00002b69@Huawei.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 14 Dec 2023 16:03:40 +0100
Message-ID: <CAMknhBGR9mkk+mG-vFJqSBFFykyppLpeOYRqcXwUWi6dtMh28Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 1:36=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 14 Dec 2023 11:33:51 +0100
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Thu, Dec 14, 2023 at 11:14=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 13 Dec 2023 05:21:20 -0600
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > > > This adds a new driver for the AD7380 family ADCs.
> > > >
> > > > The driver currently implements basic support for the AD7380, AD738=
1,
> > > > AD7383, and AD7384 2-channel differential ADCs. Support for additio=
nal
> > > > single-ended and 4-channel chips that use the same register map as =
well
> > > > as additional features of the chip will be added in future patches.
> > > >
> > > > Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> > > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > >
> > > Just one additional comment.  I 'might' sort both this an Nuno's comm=
ent
> > > if Mark is fine with the SPI and no on else has review comments.
> > > Feel free to send a v3 though if you like ;)
> > >
> > >
> > > > +/* fully differential */
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> > > > +/* pseudo differential */
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> > > > +
> > > > +/* Since this is simultaneous sampling, we don't allow individual =
channels. */
> > > > +static const unsigned long ad7380_2_channel_scan_masks[] =3D {
> > > > +     GENMASK(2, 0), /* both ADC channels and soft timestamp */
> > > > +     GENMASK(1, 0), /* both ADC channels, no timestamp */
> > >
> > > https://elixir.bootlin.com/linux/v6.7-rc5/source/include/linux/iio/ii=
o.h#L567
> > > See the comment (added recently!)
> >
> > I did see this comment but this is already sorted in order of
> > preference, so I'm not sure why you are calling it out. Just FYI, I
> > guess?
>
> No. Order of preference would be turn on the minimal if that is enough.
> First item is the highest preference (if the requested channels are a sub=
set of
> that we don't look any further).  Here that means we always stop on the f=
irst
> entry and never look at the second.

OK, I understand what you are getting at now. I thought the preference
could be my personal preference rather than the minimal case. :-)

But as you pointed out, the timestamp is handled separately, so it
doesn't make a difference here. The main point was to ensure that both
channels are always enabled since the ADC is doing simultaneous
sampling and always reading two channels at the same time.

>
> >
> > >
> > > Also, if I remember how this works correctly there is no need to incl=
ude
> > > the timestamp in the mask.  We do special handling for it to avoid ha=
ving to double
> > > the number of provided masks.  The details being that it uses
> > > iio_scan_el_ts_store rather than iio_scan_el_Store.
> >
> > Indeed. I've been working ahead on adding more features and noticed
> > this. So we will need to find a way to say that we the timestamp
> > should not be allowed under certain conditions. But that will be a
> > discussion for a later series.
>
> Interesting - you have cases where it's not valid at all?
> It sometimes becomes inaccurate because we are interpolating across
> data from a fifo, but I've not seen a case where we can't provide anythin=
g
> useful.  Ah well - as you say I'll wait for that later series!
>
> Jonathan
>
> >
> > >
> > > So as you have it I think you'll always end up with the first entry
> > > and that will include a bonus bit that isn't a problem as it will mat=
ch
> > > anyway.
> > >
> > > So just have the second entry and 0.
> > >
> > > Jonathan
> > >
> > > > +     0
> > > > +};
>

