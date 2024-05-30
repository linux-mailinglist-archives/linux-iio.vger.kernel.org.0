Return-Path: <linux-iio+bounces-5478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8C8D45D1
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50A71C21183
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F94D8CD;
	Thu, 30 May 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyqD/HGq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB64D8BC;
	Thu, 30 May 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053147; cv=none; b=QSG3gZnRwM0EJRSF1+5fAqIRzrPVvbS6ZANfDkRnl2O9/CyZxqfpHwNJzN4N7v7rtcL8ySdAFylwBLKMgLd9HXHWDacTxfVK6Bfnji9mLDTOjO/ZXhdi8+YHCnGoYeq1VEUnN3FTlEFJdWuKKfrz4ta2xds8suE012rxvBqrb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053147; c=relaxed/simple;
	bh=giRoWFP/dK6yBYYrKO1WByFz+guxxPBaXEYqITRH9+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqXk07YNtvDx60FrHNV9dto7wHp8o/BGu4zlny1PvrIsnqSrUreegzH3bw5bSX3u9onf/z89FDM+ZI94UhdVkxEZG8oP+gQuv0IF9dPYlgUOWGB/a3ha0WP/BjlAaMGZMz1o/BrKZd60Q7FEqhCsrFee5mIgS8QlrTC6t0DnGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyqD/HGq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295e488248so503487e87.2;
        Thu, 30 May 2024 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717053143; x=1717657943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AtuMkBV5/fN1Y5ikAUBcbyyc1HbEdNZWiWlekP60Y7M=;
        b=MyqD/HGqW8epxFgo15/gVBcpMubfLJOgKtXrlQJOee660j0O9wr3vmhQ36+RGgN19R
         ej0FHqGbSYSb2OJrfkhLy1TM/i2W0H3mxKP8jGkTXcytCyfCVJ3apdNLNCYcdaOO9izt
         0dOk6fyltznFV/rACBAnYXCL/uIgz80MTE49WR3yUbNa35u3NQQW6w4UPq4ikrVHt4U3
         zysvCOrZnJ3/FidpMhrMfaJDosuMbV9I6HRYSwQdDQuB8vGIlqVNIfvBLZhtXObzhxvW
         9Y/UKHZGGPuPhSxXP7wMcthXfGFnA5F81m7oydooQMNeY443h0Auamz6P6AIBqTgKjXP
         gv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053143; x=1717657943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtuMkBV5/fN1Y5ikAUBcbyyc1HbEdNZWiWlekP60Y7M=;
        b=rKSyT57Zy1xjmE2fZygxraDs/dfD7Vf4kJAiLOP3uxw/33Y0Ebqby8nyRaLcGJScyN
         5uUTqLzYL3Nwr0dXFxjT5NMmz30HdrJ6+nNYAA0cEAfL5tP0pNFFLmt7fk++9LEBgz7G
         nxWYN5zFKXMS6b7pzbZLVekOKe9cOrUxImrIbSR9lEe7dcHO9kmrOAZwTPZVd7X5gQL/
         zHdb2SOM50l4UXYmnCSdQNrhtsqoLZgzw4N+X/CIfEb3ftO2DJIeO6+BJ5SrvRZYmdQl
         +j2CfzGM2hXqps3bH5fc5+2fogsOydsZkiglq/ai0hac0epiMPRcx5AXc713+sIMhXoI
         /8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVdS2+PH29crp7ZMvai1BvCR9r2yGdWC+8svKxZdSz63EciNaJq0LQr5i/TRaBSvYWJAK6Vr/Uuuwpo1x+0Zugkha6AThKI122hWqqKuanQhnOcSG9LZIGfIJHoPByh1xsVDlr91jzB2p1/HVsSqzHJdzLVUK6YgD8JEs/gHLiJUl6g7Q==
X-Gm-Message-State: AOJu0YxVRDXfRfWE4GzMdLgcuCYC2kViiGsL5Fj9k4m9v4O91DgDY5lH
	RsM+xKVe3mBTomvM32ftEZv1pHpeO1l5cpyUHUTbYYzWXcYpxeFj
