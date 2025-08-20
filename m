Return-Path: <linux-iio+bounces-23036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA3B2D9C9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCEA5E38A0
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17642DECA5;
	Wed, 20 Aug 2025 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHgpOoyd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0F1DE8AE;
	Wed, 20 Aug 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684489; cv=none; b=UzZTiiefe/5D/ljOkY4kzVjnYYaGUZXZ7mgcGiDq8vGz0s9f8C34ch171BSQ9q6ZM+nsTNApvtY/76MLdhdf7aCdgbXUGB66U1np8OX/fOyJNfMilLH6HoesyVT/mWrU32LFbacJboeakgcWztKayqnR1sgwrCAMXBRmUmdkNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684489; c=relaxed/simple;
	bh=FZnH7IVXDZSkh1fg/9whT2XBdr3e/mxUBPm+5ecoQyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8Uq5Yj0nDOSm5n5sQ6Z7lnx7S0f7hS3PyYwxP6nJnsmQmmF9b/MPDKq8hOpCok702ZrpJqg+GjbSVyUoFYjRMJ5apsKJ9uzK3mcOyUIIwKzGb6jIGsR88qdoHkWp0AnmzjBYeIjjzwmvAl9Bu40miBE9lWlkGi+GgXEBjs+lMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHgpOoyd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a0442bso924457166b.2;
        Wed, 20 Aug 2025 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755684486; x=1756289286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A10HCd2pA3OduNKpWYQq6d5rqpa6dB0B0oPBvZ95Xzs=;
        b=CHgpOoydrLpE5a1cehubKiafAW2TqTK/wrul1s8YXv8twCx0QSn9avu0iCR3P7f6X0
         o3mK1p/31lR/UfKk+zUq6mYkm9N4GWW8mwu5w+FJBKBg6UeXX7kGGBQ0ocr1Nc4rqe67
         8m9hehY1fO40Cb3JZ/pKj6DkpvyUzLXRAnF8f+cy8Ub+d5GmQUrZbW0QgmfnNlclCsVQ
         7a7vsYRE3xHEeFDVedHcQAJAZlW0qVYAHpPJ1bX5WqqEat+okRqTlNcxHx+MM8xGXl5M
         p9FZurPyGtgg0hQUlxVVhHw1JwS61J3lMO+fRyD1nUV8XdmixW2fFiaYbPgKyL4eaACB
         ZWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755684486; x=1756289286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A10HCd2pA3OduNKpWYQq6d5rqpa6dB0B0oPBvZ95Xzs=;
        b=FZFf7Gm62AaMjaFa+03/wWNf4fmKNmJukDhju01vnAOiLXFxrx0IcwJswhcDoMHtxc
         7BlGyVytzCmBMWoIgNy+PXOt2fIAV+sBMVEBTFT/JDu8oryV+y8V6Eks0E+dAp1v6lO9
         yPnThcH+KP9xdUyY3krj1sVi1/cKAUUVPyNIAwpPWt5wlPvUCJ5miqlrtpytwocHlXpo
         T8VAlGlgLDQBvKB9urE5grD7tORYtZ7r3KWNbmFsla/Yj0KBOKxO4uuJlVVTJ6yST5TE
         8gy+tcP2ops4byV/cbRCqyEKTMhQwAi5AD66bmARv75MTi3+itqv9F4ldv5MpZZW/6MM
         m8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+efLYSiLfBers5B5mcxUQItEIj1+Q+DHtpGfO6LZyxg80RG/D5W/N+9crLAWbLW1D5anfi0qR+vdg1pcQ@vger.kernel.org, AJvYcCWahQ0LpwdgUYeb1OR3tOsGNG0uOBZZPl6fpcEkFeg089Lxe2IXJ6tiC3Sau7EdUsJwJTXEPsU94Rmy@vger.kernel.org, AJvYcCWrQFHA7JuaZyhz4K05LP70zh2tdwTIEPft8CViNOdDw+KxKlKcA4tUiOdw+osSaMbw9U0iCYzT5ApP@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+KTdguQQCO3sa0InB1u9Lea3nfZpIY7FQ1sJtuBRAUZ5OJ10
	DgDiw8q11z7eSgSuSsScorLSy+RQj50J250KroRxa6gldX2DpQbvV3osPyznJVQXn2ZgQsMCVjn
	Ens2udLqrpS9wG/8TEed+xcalHFnHdiE=
