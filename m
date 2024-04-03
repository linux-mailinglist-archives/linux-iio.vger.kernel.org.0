Return-Path: <linux-iio+bounces-4028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B38973E4
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994F428B7FD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDF414A098;
	Wed,  3 Apr 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oHpR8Fh1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4D149E1D
	for <linux-iio@vger.kernel.org>; Wed,  3 Apr 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157760; cv=none; b=NAuAklMlW60DVyFr4tCq/msD/4XNfg1dzEr0zQ1LweCdmUoUSf2H/v35gm2rS7+jQwZNKe4SKTdbbiI3gsdmY3MEfAwcIVM8uGfotcK3XJ3yR6+l4whGoKKaqpCyyn7KLrBPkCn/P700FRZn2SYajB5ZzR1F4TNsljrsucW5ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157760; c=relaxed/simple;
	bh=+euYMyeiV2Y357ZoVmZYtuw+AONkDMoF2no3e3eLI0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfJ7HXVy9m7yJQ94IKjq3O2q5lXlpjcsgPBXhPsWq04Kfj0Q+pZ8Hrn06MDFkJRNz03TlrGTeYOUaBqLEpuE1uh2wz8OMOznV/jWeiGdURdvDkImbzgqCk26wVNjZY3flbelooPcg5ciEr7eCsIfOt2DvnWvR1GYDHphch9jtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oHpR8Fh1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so96796891fa.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Apr 2024 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712157756; x=1712762556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AhMCAZ2/eS3a0ixlKk0nZZhuoVDu0//HBZjMJIcZVA=;
        b=oHpR8Fh1docopGaELBgDA2FoPtiw6BZKeRyJmkJIEyIySRqPxDSbNltoO+SJTF+WE1
         dp41BrsxBu7TXsw8Gq0LxtuQRDAPWherWns1t6wB7ldi/FMs7QZHd+ZexG49umPu1auV
         v/3jPk155UWyTUI3PHv3Kv/Us6030ITCa6l9nf/ZGSKK4FlydANYj2ek2lhAlf8who9Y
         CBnZBjWjA/VARK3DvwSVYTXoX/VhQfKvuiB11HmzqRBfvUK687dxzkjybHNLnrJDOp6Q
         Igcv6qAA61WaPNKhtbRhfiAtTAJhROlzsHoUh0oIfgARE7yObI54FuiCADgJZ1y6oood
         bMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157756; x=1712762556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AhMCAZ2/eS3a0ixlKk0nZZhuoVDu0//HBZjMJIcZVA=;
        b=fy61bHPCcxaabi4IyS3CaGZhYCS+ZSa49kCZwhdamRtRM9T81jTq+UBIA1LlFL2YOG
         p2WhNk3IKOOKgmLl1ymAnyBNFrshTdSPPxS5GbGeedJ/N+B2kBlal4YfW3Bm8xfV9zSM
         OERzZYyOtUC1988Dcsmz65U3InKLzgKpAE0NmUwi/roIzBhh40FotgEBFJz/p5G2CWNz
         4+B85BAxtuGqSDnSNknzOTPSil5sJWiKEmczmL+eNnxtAgeoydO/IoMbz65tIX54Jl4k
         I68hSunHLoNpNXNXYPQl+7cvBTYPsBZoal8SD1cCX1XCJbMckxsxDiUW4tz2lWwJoS1O
         jCrg==
X-Forwarded-Encrypted: i=1; AJvYcCWrGWDzd8Lpfhixfqm6irxvxy+HwAxtFJPNV2ud4/5cItqEwGbLI0PqUSQO7hlZfP9kQ4Fg89zH3kafG6kLTJ4cARJl71I+C34+
X-Gm-Message-State: AOJu0Ywn2TaRwG7ool4kWCR9t0jcN+gi1i7/aJRIO+b8nk7/1BtVZlxy
	xmbl8rb4ePthUGg4HchpQF2xW50YNfASLBSKtNlpV+o02SCfe2KbKiy5XES8Al0MFY0avLJSgUY
	DM31Ko2JRvToiz/yIrnZOQ6/w8nHH196QhFvLqQ==
X-Google-Smtp-Source: AGHT+IEnQhiOU4GX8bo/SHle2zD7mlsLc2kj8YUFjmP2SJmtJ1ZEfMbLwzQksNssblYF4Mup1RfvHNNasQpvSQ89XV4=
X-Received: by 2002:a2e:8417:0:b0:2d4:720f:6f46 with SMTP id
 z23-20020a2e8417000000b002d4720f6f46mr1955414ljg.15.1712157755978; Wed, 03
 Apr 2024 08:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com> <0a72de29-6d25-4d2d-9824-ca407af69153@gmail.com>
In-Reply-To: <0a72de29-6d25-4d2d-9824-ca407af69153@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 10:22:24 -0500
Message-ID: <CAMknhBHhxi7mN88+peU7BGkzSP2vtipCuvM-XfQzgusqKvARsg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:50=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
.com> wrote:
>
> On 02/04/2024 00:16, David Lechner wrote:
> > On Mon, Apr 1, 2024 at 2:37=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >>
> >> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> >> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>>
> >>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>>
>
> ...
>
> >>>
> >>>      properties:
> >>>        reg:
> >>> +        description:
> >>> +          Reg values 16-19 are only permitted for ad4111/ad4112 curr=
ent channels.
> >>>          minimum: 0
> >>> -        maximum: 15
> >>> +        maximum: 19
> >>
> >> This looks wrong. Isn't reg describing the number of logical channels
> >> (# of channel config registers)?
> >>
> >> After reviewing the driver, I see that > 16 is used as a way of
> >> flagging current inputs, but still seems like the wrong way to do it.
> >> See suggestion below.
> >>
> >>>
> >>>        diff-channels:
> >>> +        description:
> >>> +          For using current channels specify only the positive chann=
el.
> >>> +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0>
> >>
> >> I find this a bit confusing since 2 is already VIN2 and 0 is already
> >> VIN0. I think it would make more sense to assign unique channel
> >> numbers individually to the negative and positive current inputs.
> >> Also, I think it makes sense to use the same numbers that the
> >> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> >> positive).
> >>
> >> So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10>
> >
> > Thinking about this a bit more...
> >
> > Since the current inputs have dedicated pins and aren't mix-and-match
> > with multiple valid wiring configurations like the voltage inputs, do
> > we even need to describe them in the devicetree?
> >
> > In the driver, the current channels would just be hard-coded like the
> > temperature channel since there isn't any application-specific
> > variation.
>
>  Sure, but we still need to offer the user a way to configure which
> current inputs he wants and if they should use bipolar or unipolar coding=
.

From the datasheet, it looks like only positive current input is
allowed so I'm not sure bipolar applies here. But, yes, if there is
some other variation in wiring or electrical signal that needs to be
describe here, then it makes sense to allow a channel configuration
node for it.

>
>  One other issue that arises is the fact that we will reserve 5
> (including temp) channels out of the 15 that the user has the option to
> configure. While the binding will configure only 11 channels for
> example, the driver probe will error out with the message "Too many
> channels specified".
>

Surely the driver could be changed to fix this, if needed. :-)

