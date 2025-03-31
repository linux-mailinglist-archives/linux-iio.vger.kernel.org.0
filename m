Return-Path: <linux-iio+bounces-17390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BADA75D9A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 03:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A853A8F16
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2554769;
	Mon, 31 Mar 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEvJJTCu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8C1BDCF;
	Mon, 31 Mar 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384745; cv=none; b=sycBT5F8MFVm+FvA051cG7HsmHIw4TpGU/x4PcUbTQK5Lw8J8kIuCS+j9ISXbUQjRathT09uRZ2V5j7a3CtF96QL/qtGdF5jVDLsZTUdM7O7iazhqRHB6bibnpH9PbTB3PQ1YNa/7ElzRD7ZJWQC6YNKYyb6e8/PzvWDIqK+wZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384745; c=relaxed/simple;
	bh=t9j6wbuZcCRFZuHUzA3SCZLYRIW0753IbLRJzVnmuYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHxv5JnkcUl9Z2lFqeo+q3kaCfjRHaDmApE0VkZeX8SvmGwPgZGYIiBrdu+IzQ+bhC3gg9T7BR3ofz7yQqr4EXZuxrEUSUfaTrtcYJBXLNJzVHDniOVuCRZaJwddwyzdz8WkkXRv1I0NK6HcsgLSo5tnbTkdHFDGg1dFW6OGUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEvJJTCu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301e05b90caso6965552a91.2;
        Sun, 30 Mar 2025 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743384743; x=1743989543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiJEAYLa7vc4YnkyP3wR6lUVKxU/z1+YgWIvnXrE9S4=;
        b=AEvJJTCugVlNrZqc1ATj0TbkdUQakbPuXPWiuYnHpHc82td5ZtHn6wO8tYNzpt6Fun
         tRJtifaRV2xene53L7GwF9gI4TQpSZ0z8Kcf69IENYcOoI3HG6qxJh+uxl6iEWVPW2QH
         YL9C7bofMhiGzIGuShgTfGGoSAPOh4cG0GQ6ELCwRC3h9JQzWL9I0+5OuNlNVFzGGv65
         lIZKTMF40PRUneJc8z2LXL9Te9zRr9Uukm52F4ldDMvSPRS4GVxjeVFVM9CpXfoRIaUZ
         MoWNMQOmxbq/luHnE3s+bYfkQnQJWzzWQqRykXJF7HVsAuXW7HFPhw8eN4zPufDSUqT3
         uZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743384743; x=1743989543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiJEAYLa7vc4YnkyP3wR6lUVKxU/z1+YgWIvnXrE9S4=;
        b=Xo1tFciMpznyC7aMmVlThJ0ipxVuKP+6XybQI4M+MihUeZ3GYF/uBdkmDTAsXpM6hz
         YEO7wV+dWLYVC/OLJczu/pDRGewju+t3V78GfCU5Y/M7oZ3RjTtIN278QBf3GGSuI68P
         hsVDKMshjcBQfuMskEt7e0LbA5vXRgB/bLkWHcGLBhYpdojmQUQUZRk8Aw8L2rtscHTc
         PwkhzRdD2cQ9P/zLZAtIghV/BtIoB4chF4YdXQdADO7Cq50bB7UUNDPDScqgeDN0mXBT
         H/PezPoW0b4H3LXgMgFeTT70mL4hQlx63TMPwhxNOVRrfXop5h7leTqYTHo89m0YO6w/
         NwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm7/El6hVhbcZlr1HN+G6yMkkiny6um+rPvuBJRux5+MOdd36Yrn8RK5UQPN6i7Lk5oE7EzHkpqjfD@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYrjoTd4OOLHyJvU1LeP51R2XJC9iAFAJWvUnwT4OmiNcVj3d
	BCgdrJfsuWMFOx37XCyRjgfdbkF91kURBjTv7ZAaROeZ1SoUyCiRjkyIDkzLHbTyqTkKcSnLuLx
	E6rXVjM3aWi6AEpFkoIJFepLjsHDOUt23
X-Gm-Gg: ASbGncvvMRV+J+av5+gOlh/lkMuYUvP5Id6PHq7ZVYENIIsy0D4c+IHaKoTIJzw9kCS
	AdpVsaiVrBM4e4G1lDC7jMBMfCSogLpjZibxLITSzIINFO9fInE/Ai7enP7WC92+RomjSt5LYW5
	jWpjSjxUAyvTE/Z5wP1u/oFQJjFQ==
X-Google-Smtp-Source: AGHT+IGCq/ahIV7xb9PY0bQOl/QeVRcmt6X9x5toO205vOfnC9Py2IGuJmupU+6+lzxyaahjspW9G5H3mnUb6gFFxH4=
X-Received: by 2002:a17:90a:c88c:b0:305:2d27:7ca7 with SMTP id
 98e67ed59e1d1-305320adbd4mr12431435a91.16.1743384743098; Sun, 30 Mar 2025
 18:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329164905.632491-1-gye976@gmail.com> <20250329164905.632491-3-gye976@gmail.com>
 <20250330135022.76ff6f2e@jic23-huawei>
In-Reply-To: <20250330135022.76ff6f2e@jic23-huawei>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 31 Mar 2025 10:32:12 +0900
X-Gm-Features: AQ5f1Jp44ICc_w5M5LNBp81UO_iCIpSAF1RRojA7Qn1jiIFPgq70Tk5OIXGIvWs
Message-ID: <CAKbEznuVmZFiEpn7AUyDKpmHuOrvoOJgJTW2xDZSo9S3Erx8iQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: add device tree support for winsen
 MHZ19B CO2 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de, 
	gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan, thank you for the review.


On Sun, Mar 30, 2025 at 9:50=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 30 Mar 2025 01:49:04 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
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
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MHZ19B CO2 sensor
> > +
> > +maintainers:
> > +  - Gyeyoung Baek <gye976@gmail.com>
> > +
> > +description: |
> > +   CO2 sensor using UART serdev bus interface.
> > +
> > +properties:
> > +  compatible:
> > +    const: winsen,mhz19b
> Hi,
>
> Welcome to IIO.
>
> Just one additional comment from me.
>
> Bindings should be as complete as possible and also reflect
> the existence of things like power supplies even if your particular
> board is relying in them being always turned on.
>
> So you need
> vin-supply: true;
>
> and add it to the required items.
>

Yes, I will add that by referring to other IIO code. thanks.

>
>
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
> > +        compatible =3D "winsen,mhz19b";
> > +      };
> > +    };
> > +...
>

Thanks,
Gyeyoung Baek

