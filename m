Return-Path: <linux-iio+bounces-451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B87FB6BD
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07DC1C2104D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805374D120;
	Tue, 28 Nov 2023 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODxDpQPd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFCDC;
	Tue, 28 Nov 2023 02:08:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so2997260f8f.0;
        Tue, 28 Nov 2023 02:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701166099; x=1701770899; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gu7D9Uuj/glFG5Vgj83Kr5LBLOtxorZnx9Itlbl/pPw=;
        b=ODxDpQPdo3sScs8p6rTS+lua4EZ+WFB76TFx6dbHfHMizZQCDzptbXGvSjcIU3qkba
         n9a1KuyaTBNDCsKQ6ggupIsMBI+2mFnb5AhrLvKX3/lPOw/I0OxMUPvRmwFksCPASKf2
         g2S7pcXjQ9mlvhYvWjsaB17uhNXA1Rlc4mhi70ela91+SKv/+0ADLv+cx+W9Rkipaubf
         /BFvvBVg6QGtT5bD94RnRq2EBTZwdw63iroXjCluYOp9Q6xdcyW0K9j3BCjPsq9W7iof
         pZ19di6wjL57TX6zHMlHeY7GFAbuEbFmUtunpuBo6UYn9/Wxj6vnBZiuZUJjPSVgn7rr
         AXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166099; x=1701770899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gu7D9Uuj/glFG5Vgj83Kr5LBLOtxorZnx9Itlbl/pPw=;
        b=drafL066ssnjnThhB7MTvirvDpfy16tTISpfFoNSSkIka2wmMFlnKja8nWnabwUJ9+
         Ug5OVk+VV4ufrgM6+WLboP09sQ01JrSWGS1e+gjf2fRZtyW2jDNQ+M0Thjjkz+RykgyR
         opHqOI4oHNwTxoG+Ne6ulM24U6+vqlAaMQwgiy9igRXCKd9VZk55rrMcC+1NoMzTS1l7
         jtYOiMUf0dnFNUrCaJJ6YMlaSeqsJyH2y7Lr8teB459H87WxIsafXP4uxSavhQceOyWb
         Hui4irGwwKuUTGZe+O9hX0g+o9gh9VM91g0G0CI07xEtQNAiLHYyFYYQ3LZUZxL24kwH
         jNTQ==
X-Gm-Message-State: AOJu0YwvULv4QLuoHA1Vc1eDLktfV1qk6YotthTaJjKOjRhY9IF2s94H
	WyklzPZyq03qdQ9tTO7t8GOjAdffnLLNpnHLS4k=
X-Google-Smtp-Source: AGHT+IFsTFnl36sn7+8Kbkeeldpmgaauq5/JCu5VnUlgtSl4PXfWEvXOZYH71RYHUN2wjJ8w5MBySw==
X-Received: by 2002:a5d:4946:0:b0:332:e3ad:4273 with SMTP id r6-20020a5d4946000000b00332e3ad4273mr16406169wrs.2.1701166098563;
        Tue, 28 Nov 2023 02:08:18 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d4a8e000000b00332e073f12bsm14448715wrq.19.2023.11.28.02.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:08:18 -0800 (PST)
Message-ID: <5ad34779b6ad50f7f00c99f27e171f34628cebe0.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: adi,ad5791.yaml: Add support for
 controlling RBUF
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 nuno.sa@analog.com,  linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Date: Tue, 28 Nov 2023 11:11:18 +0100
In-Reply-To: <30a74f59-6230-48d5-a872-a9bee0cc5b4f@linaro.org>
References: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
	 <20231127-ad5791-michael-stuff-v1-1-04167b3edc56@analog.com>
	 <30a74f59-6230-48d5-a872-a9bee0cc5b4f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 10:33 +0100, Krzysztof Kozlowski wrote:
> On 27/11/2023 16:55, Nuno Sa via B4 Relay wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >=20
>=20
> Subject: drop ".yaml"

Will do...

>=20
> > This patch adds support for an external amplifier to be connected in a
>=20
> Please do not use "This commit/patch", but imperative mood. See longer
> explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95

ack...

>=20
> > gain of two configuration.
> >=20
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++=
++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > index 3a84739736f6..c81285d84db7 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > @@ -26,6 +26,11 @@ properties:
> > =C2=A0=C2=A0 vdd-supply: true
> > =C2=A0=C2=A0 vss-supply: true
> > =C2=A0
> > +=C2=A0 adi,rbuf-gain2-en:
> > +=C2=A0=C2=A0=C2=A0 description: Specify to allow an external amplifier=
 to be connected in
> > a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gain of two configuration.
>=20
> I don't understand this. Without this property external amplifier is not
> allowed to be connected? This sounds like some policy, but should rather
> focus on hardware.
>=20

Well, this really translates in a different configuration in the device. If=
 this
is set then the device is configured to allow an external amplifier to be
connected in a gain of two configuration which depends on the HW setup you =
want
the chip to be.

The description already states pretty much what the datasheet says. So whil=
e I
understand it's a fair question from you (you don't have the time to check =
all
datasheets for reviews you do), I'm not sure there's much more to add into =
the
description of the property.

- Nuno S=C3=A1


