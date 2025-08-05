Return-Path: <linux-iio+bounces-22297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF536B1AD05
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC2D16476E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 04:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13581E0B9C;
	Tue,  5 Aug 2025 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq6zgoeh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F25191;
	Tue,  5 Aug 2025 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754366750; cv=none; b=rJweB3CFYkemITFFbsUlFXEkxhi7fSJfLbvOS9MQEyGhO21J4MWhGh74K7C4rsjOhYm2pAOfKSRMz/StYU3+qYbVTynwk4UhKla0oQ0hLgkZqE8aP6OUNNQOQN6AxOOQ/d+fYjo6+qwNLn+2SZvfAWvjk+HTAuGZC4jmsXFdb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754366750; c=relaxed/simple;
	bh=4jnRD8VKhR7Gt+dJj8OLyHzW0o1KJxNGsvZD7K7uC9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJ4u5Mk/J4tuzKK2Zki6NgZzlbTfNWxo42TNHcfo12VA2ZbGnrjiTklwzeiAVrPZctrbtIXUo6T+lCr+m0OiBcWWf/iJO0o5ZcdngmX6Is6bJaVbUIP6a/jGFPwaoLJHR+UBUDUR0x7A4nqtuMx75Rblw6sPT5ENID2adJmzfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq6zgoeh; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso50021051fa.3;
        Mon, 04 Aug 2025 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754366747; x=1754971547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHqsHlz1Z2CiNP2JagmW9QT4QlSkYOHQCdskJj6TcB8=;
        b=Aq6zgoehXsGOZxqDMcjy2Bj7Y1dchFn6UROBVf73rNSf4zMBfuodeXPersVg/hp3eP
         u44xDaRtbvkSJ2sYyH93QVP3WMTywRkM2sdoEacJImfAV9ALAud8ioyqWIT1tizs0xkm
         WuxPCKuBMQGhGlHOtguXMCFFH1LTR3wWnx27gHLygvvittmjDjcVEbVLxVE3PiAcnIWy
         Eue1avtBvt+ODq6g63C+CsTXgwSlXb6LP2xZmCY12bKSnRMikPe/8uu0xDar4j0Jad+l
         CBbAUCIcTyLiZ+IW7QeVu02tNo4IaA+WAK2X7eyIjhWedE+CTRT72AMXtnkhhk34hd6m
         iYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754366747; x=1754971547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHqsHlz1Z2CiNP2JagmW9QT4QlSkYOHQCdskJj6TcB8=;
        b=jxDdpRbZBW5x/oT4K2a2fohYvM7ipFi/QjpR60M2yoe2R3v9WocAi6PnQlJLkFK8jc
         AarH2Fcj7wXIRiWq7O8YOix/O8hFk1RmH1JTqTkqVK42ov/nKPZFeJLcBFgcCsVRZoKb
         yB3uZtpe+v4ff9o6I3bwUThs8pkAxEtROThPpctp+SB5OZCk9IZutF3sD1hnXdysVsJr
         QocI1Z4TcfC4SvGDrWl8w/ty01se+zlJDzfhHakcJuu+6yWJvoWa3R+86aRRYXK1XY8R
         ovbHiTzT+j4D9msmU83yW6pdF3gA85XWtWjEgrLjADSS2Vp59EKb7W2K5ZrrcTOS34pP
         QAZw==
X-Forwarded-Encrypted: i=1; AJvYcCWL6PvicpaZ81U6LFlfPyMW/aMZd+bw0FaLqFg5WpPVawfcGj/yg38UEsCi2ehDJ8ZIL4T08TmyBkpN3/Oo@vger.kernel.org, AJvYcCXDcxJOTbo/rRGKoiW4e1bZrtV2hnwKNeWubXQSzBK143hmlb3k+/ALl0EQu7441rD37U5IFD42pJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbYLOevShMppBeoZaBbSpnyMmMeC2TPLC1aZHtDosmqiU5x0M
	81Iz5jHaxgBNcDy7160VuW6i8fg/mYNkewO+vTQrcc7QIGz32cYWStvnD+vLVnNTXOpccZdBPV2
	sIA6On2BVOAnkBAQsC6qK8zj8EC1Xu3E=
X-Gm-Gg: ASbGncuXj/Wzu5J8YewQ82ZC/oJfqc4YToghClq4VJktRWVWnFZIV9TNCWA9wwCwQYQ
	vJC4tmBjCm0T9r4v5D1P6L3oWuUR+3OKG/SqYzlnWXJ4hqelsd9i75bpKjox8gzNRw2n3BNQJDc
	R+Qf8kzTE6B7mV2s3kfQfdKugPGTPKk2OFnAZU9P4+xPbfybesmW74g56aUMfGiGBFxZSdj8qjr
	3zU01vB
X-Google-Smtp-Source: AGHT+IGmBENJ1t+Qvu2oPFP5zbqFeDEaup4sKrDKhOEZGixQd9xci/6aSlzwTFV83oUUvCYYKKd1l1z57uSlLOEJXVM=
X-Received: by 2002:a05:651c:4115:b0:32c:bc69:e954 with SMTP id
 38308e7fff4ca-33256810aa3mr20215021fa.37.1754366746516; Mon, 04 Aug 2025
 21:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com> <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
In-Reply-To: <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 5 Aug 2025 09:35:34 +0530
X-Gm-Features: Ac12FXzGCwERRVoXD8lubCuV_KvCHcm0UDqbcRl1VNkpqLjrtSuy-uDVzMR_wwA
Message-ID: <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Doesn't sound right to me. HAve you investigated PM runtime paths?
Yes I did investigate and found that PM runtime->suspend() callback
co-exists with remove callback.

> Looking at what the code you added there it sounds to me like a part
> of PM runtime ->suspend() callback.
Yes, part of functionality will always be common, because both the
callback implementations put
the device into powered down or low power state which is what has been done=
 here
Both _suspend() and remove are called at different times in the lifecycle o=
f the
driver, but with respect to register setting, they put the device into
power down state.
Additionally .remove() can have code for:
1. disable runtime power management (if enabled while device registration).
2. device cleanup (disabling interrupt and cleaning up other configs done).
2. unregister the device.

For eg: another light sensor bh1750
static void bh1750_remove(struct i2c_client *client)
{
    iio_device_unregister(indio_dev);
    mutex_lock(&data->lock);
    i2c_smbus_write_byte(client, BH1750_POWER_DOWN);
    mutex_unlock(&data->lock);
}

static int bh1750_suspend(struct device *dev)
{
    mutex_lock(&data->lock);
    ret =3D i2c_smbus_write_byte(data->client, BH1750_POWER_DOWN);
    mutex_unlock(&data->lock);
    return ret;
}

In drivers/iio/light, you can find similar examples in pa12203001,
rpr0521, apds9960,
vcnl4000, isl29028, vcnl4035. You can find many more examples in
sensors other than light sensors.

Thanks,
Akshay

