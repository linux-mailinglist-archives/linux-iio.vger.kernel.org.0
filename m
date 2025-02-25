Return-Path: <linux-iio+bounces-16043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB54A4396D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF99B16542D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392BD25EF9A;
	Tue, 25 Feb 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwOhoI/a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1827453;
	Tue, 25 Feb 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475617; cv=none; b=nMKAHGRECRhaoQ7LKOwwHfgODO4Mm9lUGzl5qt1sHebr0WWjXa0e+hyecX883PsQlOshf0h7PC39oZhbxsxjYRmPUDCVQpiCiFTR3Z629uQ9/VXQztPn2Gu6ZIF/NdkBJkfx3FVkIoB/OXI5CvpKnRoSi5UtiSL4/xwl7YWIZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475617; c=relaxed/simple;
	bh=wvA6dNGhP7FQUGI5EqH2LMyL9GYEhfpbGbNXmHeQeLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTdHKjEPeDw7+qmmGfc9SHN42fKlQjCzG90wGDz1NQ83W7VAhScycw1XkcuXRbVx2zCE3VQXq6TS6KKCsaEP5LWXMcuQ3D0p0DFgw4oJ3ATQvhcdGNsKCUtNgxkgBTWm71UpKCBHXFjI1h+W2kw+OfjRj9gjFX+o23kePk/4dAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwOhoI/a; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f24fc466aso3979472f8f.2;
        Tue, 25 Feb 2025 01:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475612; x=1741080412; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BoeTa4IvySQUhH0y618KDoeEQekAQiqrQ4nhoxtfnZA=;
        b=WwOhoI/a6aWW7Cl27eTNFUMpOgOw2ONVEBbw9wj5vgptSyzBrowAqqpUSCfvoWEykk
         1fvIZXdyXgFoKyq0Gp1tZOaLImImWUt6hXJMbjKzMeD3vBULrw7N6kxFf7wcYraS8jxk
         VllbF7pOlTqLvVQV0C+bJwvv1+1CaMuyWkACaI1Cfl1llGMGyodfRM2SH0Rh/V/6vz4N
         lSb2aOeDPNYBMcbRvXK8Il/uMFyM/kVG1YY81AgVI3r6yvSBi++E+CYjh9qRZLRrOr/K
         sWvPAXz7IJzlnVexqd+4YXfE+dYQK4VvMV+jKuZ/a/Hu6OqHZAEs5CwR2embZYVC15c1
         wExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475612; x=1741080412;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoeTa4IvySQUhH0y618KDoeEQekAQiqrQ4nhoxtfnZA=;
        b=LfUnsW1bRHKVSXBt8JPm5FEt6MGZ+aMiWAvl+9qT5yVuhtjK8bN+LXilGxnP0GCGfO
         A0QBviq4WQ9jwBwRbWg6cMhAdfY+3EdrlR/12BwpszJxLqis0RgpD0gJbGcWyoefTaBr
         OKi7czqQ/547SxYpLgwC9CnESS2YBj+vzowZPRWLqzGvROjys8hgvLDHkngbpBqLR6Yh
         sHaSBJRWSglGlIYUXlBPsCXa0ciCM4BM2AVnG+1RJRz2AGoTvkuBInf6+8oIDXgIl6QB
         1jvRbROV3ti3SmP2Rb8gzcMckW+IWskv2wXrdD/iJVPCvSXP2eXlgVLxQDuvNxqXtOGV
         T8yw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+gBntfB2skV28rodrQcICRyvRWcoQDMAiw3nnwFWIdaOeHyHegmta6bv4gdCenLHdpkVLZyEewEX@vger.kernel.org, AJvYcCVqwkd3fVCMA5G+3mAWvyCeAXofJOw2n5/QfRirGCS3+ZUyGgz5Uw8X1U/eNbhNz3C/locbgaSFVR4K@vger.kernel.org, AJvYcCVtgdPeWVBiIE3oBFwILtU3PZGa1z7YDe1A6oKd/s/LxR+tB945XQ5PYbN1XWLbS/2Tb0SJ75CbTAEE@vger.kernel.org, AJvYcCXUwSu/LSeoXfwHpJb9ahd7jNyaITpbo5Rt/2RI32dmpEaJKy5FqrkF5NccJAINK0HqWfOS5ZsBKrsCY/mE@vger.kernel.org
