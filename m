Return-Path: <linux-iio+bounces-5476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6178D4568
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386C91F22C6F
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 06:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A6155326;
	Thu, 30 May 2024 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeRdja3p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F51552EC;
	Thu, 30 May 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049872; cv=none; b=Uyu2h4E/KnHFOxBmTLOA4yBzL/mSX2OX0A/dZ+1TTjheg9mYCh2yasPG7GNHPLKMcJ6u72wWvvpmbYRTIbxOw3zBqXVPatqd7qTszf9WCxR+37ENBEV9g9Am+d1JTDf2vxoStP4K97lJdHIp5JcTpClRBMw+zl0RildN5KI4qOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049872; c=relaxed/simple;
	bh=mdgAiKbstfN1gUB5L/EsCiO3AyOoRXRVi2nIvdixAow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFcL3PrphYPOGYLjBDty6dB8rLnvW4Z1AF1qSzSEItYuaLf/KYeBpd7LppARYG0QYRd46luLHaXGymd9ZFjzOdkL2qztBY3KGhNWAQD/Ttrn4KjzG3XD58+YpZ93C+jPMFZH4c8H74yx5dvia6e85brnCewLFcc+MHwgJNgPzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeRdja3p; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dc0472b7eso500415f8f.2;
        Wed, 29 May 2024 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717049869; x=1717654669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSdHxLbmp97ia1G10K4CxsZgTHCb548EU1TzMRh6otw=;
        b=eeRdja3prnSVoisVedZOOgZkPV9l9OgWbRrXGAyHVKS4Cnln19f6U5Lu4NtIN58lCI
         VgWIo8gmAtYlhy6q6WQFRmytTl4H2W6a+LG672Y+Ui681A67i7eKCr86sjlw0PWolr6o
         Xc7VyrH1M90r/elFypoJLIZ+gGFwRIv1nNVuSAUaVd+M4LUazMMK5jzsJlao5jMGWmHY
         u6h05di0Sb0JAs6T2LvAaG3R2+iK0jKS8N+rb+7ZaMOicXJu9NaBCzUDmN/pIpBGybMy
         BQScjDlrq1En1sw0V7KL9P7a0ygxkc8smQa6HrA/05inq4xw9Jg7WY5GW+6umE4s0S1w
         P71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717049869; x=1717654669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSdHxLbmp97ia1G10K4CxsZgTHCb548EU1TzMRh6otw=;
        b=QKrHQI+b/B9Eq/XJsxYpVoH6fruJdq+DUnuvBXsSDELmQZsJbuOOzbbl1VHOPbXJnw
         man98p4oNZKye2+N460izNwTGM5IJ56mVWnxdztBlYandnSoaHbl2Q0VIXlHa+zunNot
         CHMhz8yTC5+xBD9LtEcAJvm2kYypdU8z37HENOC06Vh+N7dICNStEIxXfyUTV8qTwZy5
         ws6bxhkYyDCHSgH2UBoD5RXPWtBy8Trj5uTNg3eClx3xIS1EF0ljNtapRtVssMV+Pc0c
         D9rpIvo44/VnutEaKx3sXCEXZzvcnhP0VuI1uDZBWDwgiwrVTDchE8xpg3Rzg/U2NrE+
         sNeA==
X-Forwarded-Encrypted: i=1; AJvYcCX9xKd52CAgvJbDRbOZ5daXrkMcISy3F2t5a1JI/dhhBfMwICCpW8IgWtoGiXG2uJDFYe+mfExJHVYphSUD8bDzvZJ3XexfkuGBtPC7Tkxazgf02n+WPSsGpWgLg8DOcpeQJE+UpNRlUCgeJ9dU7JJwR6RsvXhlTtAiEQIRQ2ZB2phb4g==
X-Gm-Message-State: AOJu0Yz4L+mSS/926RybyPWYa1XtsrGk4WhLU68/EffKTXWnZ44XQIAz
	mwcAVeqz43V6qyGYadD/a0D4Q3NrP46BsCnTxBlKRFDcGLgJzdhd
X-Google-Smtp-Source: AGHT+IEkvn6YatjYVdSD+3mc2CY6smDx1erwxzGTzsxu2qJeg0ghrQ208yqof63hV9b736/V0cIgdA==
X-Received: by 2002:a05:6000:106:b0:354:f8a9:345 with SMTP id ffacd0b85a97d-35dc00845ebmr636222f8f.14.1717049868617;
        Wed, 29 May 2024 23:17:48 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a88esm16397009f8f.41.2024.05.29.23.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:17:48 -0700 (PDT)
Message-ID: <3dc83aa5c1d138ef70dd64ba4154acb52b65a8a3.camel@gmail.com>
Subject: Re: [PATCH v3 6/6] iio: adc: ad7173: Reduce device info struct size
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Thu, 30 May 2024 08:17:47 +0200
In-Reply-To: <ec2ac6fb-0f08-4e8c-8907-83bd8f0976c8@baylibre.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-6-7e9eddbbd3eb@analog.com>
	 <2f26b72970be841279ca00c1b5eb91dcfffabdea.camel@gmail.com>
	 <ec2ac6fb-0f08-4e8c-8907-83bd8f0976c8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 15:32 -0500, David Lechner wrote:
> On 5/29/24 7:23 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >=20
> > > Reduce the size used by the device info struct by packing the bool
> > > =C2=A0fields within the same byte. This reduces the struct size from =
52 bytes
> > > =C2=A0to 44 bytes.
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7173.c | 16 ++++++++--------
> > > =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > > index 328685ce25e0..e8357a21d513 100644
> > > --- a/drivers/iio/adc/ad7173.c
> > > +++ b/drivers/iio/adc/ad7173.c
> > > @@ -179,15 +179,15 @@ struct ad7173_device_info {
> > > =C2=A0	unsigned int clock;
> > > =C2=A0	unsigned int id;
> > > =C2=A0	char *name;
> > > -	bool has_current_inputs;
> > > -	bool has_vcom_input;
> > > -	bool has_temp;
> > > +	bool has_current_inputs		:1;
> > > +	bool has_vcom_input		:1;
> > > +	bool has_temp			:1;
> > > =C2=A0	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> > > -	bool has_common_input;
> > > -	bool has_input_buf;
> > > -	bool has_int_ref;
> > > -	bool has_ref2;
> > > -	bool higher_gpio_bits;
> > > +	bool has_common_input		:1;
> > > +	bool has_input_buf		:1;
> > > +	bool has_int_ref		:1;
> > > +	bool has_ref2			:1;
> > > +	bool higher_gpio_bits		:1;
> > > =C2=A0	u8 num_gpios;
> > > =C2=A0};
> > > =C2=A0
> > >=20
> >=20
> > This is really a very micro optimization... I would drop it tbh but no =
strong
> > feelings about it.
> >=20
> > - Nuno S=C3=A1
>=20
> This only considers RAM size and not code size too. At least on ARM arch
> every time we read or write to one of these fields, the code is now
> implicitly `((field & 0x1) >> bits)` so two extra assembly instructions
> for each read and write. This could be bigger than the size saved in
> the structs.
>=20
>=20

very good point...

- Nuno S=C3=A1

