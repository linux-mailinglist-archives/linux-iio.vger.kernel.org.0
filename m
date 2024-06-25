Return-Path: <linux-iio+bounces-6889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35E9165EA
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 13:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A33C1F22E20
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512A14B07C;
	Tue, 25 Jun 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zra+vPBh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218414AD0C
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313985; cv=none; b=PpdBFsmKCcf1YD+XwSkThUJrCOXpdtI/dIv0nGPsGL/lZirL3m4xe6hf+X8bLj5S7U9536Qo5KvBos82ZCpWg/AyoX+WZ2+5xJSQQI39H++IrpAldrobIl5W5LJA9yPkoICehKVFRe3sIXSYPIiklx9OsP+Ta5BCmBCG+4vI+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313985; c=relaxed/simple;
	bh=ZPOD4YjlpbiEJX/ltS7DkVMVnGceP4CuYQ83WTgqyEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW7JYRBdQ+hWkYgBPS4KNydF2KXU+iM7DXqLKLn+AbaijEJHrApqurPjHzKw19cdeCoh/htuuiTUiuXCfIhTih5IltoRO9LVzV7Sq+gHt32Es6B4q4BpQg3ENSKGyuQmHejviGh3njrlk1dVbUmgsR/8BvfgIv2Sm5tt4jAc2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zra+vPBh; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80f94e4c183so59615241.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719313980; x=1719918780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUdVCzPrKxaha8DCYOqNe6BhofBEMrLm8EHJxR09Qzk=;
        b=zra+vPBhjcV5lDNyDqPbYB94gSDfl0Ki3iz1Q74HF2xrKTLyJqYr/OtQJopB7tbIQX
         lAV3AL/pN43G9tYV2e6+L2ah2ecS3jHzsNMS5DgWop788ZAfZ/RS1dMPyMLM0ZUUIuz4
         jGErah7FFaVquvjv5ju8zgk/nLrDZLMacZWINRk+G+NV9/JKpW9WzR7qDxiamWjdZYDb
         edVi7Xsc3hcOvhzoGjIbGozkJWcOxAoluuoKzjeV1wtiIondHvrlpx6+GjjO2DB+Ba0U
         Ev5b95zoyQNx4QrL7qDWq1QdBKM73FgKjVsghXI6L16m0tScOkWWypkfw1cgaFvleYdz
         jh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313980; x=1719918780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUdVCzPrKxaha8DCYOqNe6BhofBEMrLm8EHJxR09Qzk=;
        b=Po/RMFOG5l7AGJYdEPLffEZsr2TlzCcf2+s2SsOwwdnJG8+7a8mrHdnpWKP+kYM11E
         Ly31pl1ybpoaG+aWsfHjigjEtuLqBQxI9B17nYz774hvh8ewO6nHSHT/Z2KJ+Tfv6Jv+
         fNe8OANlrM25jAQKkVdivBUw/G+p4YGYGYiYtUJY2E3XCWUzEyCpuPk8cCfjR5u6L5W2
         wQ39EyL0gPOivZfz/SqPy+YKOUOTHdcNJcMbEywv8eu7SLbtgqx2CF1WKJeowbJk0Uio
         eFUMLPGUF0MP9V1KJ1QKGeuRGQa5SvKgp3aQYGadVA/PAgRdVit9vIxeWlJTanWc9CV9
         NwzA==
X-Forwarded-Encrypted: i=1; AJvYcCWdFTqOZizGQIxmTVJy3EC4qoAmwHzZg0SWiqbDhxs9DLMRJbGcdRtp3GdO0HggRLEwz1qUVNuJoJqRWZX13ElNKLGX+6RmSd8P
X-Gm-Message-State: AOJu0Yx7sV48BJcLP6aGR7V9To2p9LlsUWGsT7ZkGuXfmQ9vlrY+OJYU
	e3cAi7m9bscc62J9FZSfl+rua+LOYrepCSb79a+bAUBI/3+YwZMQW/r6jCwH8IMSy3X2oc4BzdD
	bMjTIHICzGhjpnV/P7Uf9AnT4uHfPsaOum1BjewLKj8+zJ26wLdXQcA==
X-Google-Smtp-Source: AGHT+IHpe8LdBovfaRlXpDtzomRv1Bjvca6P5F6RiEUH4J/fnXdzVhMiVhAsyolKVTaZ0xuC+GqLv55SLpkJWswGfz0=
X-Received: by 2002:a05:6122:6025:b0:4eb:106:217e with SMTP id
 71dfb90a1353d-4ef612ca047mr7207047e0c.1.1719313980334; Tue, 25 Jun 2024
 04:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621120539.31351-1-dumitru.ceclan@analog.com>
 <CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com> <7f61333b-1d43-4321-aa51-79273255454c@gmail.com>
