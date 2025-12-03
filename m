Return-Path: <linux-iio+bounces-26677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A179BC9F109
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5D347741
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C742F3C1D;
	Wed,  3 Dec 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yljj44ar"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED802DFA40
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764767283; cv=none; b=U+23w6/LE7kitFR1tkJZepIXczQux/ko1wfVYFagUfSsN81079HOcFGoPzVQKOTEO3B1zUWqjIZLvT9uSwEBD5ahju5XMYJuLK9KE9oQhiHo1VaTNsAm/Qx2AHFGMZrkBuvOa8EOpNX6/uQknr025QVZ5rwyILyIqdeLYTbTKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764767283; c=relaxed/simple;
	bh=EWh94cVY0D6FnBBwVmY2kC4jd28KOSPDmIcH41P+nxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cw8vJEMqvtgcy6Na4dPt61EA4yOFmCpjWdksi/JJ4mGROgqrBYZUAquUOVg+Fvl1QNsycsRInJwgkv8NfZBFfYX2dRJV38QpViEo21ljC3Bsj+JTNhzByxvEH3QVlaKDYyb79KgAZg+4GssaFO9qbJCraAb/oBy9d3FmOfSjgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yljj44ar; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7373fba6d1so1056818266b.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764767279; x=1765372079; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWh94cVY0D6FnBBwVmY2kC4jd28KOSPDmIcH41P+nxM=;
        b=Yljj44ardop8WhV6M5KzR+eKEIHYQejcWruHxqxgnR1+/MzUo5F7DrQll1BGY5LPwS
         y7e3A+kZ7DQe9ctfYhLTyNZoEOXp/6DECmNyupA5LU6vNpQt1Mc/Aa403WlOuCkR209M
         n7NTNN5IJkYvK7xIN9V5rtt85eNz58uEoVUZ7CKEU6S5/QBMD1Sm0QgzpX3FJjjtgDoD
         MffON4ATmfBpYGD07UMBJ0M2FSfcJPVdNfxaBTfjj9po7hZyat4X1dnHZkBpPpnRsasv
         cZvl2lfMBh4ZCG5yNSagZKlepCXZCvu3OBEpdEqinSLDWrkny4EDWaqrFS03a5WY/0r6
         NUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764767279; x=1765372079;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWh94cVY0D6FnBBwVmY2kC4jd28KOSPDmIcH41P+nxM=;
        b=XPsAPDd+hGLwoa7E2KXto0taPKhip6CPOuPMlFkmkHrC82nFzi33Hg1YoB7PeZEXFv
         UF60a3lh2bkmDjkCFAK2tOX4rU8oJhuZXA+EBdgmSx0+i5tJQCAymhvwO/Qq0NKiF10r
         CVuDTmzeckKG7kZysv6Z493kJT994lT6PAjS28jgSIfCVTCVbukGQpknqqx9spR59E9v
         uErnMcGamlyNdRDtar7KV8at4xhGNNc3SCjHNc4REu+3zrUP80P9sA1cVdws+VwebiYq
         bZpG59uR9lihJ09fem8X8eINcTZOxwIUGa7byJpcXuXOwl05vE839+5MKUooVEx4qXYf
         lS8w==
X-Gm-Message-State: AOJu0YzOffCjvW/vkh4BBs4uYuoVWFScCd2hCPIsoRfRA0hMcn27VMNY
	JSK8g+43Wd4xI7mhpojBMoHHFg23Lq6Q3vaYb6k2mt2TtVVSS0OfquG/
X-Gm-Gg: ASbGncu1HWbQHe6V6iJ0UteGkOoaqhElPrQXOtGq3+Bn+zUMszxh/XtrOUXj36vmgnq
	HJTKgQlbtP0rds2xvqrosYqImnuk67kJRYAOpYKSh35j7Smgqa/bau+TAOqT/r9Zfj0ZC61KvFB
	p0jWc1cO4ZQPWH3WTt23blTC8ntSYs78+Jx+mVgaRcmB4myaRMI4gfnCkzGNhJMO9VyoSjYCsU7
	wyi3TiP9gqB/jcx3f2bgCjF1nXFxPDR+7RWp2ded+zLZMjmWvB+aRz2M14BPhMIn4XBbGmVL4S8
	tQS20WNnamtyipZI6FqA2J+bufMnyZqXrqYb5nG8rguiwsrOAjbQyC5eV6i3cDvSpBzvNIaZ5Ik
	LUoDd+h4Br4LY5PuYGOWDYUQcn57K/ATLrtg+gBDXUEDMamOTgUJQV1oeA5I2qXvSW4azpFnSTZ
	lKpzQu2jddaUo=
X-Google-Smtp-Source: AGHT+IE6T0tp3O3Eirx8vFcdkDxp9ZkMVwwUAWcbMJ390y36T3NZUXSwBXZa+DvBNpDi3Eyx+LkUJw==
X-Received: by 2002:a17:907:869f:b0:b6d:7e01:cbc5 with SMTP id a640c23a62f3a-b79dc7820d4mr244893066b.53.1764767278739;
        Wed, 03 Dec 2025 05:07:58 -0800 (PST)
Received: from [10.5.0.2] ([185.128.9.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a1d750sm1746718666b.56.2025.12.03.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:07:58 -0800 (PST)
Message-ID: <078d2c26a9939d3882d1e8597e4c9930fa99acff.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: adc: ad9467: add support for ad9211
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,  David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 13:08:38 +0000
In-Reply-To: <20251203-add-ad9211-v1-1-170e97e6df11@vaisala.com>
References: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
	 <20251203-add-ad9211-v1-1-170e97e6df11@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 12:20 +0000, Tomas Melin wrote:
> Document ad9211 variant as supported by driver.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

You should mention why this can't have a fallback compatible. Like having a=
 different scaling factor
is enough justification for it.

- Nuno S=C3=A1

> =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> index 2606c0c5dfc61fd65cd0fb2015b3f659c2fc9e07..5acfb0eef4d5cf487adaa93ce=
5bda759bb4853c9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> @@ -18,6 +18,7 @@ description: |
> =C2=A0=C2=A0 All the parts support the register map described by Applicat=
ion Note AN-877
> =C2=A0=C2=A0=C2=A0 https://www.analog.com/media/en/technical-documentatio=
n/application-notes/AN-877.pdf
> =C2=A0
> +=C2=A0 https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD9211.pdf
> =C2=A0=C2=A0 https://www.analog.com/media/en/technical-documentation/data=
-sheets/AD9265.pdf
> =C2=A0=C2=A0 https://www.analog.com/media/en/technical-documentation/data=
-sheets/AD9434.pdf
> =C2=A0=C2=A0 https://www.analog.com/media/en/technical-documentation/data=
-sheets/AD9467.pdf
> @@ -25,6 +26,7 @@ description: |
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad9211
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad9265
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad9434
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad9467

