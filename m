Return-Path: <linux-iio+bounces-3996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BAD894CE4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40581C21FA0
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899FE3CF65;
	Tue,  2 Apr 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2SvB+hP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49282E648;
	Tue,  2 Apr 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044229; cv=none; b=vEkKF3kgRgHuci7T3fbkSiTgPPcwrjZ32v3UXVADfDcJrBzcnJogzzTRYFSJmBW5/e9MwzwqYszm/PGaX26KkwlPEtlun3IU2v5lN5iSW4b6IdV4Lpn9NHqo41VtngWSJOlJD0mtu4/56cXgEuHcO/Sftvsirr314I1ItQmSDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044229; c=relaxed/simple;
	bh=c+O9Qkm5c5I3BBDEIMkth12tEKgq57H+C8wQtN/pZJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLZkDLdnv0sFWLEfqBCrQQao1i2ESEpIrEECMo7zU3QNCh2fV8oSasN8CYqH8gURyFaZ9p6ZkkF6EYEswj2IdmTQhPF7V0FWytlqCKmThgsSF2wyFSSdzLR1Era5bopsMPifTcBnb/vHXIytWJuNYgJ5ER9TfqMe/FhnVCXyPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2SvB+hP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3436b096690so165052f8f.1;
        Tue, 02 Apr 2024 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712044226; x=1712649026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+O9Qkm5c5I3BBDEIMkth12tEKgq57H+C8wQtN/pZJU=;
        b=a2SvB+hPRB8qpBk0OZ7D/M+Qh+RUR4hjaHlICBifg1gfRHlHLXCZecqEl+3h9/hBd3
         wkrMKekqEDZg5qzfLDR00bG9oeRYrzbeb8D79WS4m+KthqqCN14old7O8eOJYK8wUGSf
         +wDy0t9a9pv+WyWKpQnbmfgfz3vy/XMuhQMZgZ72kUj5ekFv7FGJ0vmC1kvnWIpMSwZb
         e6bDXdaVT+SvLJdkyHiIKWogPFqqiCjgMVvznsqkzF2uLO5h9zf7w0YyLqJdZ43HSM4b
         kwbsRFxxe6Xjn8pvP8rQGRJ2DQyQzDDfKPmkwnsIObivkXDDaCm7DALb1y+QJNhO80uQ
         /E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044226; x=1712649026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+O9Qkm5c5I3BBDEIMkth12tEKgq57H+C8wQtN/pZJU=;
        b=R3avYxUmZaKLJJMFr2tQUbppex44CwllyejXmL7kum1lINzRQFKlO3yvGmNJQ1akKH
         j80J/g/3wliXjPfv5g8zu6GA4vPAGHkslh4vYhsQ5a+/Xt2cuDBO7FgxOaY7MPdsB+gJ
         fL3h8fPXSq5FYOaT7T34pi4XYSi30SULdP2gGsYJRqHo+nTehlEFdZ809O3tAij5Nu/E
         THFgdSecb0ilDL8Fxx5TR+BE8qqsp6teIO+vhXu8KKF77+0QO0neiKMmWN1y3CdtqNnQ
         dNKfswV63swkAKrP0rmC7QLUvKsCq49/vpNj10/HUoRz+PgqCNHssvwRyPHqkqkU65K9
         pj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQqUAsjnT2Ueemp31h4mIHct44+PeUMpPSuZJsyo7KBm4pPMLtyfVF7ZeDk6+r9wTKNQtFG4TaiuYOwjPeHWqfM2X3WtC1Fwn67Q==
X-Gm-Message-State: AOJu0YyzypLfD1b8McIO5vN5hJ72yUO6U/hIg20VMovc1MbAad/fl6TM
	wJ82jIiyMansGb34oEkegwKGwDqmkQPWwltQXdlnocbR9agbVarhlGoCIPmjjCs=
X-Google-Smtp-Source: AGHT+IGWcUmSPHD2KOPgs1n8neTP3eI5nGTwrdZk0NtQVm8RzLF0yea5+vVrEgozKpTLIc2Pj7aLYw==
X-Received: by 2002:a5d:5886:0:b0:341:d316:3336 with SMTP id n6-20020a5d5886000000b00341d3163336mr14399805wrf.12.1712044225553;
        Tue, 02 Apr 2024 00:50:25 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0041493aae77esm20258815wms.23.2024.04.02.00.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:50:25 -0700 (PDT)
Message-ID: <8c3239f4ce19335878ce5c6331d535f98648a827.camel@gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: iio: dac: add bindings doc for
 AD9739A
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Tue, 02 Apr 2024 09:50:24 +0200
In-Reply-To: <CAMknhBHA3LOhZicUCG32RyiV4+OROJymzm0Qc=wqhfo3u=8vnQ@mail.gmail.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-7-afc808b3fde3@analog.com>
	 <CAMknhBHA3LOhZicUCG32RyiV4+OROJymzm0Qc=wqhfo3u=8vnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-29 at 14:06 -0500, David Lechner wrote:
> On Thu, Mar 28, 2024 at 8:23=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > This adds the bindings documentation for the 14 bit
> > RF Digital-to-Analog converter.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0.../devicetree/bindings/iio/dac/adi,ad9739a.yaml=C2=A0=C2=A0 | 88=
 ++++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++
> > =C2=A02 files changed, 96 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> > new file mode 100644
> > index 000000000000..24bcec763a9b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad9739a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD9739A RF DAC
> > +
> > +maintainers:
> > +=C2=A0 - Dragos Bogdan <dragos.bogdan@analog.com>
> > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > +
> > +description: |
> > +=C2=A0 The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that=
 are capable
> > +=C2=A0 of synthesizing wideband signals from dc up to 3 GHz.
> > +
> > +=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad9=
737a_9739a.pdf
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad9739a
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
>=20
> I also see an IRQ pin on the datasheet. Do we need an interrupts
> property for that?
>=20

Likely we'll never use it. But yes, it can be documented in the bindings...

> > +
> > +=C2=A0 reset-gpios:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 vdd_3_3-supply:
> > +=C2=A0=C2=A0=C2=A0 description: 3.3V Digital input supply.
>=20
> vdd33-supply would better match the datasheet name
>=20
> > +
> > +=C2=A0 vdd-supply:
> > +=C2=A0=C2=A0=C2=A0 description: 1.8V Digital input supply.
> > +
> > +=C2=A0 vdda-supply:
> > +=C2=A0=C2=A0=C2=A0 description: 3.3V Analog input supply.
> > +
> > +=C2=A0 vddc-supply:
> > +=C2=A0=C2=A0=C2=A0 description: 1.8V Clock input supply.
>=20
> I see a VREF voltage reference input in the datasheet. Do we need a vref-=
supply?

Same as the IRQ pin.

- Nuno S=C3=A1


