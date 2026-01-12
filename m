Return-Path: <linux-iio+bounces-27637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C347D12BA4
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 14:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0A1300C6D4
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34946357725;
	Mon, 12 Jan 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEdAe+H+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748152222C4
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224073; cv=none; b=k2+uP60DUp30jceF/g8B7kDzzHhpd18fKEduy/pCyue4iTzAb2fX8pehfr00PKhhOj/mSbZutC93ZXrnH1qdRnBYU4LFQDfV89HaiYFRs2Evidb/9NdplWGopI0frA8Os5RwqADdy1ax6+0ey96jAjiokpLesGGFrWr9Kx84kEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224073; c=relaxed/simple;
	bh=QrUQeHmuD7Kq7P+N9j6XZkXNDTrh42rBy966fxPI1wM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEQkgWnU10h/Bandc0daEhvaeSwrknmjOyN+YPKo5G3hJF0gzBylKXryzBUKpoQu54QzfTf2OAyDfGSL5FpZucIUI0V1IPP3oC+nMk4cYri7h5fhi9ECCIdqB78x5zKaEo2nFTEFXTXQbR5YfxaUd8gTAFME4PHgahBGFKYVRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEdAe+H+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so59912825e9.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768224070; x=1768828870; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qaUR1iXVEZCuCvQZbgMPmGmuTJhDs6JoaR/MCARuHcA=;
        b=TEdAe+H+43QdOHfm9wP0Xq1F7IwfrXGs1AWQc2fvgQwjq5lPrTds/CS4o/Z0UtBLu/
         D2H/nMnGlfH5e1EOVU89WnVudObyqkM0vt27py4WOCQmC2fpxdBICJEHHSDQOIt3DB2b
         7qUNE5OD86SUD/A+NjO75ALqvYH2o4plcoo9dmvU4z4j+PmdAyaUUH/zkDXvFpcUXIUn
         fLO8OkAn8mPQ8ojNoHfeqv+Re1Biqm/mydCohE3aSkR6oBpsqhY+POuQ4KjeFd033elN
         gB+wt6pF1flWqfxQuI+9jIg8qbxwZkewOb9hqxCmbecAL/DurWAQxYwBHRMqwXEtGjtW
         Q2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768224070; x=1768828870;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaUR1iXVEZCuCvQZbgMPmGmuTJhDs6JoaR/MCARuHcA=;
        b=D1u/O1xqCjeWF4NOg7nDL/aRAWLHAEIjAzolNfJ1lVQJTrO3vpWfK5uLDVwLXHe5Tj
         iaU01J67Ba/wa75fJpCi6ExNDFPsOmc7ZQ1SxK8kGt9FO+y4ugLDlz6wRMAk0aqeKo4H
         n63THLe7VwbfdBJJUFty5HrEI0nB6C5tkqCMPDKPcZXvw78kG+N2XNcyGfgBgHS6jBI4
         g4wbVu96/OXDSlQvuyHTnWbyZUAR2tEB4fi8E+CqiD9K3BYs94Y35aVzKs+DnL7lqWQj
         ZM5UIUhqAqeM3YTrfoF8NSTq8HJzCvkkQXmYpeIDiM5P0thLEg0JJuEKjdsPMH2FmaYx
         5PDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqkC0nLBcYC4WhGVz3FufHEVZPSup2NrnSD4JAqB8oMES3sUdbAd4UhiAoE1gncbl5WzdI9lpLhes=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEdBj4Z503jEnuMd96djiM+2TkStDWbklM5dInrebDMVmP8jg
	jx7bqIfr165RvECD31q5yqaq1o1hohLcgO8YMnAZFq3UZEHxMMxLwyQJ
