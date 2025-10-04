Return-Path: <linux-iio+bounces-24718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA5BB8EE9
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F2E3C7B87
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210EA2153E7;
	Sat,  4 Oct 2025 14:33:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87D20296E
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588403; cv=none; b=d8wr/zcH5+Uw7guG50ztxjoMV2wNBNIzk0kskFtsooM6fWbwnkmef0EHMgyptAAxTXUfrtvxCMq8idIGbe6bhlnkTn+TfquJDOvJp2Uq8kmigBtgEP7ghu4FUzC7eDMvU6d1B1zjY0za3o0h5XaPhyBTcRQ1Kn5B3GPXCkmoyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588403; c=relaxed/simple;
	bh=0J55Y2HmqgcnbS+RXB3tiJFIIySx+Rr5EZpIa0gAB24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhRIE4ScUzIXobCskHJzsblBxe6snTCW3SjkaXKaGChat8jk6dpQUYrrOQ9VQ6U88a64Iu6hPxZbGQF75OWHNuXLrNDZTQLLAZd92Z5hH36tfX63ODaQYy0fE+nJK2aJJ4BUePm/il9fbHPzxEv2XLVujdxC+qH9hzbmT51qRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so1963334241.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Oct 2025 07:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588398; x=1760193198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xthzmHjkhKJUrri8Wf1E3AifPP/ZxbkaJDpboT1dzM4=;
        b=SK0/wRH8S/4kY9ZIaqU64HNXG4jMc4buzPxFuC+g+4oMjOwMkSUUTUVe6jPdOrg3Rw
         k3EATeZDsFo+eHV24BdsEzkiMEqmuao7N6Cr9gsR5d5sanJBXyTG9RWNiIEvspcaVjCy
         4bprGrpoQ5BOGIPuILI3L53jGTobj4Cp52QWSHzt0DSRxhO/UqSeG8V6wRwUEHuZw0pE
         bFzdiekQm2o6riIKVD6COV4JNGWqwPW0Em5W6GtzQNnF4tZBb1aLsBP2/0g2d7viscCH
         VcQkY0+pB6uz7tlprlRXA147LOASoUdSSvXYza27dAYtwFoaVjOf5Ryx2Xmzay+ydvPR
         aDsw==
X-Forwarded-Encrypted: i=1; AJvYcCXCwTJC11psLJ6xlyMWmSTm2VCJtLq5M6hXJu+0r6y5MKQOsEksyi7tHeCGCZexrdbiwtY6GuAe44M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Bo4RB4/DRVBZpKkWuAy/GjfwF3wjh7JUeo4pW2kO+UWgomoO
	gUulcOl2y0QoGs5Dq82fT4/3CAyerJ3Ypw+ZYE9ZasKXjZ1r+yQHgrTPly6psQ7U
X-Gm-Gg: ASbGncumjO+bPDzezREP/hp85Rl41hoyYhkIcXVIfvQZY7Wl0ADVnp7xxqygSXgd6os
	sxwg601maIjJC3GgGF94/hEg0PTRnPohA1L9ZYUIXtOrnRH7LNkxjxr2EVz4flyuGVhvrmF++Fe
	S16KYa3Z/XLARmVud9xiDTPBSB46UBc1xAeX/gg/EJT9TgnReD5YzQtrCtLAF7OXqtyVHjJEwTt
	JzSQNQB0JWWgNtj97sOC+sEse40gHXshUk+/+b1Y0lJBGQBfngv/CiemOMBLSTzSK0lh9guHCB/
	ojzSDHXAgjLdFndMH8frIU0Gkw6pScQcjO8ETN9q/x2t8Er4YrFCjS9Oi60+rGQG4pZp3txnqa+
	0qs/mp6u+EQyXiKS77sp2qVDcNHiOKZ6BzoM0b5xOI1ILA7da8uuCQnu9k4D7lqbYfa9buKY7Rf
	YhzRE+5PAh93a3W9tXuZ4=
X-Google-Smtp-Source: AGHT+IFwlYXguZXLitTWBe+hw412PHrRVIVRm4D87crssWItVNq7J+qvIDtBDflU7oJoWv6Lj1QxbQ==
X-Received: by 2002:a05:6102:ccc:b0:5a1:7bf3:4d05 with SMTP id ada2fe7eead31-5d41d0dcaeemr2767244137.18.1759588398371;
        Sat, 04 Oct 2025 07:33:18 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4c5d697sm1860692241.0.2025.10.04.07.33.17
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 07:33:17 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5c7fda918feso3440689137.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Oct 2025 07:33:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKV4lGhYthAJXR6PnBDEGZ7CyOyfsG+OPhBtA2sZCLozNoRH0mslEu+AYOU3y66mfpQ0lU5MtsaK0=@vger.kernel.org
X-Received: by 2002:a05:6102:291f:b0:5a2:668d:f20b with SMTP id
 ada2fe7eead31-5d41d0dd17bmr3054407137.16.1759588396956; Sat, 04 Oct 2025
 07:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com> <20251004143901.505ec386@jic23-huawei>
In-Reply-To: <20251004143901.505ec386@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 4 Oct 2025 16:33:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+V60pZSRmu6SjeBNyi_0+Un5pXjWDLDDBt6UbYfTmeQ@mail.gmail.com>
X-Gm-Features: AS18NWBkap4dmgI1LydXdtTPg0XGaFgAjq5oqq5cMsJWqAup1M73smsgPeqmT7I
Message-ID: <CAMuHMdV+V60pZSRmu6SjeBNyi_0+Un5pXjWDLDDBt6UbYfTmeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Oct 2025 at 15:39, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  1 Oct 2025 15:23:10 +0300
> Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
>
> > Add support for the A/D 12-Bit successive approximation converters foun=
d
> > in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> >
> > RZ/T2H has two ADCs with 4 channels and one with 6.
> > RZ/N2H has two ADCs with 4 channels and one with 15.
> >
> > Conversions can be performed in single or continuous mode. Result of th=
e
> > conversion is stored in a 16-bit data register corresponding to each
> > channel.
> >
> > The conversions can be started by a software trigger, a synchronous
> > trigger (from MTU or from ELC) or an asynchronous external trigger (fro=
m
> > ADTRGn# pin).
> >
> > Only single mode with software trigger is supported for now.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Hi Cosmin
>
> A few really minor comments.
>
> I might have ignored these or tweaked whilst applying but looks
> like you'll probably be doing a v4 anyway so I thought I'd mention them.
>
> Thanks,
>
> Jonathan
>
>
> > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> > new file mode 100644
> > index 000000000000..51d1852d814d
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzt2h_adc.c
> > @@ -0,0 +1,309 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/adc-helpers.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +
> > +#define RZT2H_NAME                   "rzt2h-adc"
>
> I'm not a huge fan of defines like this as there is no inherent reason th=
e two
> places it is used should take the same value. If you feel it's really jus=
tified
> then I don't mind too much though.

I am not a fan either, as using a define in the initialization of
platform_driver.driver.name means I have to do another grep to
find the actual name.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