In-Reply-To: <7f61333b-1d43-4321-aa51-79273255454c@gmail.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 25 Jun 2024 14:12:48 +0300
Message-ID: <CA+GgBR8JoeUPKVs6h3-ucJk_AuzKyn6TWb0ZozsXYqcxSsmFuw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix disable_one callback
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, dumitru.ceclan@analog.com0, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:45=E2=80=AFPM Ceclan, Dumitru
<mitrutzceclan@gmail.com> wrote:
>
> On 21/06/2024 16:26, Alexandru Ardelean wrote:
> > On Fri, Jun 21, 2024 at 3:05=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@g=
mail.com> wrote:
> >>
> >> The ADC ad7192 is a sigma delta ADC with a sequencer that does not
> >> require a disable_one callback as all enable channel bits are within
> >> the same register.
> >>
> >> Remove the requirement of the disable_one callback for sigma delta ADC=
s
> >> with a sequencer.
> >>
> >> This patch could be squashed with the commit that it fixes from patch
> >> series: Add support for AD411x
> >>
> >
> > This fix looks fine.
> > But, then this raises a question if this needs be to extended to the
> > `disable_all` and maybe `indio_dev->info->update_scan_mode` check.
> > And if so, how should this be handled?
> >
> > For example:
> > drivers/iio/adc/ad7124.c:    .disable_all =3D ad7124_disable_all,
> > drivers/iio/adc/ad7173.c:    .disable_all =3D ad7173_disable_all,
> > drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
> > drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
> >
> > And:
> > drivers/iio/adc/ad7124.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi=
,
> > &ad7124_sigma_delta_info);
> > drivers/iio/adc/ad7173.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi=
,
> > &ad7173_sigma_delta_info);
> > drivers/iio/adc/ad7192.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi=
,
> > st->chip_info->sigma_delta_info);
> > drivers/iio/adc/ad7780.c:    ad_sd_init(&st->sd, indio_dev, spi,
> > &ad7780_sigma_delta_info);
> > drivers/iio/adc/ad7791.c:    ad_sd_init(&st->sd, indio_dev, spi,
> > &ad7791_sigma_delta_info);
> > drivers/iio/adc/ad7793.c:    ad_sd_init(&st->sd, indio_dev, spi,
> > &ad7793_sigma_delta_info);
> >
> > At least the ad7791.c & ad7793.c drivers support parts with more than
> > 1 channel, and there does not seem to be any `disable_all` hook
> > defined (at least in iio/testing).
> > I have not gone too deep with `indio_dev->info->update_scan_mode`, but
> > it would be worth to do a check there as well
> >
> >
>
> disable_all and update_scan_mode callbacks are required only when the ADC
> features a sequencer, as in you can enable more than one channel at a tim=
e
> and the ADC will automatically cycle conversions through all enabled chan=
nels.
>
> This feature is signaled by setting the ad_sigma_delta_info.num_slots att=
ribute
> to a value >1. The only drivers that set .num_slot from what I see are:
> ad7173, ad7192, ad7124. So only these 3 are relevant in this discussion.
>
> For ad7192, disable_all() is useless as both ad7192_set_channel() and
> ad7192_update_scan_mode() actually set to 0 other channel enable bits.
>
> I do not see any reason at this moment to extend this to disable_all and
> update_scan_mode.

Ack.
Thanks for the explanation :)
I think I also misread the code there; I was thinking num_slots is
related to the number of channels.

>
> >> Fixes: a25a0aab2187 ("iio: adc: ad_sigma_delta: add disable_one callba=
ck")
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >>  drivers/iio/adc/ad_sigma_delta.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sig=
ma_delta.c
> >> index d6b5fca034a0..8c062b0d26e3 100644
> >> --- a/drivers/iio/adc/ad_sigma_delta.c
> >> +++ b/drivers/iio/adc/ad_sigma_delta.c
> >> @@ -672,11 +672,6 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta=
, struct iio_dev *indio_dev,
> >>                         dev_err(&spi->dev, "ad_sigma_delta_info lacks =
disable_all().\n");
> >>                         return -EINVAL;
> >>                 }
> >> -
> >> -               if (!info->disable_one) {
> >> -                       dev_err(&spi->dev, "ad_sigma_delta_info lacks =
disable_one().\n");
> >> -                       return -EINVAL;
> >> -               }
> >>         }
> >>
> >>         if (info->irq_line)
> >> --
> >> 2.43.0
> >>
> >>
>

