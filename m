Return-Path: <linux-iio+bounces-20059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B4EAC9636
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 21:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092497B4B7D
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791B23ED69;
	Fri, 30 May 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZYRHCM1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4E213E78;
	Fri, 30 May 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748634717; cv=none; b=RgFxWlHMDdaLrtSyIi9WXuqlskFi1nbfXibsHp5R4I9eY6UUvo8wIhyd56XXyoQQmIdIjJILeVH/uWkzLX/6SRWl5s1V0BAvbA9RCsKIeQ0dtyoSBQW9IKQFaKUIlVMXcm9gDHbY7TumnQeKD7KjdFT7cUlshbVK5Oirn4eHIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748634717; c=relaxed/simple;
	bh=h1vwi/RyC+UZ4DB7N0ebzDTcNRnkLkH/wUoGdyhSUHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZu3gt6B8GuAXYNKAnOrn3RKyALIGQ1/Ymtl0NC/3bM4Ibl75hIGTIRd23qJl2FzK/GZhigLL6JbXMdnTG0t//qhff6mHzZEBhAxG62jLkAN803cDcx7+wC95alpgF0rvxg6/6IRgZmtSv4AsaUuyBdobb99Su8Aa2HpQPvF/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZYRHCM1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so287663166b.0;
        Fri, 30 May 2025 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748634714; x=1749239514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1bTm55x2YHPx2PWXkKZWZjmWDSjseae9B+twvDPQJc=;
        b=dZYRHCM1P1S5uOszEWlfWutPmIzcATUdJJ/PCbOSJ806/Bi95UVdYzCarrNiTvTB8A
         C5IhMWOGlowrdYLcuI45VZar0sAy9Bg/jKJ2O7uT7esgKJu/ezL055uJOzqA86WrISdM
         JYA6XNE8vFnSn9g7O6i4nA0z19tkIu9jdljvhACFWENIZWkxow5ukVlXqWuByVPI68zf
         G6LYQcwlJKTRPbJH7vq2kVJACK+8k0SSoQgMhpX1IqHCnWqHS3ETOG0w5b1B+nb52De0
         HsAEyyOOENEAiiqgcjg28+fIveVJIr0gAKMQ9mG4+ZqIvbOnhEyUAOhglj5okvJ/HPE1
         lUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748634714; x=1749239514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1bTm55x2YHPx2PWXkKZWZjmWDSjseae9B+twvDPQJc=;
        b=uC9lGphBJJMhJkVcLaZxP4mIYzyzLHSV1b2CsYgwGv4nDmcHNTH3JKdjoRc0N/1T61
         EcQgXp1IrlxQu0ay5Wl2HZTAWedndly2gc9lDw4qiN9x4QH2DYOFAGS1M8z1YR+un/4/
         vh/vn4onbVK0f34Hb7m0ePfAl0QaOniki6jxwGfLGkES5zI8ZUWoMZA8EoMYOzjRsCgH
         jzARZYTEsxyXmJWywUNiMor/P2Tl0qQmiVpydsz6tvgP+KFNiQedZEAKfbve2w+hY8Ao
         WkyWgSqbxhBhAHaoKBTm60gWtuc83OGZFklhiv6CEW3YKDmy+DBe/vkFXN1rT6rG3NTG
         gTRg==
X-Forwarded-Encrypted: i=1; AJvYcCURWPMX0e1xcfmF/gal+v2u6f/8z4zmISx3lN4EYss7bczZniRxglPD0L9mijvwz7LVH1oBrRL6AONkIJrE@vger.kernel.org, AJvYcCUvBCoUENNFBKKf4wrrr6Q2zrQgTUYd3VEKmC28xjNg1GPRnU68I3WM68stECMZYP1JNP+jQHHI@vger.kernel.org, AJvYcCX5EpQltgGyYSLy5JQCXZp6El2VX0v4y2Ti+u3miD13Sod6QZNAtg8F0HyTWmlOdpxiUyz6OrzJMJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEc4Bokbh0ZvVZKt7T+E+z6aVBGKbhBRVovAYxRPQ6qLscnwy
	Znxlvx4HSPPCUnuX2RFlX/Fj0V12jCfWmlRK1pHm6m6Od8Xi/XuBwN2Fw6+SQJ5W17hjtWekbn0
	seTR0Pp2T8dm6UjPQI1vQEolH+aRydKz+OFTW3SA=
