Return-Path: <linux-iio+bounces-13928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24492A01FD6
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 08:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F163A3DEB
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D71D61A1;
	Mon,  6 Jan 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpKcxQga"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E62D600;
	Mon,  6 Jan 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736148214; cv=none; b=qdx/ULwj8wBH5XQOwjFC4Uw8IeXZD3gUFl3d0XljeIYx8dEhOQSCIw6def7OcIOcbHquEKuAoFtgDZpR0QBGfYclfCPVTfuayu77HGAYMjkpVaMfhOtEDPkSPXXJmwXFJj0XBB989k0FbOhwW9RH6fXiZ9Fgp1+Vf453tcwzN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736148214; c=relaxed/simple;
	bh=zAxgWUko2m6cuGd5MQunSh/LZr15LsDHR69MlWNLRas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofHwBrtqYEvH4lCSKQ/XLXbOm8h5ehvkslyEhB/7ZzJ/qo2zSlVWcxsk8HHkJi7VKDUSf3vKXuHozgmf7qkk+4a1I5RwJS+9lCElq8vN+HGasiQ4shZfe11V7WmGFdoS8hAfjdLQvmKz4qWHOFwQU+NFiueM7/QuZCz0qKfnESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpKcxQga; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa67ac42819so2019317866b.0;
        Sun, 05 Jan 2025 23:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736148211; x=1736753011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUBrFahDDtLxpUl8e1hAAHHnLLP81rttueCp4XvEwcA=;
        b=CpKcxQgaHQvj3YZR2TJNoJPedhj922Bzr4iKLW0i1Mp6nrsp7A1P1fGIS309aWUGLN
         lW1n6zhxEV3QvUwciC8WBZ6uEQ1f0gaoBc48OiazGIk4bhoIegMPPKNIV/NM/CrbPxF0
         7B752a6ozfrqk/rHrLZMtgK7Wjua+ZUu2uhgJkfWkES2nnKlyqDXTiDqkStQMrxoZiYp
         K7v1TCnIP7ZZxY+uQInHxSRHYT97QhcI5KivUpYLNB/A0ZSqi8zdopQzBM2t5RzWHdxZ
         M67kTPLmdE9G4xkqPkzgYHRM1HdtdVJWTdTJMa6yYtxYiuzJpNgu2je4oWHvXmGPcx5p
         g7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736148211; x=1736753011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUBrFahDDtLxpUl8e1hAAHHnLLP81rttueCp4XvEwcA=;
        b=N31FniMWJRbt79kPIpI5eDke+QT53IM+5SVw6vp5HdJ51Yz9eYIRQNusePpXzMV3mG
         mT5miTpYiQx78GOYEYa1EorjjLMyAKtGWg9PbI5+fQQ0NEr9iuQBg1KTdtVJZpsDEANH
         pqcI9BikpCN3LwE7ILzgii0bWBoTx8KHInOgfPqvYzmdekO7IAPc7fjLNNbNlDL4dCAP
         JPbO+uE23CFH39/4CCRzAxb1ZactnDBv50UAyZ1mnH8EBp4UyW31Tcz8DJf0NUb6atH3
         vjXTW73SJhoIHn+iLBzYzluz5nuD7iUwx/a2xlTGUVaVduPOrAD3DU1ExWuiRK6oCuzA
         RyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Amz8Yy5hNp0e6TWY63N8D+hW7DZm5WTLV5rOTjtGr7HvTCLsVJd3n2NWTzQaojEhUeF43Yyet+FI+/ka@vger.kernel.org, AJvYcCVPZvyQb59b4MiD3XBQkCphVi9M4wuPJhrhzwO+TSu0MS34TIL0aYsEOV+gNicplz1fOxvUTE3+630q@vger.kernel.org, AJvYcCWKdY7QM8YO1EYWvez92k4zPXgOyPSQbOPVpyx26B+Sz/cbLkj0Bb+jtPAk/ASfx1ydR+/DQz0U1fRT@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVJVYwynVD8r+GHcnebamEqJvGDQUANfKx4HZYV1tLAVHJfKZ
	URHZz0D3HSIGPR9wH5thceIw7qA9o7ys3RbAX/pYrurNUmspXSgDjHES5EOGfoYopXYxOPKS0kq
	lBV//5POO+u8QOfcQE92JVfGKr58=
X-Gm-Gg: ASbGncsgQSwcrycGJLGpF8tyPMxRR5h1yH7NW0Y4PbJKoQApQJPUdRi+6Qni4yffg6E
	A0kao+vO0tDSgWEDFfP+0UckPC8enHMsnsKptvA==
X-Google-Smtp-Source: AGHT+IF/O4a2DxY72awTlyBOBHzOP/Q9qJqdDB4BtBgc/Mr6bjjnNFpEVb5oAVJarwl+pT6rzbfygouRCm69jRrsPV0=
X-Received: by 2002:a17:907:9405:b0:aa6:93c4:c685 with SMTP id
 a640c23a62f3a-aac2b946474mr4497373466b.23.1736148210495; Sun, 05 Jan 2025
 23:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
 <20241226055313.2841977-2-j2anfernee@gmail.com> <lfthwnvwodqogsk446r5nzpmjunfnpdv33xmaookedwjgpdu4n@llvla6siyl5f>
In-Reply-To: <lfthwnvwodqogsk446r5nzpmjunfnpdv33xmaookedwjgpdu4n@llvla6siyl5f>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 6 Jan 2025 15:22:53 +0800
Message-ID: <CA+4VgcK_9_YD0d7LUKbxU6yd3Qo9RT4yNbi90mMN=kK0LHXwow@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com, 
	alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com, 
	herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Krzysztof,

Thanks for your comments.

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=8827=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:17=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, Dec 26, 2024 at 01:53:12PM +0800, Eason Yang wrote:
> > Adds a binding specification for the Nuvoton NCT7201/NCT7202
>
>
> I gave you link to exact line with exact text to use. Read it again and
> use it, instead inventing your own wording. The documentation does not
> say "Adds" but explicitly asks you to say "Add". Why using different?
>
> Subject: nothing improved.
>
> >
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > ---
> >  .../bindings/iio/adc/nuvoton,nct7201.yaml     | 49 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,n=
ct7201.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.=
yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> > new file mode 100644
> > index 000000000000..08b52258e4af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton nct7201 and similar ADCs
> > +
> > +maintainers:
> > +  - Eason Yang <j2anfernee@gmail.com>
> > +
> > +description: |
> > +   Family of ADCs with i2c interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,nct7201
> > +      - nuvoton,nct7202
>
> Devices aren't compatible? Explain in the commit msg why they aren't or
> use proper compatibility (oneOf, see numerous other bindings or example-s=
chema).
>
>

+  compatible:
-    enum:
-      - nuvoton,nct7201
-      - nuvoton,nct7202
+    oneOf:
+      - const: nuvoton,nct7201
+      - const: nuvoton,nct7202

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      Reset pin for the device.
>
> Drop description, obvious.
>
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@1d {
> > +            compatible =3D "nuvoton,nct7202";
> > +            reg =3D <0x1d>;
>
>
> Make the example complete: add interrupts and reset-gpios.
>

Add interrupts and reset-gpios example,
+ #include <dt-bindings/gpio/gpio.h>

    i2c {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
       adc@1d {
            compatible =3D "nuvoton,nct7202";
            reg =3D <0x1d>;
+            interrupt-parent =3D <&gpio3>;
+            interrupts =3D <30 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios =3D <&gpio3 28 GPIO_ACTIVE_LOW>;
        };

> Best regards,
> Krzysztof
>