X-Google-Smtp-Source: AGHT+IGlbJ6SgkXTgsdRMdKoETLyUQli4nBpb8o60i2HyKVHmMf5vMGkASllfGkOEwjvm7DV4jsRdw==
X-Received: by 2002:a19:521a:0:b0:51d:9e17:29ea with SMTP id 2adb3069b0e04-52b7d422099mr633102e87.15.1717053143282;
        Thu, 30 May 2024 00:12:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-356c8daef27sm14554592f8f.115.2024.05.30.00.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:12:22 -0700 (PDT)
Message-ID: <218737c70a9215e1ed49874f075a616bc9cf1de9.camel@gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, "Ceclan, Dumitru"
	 <mitrutzceclan@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 30 May 2024 09:12:22 +0200
In-Reply-To: <362e006f-7856-46e3-90fa-b1610784ee9d@baylibre.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
	 <20240527-arguably-said-361184ad848e@spud>
	 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
	 <20240528-filtrate-cloning-b9152322a3da@spud>
	 <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
	 <362e006f-7856-46e3-90fa-b1610784ee9d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 17:04 -0500, David Lechner wrote:
> On 5/29/24 8:38 AM, Ceclan, Dumitru wrote:
> > On 28/05/2024 20:52, Conor Dooley wrote:
> > > On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
> > > > On 27/05/2024 20:48, Conor Dooley wrote:
> > > > > On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 R=
elay
> > > > > wrote:
> > > > > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > > > >=20
> > > > > > Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
> > > > > >=20
> > > > > > AD411x family ADCs support a VCOM pin, dedicated for single-end=
ed usage.
> > > > > > AD4111/AD4112 support current channels, usage is implemented by
> > > > > > =C2=A0specifying channel reg values bigger than 15.
> > > > > >=20
> > > > > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > > > > ---
> > > > > > =C2=A0.../devicetree/bindings/iio/adc/adi,ad7173.yaml=C2=A0=C2=
=A0=C2=A0 | 122
> > > > > > ++++++++++++++++++++-
> > > > > > =C2=A01 file changed, 120 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad71=
73.yaml
> > > > > > b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > > > > > index ea6cfcd0aff4..5b1af382dad3 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > > > > > @@ -19,7 +19,18 @@ description: |
> > > > > > =C2=A0=C2=A0 primarily for measurement of signals close to DC b=
ut also delivers
> > > > > > =C2=A0=C2=A0 outstanding performance with input bandwidths out =
to ~10kHz.
> > > > > > =C2=A0
> > > > > > +=C2=A0 Analog Devices AD411x ADC's:
> > > > > > +=C2=A0 The AD411X family encompasses a series of low power, lo=
w noise, 24-
> > > > > > bit,
> > > > > > +=C2=A0 sigma-delta analog-to-digital converters that offer a v=
ersatile range
> > > > > > of
> > > > > > +=C2=A0 specifications. They integrate an analog front end suit=
able for
> > > > > > processing
> > > > > > +=C2=A0 fully differential/single-ended and bipolar voltage inp=
uts.
> > > > > > +
> > > > > > =C2=A0=C2=A0 Datasheets for supported chips:
> > > > > > +=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4111.pdf
> > > > > > +=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4112.pdf
> > > > > > +=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4114.pdf
> > > > > > +=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4115.pdf
> > > > > > +=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD4116.pdf
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD7172-2.pdf
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD7172-4.pdf
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD7173-8.pdf
> > > > > > @@ -31,6 +42,11 @@ description: |
> > > > > > =C2=A0properties:
> > > > > > =C2=A0=C2=A0 compatible:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4111
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4112
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4114
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4115
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4116
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad7172-2
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad7172-4
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad7173-8
> > > > > > @@ -129,10 +145,36 @@ patternProperties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 15
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff-channels:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For usi=
ng current channels specify select the current inputs
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
nd enable the adi,current-channel property.
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Family =
AD411x supports a dedicated VINCOM voltage input.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To sele=
ct it set the second channel to 16.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (VIN2, VINCOM) -> diff-channels =3D <2 16>
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 There a=
re special values that can be selected besides the
> > > > > > voltage
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 analog =
inputs:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 21: REF+
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 22: REF=E2=88=92
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support=
ed only by AD7172-2, AD7172-4, AD7175-2, AD7175-8,
> > > > > > AD7177-2:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 19: ((AVDD1 =E2=88=92 AVSS)/5)+
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92
> > > > > > +
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
nimum: 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
ximum: 31
> > > > > > =C2=A0
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single-channel:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Models =
AD4111 and AD4112 support single-ended current
> > > > > > channels.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To sele=
ct the desired current input, specify the desired input
> > > > > > pair:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (IIN2+, IIN2=E2=88=92) -> single-channel =3D <2>
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum=
: 1
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum=
: 16
> > > > > > +
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,reference-select:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Se=
lect the reference source to use when converting on
> > > > > > @@ -154,9 +196,26 @@ patternProperties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - =
avdd
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: refou=
t-avss
> > > > > > =C2=A0
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,current-channel:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signal =
that the selected inputs are current channels.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Only av=
ailable on AD4111 and AD4112.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,channel-type:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Used to=
 differentiate between different channel types as the