X-Gm-Message-State: AOJu0YxukA3xv+1XbuUklgAaCq9bKdVkLQLxIr0UFNkeBBoOiNYqexqq
	s4nwKlJAURTEjczP4AsJU/AkMQegu1/Vie2WUxYbJLjs9kxZ9Cl0
X-Gm-Gg: ASbGncuQUmcXSl5KKK9rAERYRqAZGl3y2V719GAsZ8K1Ft9ZTmqSFJwVsjUCPVuV5/s
	qmTA1q6RL6XGfipGp0bIoBc6oxkGzJB1ImG43pHv7U53mkDKI5RRF3D6AH7iytREBU4BHg/w1ge
	C0Vj/OqX/K4cw5FeS1PpQq5zDNhUIUskLZ7IWbH6jo7wKRW4BNa3IzxLg/yHAhhDrLvIt5lTyGW
	KoV1yRsJGlWGzSa+zsk+O2+WEBbixEy99xgP5lYidirXnG+BuTsNHOVsoCcUdNW9X8VAR/vGD2s
	eIA4AASa3UPtHFyhasn3+Bq4i2YuExPPRT0ElnKdTJtcIo03WJV82BgEcXMKHsb5F5OIm+aUbg=
	=
X-Google-Smtp-Source: AGHT+IGKR5FdofxNOKP+qxKxSYIfHIHMFWegnDiA4Uxlry5eM8hOqCDEIcHmmairlELksJynZ+fJbQ==
X-Received: by 2002:a5d:5987:0:b0:38a:88ac:f115 with SMTP id ffacd0b85a97d-38f70826511mr10518653f8f.34.1740475612128;
        Tue, 25 Feb 2025 01:26:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866ed2sm1664976f8f.16.2025.02.25.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:26:51 -0800 (PST)
Message-ID: <e527ea625d48239fb765a1a9e0a9c458936b06bf.camel@gmail.com>
Subject: Re: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, "Budai, Robert"
	 <Robert.Budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"	
 <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
 "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>, "Miclaus, Antoniu"
 <Antoniu.Miclaus@analog.com>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,  "linux-iio@vger.kernel.org"	
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"	
 <linux-doc@vger.kernel.org>
Date: Tue, 25 Feb 2025 09:26:56 +0000
In-Reply-To: <20250222123815.0521df87@jic23-huawei>
References: <20250217105753.605465-1-robert.budai@analog.com>
		<20250217105753.605465-6-robert.budai@analog.com>
		<aee93ef96e71adf70a48ee5877bd75966d9c78c1.camel@gmail.com>
		<45d64de8a1074788b7c4bffc29788742@analog.com>
	 <20250222123815.0521df87@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-22 at 12:38 +0000, Jonathan Cameron wrote:
