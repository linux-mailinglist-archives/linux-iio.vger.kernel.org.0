Return-Path: <linux-iio+bounces-910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6081242D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 01:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3BF1F218A4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAFC63D;
	Thu, 14 Dec 2023 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+HCa4Du"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B595106
	for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 16:59:06 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2cc43f9e744so62991fa.2
        for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 16:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702515544; x=1703120344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLPQRFERPZKZe4sP96FP5UOkMogbBRWOBLXtIS+wgKA=;
        b=H+HCa4Dum7Yqt6M+Vya5PNZ9+zhC6v6nSGCkjXiZNSJL8vobmRR9jQwjxW9HeiWm6H
         SeWzH4GxlydbCrGFArGv7H1LSq0cu1QFXCQsoQ8RV8qH00V/rvt2NhGll4r2mMlY8KJV
         khPbSsqL01hzPqoON5GpJEB1bXDyXt7eVLVB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515544; x=1703120344;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLPQRFERPZKZe4sP96FP5UOkMogbBRWOBLXtIS+wgKA=;
        b=dQ2rFWOjaSLbig1IZpbbpYzS+brAogqFciFqQCJJZiKM3wE8K64XFW3hQNywVDxU3p
         QLQszqveTi7BEqRgswtgEYO5rUGVsWLKXbdU65RFezPG8OUkbDXr8W/lrmtn6QVew53V
         d037lv3MmiQhORtqviKjCp3cr+Hh3DLh0IZs/+xMfHWnslFgE6YDnUh14tX2uyVCQS0K
         N+CeYkzw1YiAzumTtvzMOj6+ghTYm5SOs93HWF+m0VhaxuZCtb5b4U/NXngJ44VofxT2
         q5DpfrVokX+tpy1x2Y1KTQXZ8YQTCI6QOv8IItzNa0W5KDqmERCILmRfIb0GWHNMsubY
         TSjQ==
X-Gm-Message-State: AOJu0Yz6f/QBKV8j7s65UdTZJbOL4r0gMTMoDuILUtDyAhGzoJiGHila
	w56MX/ElOXv3jlMO4YSB13eY1V2VWGQdUobIg1NBC4Ow2JFWiqOr
X-Google-Smtp-Source: AGHT+IEunZGd9tNek4p895u1vSnibbU895Lddmz8b+pc8eZ7RAYfA5ccHN3CMRjZTHj2uRjOAKt0XYWsogRcyShRfeY=
X-Received: by 2002:a2e:a4b8:0:b0:2cc:1d91:83fc with SMTP id
 g24-20020a2ea4b8000000b002cc1d9183fcmr2754449ljm.30.1702515544589; Wed, 13
 Dec 2023 16:59:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 16:59:04 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 13 Dec 2023 16:59:04 -0800
Message-ID: <CAE-0n50U47OKs50bOf91HoOayVJEj=H6P-cpyZ_46pX8CVZ4BQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
To: Jonathan Cameron <jic23@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Justin Stitt (2023-12-11 16:42:52)
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 438f9c9aba6e..e3bc30b57b19 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -873,6 +873,32 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>                                         20000, 2000000);
>  }
>
> +static u32 sx9324_parse_phase_prop(struct device *dev,

return u8? because that's the type of struct sx_common_reg_default::def.

> +                                  struct sx_common_reg_default *reg_def,
> +                                  int idx, const char *prop)
> +{
> +       unsigned int pin_defs[SX9324_NUM_PINS];
> +       int count, ret, pin;
> +       u8 default_def;
> +       u32 raw = 0;
> +
> +       default_def = sx9324_default_regs[idx].def;

Do we need to do this? Isn't this reg_def->def?

> +
> +       count = device_property_count_u32(dev, prop);
> +       if (count != ARRAY_SIZE(pin_defs))
> +               return default_def;

return reg_def->def?

> +       ret = device_property_read_u32_array(dev, prop, pin_defs,
> +                                            ARRAY_SIZE(pin_defs));
> +       if (ret)
> +               return default_def;

return reg_def->def?

> +
> +       for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> +               raw |= (pin_defs[pin] << (2 * pin)) &
> +                      SX9324_REG_AFE_PH0_PIN_MASK(pin);
> +
> +       return raw;
> +}
> +
>  static const struct sx_common_reg_default *
>  sx9324_get_default_reg(struct device *dev, int idx,
>                        struct sx_common_reg_default *reg_def)
> @@ -884,35 +910,30 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  #define SX9324_PIN_DEF "semtech,ph0-pin"
>  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
>  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"

Can you send a followup to remove these defines?

> -       unsigned int pin_defs[SX9324_NUM_PINS];
> -       char prop[] = SX9324_PROXRAW_DEF;
> +       const char *prop = SX9324_PROXRAW_DEF;

This can be left unassigned now, right?

>         u32 start = 0, raw = 0, pos = 0;
> -       int ret, count, ph, pin;
>         const char *res;
> +       int ret;