X-Gm-Gg: ASbGncv6JYPScPgKXCdgxLU+gL3zq3fkpt6IHh/2WgCG7bSpRdE4tkaxF0oQxyEf78w
	pPMQWOVf0SnQQiwjeW+7H81om7HKHzbPkK4j/MqKp4aHJbxfuD9oyET/8Od/OPTr76/taVyAnk0
	htQ7lxSTqSVQOJ3NjRZcf1Ewet1DYuckdJj4lS0iaotewMA7Xni1MVRV8lidJcAKnXT8RYFyelQ
	FUIQBvg+A==
X-Google-Smtp-Source: AGHT+IF0+R0Fi3FH4hzy3g1t0qDqEyKVt5uDOei3+hJK+Y1205usJSF6wJdnHtvCy70VrmskKGSfuhi8jaApX0uDUCk=
X-Received: by 2002:a17:906:6a22:b0:afa:17ef:be34 with SMTP id
 a640c23a62f3a-afdf005d188mr176046466b.5.1755684485775; Wed, 20 Aug 2025
 03:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com> <20250819-upstream-changes-v7-4-88a33aa78f6a@watter.com>
In-Reply-To: <20250819-upstream-changes-v7-4-88a33aa78f6a@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Aug 2025 13:07:28 +0300
X-Gm-Features: Ac12FXwFK3zS39o8cYKu54pIrc-2L6sdZoLIj6cAUWdmikwm-1-fDBi4WslIDiQ
Message-ID: <CAHp75VfrRJmB-Q6TM+Tiy79_q63=cOvyrePMQwi6ZbvDNUPezQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] iio: mcp9600: Recognize chip id for mcp9601
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 2:45=E2=80=AFAM Ben Collins <bcollins@watter.com> w=
rote:
>
> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
>
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
>
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.
>
> Moved "struct mcp9600_data" up in the file since a later patch will
> need it and chip_info before the declerations.

declarations

...

> +struct mcp9600_data {
> +       struct i2c_client *client;
> +};
> +
>  #define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, cj_ev_spe=
c_off) \
>         {                                                                =
      \
>                 {                                                        =
      \
> @@ -123,10 +133,6 @@ static const struct iio_chan_spec mcp9600_channels[]=
[2] =3D {
>         MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
>  };
>
> -struct mcp9600_data {
> -       struct i2c_client *client;
> -};
> -

It's not obvious why this piece of change is needed. AFAICS it's a stray ch=
ange.

...

>  static int mcp9600_probe(struct i2c_client *client)
>  {
> +       const struct mcp_chip_info *chip_info =3D i2c_get_match_data(clie=
nt);

>         struct iio_dev *indio_dev;
>         struct mcp9600_data *data;
> -       int ret, ch_sel;
> +       int ch_sel, dev_id, ret;

It's hard to maintain and prone to subtle errors if we split
assignment and check, so please move assignment here.

       chip_info =3D i2c_get_match_data(client);

> +       if (!chip_info)
> +               return dev_err_probe(&client->dev, -EINVAL,

In such cases we usually use ENODEV.

> +                                    "No chip-info found for device\n");

...

> +               return dev_err_probe(&client->dev, dev_id,
> +                                    "Failed to read device ID\n");

With

  struct device *dev =3D &client->dev;

at the top of the function this and other statements become neater and
easier to follow. In particular, I believe this one may become a one
liner after the change.

--=20
With Best Regards,
Andy Shevchenko