> On Thu, 20 Feb 2025 13:43:04 +0000
> "Budai, Robert" <Robert.Budai@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > Sent: Thursday, February 20, 2025 10:22 AM
> > > To: Budai, Robert <Robert.Budai@analog.com>; Lars-Peter Clausen
> > > <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > > Sa, Nuno <Nuno.Sa@analog.com>; Gradinariu, Ramona
> > > <Ramona.Gradinariu@analog.com>; Miclaus, Antoniu
> > > <Antoniu.Miclaus@analog.com>; Jonathan Cameron <jic23@kernel.org>; Ro=
b
> > > Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; =
Conor
> > > Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux=
-
> > > iio@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org;
> > > linux-doc@vger.kernel.org
> > > Subject: Re: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550
> > > support
> > >=20
> > > [External]
> > >=20
> > > On Mon, 2025-02-17 at 12:57 +0200, Robert Budai wrote:=C2=A0=20
> > > > The ADIS16550 is a complete inertial system that includes a triaxis
> > > > gyroscope and a triaxis accelerometer. Each inertial sensor in the
> > > > ADIS16550 combines industry leading MEMS only technology with signa=
l
> > > > conditioning that optimizes dynamic performance. The factory calibr=
ation
> > > > characterizes each sensor for sensitivity, bias, and alignment. As =
a
> > > > result, each sensor has its own dynamic compensation formulas that
> > > > provide accurate sensor measurements.
> > > >=20
> > > > Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > > > ---
> > > > =C2=A0
> > >=20
> > > I guess it would make sense a Co-developed-by: for Robert?
>=20
> The From is set to Robert, so that is implicit.=C2=A0 It is an odd chain
> though. Now I've looked at it this doesn't
> seem quite right but I am struggling with what it should be :(
>=20
> I think this chain means that Ramona, Antoniu and Robert made significant
> contributions. Robert's was after Nuno had handled the patch on some
> ADI tree?=20
>=20

So, I was the one that original wrote the driver (I think about 3 years ago=
) and
the needed modifications on the adis lib. Then, Ramona, Antoniu and Robert =
all
worked on the driver after me when someone remembered it was about time to
upstream this :)

...

>=20
>=20
> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> index 16f01c61a429..8ec3afe6140b 100644
> --- a/drivers/iio/imu/adis16550.c
> +++ b/drivers/iio/imu/adis16550.c
> @@ -509,10 +509,10 @@ static int adis16550_get_accl_filter_freq(struct
> adis16550 *st, int *freq_hz)
> =C2=A0static int adis16550_set_accl_filter_freq(struct adis16550 *st, int=
 freq_hz)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 en =3D freq_hz ? 1 : 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 val =3D FIELD_PREP(ADIS16550_AC=
CL_FIR_EN_MASK, en);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __adis_update_bits(&st-=
>adis, ADIS16550_REG_CONFIG,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16550_ACCL_FIR_EN_MASK,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(ADIS16550_ACCL_FIR=
_EN_MASK, en));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16550_ACCL_FIR_EN_MASK, v=
al);
> =C2=A0}
> =C2=A0
> =C2=A0static int adis16550_get_gyro_filter_freq(struct adis16550 *st, int=
 *freq_hz)
> @@ -535,10 +535,10 @@ static int adis16550_get_gyro_filter_freq(struct
> adis16550 *st, int *freq_hz)
> =C2=A0static int adis16550_set_gyro_filter_freq(struct adis16550 *st, int=
 freq_hz)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 en =3D freq_hz ? 1 : 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 val =3D FIELD_PREP(ADIS16550_GY=
RO_FIR_EN_MASK, en);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __adis_update_bits(&st-=
>adis, ADIS16550_REG_CONFIG,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16550_GYRO_FIR_EN_MASK,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(ADIS16550_GYRO_FIR=
_EN_MASK, en));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16550_GYRO_FIR_EN_MASK, v=
al);
> =C2=A0}
>=20

LGTM

