Return-Path: <linux-iio+bounces-2346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBA84F9C1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E363B29792
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352797B3D9;
	Fri,  9 Feb 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H97gUlc1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672195339E;
	Fri,  9 Feb 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496682; cv=none; b=r6zU89HlI5OD50VqigFD10n9izpOECwUbmguTJO8PC1y5g16ofxhAY80556/eOUEZpBcwjB+pHZ5GIhBfet9KpoyodmKsHJdQx6Z2IXMYWXwH7vdLLcl0LN+6MK7z2LG1OLFGYtiwv37HST6PHHWgjShB5dtuAmDcpqnQ1dMeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496682; c=relaxed/simple;
	bh=3c4KyVUY+8+J2DM9TNTTr8gHCtMfIf+GQGeL5c4hL+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq4HdflRnNwK51ufUJvvP/qYGKr0baIyX3/LCAXnaQp1IcmKPHhikbJkL0C/OtCIxIi9lUG4Xf2DkaSHoN2kIV2oi/GBVyYAGxr3m5QYz9hUoE7gGCx/0EcQonUbyEF2gaWtaj3VmvEeL//Vq8nY5C3CTvMWbfxafp3yQPtHS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H97gUlc1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30f7c9574eso139066566b.0;
        Fri, 09 Feb 2024 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707496678; x=1708101478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vt0bXaQo/CSZ1wNgT5DTTVusWcy3bPhCv+mvMVFiao=;
        b=H97gUlc18FG7S1/v1gg4+CDYZXF4n50+/C5SeV5+CSf1GkAJTcAfCvK6NQVxqtVR/G
         EoRodCv7r1mBxBDUBwv3KlJJhr/6dONX6frJzafE5iJ1RHpjBuff31QG6xJHLkSkadoE
         YKWlEK03u/Yse+jElvJzxeqZ7HfkZ3UmFz7WM1GQPzx9qv84LRmh+tODhEIgldfQNNJe
         nFcxTKV37bWa4nwXaNwXZO7w6jU2GcgDcaYV98tmF56qvZck1gYL0PDYfLl/X6+6YV/G
         Dvbt03epskiQrIqBtmVOkmmnPl0prTa9A8CXY/BZrIWuH+SMuJKsWnV9+KNs3Ie7Bsg4
         RI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496678; x=1708101478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vt0bXaQo/CSZ1wNgT5DTTVusWcy3bPhCv+mvMVFiao=;
        b=RxSs2Vk1xnaHdVG9uzTBcNidhgNYTQgyJl7JoTGjzh7ocfY6svK1aI6f1kpf7WGmWI
         i64+1PWuKAs+QzubhMvDIsEKKzGxLW3OuFVoKkLm+kkW3tQaxUtO5cySt1NtBazj1V3X
         Kg/rH8KmVv6jQIqGIcGbOBHzFGjvOuaJcfBRurnbw3CYpqzOnKzPqX3dMTvf50jGnCRL
         YIg3k2qcOa3prFGu80EV64LOMHOvMSyVB8uO3xOv6qPKKXM9cfpXd6hA/3W/bF6FmxlZ
         ZFTayAnEByooxuCivS6O8j+7+Q6dHxWcXbFO7AWJUCkTuG69EOeCpzCC0WJL8z22dR0I
         8Z/w==
X-Gm-Message-State: AOJu0Yz7RlZOgno/Inuybksj+93feWW0YWLAlRJGfkVDer0g6MkJu2Wp
	vNVbZLBONBZNQCLuRV386OwcYpTVneuJFUs7cnhkV+DoyKJhy8V7fpXbx5amLM13BvDaLiGsdTM
	h69SQakZ3jk/IRujFETCMgJ+jJ7A=
X-Google-Smtp-Source: AGHT+IHjBfcFQ2n8/BDra0d/k8j4SvKGStxvIAM5UnP75L0HVnopCXmDW3q2CDesrBcoA7hmLnl6msi1j/s4FahpZNM=
X-Received: by 2002:a17:906:138a:b0:a3c:2b1:48ae with SMTP id
 f10-20020a170906138a00b00a3c02b148aemr1085170ejc.27.1707496678288; Fri, 09
 Feb 2024 08:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com> <20240209-iio-backend-v10-6-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-6-3ed842064318@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2024 18:37:21 +0200
Message-ID: <CAHp75Vd0qcJiw7EPsSjLAG1G8RFymFuRif7FY2YVTBPK9M2KJQ@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] iio: adc: ad9467: convert to backend framework
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote:
>
> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).
>
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.
>
> Given the lack of features (and devices supported) in the ad9467 driver
> compared with the ADI out of tree version, we don't expect any user of
> the upstream driver so no one should notice the ABI breakage. However,
> if someone is affected by this, ADI will happily support transitioning
> to the backend framework.

...

>  struct ad9467_chip_info {
> -       struct adi_axi_adc_chip_info    axi_adc_info;
> -       unsigned int                    default_output_mode;
> -       unsigned int                    vref_mask;
> +       const char              *name;
> +       unsigned int            id;
> +       const struct            iio_chan_spec *channels;
> +       unsigned int            num_channels;
> +       const unsigned int      (*scale_table)[2];
> +       int                     num_scales;
> +       unsigned long           max_rate;
> +       unsigned int            default_output_mode;
> +       unsigned int            vref_mask;
>  };

Seems like you haven't checked this layout with `pahole`.

...

> +static int ad9467_iio_backend_get(struct ad9467_state *st)
> +{
> +       struct device *dev =3D &st->spi->dev;
> +       struct device_node *__back;
> +
> +       st->back =3D devm_iio_backend_get(&st->spi->dev, NULL);

Simply 'dev' as the first parameter?

...

> +       /* If not found, don't error out as we might have legacy DT prope=
rty */

This seems related to ENOENT, correct?

> +       if (!IS_ERR(st->back))
> +               return 0;

And the above is about something else (found?) case, right?

> +       if (PTR_ERR(st->back) !=3D -ENOENT)
> +               return PTR_ERR(st->back);

--
With Best Regards,
Andy Shevchenko

