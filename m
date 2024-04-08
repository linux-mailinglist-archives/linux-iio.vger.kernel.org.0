Return-Path: <linux-iio+bounces-4145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988489BAD7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E91B23BD9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0147F7C;
	Mon,  8 Apr 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVMxL+Ye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEE481A7;
	Mon,  8 Apr 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566094; cv=none; b=tIlmv6RNp1q5KyHByW3msZqi3ErFNbbNkayUShChfYMfJRHnEqQhqdviMh8uP8OMRKo+XeL9hapn6MGwVC5AdvEOmtjGvQ4yUYOUuhCU03CCcIBvueJmQFuvM2unY2U7CL8caBAdsYu7OWKnDLGglAFu7+EEuN2K3T1uil6OFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566094; c=relaxed/simple;
	bh=X0HDNO7AeGlMTox0YwbYf+RZ/kvp2RnxUzxcdGNoImI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDqFSyjPI5KdNBZlvGoRobqI1d184hUXGkOcceUVpYKWwvLM+cKloV6bKyIq7/RUdrXvenaM3SPT1J3slerXrcX1OTyBNVzYx8MK56GXbgzzcf3bTAowUBPBefmNazj6VYPISI0xorTLIwcPVni5tvgsHCn1wsoMoo9OovOYpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVMxL+Ye; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4702457ccbso543087966b.3;
        Mon, 08 Apr 2024 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712566091; x=1713170891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wpo8vrs9eO0Txlhpk0PzKhHZasRAvjQ2hvMb1Hj5UVE=;
        b=RVMxL+YefrClPiLT2+Lh/ErWjV7ZSmTvmKmX9cGj2F2WDFq70YnhRHImu2tP8pfvf7
         5JQTd+LyvXqUZytsqIvcy0JyfvF7xQfx8QQSLkTBs3aoW6UHvIm0gZi2xYCABAj2FFtp
         IaO2YimNn19ZtRnIkqIaWEbqc6i+ZpcpnyauaH0U3gho8mYjjkwVnQLYMaOa57i7RQd0
         gz/gc7s6FT3F3ua+MuHWealBMdzuanRmpLdkWZsuJd07hMimp7IyvbOv2cCO6aPSvHLC
         LniYLNyFuKCzUuEacCs2x1pRIiJzgNNiRXas8wt0WO3+RRZl6BDaNOd4mCDIWBVYtQnM
         tagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566091; x=1713170891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpo8vrs9eO0Txlhpk0PzKhHZasRAvjQ2hvMb1Hj5UVE=;
        b=AD/5i4IAjIfRODwvY26D7BD9Z+Hq7n6qSat/FMj6otzW4gaxhzzkw9rKXNYIh61Zro
         gJrdDinn3Dh34JLMyhzjffhAehLCoHteUYrEFHLCCD7zkk/rX36qQSzXLNDCoAEIRsb4
         X3cCG0jNt0kH6VgPs00ShMD0EzAoG4rU4s3DqtBGC5GxWgeF+m3NwlD2mNW0eYSb//xS
         x4kecZiWUDvl6GttK4Ap1/NohgG3QIdCn7ia3IGpaqxWXEGe5mg0NoG/njbEV/XoDvj8
         Aidos5RCniBPHf9Y4zXxBOstKfnwt4EJMdPzWy8K6ZJMX7v9JMmC7uNBewnS2cHEoG4f
         DmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXriUb28WuH7O+3iqE/ApxYELGtpFd3Eit8m6zWcWGOUlamLkH5Wxa8Ah0xPBaWhLwzldd12b45KS+3cR3Pq7bGFrpRPrjDYo1ZZQ==
X-Gm-Message-State: AOJu0YwDgiFxzxVnCBIrZIyeAylyc0ZVI9hZYR2UnffGP5b6nFQb1gIU
	CJ1sMAxbpXvDbLM2nMGiBTtAX/sShbPL1TYG1jZ/oTtFptCGLiHBytzP2QOrpH+d+w==
X-Google-Smtp-Source: AGHT+IF7QtL3Wea9RVeYfqOxn5Yt1G1Xm3dw/GUgliBFwnsRoEWWzK/lm9TQKjLSMB6Wg1xBOW8JKQ==
X-Received: by 2002:a17:906:6a17:b0:a51:c52e:3ed4 with SMTP id qw23-20020a1709066a1700b00a51c52e3ed4mr3546042ejc.69.1712566090752;
        Mon, 08 Apr 2024 01:48:10 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id qy47-20020a17090768af00b00a517995c070sm4143172ejc.33.2024.04.08.01.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:48:10 -0700 (PDT)
Message-ID: <d99653ec9a40a16b088c425d5552de85892564fe.camel@gmail.com>
Subject: Re: [PATCH v2 11/11] iio: dac: support the ad9739a RF DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 08 Apr 2024 10:51:43 +0200
In-Reply-To: <20240406174119.38b821ff@jic23-huawei>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	 <20240405-iio-backend-axi-dac-v2-11-293bab7d5552@analog.com>
	 <20240406174119.38b821ff@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 17:41 +0100, Jonathan Cameron wrote:
> On Fri, 5 Apr 2024 17:00:09 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are cap=
able
> > of synthesizing wideband signals from DC up to 3 GHz.
> >=20
> > A dual-port, source synchronous, LVDS interface simplifies the digital
> > interface with existing FGPA/ASIC technology. On-chip controllers are u=
sed
> > to manage external and internal clock domain variations over temperatur=
e to
> > ensure reliable data transfer from the host to the DAC core.
> >=20
> > Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> The only thing I really have remaining questions on is the choice
> of chan_spec with altvoltage and voltage channels.=C2=A0 Why does that
> split make sense?=C2=A0 It's odd enough that some comments in the code wo=
uld
> be a good thing to add.
>=20
> Jonathan
>=20
> > new file mode 100644
> > index 000000000000..9b91d66f826c
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad9739a.c
> > @@ -0,0 +1,454 @@
>=20
> > +
> > +static struct iio_chan_spec ad9739a_channels[] =3D {
> > +	{
> > +		.type =3D IIO_ALTVOLTAGE,
>=20
> So this looks a little unusual. Perhaps some comments on why it
> is appropriate to have this channel.
>=20
> In reality there is only one channel I think?

Yeah, I had this same discussion internally and was also thinking in having=
 one
channel (just ALTVOLTAGE). I ended up doing it as we have done it internall=
y so
far. The reasoning is that we have two sources of data:

ALTVOLTAGE: It's the internally continuous wave the backend can generate. T=
hat
is in fact alternate voltage.

VOLTAGE: Is kind of what I call external source where we assume is just typ=
ical
DAC data and that typically is VOLTAGE (but for a dac like this, I think it=
 may
very well be, if not most of the time, also alternate - the thing is, we ca=
n't
know for sure as we should be able to have both)

- Nuno S=C3=A1=20