X-Gm-Gg: AY/fxX6pSEEpzVGTazL3zOBUNYkAJxFEW57ZADfZz8kXSQ5K4YMM532SLkovs4Bkcal
	fWlAExPN1yjNMRXJlIKpee+d3zzFvnnqIUxiMEyrzeghCz9qYkZQmVT8N89XJvmluUAZWF+tkta
	ATmiWD7ykN7n7/xigdQfwgDEuEf05WN3Q595vEwK9zKKww3jnIMiZhLsNSoacZ/TXUQxwyDLd2T
	Nn3GTNpZm4F996I0MJdHbaWqwLRnS0SArTTJcBTr8+kYhUGbzmYggvZrQaMVfL6GONapjYpsTlw
	4HL4eN6vXkkMrzOIOdDUab98d6vX5WxUrMrtUEbyNMJRE/mFUbomlkdeQaP/BZsY8jQikCZwMmF
	e5sNXCe61IlAc2E2sFPJVi5usHsvia8dGGRbMI+TsFVdHmLRtGqtn7se9FHYSR7ymvieOHX1zf4
	xEXcBMwtAv7fubhugr1Iz1186jKjSfyw==
X-Google-Smtp-Source: AGHT+IFK+bTXgrx0rrDtsi2mZgSzqRkancBWy+9OHXmBOnd3lcCOJSOYbZz3Wv2tOFi5TLTuZs94xA==
X-Received: by 2002:a05:600c:8b57:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-47d84b182a7mr202762515e9.15.1768224069584;
        Mon, 12 Jan 2026 05:21:09 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86c6ff40sm284618595e9.2.2026.01.12.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:21:09 -0800 (PST)
Message-ID: <d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 13:21:51 +0000
In-Reply-To: <20260111114109.28b01266@jic23-huawei>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
		<20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
		<20251221200014.29af7df8@jic23-huawei>
		<356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
		<997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
	 <20260111114109.28b01266@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-11 at 11:41 +0000, Jonathan Cameron wrote:
> On Mon, 05 Jan 2026 14:57:02 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:
> > > Hi,
> > >=20
> > > On 21/12/2025 22:00, Jonathan Cameron wrote:=C2=A0=20
> > > > On Tue, 16 Dec 2025 11:40:06 +0000
> > > > Tomas Melin <tomas.melin@vaisala.com> wrote:
> > > > =C2=A0=20
> > > > > Not all users can or want to use the device with an iio-backend.
> > > > > For these users, let the driver work in standalone mode, not coup=
led
> > > > > to the backend or the services it provides.
> > > > >=20
> > > > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>=C2=A0=20
> > > > Hi Tomas,
> > > > =C2=A0=20
> > > > > =C2=A0static int ad9467_probe(struct spi_device *spi)
> > > > > @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device=
 *spi)
> > > > > =C2=A0	indio_dev->channels =3D st->info->channels;
> > > > > =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> > > > > =C2=A0
> > > > > +	/* Using a backend is optional */=C2=A0=20
> > > >=20
> > > > I'll largely defer to Nuno on the backend aspects but I would like =
a
> > > > lot more than a statement that it is optional in this comment.
> > > > At least something about where the data goes and what a real system
> > > > that didn't provide a backend would look like etc.=C2=A0=20
> > >=20
> > > Having the backend as optional is about flexibility to incorporate th=
ese
> > > devices as fits best with the system. The current backend approach is
> > > pretty much dictated with how the ADI default backend is implemented.
> > > These devices are fully configurable via SPI interface so the backend
> > > doesn't necessarily need to be anything fancy or even configurable.
> > >=20
> > > So there is atleast two use cases that promote the optional iio-backe=
nd
> > > approach
> > > =C2=A0- simple backend that is not configurable, no need for a dedica=
ted
> > > driver. The backend (FPGA) sits and waits for data and handles it whe=
n
> > > it arrives=C2=A0=20
> >=20
> > Agree on the above. Ideally we could have some dummy backend for the ab=
ove but
> > it is not really easy/maintainable to have it.
>=20
> When we say the backend needs no driver, where does the data end up?
> Is the idea that it goes into some processing pipeline and sent to
> some external path that we have no visibility of? i.e. We configure the
> data capture in Linux but never see the data?

Yes, that's also my assumption about Tomas's usecase.

- Nuno S=C3=A1

