Return-Path: <linux-iio+bounces-23397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF7B3C2E1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECED582B8F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC3239E6C;
	Fri, 29 Aug 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFp9jkIt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F286238D54;
	Fri, 29 Aug 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494714; cv=none; b=CENS/XBhTuJNatc29+YPAiLGF4MRZJGyAwnN1vj1lq75R5FVH0970sM0dwfASnSxpqsuo1FMB8N3dHOfZHpR7IcrNK63wEcGRaeGlRUUxSEpHBRPut7xqg+k1QfmbbVM0M6yZUbf12/a2Ilr2o/510tdzqJ5UAp4o/l4WQgkppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494714; c=relaxed/simple;
	bh=Fuj6D0zW+DGqNmXsWTSh98hjxolyVyCn1KRczDru8/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwf0G0gFo8C+jzxzJSgn+cNw8eWGtVe8PiZ3OPEsvQTFKd2ckYvD5Hf9n6AjncY6PsnkS3FJQEr/jI+FiifL0vqhffhcYuUaAmf510TTBimbJ8p5IPUeabtDbbJzT3IbAAX03zGvOlJZO11Nm7e16mK76w1ozpr3caXwh5WXu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFp9jkIt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afeee20b7c0so305440366b.3;
        Fri, 29 Aug 2025 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756494711; x=1757099511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KrY9Cwk2A6SDLbzKOA/S9ShMFQemtMswFHSYX9H3MQ=;
        b=DFp9jkItqraztkoG/oH5fLGTCYivNWq7wBJjNJVjCUCVPXGwXGyYo22A2Se9agF9PS
         ZEFSA1o7L3FOow+POHdEiT8hrRbkEkqrpyaT7yx5tERVMJADnRkOQKpOjbXrZcCOX52Y
         a8djwXrRo0DHsjnKIrqCoZTjUFdYF4+hbL/ezRUzJ40XqAGuy+2ow5e4GozFS4AsW36B
         fcJ40Fpww5UXLv/hmcBDdOn0vi7djsstRIOqeTBDx26KwOaFkjy2iq6hpfAcHOabvG35
         2vxC1HPteSn/UDudorJirTT/ni+eNCAhhayn9TmAFWoxnOIH/5r6OB5R51c8D38it3HN
         tmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494711; x=1757099511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KrY9Cwk2A6SDLbzKOA/S9ShMFQemtMswFHSYX9H3MQ=;
        b=l8Y6TNrYtx4INKJivoMpldELAno70Ztm/DwzZ9MM9SPA9z+gXMDG45OhNhD22TeZqC
         lwLdp/FF0QtxNXn2XKz+Y0InAX8FsV9wqqfWt41zI5DK/Wx9HMFAvx52BBo+4P83zv8e
         KgJak0rh1KP6gJkr/0Gif2WSfDO03UlWelWeMF5Cd6s/60IC26CMzEGt1/vwShdNAt0n
         52/Bm/YGN1W81lpCYNiBDqXjaXmiQvUxKIwArsgBOI7sMyEZ4MQYBAaWl/nCNNrbOaOR
         OMOgrtcb/x+FonmPCebPJzszGWD83IgcgVNAg/lwHBSEf512s6x0EvvOqd+0Rb0SnfDz
         E1UA==
X-Forwarded-Encrypted: i=1; AJvYcCUYi/PecOElsxK0hLP7CsWY3kq9XJO6lxcFeLTBZvFZ5IRwSFWJQGvGeVOCURvnbSu8X0Vk6CZBpW5FqGs/@vger.kernel.org, AJvYcCWx9vIHaSJfbvzsIvPAleobJOU8LB3UoDcRNN9WGxO5ufmqtVm24x1qa4JtY3XU6WDTglxRO7d7Gqti@vger.kernel.org, AJvYcCXQuFppz0Heur6cTZ/xPjl35oNc4KDfJ0nCa1QzEoFm2zotf8Bk64dN+4B+sx5s9VqxOhqsCewdfq1W@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6SCoTPGz6Ncw/AOLAFeIyVsxSdrs6DvDG4HWxe2ddX+9+2MU
	EJAhp89sMhGwQvhhKXAaFMau6kXP+eZKf4olrai3tiic0qAFyXWGGLNdkRJ6A8AOlO6ExefgSNw
	4smixCj37UQgYWCUG+3ajz0y2ggDU/VE=
X-Gm-Gg: ASbGncsLNcMtOcHPfDNId825v6lCCy/VN/CZSCBKHOMda2CNWGZnkjC/b4PDD5A0OTQ
	SBvy//XjspBInCjxb7GmVm8kvJiFofhGpe/MiDerzNnQQBNZOfEX/B/fZCE/iR9MMxDETSmoe3l
	rx/k5YYira9D7oCfc1mugYBqL4hWVlapORuiax4TvwPR4RZRvc8u2u3qfEf1EP22zAyIMRINyhw
	/ruepLYWkZ+Vqe8qIA0tu3vMQZD
X-Google-Smtp-Source: AGHT+IHoLfOYIGXesMOJz7PlMIWE8EucCQX6fHarlka2VTVEP4xLnkqmHESieocix4CFJxHjmjzYogGgzh9h96yewgM=
X-Received: by 2002:a17:907:1c92:b0:afc:b617:de96 with SMTP id
 a640c23a62f3a-afe2963b638mr2378979366b.49.1756494710438; Fri, 29 Aug 2025
 12:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
 <20250828-iio-adc-ad7124-proper-clock-support-v3-3-0b317b4605e5@baylibre.com>
 <CAHp75VdtQ8vKULomgqPxwX=WZWUde7PC129BEznYqefd-U4DEQ@mail.gmail.com> <a20356ca-05ca-4c99-819b-4b278e799f2a@baylibre.com>
In-Reply-To: <a20356ca-05ca-4c99-819b-4b278e799f2a@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 22:11:12 +0300
X-Gm-Features: Ac12FXxOhkvK29FRssLfGKIp7tr3Tyfrj4DQU3WAlTOm9wwu2MUZHEFn0xlevUM
Message-ID: <CAHp75Vf8fAFin1tJ-yjr22RPuDgBEBnj6JO3GkjDcZsmYoOfYA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: adc: ad7124: add external clock support
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 8:19=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 8/29/25 10:53 AM, Andy Shevchenko wrote:
> > On Fri, Aug 29, 2025 at 12:55=E2=80=AFAM David Lechner <dlechner@baylib=
re.com> wrote:

...

> >> +                       if (clk_hz > MEGA) {
> >
> > I read your answer, but maybe I missed something?  Can we use (1 *
> > HZ_PER_MHZ) here?
>
> I suppose we can. But it doesn't add any additional information.
> We already know we are dealing with Hz because of clk_hz and 1
> is implicit. So it is just a matter of style preference. Since I
> read a lot of code, I tend to prefer the minimal approach - it is
> less to read and still has the same meaning.

Physicist in me prefers pedantism in comparison of the units. We don't
compare kilometers with kilograms (maybe not the best example, though,
if you understand what I mean :-).

> >> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_SEL=
_EXT_DIV4;
> >> +                               st->clk_hz =3D clk_hz / 4;
> >> +                       } else {
> >> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_SEL=
_EXT;
> >> +                               st->clk_hz =3D clk_hz;
> >> +                       }


--=20
With Best Regards,
Andy Shevchenko

