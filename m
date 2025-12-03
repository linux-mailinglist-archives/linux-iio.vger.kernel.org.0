Return-Path: <linux-iio+bounces-26701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59133CA0BCE
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 19:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA61430BEA42
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DF36A000;
	Wed,  3 Dec 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+AFntyk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5936998C
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779466; cv=none; b=I9sax+nV/odLDxCCUYOBfd1CcJvB1+uytvPAI+60IMVoRV0WMYLFlowPvJXnwITVoNjtCGd/TPAhC3seSK+LcDotBKjAvngWA7aLGM3RKDe3wQWOfIkRZ7NerFFlTKPeG5e47Dat9KiD7V8XXwCNRqCLPTFKCn6yMRKy0JW33iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779466; c=relaxed/simple;
	bh=3MIXdsigspeo4C63T8qwnOO/mBFa2KWjzf0ry3UD/YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hB12Yh3DWjv112WF+zW479JLhpISHIHNUJxruZFsWU5RMMfBgRtkCN45aZ6evB3YGep0wQf5NXpVG5pMV+19OT0tANissDelFD3beQkCLy3+85i87i/xy2W7geICnlEQzy15oXoqcBFTCHN8KQ/vwGa4+iDTkqDneBaZZBUEaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+AFntyk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so978943266b.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779461; x=1765384261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2e6PRTEqI9s8FYnmq+wRVUx0fbB+PcW+ECf6OODKgVU=;
        b=m+AFntykArQ+p2PFWudoUlpL6pesxtLCRtNCAII1/klZzKku35gw985kA2dCmzHcGr
         6t6lvlaGyu7GMT9U1mR4ofmV5fEXqlTdBvOWhbpb+qEc5iSzwSwSif+1sTCqTc7sEpiz
         /mXISVi9Qr1cq2l0yQ+1B1sUcwQIjR1yAUEeKqhmiCtaBXtzoRhMfkQKwXr8vF69ssut
         Eo5wUTZ92Mlkx9Cnr7sG3ZuixNgwk5noLKdKITszI2L9Q18oJ2KUCZUL6QiUmndDrPIy
         F8R3KthHqu+6gAFHXMUHErjkPZTq+EVkuyotvx8kA/CZqAsf7GC14Jdu7rPxFgPhG9E+
         oG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779461; x=1765384261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e6PRTEqI9s8FYnmq+wRVUx0fbB+PcW+ECf6OODKgVU=;
        b=jbH0tPwNnqWy/2nFZp1IpCI2+OK2O/F78JtXx1pyXiYPcNI3QrL3RkWMzzYryBIvAR
         Ld7FTw5pgBbLVg6EfZD8F1oFHPMHic8hgYtGTU9f+i/glJoSTmWJFn5RfNUesmRx+Ba4
         s2BZjRCppe5CYGHSTTBtGOS/gmFOdBtE9MYDhecIJP1wg9IeEzneNNmg4K4RO/A0tX62
         Jy+euaOvM27vy/1EkCcbm3qUIjBgaLAqGnqfSkYdJUCSO3p+HGJRA0t3ZO8HdsK0z88k
         jZV6t0aP0wLNNhhqSqxbPYwaFfLL/F6rm8q26GJ3FHkYTmR04cgaUHRTPefG2ejdTCYp
         sUZA==
X-Forwarded-Encrypted: i=1; AJvYcCUH0GP2tSoKelUVppGbhX96R4Wlv9nCUl0gz04sZny0SSP4HXzdGaviu7vzx3GEr+ZXnHHZoMGDGhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDVMf4mWaisQ8u5TZ+WgBpTYB8pszxzu9oKCuoO824osSzByW
	RQV2bQkDF552G00OjsfH0aDRhrhg/teYnfNjWgqa039HVPpmAydYk18TlcFn0w==