> > > > > > device
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egister configurations are the same for all usage types.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Both ps=
eudo-differential and single-ended channels will use
> > > > > > the
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ingle-ended specifier.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/type=
s.yaml#/definitions/string
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - singl=
e-ended
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - diffe=
rential
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: differenti=
al
> > > > >=20
> > > > > I dunno if my brain just ain't workin' right today, or if this is=
 not
> > > > > sufficiently explained, but why is this property needed? You've g=
ot
> > > > > diff-channels and single-channels already, why can you not infer =
the
> > > > > information you need from them? What should software do with this
> > > > > information?
> > > > > Additionally, "pseudo-differential" is not explained in this bind=
ing.
> > > >=20
> > > > In previous thread we arrived to the conclusion single-ended and
> > > > pseudo-differential channels should be marked with the flag
> > > > "differential=3Dfalse" in the IIO channel struct. This cannot
> > > > really be inferred as any input pair could be used in that
> > > > manner and the only difference would be in external wiring.
> > > >=20
> > > > Single-channels cannot be used to define such a channel as
> > > > two voltage inputs need to be selected. Also, we are already
> > > > using single-channel to define the current channels.
> > >=20
> > > If I understand correctly, the property could be simplified to a flag
> > > then, since it's only the pseudo differential mode that you cannot be
> > > sure of?
> > > You know when you're single-ended based on single-channel, so the
> > > additional info you need is only in the pseudo-differential case.
> > >=20
> > Yes, it could just be a boolean flag. The only thing I have against
> > that is the awkwardness of having both diff-channels and
> > differential=3Dfalse within a channel definition.
> >=20
> > No, there is no uncertainty regarding pseudo-differential, it's
> > basically single-ended.
> >=20
> > We cannot use single-channel for voltage channels, two voltage
> > inputs need to be specified. And again, single-channel will be
> > used here for the current channels.=20
>=20
> Instead of using diff-channels for single-ended/pseudo-differential
> plus a property that says "actually not differential" could we just
> add a second common-mode-channel property to specify the second
> input pin that is connected to the common mode voltage source?
>=20

Yeah, I definitely don't like having diff-channels and then go "oh, not rea=
lly a
differential channel". So, if could avoid that, it would be great!

> Just to make sure I'm understanding, single-ended means common mode
> voltage is 0V (or AVSS for this chip, I guess) and pseudo-differential
> means the common mode voltage is something else other than that.
> In other words, single-ended is just a special case of pseudo-differentia=
l.
> So effectively, no difference that we need to describe?
>=20
> So something like this could work?
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* a fully differential voltag=
e input channel */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bipolar;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff-channels =3D =
<0 1>; /* VIN0 is +, VIN1 is - */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,reference-sele=
ct =3D "vref";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* a single-ended voltage inpu=
t channel */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <1>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no bipolar sinc=
e common mode is 0V */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single-channel =3D=
 <2>; /* VIN2 is input */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common-mode-channe=
l =3D <3>; /* VIN3 connected to 0V */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* a pseudo-differential volta=
ge input channel */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@2 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <2>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bipolar; /* since =
common mode is not 0V */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single-channel =3D=
 <4>; /* VIN4 is input */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common-mode-channe=
l =3D <5>; /* VIN5 connected to Vref / 2 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,reference-sele=
ct =3D "vref";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> 	/* a current input channel */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@3 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <3>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bipolar;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0 is not the sa=
me pin as channel@0 because of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the adi,cu=
rrent-channel flag */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single-channel =3D=
 <0>; /* using IIN0+ and IIN0- pins */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,current-channe=
l;

Unless I'm missing something, this flag is also not being used anywhere in =
the
current series?

- Nuno S=C3=A1



