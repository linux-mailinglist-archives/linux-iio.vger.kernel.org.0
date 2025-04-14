Return-Path: <linux-iio+bounces-18094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6004A887BA
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00EC7A603C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B427B512;
	Mon, 14 Apr 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm90pQAh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C427B50C;
	Mon, 14 Apr 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645793; cv=none; b=BWFdzWWN9yITGSyBL4KMhy8d5U78SN3kqgyTNl1Cn/Q0NnHMw534p1deZGBpH/S3g2TJXSw1Cgq742WPXS+7Owf+l21yCYzEJ8c4tH4WhlnF9um7mkgwDFfjw83BkKf2X3voproTh4GzsCHS/bUq2DJQUBZmfiELy/zPcClxJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645793; c=relaxed/simple;
	bh=QYKIvQbJ/5ZToOmtloz4O7Eq3NDCH7iJc7Y27O3b458=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSxEVsm2av3oe+E/UzlFHl/rzcxKiD44xD91PUfdjuZ3m8wJDOJg27HdHSL4OlEWlPP3pR27qVAl+zjL8IjfHZ9KTkzGpU24Z153oswmsS12pl0r2yqpUeH+3iztk07Y7shlcYNnwR6B8jYm//lkIFpHj9nruaJZU1Ugit9Pro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm90pQAh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739be717eddso3459643b3a.2;
        Mon, 14 Apr 2025 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645791; x=1745250591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1gCG2VcKxFnH6R/6Xp9i/XYGHNpZfbFn7TEjoOnrHjw=;
        b=bm90pQAhmRGwfHl94gs/R7OOs+UAZ19E7krKLboskGPMlIcN5VAkfyUn4EM4qBfgcS
         fJske1k+xnLzduz0xYL+BGrVIQaXDW8JUxdpdFBEa53nC1G+e/KM6UMXbSw3urfWNxCt
         jztPEAUWheuEwW0piAWAMjscfDnMCOadaxweDGK3fLXVfViridOqogvFjplqPnYkr3Cx
         IP0tpoih1XteMQVTGYbPr8+iAb7UjxuZGgr7js0jxTM+G74KmbLLlN+IOTbp2b9SObwu
         mH+pUNqj2k6KMi+JG5xmpHrfaKssHNENZVBY0mcgTwwaw1AvuPE9gEkjxl+9h+rp4ez1
         PAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645791; x=1745250591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gCG2VcKxFnH6R/6Xp9i/XYGHNpZfbFn7TEjoOnrHjw=;
        b=KZvZEdxwFIWODgYMAHHA9aW2Tm7ZC4iqt27g+rSHYevM0e/V8ZJcSBlTPkOLnIpsoa
         vmpS/xwUUh3LKVC5kuf9igXpXnzt0yXoOLy/13mUzlD7Mo1fFfE4X6rVC3YK6pAX/5D2
         3ynSOxw3hCqmZnr3pWxzMfvi+32QxWO/1FRQ+gDWOCAPzzG+n+MB7406qQJ2DIpamO8V
         q43/9imnn3Ca6N6+bE2Mv6/lOxOkL92G9kQ9e+B+ERoFlv5iVjr/MgfBT55ILrG5bNNf
         Wq3AnYloWeUS6bEX9MZKBUfXReRj/CyohBfrDcHm16M2mN2uO4YmgueVRplnWXeZoMPO
         tuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiBPFHBtmpMlKjg0MIUigWe3t1MobM0NVxin7l/910MfWvd9xEyd+fw6KI4pOjRZuSTtAr4xynlRjm@vger.kernel.org, AJvYcCXOo6ikOUFl6bdT9/uCI8t+XwT5X7kds8B02bS5HmjqruOrwgO97XGL+V5gVUPUFcSqMmJ5hNN7GVJX@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkJzNVHNUvFKwhDi3opVhZ4dNWp/f2xzPRTIbqaKNYf3B8p/E
	DQHdoPdKbxxA0bjJ+FU48S9cN7ovoJfmijwhKPyXUDlcbfVow+Q8/uv6OP/i+DyBJPZc2ye+Jdc
	fdmo44CLCM1NIHybm3p+qi3tSbfdqIerzaAk=
X-Gm-Gg: ASbGncuEFbBHtg9+dnq2d3dFlNBX0CYHz6pnFbMAr5SM4kFlUxN9KyoKdUXuVLqb5yx
	1KvJ85QFgcBKx2Lu/yKJfD70fA8BJtK0XANWpYoMGJ02wEEjjGbAJr3WYs/4iu3c5+R/9U0Myay
	3gwe04QbaIcPMQmFC1N1/8bAU=
X-Google-Smtp-Source: AGHT+IFypoQ5NojaWxIyyyqNQ2uh9biJjBG69iPSrtXMkC9lcqW5tM04V6780U/oisxekS+IcULQZFd2K0VzkehKxzI=
X-Received: by 2002:a05:6a00:1829:b0:736:4e67:d631 with SMTP id
 d2e1a72fcca58-73bd12b0207mr18470969b3a.23.1744645790677; Mon, 14 Apr 2025
 08:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com>
 <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com>
