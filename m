Return-Path: <linux-iio+bounces-780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA980B4EE
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8192810B3
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA06154B2;
	Sat,  9 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CADnUakw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20E123;
	Sat,  9 Dec 2023 06:35:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso357660066b.1;
        Sat, 09 Dec 2023 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702132516; x=1702737316; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+QsD8qMCGFjiqSvBZG2+lKBhtPymtTkXT2O1YofK6Vg=;
        b=CADnUakwqS+b+cY8K2NopMsTcHG+im7zqZ0SIZnUcGn3PhbVAw5u2YsrKxYWTquZfD
         gX7ZPzSZZnyKwiQenQzgjQ2UEYCkVRBNs8z/JygHbILPzviZRJCL8Z8j1yXiXaUD5TZY
         Vrs89qrzUDGJN1jVh7jB2MfhUa5+e/zx5midDvGRHNPqf+sHjWo/XWJRVkSnkIipXGwu
         iQPX74dzPxx//qqP5R9FEFU5+03nLg8sbgqtpOTU1/Sk50PZL3A1dUyYA76CbnSBWDEc
         R508Vspk9zz9JfUv66OCcjEFaxBb0ZILeYoBUHHJVBRnuaHSYcWTH0lud/n7EMYoid72
         JGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702132516; x=1702737316;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QsD8qMCGFjiqSvBZG2+lKBhtPymtTkXT2O1YofK6Vg=;
        b=D4xYc9AREC/7iUMtUBy+HuLI1/xPAvlcY4ikLdyZmx93ml84Uggnhh9Y/pnpYsTPpm
         X0TQ4JAC5Qndg3bNomVdk/HYnz33KOjqBYLPd+IU5j+S//stcFkC6rJfrGpw90qUxQ4f
         PEzlDtnF9ZoMQ51K17WH15vFugUncq/mnAUS51iphKGxw6cBafO6e/eXWIQAXHH7sDvk
         FktIsARdcFJSEyD6lvG56kX/u9cp9owE1dcn1vumUFhcXWQtNURVfSRUr0knjv8hJAJQ
         0I0o+kS94k5A9mX/vklenxgaYCuWlW6ENyZjK5ITkZmeITgSs99e9mg/QeIuKo1bMtQd
         x11w==
X-Gm-Message-State: AOJu0YyamBiiVguzIJtYRV0Mmx2ORwLD5l3SzUxjbCMsgwzZU+JkJHnM
	eht2pBB9/66K127g+51XIqA=
X-Google-Smtp-Source: AGHT+IFlW1JQEuYSsinoM+5fltU2JOyjkth8SScjewoRGoiy1UDCfMFkR5XRFzVn5oNV3I1Qh/klLw==
X-Received: by 2002:a17:907:60d0:b0:a1c:ab29:87e2 with SMTP id hv16-20020a17090760d000b00a1cab2987e2mr2155218ejc.35.1702132516003;
        Sat, 09 Dec 2023 06:35:16 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id ry9-20020a1709068d8900b00a1f744953c1sm1639139ejc.105.2023.12.09.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 06:35:15 -0800 (PST)
Message-ID: <c01990b65ad028a0b4ed29571ace30856e51f710.camel@gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: adc: ad9467: document io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 nuno.sa@analog.com,  devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Date: Sat, 09 Dec 2023 15:35:15 +0100
In-Reply-To: <82817908-1965-4d0a-bd2d-4785bfda45a7@linaro.org>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	 <20231208-dev-iio-backend-v2-1-5450951895e1@analog.com>
	 <82817908-1965-4d0a-bd2d-4785bfda45a7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 18:40 +0100, Krzysztof Kozlowski wrote:
> On 08/12/2023 16:14, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Add a new property to reference IIO backend devices.
>=20
> This we can see. But why?
>=20
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++=
++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > index 7aa748d6b7a0..ae74249b4726 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > @@ -44,6 +44,10 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pin that controls the powerdown mo=
de of the device.
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 io-backends:
> > +=C2=A0=C2=A0=C2=A0 description: Phandle to the IIO backend device.
>=20
> Looks like standard property. Where is it defined? What is the meaning
> (your description does not tell me anything more than property name and
> its type)

Yeah, Conor already gave me some feedback in the cover where I mention this=
 property.
I'll improve on the description and send a PR for a generic schema.

Thanks!
- Nuno S=C3=A1