X-Gm-Gg: ASbGnctyELdF1X++WtSxkttNllmICXQYB9mE+iTSMJsx6Ui7VWeeYiA5Ir96avlO/H6
	AnZppLLGfx7U4Y7ONOVox6/MmCtg5LP7nWIr94jYQXpOaSVRDR4cDlCkh++L/+aIKWI8YLFudEC
	Rrup7WAKQdv6JA9KSu0SN7b0Yi6UJQShW9
X-Google-Smtp-Source: AGHT+IFnm9/l+FfpvwAvzjoQjryBXod5MID+4KyoaE1x1pREYm3Q8LMuGU8C0qRqQqfuHeHwXCHL9Ar+jRJWWnFZ7L8=
X-Received: by 2002:a17:906:36d9:b0:adb:3509:b459 with SMTP id
 a640c23a62f3a-adb3509b66bmr291824066b.19.1748634713720; Fri, 30 May 2025
 12:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
 <ed40509d-9627-43ce-b209-ca07674988ff@baylibre.com> <CAHp75VeAOFXuxsiAEwJ=dMJ8NZsyA7E-h4L=2ZgpprdUXU2EUA@mail.gmail.com>
 <67c33f11-0196-44f4-9cdd-762618cb88be@baylibre.com> <aDnwMDGDf3-KUb3J@smile.fi.intel.com>
 <6825fc30-d8ef-4a10-98ec-79ed303dd145@baylibre.com>
In-Reply-To: <6825fc30-d8ef-4a10-98ec-79ed303dd145@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 May 2025 22:51:17 +0300
X-Gm-Features: AX0GCFsAj8I7Zw9C8mwvgYPqnnfqSvfd9Y3x43Ewi-ghQRbpROjVq0lPwutlJX0
Message-ID: <CAHp75VcHqqu+gJA-7Kz+eFu_CCh13SyNmvUC0E2Rp3ucLhUmqA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 8:57=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 5/30/25 12:51 PM, Andy Shevchenko wrote:
> > On Thu, May 29, 2025 at 01:49:16PM -0500, David Lechner wrote:
> >> On 5/29/25 1:16 PM, Andy Shevchenko wrote:
> >>> On Thu, May 29, 2025 at 7:02=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote:
> >>>> On 5/24/25 5:34 AM, Sean Nyekjaer wrote:

...

> >>>> fxls8962af_suspend() calls enable_irq_wake(data->irq); before disabl=
ing the
> >>>> interrupt by calling fxls8962af_buffer_predisable(indio_dev);
> >>>>
> >>>> It seems like the order should be reversed.
> >>>
> >>> AFAIU the wake capability of IRQ line is orthogonal to the interrupt
> >>> controller enabling (unmasking) / disabling (masking) the line itself=
.
> >>> Or did you mean something else?
> >>
> >> I don't know enough about how suspend/wake stuff works to say for sure=
.
> >>
> >> I just saw the comment:
> >>
> >>      /*
> >>       * Disable buffer, as the buffer is so small the device will wake
> >>       * almost immediately.
> >>       */
> >>
> >> so I assumed someone had observed something like this happening alread=
y.
> >> If an interrupt occurs between enable_irq_wake() and actually
> >> going into a low power mode, what effect does it have? I ask because I
> >> don't know.
> >
> > To be a "wake source" means to be capable of signaling to the system th=
at wake
> > is needed. If an event comes after enabling an IRQ line to be a wake so=
urce,
> > that should wakeup the system (independently if that IRQ line is disabl=
ed or
> > not on the IRQ controller side).
>
> OK, more clear now.

FWIW, https://elixir.bootlin.com/linux/v6.15/source/kernel/irq/manage.c#L88=
7

> So I should have been more specific with my previous
> comment. When I said, "before disabling the interrupt", I didn't mean
> calling disable_irq(). I meant disabling the actual output pin on the
> accelerometer chip.

Ah, in that case it's of course a different case.

--=20
With Best Regards,
Andy Shevchenko