In-Reply-To: <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com>
From: gyeyoung <gye976@gmail.com>
Date: Tue, 15 Apr 2025 00:49:38 +0900
X-Gm-Features: ATxdqUGczoRTzd1bDIDvglZdEHuBAKY_3hYI3ePU13Zdb6clkeC7Zp2Io5vUXw4
Message-ID: <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Andy, thank you for taking the time to review my patch.

> > +#include <linux/kernel.h>
>
> No usual driver has a business to include the  kernel.h. Just follow
> the IWYU principle and make sure what you include is what you use
> here.

I thought "linux/kernel.h" was a globally essential header.
Thank you for the information.

---

> > +struct mhz19b_state {
> > +       struct serdev_device *serdev;
> > +       struct regulator *vin;
> > +
> > +       /*
> > +        * serdev receive buffer.
> > +        * When data is received from the MH-Z19B,
> > +        * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
> > +        */
> > +       char buf[9];
>
> Should it be DMA-safe?
>
> > +       int buf_idx;

I'm not sure if I understood your point correctly,
This code isn't DMA-safe. I'm currently understanding why DMA-safe is necessary.
(but actually other drivers implementing 'serdev ops' use non-DMA-safe buffers.)
I will verify this part and then send the next patch.

---

> > +       struct completion buf_ready;
> > +};
>
> Have you run `pahole` to check if this is the best layout?

No, I haven't run 'pahole' yet, but I'll verify the structure layout
using the tool from now on.
Thank you for the information.

---

> > +       case MHZ19B_ABC_LOGIC_CMD: {
> > +               bool enable = *((bool *)arg);
>
> Oh, no. The boolean type is a tricky one and here you probably break
> all the possible implementation defined behaviours esp. on bigendian
> systems.

> > +               uint16_t ppm = *((uint16_t *)arg);
>
> Do you guarantee the alignment?

So far, the arg has been the address of a u16 type stack variable, so
there was no error.
But I'll edit this by referring to the alignment documentation.

---

> > +       ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
> > +       if (ret != MHZ19B_CMD_SIZE) {
> > +               dev_err(dev, "write err, %d bytes written", ret);
>
> > +               return -EINVAL;
>
> Can ret be negative? In such a case, please propagate the actual error code.

Yes, ret can be negative. and I'll propagate the actual error code from now on.

> > +       }
>
> ...
>
> > +               ret = mhz19b_get_checksum(st->buf);
>
> How ret is being used? And if it may hold an error code, it should be
> return to the upper layers, otherwise the ret variable is a bad choice
> to keep this locally.

Sorry, this "ret = mhz19b_get_checksum(st->buf);" line should be dropped,
 I missed that.

---

> > +static int mhz19b_read_raw(struct iio_dev *indio_dev,
> > +       struct iio_chan_spec const *chan,
> > +       int *val, int *val2, long mask)
> > +{
> > +       int ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, NULL);
> > +
> > +       if (ret < 0)
> > +               return ret;
>
> It's better to use the form of
>
>    int ret;
>
>    ret = ...
>    if (ret)
>       ...
>
> Also why do you have ' < 0' parts? Please, double check that you use
> this form of the errorcheck if and only if the callee may return a
> positive value.

Yes, this function returns either a positive value(0 ~ 2000),
depending on the cmd argument.
So 'if (ret < 0)' is more appropriate than 'if (ret)' in this case.

---

>
> > +static const struct attribute_group mhz19b_attr_group = {
> > +       .attrs = mhz19b_attrs,
> > +};
>
> ATTRIBUTE_GROUP() ?

I looked into the API and found only ATTRIBUTE_GROUPS(),
But using ATTRIBUTE_GROUPS() requires the attribute_group value to be
declared as an array ending with a NULL entry. Would this be OK?
then i'll use ATTRIBUTE_GROUPS().

---

> > +static size_t mhz19b_receive_buf(struct serdev_device *serdev,
> > +       const u8 *data, size_t len)
> > +{
> > +       struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
> > +       struct mhz19b_state *st = iio_priv(indio_dev);
> > +
> > +       for (int i = 0; i < len; i++)
>
> Why signed?

Would it be better to declare 'i' as 'size_t' to match the type of 'len'?
then I'll change 'int i' to 'size_t i'.

---

> > +       ret = serdev_device_set_baudrate(serdev, 9600);
> > +       if (ret < 0)
>
> Why < 0?

First I assumed there was an error, but after checking the
serdev_device_set_baudrate() function,
I found that it doesn't return any error. so I'll remove the error check.

---

> > +               return ret;
> > +
> > +       serdev_device_set_flow_control(serdev, false);
> > +
> > +       ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> > +       if (ret < 0)
>
> Why < 0?

I'll simply change it to 'if (ret)'.

---

I'll revise the overall coding style by referring to other reviews.

Thanks,
Gyeyoung

