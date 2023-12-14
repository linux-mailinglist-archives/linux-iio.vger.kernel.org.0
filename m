Return-Path: <linux-iio+bounces-918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68701813002
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 13:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA701C219EA
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71114AF94;
	Thu, 14 Dec 2023 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu4TcqRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C56132;
	Thu, 14 Dec 2023 04:27:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so11138065a12.3;
        Thu, 14 Dec 2023 04:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702556827; x=1703161627; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ueEUnJf9vhjwrQfvpBg6AiET0LLFEjTRO5+ClpFgSGA=;
        b=fu4TcqRsngh7GR++p6CS9uodJWxS7E622OXadsr6LfmqKbo+5am+63Jb45+Zu0pPBE
         37ppUIMsLfABYStRFBLmsjiNHmBig+P/fwH0sS/NGSxtNM6lqXLTYBjp9VQko+/n2gxJ
         RoiAkkx+u8SZseaNfXy72rFayrixcqp5+htZqjg5hSlAWmmHcAYbysgBYZc6b2rcF4pA
         liPYW9dGzjE9B2itEKE35O6bDEW1MccvUYRY1Q0BxLZLFWwBIRqi6Sf6UUmyjuZEubMB
         z2Vo/L+a89lv1Z/td2Gl9ieIimqrhyGIPTaxcHDOntRtot/ZLxjs6b8eq2AJODQ77vit
         /KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556827; x=1703161627;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueEUnJf9vhjwrQfvpBg6AiET0LLFEjTRO5+ClpFgSGA=;
        b=AU930RRQlLjQ8VUVjzlNlHFgxsq2DQbeBoJavp6be9KMvXnNikCUy2d6bA8rdj7aNu
         1HsXa9jR0xVP9Z81gF6PANcpni8CaFtdpR2GqvBGGLpBrEzWFFQ8u5j6G4ZB0ZTcael9
         na9mzxpGh+5yvCZH/XbOVG8kLHE/C1ShIIfmOceOgjbONQ0N43v6VXml3A6f0mpybiIA
         q/jO0WoJ7XIUQMpBDF4Dkh1u0kY5JXwVR2gB4m0F1LdDtmNtwHXQwpuCIbTYYHC5c6/R
         jRw3esiU784TEyPbZ0woNJaYe6k0Fb8XdZKKT26+Kmn3PLy+V9p8e3H2TenuFs84/P6J
         mdBg==
X-Gm-Message-State: AOJu0YzlwiuDldU0hWT+sbkE+ZhSXqZTt+LdQnPihX2lfDIurDKw/nyS
	hMbLShsVnTNmOgRCPDPzKI9l63dCcYO1EVwQ
X-Google-Smtp-Source: AGHT+IF0Tmyn8Iks3LhYLvasc4ZT2QU2SDDlt4bwZaG+XPmfi7zsPESNLUUPTRaDQEevZ/LfngxtqA==
X-Received: by 2002:a17:906:598b:b0:a19:a1ba:8cd3 with SMTP id m11-20020a170906598b00b00a19a1ba8cd3mr4006559ejs.113.1702556826965;
        Thu, 14 Dec 2023 04:27:06 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id th19-20020a1709078e1300b00a1bda8db043sm9139820ejc.120.2023.12.14.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:27:06 -0800 (PST)
Message-ID: <983df13c5da90bf36dbca1a4dd3a6fd7ffd340a6.camel@gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 devicetree@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org
Date: Thu, 14 Dec 2023 13:27:05 +0100
In-Reply-To: <170249013568.1591665.1236116981497856652.robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	 <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>
	 <170249013568.1591665.1236116981497856652.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 11:55 -0600, Rob Herring wrote:
>=20
> On Wed, 13 Dec 2023 16:02:32 +0100, Nuno Sa wrote:
> > The ad9467 will make use of the new IIO backend framework which is a
> > provider - consumer interface where IIO backends provide services to
> > consumers. As such, and being this device a consumer,=C2=A0 add the new
> > generic io-backend property to the bindings.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++=
++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-ba=
ckends:
> missing type definition
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231213-d=
ev-iio-backend-v3-1-bb9f12a5c6dc@analog.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

This is kind of expected as the property is being proposed as a generic one=
...

- Nuno S=C3=A1

