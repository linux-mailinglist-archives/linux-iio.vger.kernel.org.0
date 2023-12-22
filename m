Return-Path: <linux-iio+bounces-1218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A203081C721
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 10:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E48CB2346D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2CD530;
	Fri, 22 Dec 2023 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIrwDfNx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15ED51E;
	Fri, 22 Dec 2023 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33666fb9318so1437864f8f.2;
        Fri, 22 Dec 2023 01:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703236055; x=1703840855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CoXYLZZXsRfrRLR/vElKQjDEkbBG0uHrbhO1kZUdwjI=;
        b=gIrwDfNxqWJQqQrtintS207646Qpn5jRwBwDM7EI183ARc5dehHTlCGUk27Bn3vjFz
         SVEu15MrSkGKDYURmhkWwSQ0/rHF52UtyLkzFok2+4R3iccg1kTaqwojW5vx2dNqNJX0
         hjC2FblqftJRyis1ukU2U1DHiVJIWZIpfuVlB5xvktGKxvY0+J+ri12JkPBEiGVRmjke
         CWtPrwWSnHuc4eMs0YwmgltC8y9tVxvJXg6IQPaKUP3gGVL764oVLNxqxv8KcJI796yE
         PxLHRiXEiU4jWOxIhuiVgdPLxDa65JJr7QdycM0iLmMKyfUrH7ERLbxwBbPO0KUC3Dq9
         wckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703236055; x=1703840855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoXYLZZXsRfrRLR/vElKQjDEkbBG0uHrbhO1kZUdwjI=;
        b=EeKXmsKruvOuTkUB6Cxt1qokGiaFDD5AioIRRflj/TI/wjqmRwQH1nBF2jjCXAogB5
         MpflGMhvG2O4b1Kznyfk113dMGcVrMIC8SwoYlf5GOgGqfWD0lWAfXiHEKMLJvL565YR
         xXMDUVDW9RynJLFoC+qsVM0+Gjumyu+WXcMPg7Rhs0y/9t28YomCjZLtIFDKpeTLfscm
         AXGdBF9dHMT//wEbPZRO8BYojHUDOf51XllAH9427eRnO8KKn7JjkSgbV8lBT58JTMFT
         0Se5ZmwC3OM7UPOi5HrrXmZ9sTFDx4k32wgDPBOQrpTXuNN9WCpqiaaUhwWUGMSJhcE2
         TKfQ==
X-Gm-Message-State: AOJu0YycyTCKaqlyOSr2LNwRpQLPZc80cNQUGtjBH/obaSXDYhrRonD6
	lW3+0PvpxRf6xPY6VVW81hCxj6li7jE8Mtg5WvQ=
X-Google-Smtp-Source: AGHT+IFoVZhMYz1oDB0MvyLErIPElov49RB4uA6y8AXLGR7+83mY7bwvrW9/Ub7Jzl0rT/EgZymdSw==
X-Received: by 2002:a05:600c:3d88:b0:40b:5e21:ec1f with SMTP id bi8-20020a05600c3d8800b0040b5e21ec1fmr552331wmb.81.1703236054425;
        Fri, 22 Dec 2023 01:07:34 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:5877:261e:1d6d:8696? ([2001:818:ea8e:7f00:5877:261e:1d6d:8696])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0040c3953cda5sm14028665wmo.45.2023.12.22.01.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:07:34 -0800 (PST)
Message-ID: <0412e07926d67490a66d0aac19ecca734ce54426.camel@gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: adc: axi-adc: deprecate
 'adi,adc-dev'
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Fri, 22 Dec 2023 10:07:34 +0100
In-Reply-To: <20231221172538.6477b843@jic23-huawei>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	 <20231220-iio-backend-v4-2-998e9148b692@analog.com>
	 <20231221172538.6477b843@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 17:25 +0000, Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 16:34:05 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > also remove it from being required.
>=20
> With my 'specifications language' brain engaged (also know as pedantic)
> I think this is a 'should' not a 'must' case. You aren't breaking
> backwards compatibility just advising moving to the newer / better interf=
ace.
>=20

Well, you surely know better than me as a native speaker :)

>=20
> >=20
> > The reason why it's being deprecated is because the axi-adc CORE is now
> > an IIO service provider hardware (IIO backends) for consumers to make u=
se
> > of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> > of consumer referencing other nodes/devices) and that proved to be wron=
g
> > and to not scale.
> >=20
> > Now, IIO consumers of this hardware are expected to reference it using =
the
> > io-backends property.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 4 +-=
--
> > =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > index 9996dd93f84b..835b40063343 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > @@ -39,12 +39,12 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A reference to a the actual ADC to=
 which this FPGA ADC interfaces to.
> > +=C2=A0=C2=A0=C2=A0 deprecated: true
> > =C2=A0
> > =C2=A0required:
> > =C2=A0=C2=A0 - compatible
> > =C2=A0=C2=A0 - dmas
> > =C2=A0=C2=A0 - reg
> > -=C2=A0 - adi,adc-dev
>=20
> Dropping it from required is fine, but do we have a new condition where o=
ne or the
> other
> should be required?=C2=A0 If so good to add the dt-binding magic to enfor=
ce that. Look
> for a oneOf combined with required. There are a few IIO examples of this =
either or
> type required. You may want to then enforce that both are not provided th=
ough I
> guess we perhaps don't care - the driver will just prioritise one approac=
h over the
> other.
>=20

Hmm, the thing is that io-backends is applied in the frontend device (so ot=
her
binding) and in here we should only have the adi,adc-dev which is now depre=
cated so
I'm not sure how that would look like?

I think new users of the deprecated property are very unlikely unless they =
choose to
ignore the deprecated warning. As for old users (if they add the new one an=
d don't
remove this one, the new one will have priority). But I'm still confident t=
here are
no users of this out there :)


- Nuno S=C3=A1


