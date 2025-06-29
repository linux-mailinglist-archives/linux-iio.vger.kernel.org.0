Return-Path: <linux-iio+bounces-21101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D0AECB7C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 08:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99033B7850
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 06:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA61C8630;
	Sun, 29 Jun 2025 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEPzVRto"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CB2F1FE2;
	Sun, 29 Jun 2025 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751177248; cv=none; b=dGyXLaV8vbvuFt0Ko6vA/n5Vt6vi+uF7uu+QWuLfNlapaXod83pyrkGv3uyn6Gt9FCx+6gkmtOcWg0bfjoJ17Vo1Q6IV/oYE2DQxEpg/HdxtNhUZp0kzBCFyHFDt1P0Vvtze5xiZAx6vm6LOeKK7TMNgJCVDXZF6p0tKlxpg4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751177248; c=relaxed/simple;
	bh=bYqFLIZXsb6gcCjNpM4ym14FGTm/+NRkiOkxq8se0OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arjEZIym67UBnKndbUB3CF1Wfacz9s2GrHTgtCgRXYPXmbnaFqiV8OQ90cpZzXrLEDqRybUjNx556Ih/JBlz9pwBAE69d1NPcCICa2U+gTKS1aFmBAxA3Uqol/ohtcouC//inVOqVJuWkh9EZTQAwEM8wn9bIabrh4mW4+G66LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEPzVRto; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae360b6249fso311667466b.1;
        Sat, 28 Jun 2025 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751177244; x=1751782044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYqFLIZXsb6gcCjNpM4ym14FGTm/+NRkiOkxq8se0OA=;
        b=cEPzVRto1UOabtTqcg4EPqg9XApWlGDsyXF/BXzNyqkJgX4ikKi65VUi9dPpcK9QWu
         4UcFVU3tkcnzFo07kbqXJGqnVoksBfr1hipwSVvWZHY2S7PuE9j69yPypbJRSn4DVHxA
         f6QvvNGQlprGxKVUOPJHYkAKfCYJK5YUDko/tJOIKO1Ix84lWEF3jLPVf824ayo2YW0R
         PER/3oFmM2Dy8eqezEQq2Oy37hDxrzNViZoE31qxBkFs4VBxrju809JA52lvyGtxWbNN
         0kboyEnOHiK9G2ylhId8rgkTqu3Byc41s/wVUsMGsNFaT1qKnmXYA8vwE7kBnQudyBnn
         Ty5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751177244; x=1751782044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYqFLIZXsb6gcCjNpM4ym14FGTm/+NRkiOkxq8se0OA=;
        b=AnRp/E7xMYNDSbSNxZmWYPMF+K70C50xHVRAMccyBfjjyD3bZMnx8SfjfYMEITOO5M
         XH/Pfap6MPDVnw4IyljotK/t4g0ixKUQ4jacgsgaDV1kalwSv/khUiaBTJK1X0IwHEag
         GbeBO3HDxrXf1U7QCfrUwgIFk9Bgis1PoUqhtfAJfCJk0Z2BdNSvQl81OXyAr2OFK+pY
         xolgwXisdwcZLZYimGWDGcrC8PE24SoWJQCwCz1waZaGAJp19tT7aBvBRt6deIvNj6qV
         pPJHkh5bY1dxdpGz/0JIdZYL/8GjpPC7Idip/esavAKtoW2H5/+ynmAC4+1RxzFfbRHd
         Iknw==
X-Forwarded-Encrypted: i=1; AJvYcCUcfyIvxqpOcQY/JffjN32oO/sIGjcc2/XhF2Olo5fYoI8soyTxbdEfjeZSRl2WPURg/Y10NpGltMHR@vger.kernel.org, AJvYcCWr5AIjEub6/2xxCxSG9y1xSf7G1bCNCgsywVYuD1RizehSCoRtiCC1gC03qcxh1p4AghG8Eo/XXxOB@vger.kernel.org, AJvYcCX2BC4fSOjHGgN1XY2d9g/41SYr9mvXe7fl9GHJmsL66O+kekiOyjPaP51B04ykyuY9n+KIw0tJ8OvH25zl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9w4PVMCs9rjAMyfYUl9V9ghOsR3Unfqg0ZxmdD/Ih2BSh0BBt
	+b5dYeqXumCw80LpbZiXblqpAgpfrj/k/9tftFuXmwsMmP6SQFTkHBvLjMbn1/nJvuINCNmopPR
	XVnxjt26rF5atyz5yQJpRN6o4H1IXXZQ=