> =C2=A0enum {
> @@ -832,7 +832,6 @@ static u32 adis16550_validate_crc(__be32 *buffer, con=
st u8
> n_elem)
> =C2=A0
> =C2=A0static irqreturn_t adis16550_trigger_handler(int irq, void *p)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 crc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 dummy;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool valid;
> @@ -1143,7 +1142,7 @@ module_spi_driver(adis16550_driver);
> =C2=A0MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> =C2=A0MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> =C2=A0MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> -MODULE_AUTHOR("Robert Budai <robert.budai@analog.com>")
> +MODULE_AUTHOR("Robert Budai <robert.budai@analog.com>");
> =C2=A0MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
> =C2=A0MODULE_IMPORT_NS("IIO_
>=20
> > >=20
> > > Anyways, all looks good except for one thing that I just spotted...
> > > =C2=A0=20
> > > > v8:
> > > > - removed __aligned from struct adis16550, as suggested
> > > > - crc buffer extraction into the crc check function
> > > > - passed buffer into crc validation as original, __be32 and perform=
ed
> > > > check
> > > > using be32_to_cpu conversion of the buffer
> > > > - added trailing comma to line 993
> > > > - removed trailing comma from line 877
> > > >=20
> > > > =C2=A0drivers/iio/imu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 13 +
> > > > =C2=A0drivers/iio/imu/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 1 +
> > > > =C2=A0drivers/iio/imu/adis16550.c | 1149=C2=A0=20
> > > +++++++++++++++++++++++++++++++++++=C2=A0=20
> > > > =C2=A03 files changed, 1163 insertions(+)
> > > > =C2=A0create mode 100644 drivers/iio/imu/adis16550.c
> > > > =C2=A0
> > >=20
> > > ...
> > > =C2=A0=20
> > > >=20
> > > > +static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz=
)
> > > > +{
> > > > +	u16 dec;
> > > > +	int ret;
> > > > +	u32 sample_rate =3D st->clk_freq_hz;
> > > > +	/*
> > > > +	 * The optimal sample rate for the supported IMUs is between
> > > > +	 * int_clk - 1000 and int_clk + 500.
> > > > +	 */
> > > > +	u32 max_sample_rate =3D st->info->int_clk * 1000 + 500000;
> > > > +	u32 min_sample_rate =3D st->info->int_clk * 1000 - 1000000;
> > > > +
> > > > +	if (!freq_hz)
> > > > +		return -EINVAL;
> > > > +
> > > > +	adis_dev_auto_lock(&st->adis);
> > > > +
> > > > +	if (st->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> > > > +		unsigned long scaled_rate =3D lcm(st->clk_freq_hz,
> > > > freq_hz);
> > > > +		int sync_scale;
> > > > +
> > > > +		if (scaled_rate > max_sample_rate)
> > > > +			scaled_rate =3D max_sample_rate / st->clk_freq_hz
> > > > * st-=C2=A0=20
> > > > > clk_freq_hz;=C2=A0=20
> > > > +		else
> > > > +			scaled_rate =3D max_sample_rate / scaled_rate *
> > > > scaled_rate;
> > > > +
> > > > +		if (scaled_rate < min_sample_rate)
> > > > +			scaled_rate =3D roundup(min_sample_rate, st-=C2=A0=20
> > > > > clk_freq_hz);=C2=A0=20
> > > > +=C2=A0=20
> > >=20
> > > I would imagine the above is the same deal as in other devices [1] or=
 do
> > > you
> > > know for a fact this one is different? Maybe it's simple enough for
> > > Jonathan to
> > > tweak while applying...
> > >=20
> > > [1]:
> > > https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.13.3/=
source
> > > /drivers/iio/imu/adis16475.c*L364__;Iw!!A3Ni8CS0y2Y!7Y71yPaQAxVzNRd
> > > O_jT7wEz4k-
> > > s6z4tJHOcES84HYkq8qNGsgJH7zxwjfPNjLF3OEGVInSolo1ennLU_mwpmEbo$
> > >=20
> > > - Nuno S=C3=A1=C2=A0=20
> >=20
> > [Robert Budai]=20
> > No differences were found in the scaled_sync behavior of the ADIS16475 =
and
> > ADIS16550. It is safe to add from my side.
> >=20
> If we want to do such a module parameter override I am fine with adding
> it but as a separate patch on top that provides the reasoning etc.
> It is a little to messy for me to do as a tweak.
>=20

That's fair

- Nuno S=C3=A1


