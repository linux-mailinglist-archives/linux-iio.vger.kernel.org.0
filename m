Return-Path: <linux-iio+bounces-12724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE399DA3D0
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 09:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A2BB262DB
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183291865E2;
	Wed, 27 Nov 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np+L1VUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEA17BB21;
	Wed, 27 Nov 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695689; cv=none; b=U2mIxm9dsLK1e3YCBNR8nGLnS1sSFwyDwbG1MHRnPLbiyYVXna/psm8eICXERB2C9tYofU2H5dFOol4bUoDcbFWLj1NKMd6vvTguLiBwzYMfj8I9pE9r/nTmiFf7O46C5IdpkbuNuIdSrv8N4z8SWXfxGZXjblj+23FeiLrE/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695689; c=relaxed/simple;
	bh=stSSnFTtoJHg8BqGvfNhevnOn2ndUoEebm8YWcO5spM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HutAv6IrS7jT/9mz7PlU74oo5L36J2Suo5nLYoD3tSz0KRvjE91GY5F7hEwXMnQyeSx5onXUw4NWFLc9XIy3eBxJjflsszXQoJ4swuHmfNBkIQGwxClN1qapZRgjnxBDrp4G/xiHZ+b+tRJmbgu/Rpxcw8/7ii7SLJZ5jG2cA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np+L1VUS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e38232fc4d8so5690763276.2;
        Wed, 27 Nov 2024 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732695686; x=1733300486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXx+dVC/bMbMySJqkxvau2EzlELyuHvZH+PJDlKKiNk=;
        b=np+L1VUSE9UJvfqeABBBElaJvQja+dmPswBsNsZhQhHZRXONRCR1oJD+N05NGiBHux
         8VdWuIekERVtrJG2+Bw7llpoalgU7icyn2X0ZEBbaiRm0oHzf6bL6GYjzm5gIcAqsXQR
         /U2MiW3qGoxxoRwP2ZP30dtjvPylRFKuh4EPi5RpYfXvy0bu6i6MOL3GmirHLBzzQbeQ
         TR9XoiVyL32pnJABnSBnXc4/0r2TEGeQQLqc7fxU23gIhM5xYS1h1BVGddEIB+9f4Z46
         2YyNPRo2GPRuv+SeVuo4eRUSGGFXYN1Rg8eDwjIIHw8tLpTw35r8KZUVhXaIdg1JmVf2
         xNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732695686; x=1733300486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXx+dVC/bMbMySJqkxvau2EzlELyuHvZH+PJDlKKiNk=;
        b=U120C/uAuuMnZ5tvFX0ayz9bz3N4hmC85YkKX/AWwxXQhJr3sbzYapMKNY5jQt5ja4
         YvRQWMjMvWWvN6g6z5ZZBARJzJzv3RLMOISYNabZHI1TkZN9gQclNLjm6iP2YBLcYDiZ
         hC0M4H8uVsro9rsXhgLhkV8b82ZlmMEoGuoE4rELNCsumGZtHhBcGeE/kd8auljVJz0V
         UtKrDaWIwBv5X7bTPeir7w9TCA2U6Iu6mSfZQ8yvu9lNZ008u2wQtGsVdxNi6Prp+rj7
         BocBcZOrht/00Ywj2mnrklA8fy2rGD7+1JMI77jHuX6AkDr8WN1ctUE+MCk7D1OZdfMD
         22mg==
X-Forwarded-Encrypted: i=1; AJvYcCU0dqiXgXP16eYc+Scoc8EPEgpJOe3i39233Oqc7lSzad0lZsBhQ452YSmOu4yxA+kngpAocQ6oxRDE@vger.kernel.org, AJvYcCU2zoDzoxQBcKYYM9LSGyrDrRuuUyiuts41SjXFwNnuvNM63LhgkY7NUP8SuiBnio6hLSj4LtV4Og0C@vger.kernel.org, AJvYcCWKFE2eRA1Zqdl5vEeJsNYk/8iOL+xGF+G/0txjf9YyVyBQQObFC2eMBMjLvGk7FKKCgs3e1LO6BI5yJxFH@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqfsnraG4ZpUps0Cr8KKO60ycLfsXTHPXqoXbK/cBYPeee15o
	vVQndHOPSN+42mdzrUzQnOV9kaV9BQlzKTsVMhOltDEYwHHHviLYWJHmAcybIkv8P5H21O4kPZy
	fkscH/OowJ2zjXx2U7K/kK/H2gY4=
X-Gm-Gg: ASbGnct75szYswTfn1Pf5M2M5g5ZRXR3BQnNy1pbXUqa9QEIl+l5A5PyTDHn7Fe8cSM
	C4durrFYCFOopSmySdUB5MgvxbiWRcHupCmREjOklI8nuqD2+8SS8Tn6Y0MH6pIs=
X-Google-Smtp-Source: AGHT+IEKPD8zeEXnQhDGjU08izfyjaPh9mW6eUsQmF+VL7kvEeC8+Cs3bH4LLV81hmpuN/ogXjymN3kPibAGVGCWNM8=
X-Received: by 2002:a05:6902:210e:b0:e22:6a94:f22f with SMTP id
 3f1490d57ef6-e395b8c1eb5mr2083679276.28.1732695686164; Wed, 27 Nov 2024
 00:21:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126074005.546447-1-tmyu0@nuvoton.com> <20241126074005.546447-2-tmyu0@nuvoton.com>
 <20241126-shimmer-such-35cf44076981@spud>
In-Reply-To: <20241126-shimmer-such-35cf44076981@spud>
From: Ming Yu <a0282524688@gmail.com>
Date: Wed, 27 Nov 2024 16:21:14 +0800
Message-ID: <CAOoeyxUXYU4rMxku62CnS6BPNZ4shm5t4R_it63JTVsT0-Nrnw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: Add support for NCT7718W
To: Conor Dooley <conor@kernel.org>
Cc: tmyu0@nuvoton.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, cmo@melexis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Conor,

Thank you for your comments,
I will make the modifications in the next patch.

Best regards,
Ming.

Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Nov 26, 2024 at 03:40:04PM +0800, Ming Yu wrote:
> > Add devicetree binding document for Nuvoton NCT7718W thermal sensor.
> >
> > Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
> > ---
> >  .../iio/temperature/nuvoton,nct7718.yaml      | 44 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 +++
> >  2 files changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/n=
uvoton,nct7718.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/nuvoton,=
nct7718.yaml b/Documentation/devicetree/bindings/iio/temperature/nuvoton,nc=
t7718.yaml
> > new file mode 100644
> > index 000000000000..a3573e3d454d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718=
.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/nuvoton,nct7718.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NCT7718W Thermal Sensor IC
> > +
> > +maintainers:
> > +  - Ming Yu <tmyu0@nuvoton.com>
> > +
> > +description:
> > +  https://www.nuvoton.com/resource-files/Nuvoton_NCT7718W_Datasheet_V1=
1.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,nct7718
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> Please add the vdd supply as a required property.
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        temp-sensor@4c {
>
> The generic node name is actually temperature-sensor.
>
> Thanks,
> Conor.

