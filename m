Return-Path: <linux-iio+bounces-13115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFE9E5C4F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B780528611D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4C22256B;
	Thu,  5 Dec 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoAn5TRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E320C468;
	Thu,  5 Dec 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417772; cv=none; b=fJqBZ1fk90rVft1wX8fRiLZSZ2MN/C0YAknFDZZBfoFhSoS8AkrCn7V4rT1+pTVHMb9eVPQBjhQ5d3HuEesF5dzLKXYFoCwmObl8h6NBKmYN1J8rhNgX9FGkR866qzSurL6s+uIlaqktxmw9xXHPscyxmDX8fj17IEq+LfJm+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417772; c=relaxed/simple;
	bh=4M7hbK3J9OLNDiF6fL3lOhiEDF68to06VOBBRxYM5po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsFgK1BMxuMlXkKl4qmroG/UAir3tB2zWOqNNjDGNMO/N3y5HgsFwThEgamEHo9oQ7MWwmBEZumENQT/HOvUZMmBguU8nLAe48qFdppeC/nF3wOLk+I1dW0lrV2ya3xzFc+HETf58K18ANCT0UMnqoMpkvN/iQQXr7IxUL2s7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoAn5TRY; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef506dc6daso395317b3.1;
        Thu, 05 Dec 2024 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733417769; x=1734022569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHCDoWKd85bJct1KY5n3eYXYTwTu+eTxR+vTy5I6ktc=;
        b=hoAn5TRYV+8/wzKebrHGlGqmkokqBX9SHL3nR42V62MmgTHvU1hf9FI5gTzrYtKVkx
         NTXfTlo8dVa8Cy3zF9ESuV1hAqEyqKKOFqeIMPtrVCdfqbzPjEudUhPke+gggPeBwihi
         C8yc9KzKFdHHYkrVfq8BhiHbnR1yYwilzps6896szr47gNSZi9HljuPJOwGAPQdt5/Cf
         pWNOqAe5l2U2KxLp07QO/ODRpSkPSPugdUB+G3OFv0NcllA+AnYTh8hL4hFubX1duwfq
         wRFettqS3V0rn8AoX9nnn8BbjZQKzHkJsV3WC45y+eKcBk0yPdruCuW/VDBd1TLAynGf
         XTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417769; x=1734022569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHCDoWKd85bJct1KY5n3eYXYTwTu+eTxR+vTy5I6ktc=;
        b=Ir8859iSvL9RkDfmNllxRRB1knhMFQt1r8R7MiMjVUkf5l1BhrjvErB2D9ctHH84JS
         zhOCXw3bzdIm7BI+Z4K7fzoApCRQCtVG2kCZh68cyoRwOMKEvRe2NtMm47IZJj2YtLqo
         xwLx61hdXkZMxVuP0H0db2MJG+OY+o6Q/bqsZ3X6+ikBtpRCf50xJ0d/kh/EnR68MWxw
         H0uXU6nN+ys6rasa7eu9DZQhsBnM+XZVQZfHpC+8oPEFyhAo7vc+/BdrYcWMkrQD9oaS
         T6uAoBCWzwN7PJbRryQGxpgRYyGrMyZ5a5ftZHULb4DxIQ/JIR/gS0ZoSVdfRWodU259
         ecEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6mI+huHMu+kV7BJw3/PqNvLtQhyFgyVLNKHJQUYQsHojxh5yIbbEM2MtRJiiuWA0O9LHKVsCJ7iFm@vger.kernel.org, AJvYcCVvcZmsM9VYlAt1PXtD4UYusM20nKmrcafw2+HP1UO5h41ixa8c9pGhHuj4dsce7zAXL58VthGxzaASpFSK@vger.kernel.org, AJvYcCX6S+3ry8hVbXLqGyyz/W2jT6DiYKD9SUsUbHcf5IDctnT3TmgSB6k1g9/ih/hZSONpI2a/uKAup58k@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/bkXk/7UapMOHcLMO/YE1oOsD4yKnjzzgox4C0LsXuTaXrvy
	GginmW0xlLQRBTbi6X8VTbdTxto6BQ8KzL+uAVNqUQP+d7j3woxp2aqC1usoQxiEDWpwyxasWWf
	pPB9mhy3WxQq27Vu+6ZxEWRyE4Zo=
X-Gm-Gg: ASbGncvNSN501lfFOfbrkIlvgFkbKaZXgJM5pk7WuQt5amIJzgUwbUcybzPdF/bO7BS
	qTP3WAsHuCqM8FiEQxsFM9moV31Q2USw=
X-Google-Smtp-Source: AGHT+IEjg4f8Olmv1YAKtcuOtNBkdcwgg1Ho8yntikUXZ7xFoGmYOIJbU3B+YWDuXhIxvPC56TAvojN57EVpesWovrs=
X-Received: by 2002:a05:690c:6e0a:b0:6ef:6b56:fb3f with SMTP id
 00721157ae682-6efad2fc2e3mr53961257b3.7.1733417769399; Thu, 05 Dec 2024
 08:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204182451.144381-1-l.rubusch@gmail.com> <20241204182451.144381-7-l.rubusch@gmail.com>
 <r23e4axzdjn423yl44lv2sjprywtjymvgramrrfoc2lv6ebeui@hzbm4ilbyvhw>
In-Reply-To: <r23e4axzdjn423yl44lv2sjprywtjymvgramrrfoc2lv6ebeui@hzbm4ilbyvhw>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 5 Dec 2024 17:55:33 +0100
Message-ID: <CAFXKEHYEyTHX+iDR+sCY9n4aPgWkZ9qMENbSq-ohMWWNUq1REQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] dt-bindings: iio: accel: add interrupt-names
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Dec 04, 2024 at 06:24:47PM +0000, Lothar Rubusch wrote:
> > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > sensor. Only one line will be connected for incoming events. The driver
> > needs to be configured accordingly. If no interrupt line is set up, the
> > sensor will still measure, but no events are possible.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml    | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.ya=
ml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > index 280ed479ef5..a4c2cefe1a4 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > @@ -37,6 +37,15 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  interrupt-names:
> > +    description: Use either INT1 or INT2 for events, or ignore events.
> > +    minItems: 1
> > +    maxItems: 2
>
> No improvements, no responses and according to commit msg you have only

That's not true. Indention was now fixed.

> one item, so instead above and below just:
>
> description: .........
> items:
>  - enum: [ int1, int2]

Yes. Unfortunately you're right. I was not aware of the [] writing. Much be=
tter!

Sorry, for wasting your time with that. I learned to not just
copy&paste w/o running the lengthy dt_binding_check. Fixed version is
coming up.

Best,
L

>
> Best regards,
> Krzysztof
>

