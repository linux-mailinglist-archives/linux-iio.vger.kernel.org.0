Return-Path: <linux-iio+bounces-17387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE8A75D8B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 03:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE94188A2CA
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47590250EC;
	Mon, 31 Mar 2025 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyQlIXyO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E0FC0B;
	Mon, 31 Mar 2025 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743383516; cv=none; b=gwOfiBVJ0P1We0lGs/PgJ1z6VEKw3pDPzrXefNhVxdj0sspU9rUulJDJeVScKBpcmP0/W1Ycqym868ggwJ4Yh76/S9EvPJ9h+NiRl02xjqxHkrinNxc3kzyf1RAxGORBWNjU/rxIYRK/UThUbpqf5Z3xky/LRf5E8yzVrajA1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743383516; c=relaxed/simple;
	bh=llIt1sHk3DMGpSKakNbpkS5swEFDulAnALpd1CbsWK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAHg7PMDdw33zs8qqkAbcg0E9ukI9QtWTKSLAQk2Sh16SG0cvQ/WmxD3GKqfhoEX6CC7UyQetyrogHye19w26uKe/3V86+GbD5ioRoxkvVoTfVuXjd2uy6IPQQgt46hIPzy8/QR/GBrp0RmnI2lAmZfAAerKYXj8rhxBKg7hLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyQlIXyO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so71952495ad.2;
        Sun, 30 Mar 2025 18:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743383514; x=1743988314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u2xZDS6Emr/Uvp2JyT+/IB2OBiHSpGChm1jJYj0Kp0=;
        b=JyQlIXyOG5FKpU1wjSJfoShFBoI0OUeUwRu+wfFc07cw/dVrHqqaGwaf5fcrilyR2Y
         VatyoQ6FhCWqXa9imiBGkH5w31Ip7IMl9/68sGOj0dI0vXu/0g8NAoWfwCoCnLjk/FWh
         NQvpXo6xx5RI2N85NEytxAGzLDhB6csngC9bqtS/sLSyftoZLpsauQ49rGRyuq8dRF6z
         Vy4EoDlUCv9vWiPCqHSdbJVjJVdPN+jpVEOTfpzYXCgEls+cIIoljuYGxNlqmfqEWQhc
         9hEi841gHF+WRJSYfh8kFcaXm5GialhOS7c84hKU1hQXDX8I0V0FFQnuLl0gI2wPetNs
         X/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743383514; x=1743988314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u2xZDS6Emr/Uvp2JyT+/IB2OBiHSpGChm1jJYj0Kp0=;
        b=KjzyLi+JXjozkVZduhaHV+UHUazPM/FjWl5A6OU6Prdhy8qtDvt/OPoMIB7Us5QN++
         NyDQIDtI30jxP/sQ++Tns2IZJ43igYEAxFdZM4upAC3YFieZtZMxaipy3ut8QsIdASVz
         DuO7juR/wa1XED1o/0n06dmxGXrdK6FJQ8MgSIDdim4A57bArWgKHjF0H7rhw1rmSdK4
         fy7KbL0Z5rqdwyhObix8IM8s/pkd4ge1TQrxUhX8QLCPE2QjERgb9ZZvtaKZZUJBFF67
         ZS/zVCYU6k+5anACIt9xFw5k2LefWUUBHyuhbz1+wS2g0fSLK/UuJIu9WeBEPS0ZoMCD
         w2hw==
X-Forwarded-Encrypted: i=1; AJvYcCUmO2mlNHiV/bhBjIOupSTWjmbIMoHYMUCkg81d3o0Ew5/vfNCpckanXNrVsejHnJXaRzXi8FMYk11S@vger.kernel.org, AJvYcCXXBgBao3MXv2Zxjrii9ioJLMHv+TaAMHKP7XauqCwqAX2i0G2sQg8fpT6HnGCT8WhkESvCR1X2n8tV@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsYl7gy9Rx9ybrspLIQJrymjqmIMzpCtIWXWhWyLEm3seXVVo
	bGU7Nv2NJggNfQZNIKmUW+z5mDSe3dVNmMkcC/kKYt6fKpOWSAvMRq0OVHbrWVYFzAjEUg9xb4H
	JqzuHtqB0xHYzgCOhDGV+KzghsWq8yYs+
X-Gm-Gg: ASbGncuKfzwziHA1OfRkyb9vYTgTYlU8UJbOz9LjN/Un//pi6rNMfqW5ATfnDTVQbif
	eroWuoei971fcdnJwOfIrjPlA+k3kJVW1HiM8GsYs8YpmO2xspKpqu8NQY+Yfq5yK0UzOl0I6sB
	qD830ICKC/r8VVbZrEulHxXzHIXg==
X-Google-Smtp-Source: AGHT+IEPmOfZFEVuL6fhH8iga6r2jo+xSkxe2pBpETuflPJRN0RQ8yrKzA/0szaJzq4V0eMcL7tMZFBFsxvWRlQSHJs=
X-Received: by 2002:a17:903:19e3:b0:221:7eae:163b with SMTP id
 d9443c01a7336-2292f9fbf8amr125382865ad.46.1743383513795; Sun, 30 Mar 2025
 18:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329164905.632491-1-gye976@gmail.com> <20250329164905.632491-3-gye976@gmail.com>
 <3c8f431c-f399-46a9-a031-b1fe39ccc9d4@kernel.org>
In-Reply-To: <3c8f431c-f399-46a9-a031-b1fe39ccc9d4@kernel.org>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 31 Mar 2025 10:11:43 +0900
X-Gm-Features: AQ5f1JqMVpsb_nfQFckREx9k4dLoB7NlL_JMobmQJsFwZVEyqLh_wgoezFU0yPQ
Message-ID: <CAKbEznvZ0R4QaRcp_850vydGJO9x52ctRpF9Q_y1dFFjd-+_RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: add device tree support for winsen
 MHZ19B CO2 sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 6:39=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 29/03/2025 17:49, Gyeyoung Baek wrote:
> > Add device tree support for winsen MHZ19B sensor.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> > ---
> >  .../bindings/iio/chemical/winsen,mhz19b.yaml  | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/wins=
en,mhz19b.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz1=
9b.yaml b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
> > new file mode 100644
> > index 000000000000..c08681e43281
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
> > @@ -0,0 +1,31 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/chemical/dht11.yaml#
>
> Never tested.

sorry, I missed that, my mistake.

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MHZ19B CO2 sensor
> > +
> > +maintainers:
> > +  - Gyeyoung Baek <gye976@gmail.com>
> > +
> > +description: |
> > +   CO2 sensor using UART serdev bus interface.
>
> serdev is Linux thing. Just drop description.

oh, I see that a hardware-specific description is needed here.
I now understand the documentation style. thanks.

> > +
> > +properties:
> > +  compatible:
> > +    const: winsen,mhz19b
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    serial {
> > +      mhz19b-co2-sensor {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
>
>
> Best regards,
> Krzysztof

Thanks,
Gyeyoung Baek