X-Gm-Gg: ASbGncsUnpembJZ7mcgDMWSBwINS5MmCUjRVwWwHoUx0As/ojxPf5j7cuuBvb4LMDLB
	oCLipdnJLIeyW653kbNIi2CetbWoXfZrhzhWCwbxVR/meyYbyLUje8XN5NXa6qYMD05ItF/UboU
	FEOnj3tILDdnrThIs8812PlrDJgAaSNxqDht31RrJ4Sfdf9K8rKyHTPPn8G0exN9rxOcgvPQ9Fk
	8J8kFr2NFki7Mlu2TcFeDodtSTmDPtCXUhM6z88bUIdAW/mya88OH5p/F8PkMG/qrkF/Lznx1l0
	RiGBYHUFWR9IeWY20GhxI2/GgztU7HnyWY/I75NJXR7GUHG1MJqOh5+OsqKpRAUKQAo8cEWJ8KH
	m4UG+NdPFnKY4fkjw8/v6nU05uc+2YNvGi/toSYNhD50Vi3LgM3MmNUkw+02kduIBUU+cJQUKd+
	buL//JMgtjq/E=
X-Google-Smtp-Source: AGHT+IGACGG5o5SMYiYskdoEX5pPCvJtLGXK6o/u1Fz0gxt20qIETJiQ2oK8PohupErVVa48lg2+Xw==
X-Received: by 2002:a17:907:3c8e:b0:b76:63b8:7394 with SMTP id a640c23a62f3a-b79dc735269mr307145166b.51.1764779460464;
        Wed, 03 Dec 2025 08:31:00 -0800 (PST)
Received: from [10.5.0.2] ([185.128.9.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59e8fdasm1789486766b.51.2025.12.03.08.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:31:00 -0800 (PST)
Message-ID: <d19cbb170e066eb00c4f4066b2596e34ddb7b09f.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: adi-axi-dac: Turn dev_info() into
 dev_dbg()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 03 Dec 2025 16:31:40 +0000
In-Reply-To: <44640683-de26-492f-a7ef-6af4a61518f3@baylibre.com>
References: 
	<20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
	 <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
	 <a17f410b-17b3-4abd-98c0-be6952894eaf@baylibre.com>
	 <13c8796d8c24f2d0eefd99e6529bc91d448243b8.camel@gmail.com>
	 <44640683-de26-492f-a7ef-6af4a61518f3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 10:14 -0600, David Lechner wrote:
> On 12/3/25 10:10 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-12-03 at 10:05 -0600, David Lechner wrote:
> > > On 12/3/25 9:53 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > We should not abuse logging and logging a successful probe is clear=
ly
> > > > abuse. Turn it into dev_dbg().
> > > >=20
> > > > If it turns out the IP version is that relevant we can make it easy=
 to
> > > > get through a new debugfs interface later on.
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 8 ++++----
> > > > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-ax=
i-dac.c
> > > > index 0c7b62f5357d..f536158beb4c 100644
> > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > @@ -1000,10 +1000,10 @@ static int axi_dac_probe(struct platform_de=
vice *pdev)
> > > > =C2=A0						"cannot create device.");
> > > > =C2=A0	}
> > > > =C2=A0
> > > > -	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> > > > -		 ADI_AXI_PCORE_VER_MAJOR(ver),
> > > > -		 ADI_AXI_PCORE_VER_MINOR(ver),
> > > > -		 ADI_AXI_PCORE_VER_PATCH(ver));
> > > > +	dev_dbg(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> > >=20
> > > Didn't ADI HDL versioning policy change to semver so that the last nu=
mber
> > > is no longer necessarily an ASCII character?
> > >=20
> > > We could probably change this to %d.%.d.%d while here.
> >=20
> > Honestly, I'm not sure how that settled up. I'll check and if that's th=
e case I can change it.
> > But then it will be a bit messy with older IPs. Maybe moving this into =
debugfs and handle the
> > format
> > there would make sense.
> >=20
> > - Nuno S=C3=A1
> >=20
> > >=20
>=20
> If it was still an ASCII value, it would just look like an unusually
> high bug fix number, but I don't think that hurts much. I don't think
> we need to go as far as changing it to debugfs. It should be pretty
> obvious if that is the case and people can figure out how to convert
> the number to a character.
>=20

Alright, but (unlike the spi_engine) it seems this core is still using the =
old format [1].

> The dev_err_probe() function in the previous patch in this series
> also has the same issue.

Right!

[1]: https://github.com/analogdevicesinc/hdl/blob/main/library/common/up_da=
c_common.v#L128
- Nuno S=C3=A1