X-Gm-Gg: ASbGncsNfdXVnV6kprZj9xotNgGZmeVyAfTgpkXoydXgzHd8kt6WWygH7IEIa96FHXx
	1WWSp66AK7lMXfZTNaksbtH9codxrXS7O/FyzU8U7sPAtSzA87Cx0AY5zwlWU8zN+JymZFa1C+/
	k1qAQdDq5rrpT1MXLZj83unEMfip+lbbz7XvKCUVfafoQ=
X-Google-Smtp-Source: AGHT+IEnTPCkfCXy5RpG7VzM6+fV40PQh3ojV3JzWLYMESorgVr+L6P1UFXXpJiOWxGusVb2i1ZFPFWgdcNOisQLw9k=
X-Received: by 2002:a17:907:2d2a:b0:ae0:cf2e:7ea4 with SMTP id
 a640c23a62f3a-ae35013e822mr817558766b.40.1751177244064; Sat, 28 Jun 2025
 23:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614091504.575685-1-sbellary@baylibre.com>
 <20250614091504.575685-5-sbellary@baylibre.com> <CAHp75Vf=zQ+pdo5V1fAq2qWEpdUfNfWdO+_iW0wETWSniXisyA@mail.gmail.com>
 <aGB2Fnv797Wrenza@dev-linux> <bd72b92e-bf8d-4fc2-84ae-4f9fd8b40c37@baylibre.com>
In-Reply-To: <bd72b92e-bf8d-4fc2-84ae-4f9fd8b40c37@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 29 Jun 2025 09:06:47 +0300
X-Gm-Features: Ac12FXxwQIYGmywslgGjo30dyPQWONS3FKJr5MJU9wnK_Hf0D8V8jkMkpBgMSr0
Message-ID: <CAHp75VeXxPum242gE8NoC9f8ZKkFg2FTAkmBXvY9m-BNz6+i7g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] iio: adc: ti-adc128s052: Add lower resolution
 devices support
To: David Lechner <dlechner@baylibre.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 2:30=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 6/28/25 6:09 PM, Sukrut Bellary wrote:
> > On Sat, Jun 14, 2025 at 09:45:43PM +0300, Andy Shevchenko wrote:
> >> On Sat, Jun 14, 2025 at 12:15=E2=80=AFPM Sukrut Bellary <sbellary@bayl=
ibre.com> wrote:
> >>>
> >>> The adcxx communicates with a host processor via an SPI/Microwire Bus
> >>> interface. The device family responds with 12-bit data, of which the =
LSB bits
> >>> are transmitted by the lower resolution devices as 0.
> >>> The unavailable bits are 0 in LSB.
> >>> Shift is calculated per resolution and used in scaling and raw data r=
ead.
> >>>
> >>> Lets reuse the driver to support the family of devices with name
> >>> ADC<bb><c>S<sss>, where
> >>
> >> I believe it's incorrect, i.e. it's something like ...S<ss><?>, where
> >> <?> is something you need to clarify, and <ss> is definitely a speed
> >> in kSPS.
> >>
> > Thank you for the review.
> > I am not sure about the last s in <sss>.
> > It could be TI's silicon spins versioning.
> > I couldn't find any information about it in any of the datasheets.
> > I can drop the last s or mark it as <ssx> and specify the first two <ss=
> as
> > maximum speed.
> >
> I have a hunch that the last digit has to do with pinout/number of
> power supplies. adc128s052 has two supplies V_A and V_D while the
> others only have V_A.
>
> If this sounds vaguely familiar, it is because it was discussed
> today in this thread [1] that Jonathan CC'ed you in. :-)

With all this being said, please, switch to <ss><p> and describe <p>,
but with the caveat that the <p> is empirically deducted based on what
community observes.

> [1]: https://lore.kernel.org/linux-iio/20250628162910.1256b220@jic23-huaw=
ei/

--=20
With Best Regards,
Andy Shevchenko

