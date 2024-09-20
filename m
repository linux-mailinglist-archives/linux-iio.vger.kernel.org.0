Return-Path: <linux-iio+bounces-9662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05397D5BC
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DA8B232DD
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1916A943;
	Fri, 20 Sep 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+ce2VNi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C77165EEB;
	Fri, 20 Sep 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836476; cv=none; b=G9OPJ8L9NXLAqqFmURB1xGCw3et4TWk+QlSnTC+7uXka7hAoZx797aj9GdRh4Zam72wx0SbdacMbq1LW0lnTakv00N9177i2fgv8ePIBVrC/dIxmSBuif7JvB4X6RY99rO6i3a8bXvMmDJ/Yt5z0dDhA5duWkgPt4ViqnEnricc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836476; c=relaxed/simple;
	bh=RzaI1Bue8WUSTHVDYIvRA1yKnKrbyy5a7y0/P3CYtBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbF58NEUbqMvqlhXEpm7Rlo5UDDpFsSZ0m8svdq7rJj7KQ8dLVDXBFKscB64TthtxhHddNmv0rgzGmIBQ/cozBzEwyL6DZ7Tu9b7B00DNzV2Ibj1cXABpG6/dIWaschLqOvJomEhLeByunn40xZbYeQ0CN/nsGLzgZC0CYuxjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+ce2VNi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c466170bfdso391163a12.1;
        Fri, 20 Sep 2024 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836473; x=1727441273; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RzaI1Bue8WUSTHVDYIvRA1yKnKrbyy5a7y0/P3CYtBs=;
        b=g+ce2VNiH9NkeBPtAiRGP+Tpb7+mneEG6BZdXPELkoyAXZM7xK8BSVtjm3y0wAF+we
         7fE4Bb1kA2i1/vmwmJTZMeOXBHIxf/bokUUp5/IXHscCUpQ1DmUfA/f230GEEGVCf4Z2
         PjvNFslW214S9ZLvVUbX3RRxYV80DprxpFEnimV8l2su77jVoqOym7sWacBtD5bZ8apk
         O2wwYAH1Fdqg+fCEZNtoakkeKkx9nDFqrO0R8A0VHCw26gwlyLMMzQiTaDOVtQ7AGakC
         G4lmkgL2Ky7wmXKp3fXqrNXulL/cE7WxUxXZFuFcGTjuOD8bkRg9BwlEZE0ezFypLfhm
         v8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836473; x=1727441273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzaI1Bue8WUSTHVDYIvRA1yKnKrbyy5a7y0/P3CYtBs=;
        b=LRYsO571wR3QgP8mku/WoTdutIEU0BgAzY25IdI9mxXjWb92tgylnOrTM89TYmznaP
         aj5FBAqhT+evZe5S/ZAiPAtIa77q9Fsszw6tTk8xKVffSwM5+xn/kBeZnygdIGFTAgnS
         fAcCT7aft6rrbdYa2cBQzyEX8IGaoBnt8/7Y28GlYwFr/6aKfGiKMT9ROfxe6XLvJrLm
         VVbcTSkeLpreLnKhNPbf04BL+GCAvN8tA2OqWovxzi0ZLKPj83JV4x4FnGRpHuy7c68b
         MLeGyAuChBbZP2fCVxt31X8Z7wEy5ghwwEl1VS5b5FlwuSEgNTWYPh86/tPC2jP3F2QJ
         3Kqg==
X-Forwarded-Encrypted: i=1; AJvYcCX5jqC9MX2KTkpnoiDvaPT7bE4q28PJGR/u2q4m6OaD9Fse8NcuOS5ATJeR6yWWUrOiDi1n6+QLknkPvVvo@vger.kernel.org, AJvYcCXkwK8Quc1QpUbifbXPVs4M60O2eMNyjX24APCIAZqS8NUxf+kQ0b0vsDPFDFKEGj8Q3pE57cz1Q8tl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyncm5ZrQS/zyPZ+OdBoK9xgaw2RHh2OYTMsmecPmml8hQwjRO6
	AQxQY9bk0dxC/3+elgkvQJ372/xH3v/+9fTrOGgCV56pZ+Z8YWDj
X-Google-Smtp-Source: AGHT+IGvK6Je6lL02ozpRaYklA0yiDCKfJuDxR/k7NOTIJ9ruYRb6YZUw/mv1vmSox7D4LVmdMFcvg==
X-Received: by 2002:a05:6402:50cb:b0:5c2:6311:c9d1 with SMTP id 4fb4d7f45d1cf-5c464a5c02bmr1993961a12.22.1726836472348;
        Fri, 20 Sep 2024 05:47:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5dd02sm7221881a12.41.2024.09.20.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:47:51 -0700 (PDT)
Message-ID: <36e4c636578f2871c0f6b4c6242d71e409215ae0.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: axi-dac: add ad3552r
 axi variant
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Date: Fri, 20 Sep 2024 14:47:50 +0200
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 11:19 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
>=20
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using an additional QSPI
> DDR interface.
>=20
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0.../devicetree/bindings/iio/dac/adi,axi-dac.yaml=C2=A0=C2=A0 | 40 +=
+++++++++++++++++++--
> =C2=A01 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..6cf0c2cb84e7 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -19,11 +19,13 @@ description: |
> =C2=A0=C2=A0 memory via DMA into the DAC.
> =C2=A0
> =C2=A0=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> +=C2=A0 https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.=
html
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-9.1.b
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-ad3552r
> =C2=A0
> =C2=A0=C2=A0 reg:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> @@ -41,22 +43,54 @@ properties:
> =C2=A0=C2=A0 '#io-backend-cells':
> =C2=A0=C2=A0=C2=A0=C2=A0 const: 0
> =C2=A0
> +=C2=A0 '#address-cells':
> +=C2=A0=C2=A0=C2=A0 const: 1
> +
> +=C2=A0 '#size-cells':
> +=C2=A0=C2=A0=C2=A0 const: 0
> +
> =C2=A0required:
> =C2=A0=C2=A0 - compatible
> =C2=A0=C2=A0 - dmas
> =C2=A0=C2=A0 - reg
> =C2=A0=C2=A0 - clocks
> =C2=A0
> +patternProperties:
> +=C2=A0 "^.*@([0-9])$":
> +=C2=A0=C2=A0=C2=A0 type: object
> +=C2=A0=C2=A0=C2=A0 additionalProperties: true
> +=C2=A0=C2=A0=C2=A0 properties:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-backends:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI backend refer=
ence
> +=C2=A0=C2=A0=C2=A0 required:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - io-backends
> +

I wonder if it makes sense to have these specific bits only for the new com=
patible?

- Nuno S=C3=A1



