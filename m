Return-Path: <linux-iio+bounces-24004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8AB541BA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 06:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2752CA007C8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 04:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4B258CFA;
	Fri, 12 Sep 2025 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X92hgrNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011719D8A3
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652380; cv=none; b=SySS+5dXUjmvgAKeVdMkXksf3dtDOQMiX0Av3898z5a5pBqwdmZx0C6w8Tm6GfSbfAKqOAeQIal48Z5h0q3mTC+adySSHhhnlyLvw5FSQijhGOJXaCDIcbXUVk5cOnhIj+TPnMZtNRZiSDcCvWNQKf8aoOuY/TLv+SNZ6uSnP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652380; c=relaxed/simple;
	bh=TpUNMHEqmkCZSGnRTVB1Ed/+IAY3EQrOacZve65hZyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqgjUKbqNTLSvtAPE7cwkTIbPRCErsBHmYJTLhkYo/iFeg1IcTtDOM75VhCjmk756y+KtZPBMeVoiPLXzjUxs1115aqSxhewnV7u0pT5PrKU+mOrKyv8mW2XnnkSbbQXGFxhPOWCbQZ3NDGzl1TrdD3+48f0wlQ/1oGNCoKWzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X92hgrNR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso248116466b.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757652377; x=1758257177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPyIFFvWJ2Fqxf0usnACNYTRuGONj4aV/5x3K8yq/0Y=;
        b=X92hgrNRbUMCE4ViUGEmvMyOEWyXx+uX6KZwziGn/b39YdgGHZj/unIyPnBOJV7RuJ
         8bzv/4AIdWDymcqMcXqbGeudzOWET75GGmBjFeGpxovodWy6ngpWWdiWkGFYKxx5j5H4
         iUjYV3E5fkJaefDFF0JXnp38Cv1z1FmqeRp8qmlRKczdh6Za2WFBS+8m71WgHCJGYA7j
         xzGZvsATllar07JVbPTFubG71oVPSmHM8VvOVxM5EFeJBYGOBe7j+JcunL4zQmSgj9Fw
         eaR8jKowCyNFR+duJ7WfSPeVKaBvsJLCeNWsyxkgGM+4V8KOhhyYpQvudRtwvsEiKW6R
         qSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652377; x=1758257177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPyIFFvWJ2Fqxf0usnACNYTRuGONj4aV/5x3K8yq/0Y=;
        b=FHueTf7wp1Z2xN/T7+N9q2wpBWfmix9DhyM9beSspeBfu2zKkygyjc6mT9ubWYuqHk
         KOUqXsLWhlTUg3mxbq6r7Fi7nng+nFrzcEz0Zf/X0IL0QDvOwtxzv8bYUrcT5mjBRAWz
         5xgRCvrA8JFktuP56BJnKu4zSX/hhqv344oSuGy4UlN7UuF1q21aAG1A/8M0l7B0UYNv
         YXMCQvyNPhRNPMXQ/ixGLlq66CiLauS3jYv9vqGS4Z7qkjonKaX+lcFwkldh8ruFYdLi
         t9MJZRgUjup3T4VgnLSKn80yWIgg7O67bUrx/zE4WuWKZcb3FVO8HInkrjKE9X0hu+8c
         gvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVyIAlIpmTOB72GWRxkWh8BDmIf4FUSBw1voc8EVQNsXCJQcWo/FjQNCPdExbc0pAmgaSC+49YVSdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMSfdVFsaehoU8guQw+Qp0qOPhWf3rAmLcpW6zrpR/7L6x205
	RbqJOufr5l6M+mTBB0VukiN6Hfw0N+r+eEgNxero5lnI4dTU6AKgCi2YBQW/IScHOzo0KHYErnQ
	NyddKzK6Sfg/F93DtoPGL66MKDsytzas=
X-Gm-Gg: ASbGncti8X2c1YufqzAmhK8eRXnHN3RDc0E0c86lKKu9sFs89hvScXozJEUn1WnKBI6
	WRWYiQpDWNiTSVb0TPazizZatCcKqI098Amh/YLvGC8owWxNl2wTPiXXsRsnJM1lPIDm7Op2fL9
	dhkauZYAK+Prf0s4fgXj9YBn8GqSa9DA1yDajW1BNZkQBUbNQaDAcV2UOn/NXA7rr7id6RHr0d2
	yIJIeZB8/uSWS7PSQ==
X-Google-Smtp-Source: AGHT+IGrjZ4Yal+gsevWhgCEpcnrtzJz9j54FSUPVtZ49Qh1nxgsRYE/+aTevgym4aFnuwf0J3Dt95GMvslt3Ecgfos=
X-Received: by 2002:a17:907:7faa:b0:b04:74d1:a57c with SMTP id
 a640c23a62f3a-b07c3a76750mr146310366b.58.1757652376991; Thu, 11 Sep 2025
 21:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 07:45:40 +0300
X-Gm-Features: Ac12FXzDMR8_bGyEoyQ1qf9m-hGEeoE7KKekcW58wgWXbu-hWTBEx_d3jGIfl9o
Message-ID: <CAHp75VdMSr400YokZfv8SAkt-M8kuw7gt4+eCBb68xt7ipKJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: ad7124: support fractional sampling_frequency
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Modify the attribute read/write functions for sampling_frequency and
> filter_low_pass_3db_frequency to return fractional values.
>
> These ADCs support output data rates in the single digits, so being
> able to specify fractional values is necessary to use all possible
> sampling frequencies.

...

>         factor =3D 32 * 4; /* N =3D 4 for default sinc4 filter. */
> -       odr_sel_bits =3D clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, =
2047);
> +       odr_sel_bits =3D DIV_ROUND_CLOSEST(fclk, odr * factor +
> +                                              odr_micro * factor / MICRO=
);

> +       odr_sel_bits =3D clamp(odr_sel_bits, 1, 2047);

I would rather see this clamp() call to be the part of
cfg.odr_sel_bits() assignment, otherwise the above line and this
operate on the semantically (slightly) different data. So, the first
line should use different variable name, or the second, like
odr_sel_bits_clamped.

>         if (odr_sel_bits !=3D st->channels[channel].cfg.odr_sel_bits)
>                 st->channels[channel].cfg.live =3D false;
>
> -       /* fADC =3D fCLK / (FS[10:0] x 32) */
> -       st->channels[channel].cfg.odr =3D DIV_ROUND_CLOSEST(fclk, odr_sel=
_bits *
> -                                                               factor);
>         st->channels[channel].cfg.odr_sel_bits =3D odr_sel_bits;


--=20
With Best Regards,
Andy Shevchenko

