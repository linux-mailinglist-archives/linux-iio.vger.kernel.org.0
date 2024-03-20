Return-Path: <linux-iio+bounces-3637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF68A880FF6
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE161C2312F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333B2232A;
	Wed, 20 Mar 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw1LCjbr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4443BBCE
	for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930656; cv=none; b=E0N3BTE7/pePX6cvw848hxL22BL3dDd3832I42gk68Zc9UYcF2zvMv/F6HlkULbo4zHP4nzrxgpKgF0f3E27MLF6vUp0WV65njW1ljZmwQQS+uLpzSGDh7TsMkX3Hg2J0yxSo/MJfz7nP0QghdG1B0SSPIkD71v/x0qaZ1V+OPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930656; c=relaxed/simple;
	bh=dmBIwpNva7TEkXpnOO/Czw8tTCnWdlg7AwIKfESnwyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q7RaNPtzURB+YTPu5aiKbCf75GJsFAWwcGIqMLBz/lLzD7zeHv3oTvGlOdEN+AlOXb/RK9fLi6zrl/GZD3nKohX3YJHEkFQEvIBizj36SWXT8pCrqazlwmactVaK0M4Z5GSU5R0c5UzeAnq331X5lM8RJDgQ/ezVAjedmPW61P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw1LCjbr; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d4404fbdf5so1212666e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710930654; x=1711535454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqX+KnAanv2iuqfGETlGsbj1uZm9TQcxB/bIQKGRSN8=;
        b=Aw1LCjbruHheMea1qCe9tHUfJpa3uX7R5H3RObDhbsJaZq8EIZpRaDFrR9xi8QBf6p
         erAdXw0GoDJo0ENcvXwvLJ8/aEtnuQLhuRGO+EW21zMlCYuAI8i+WFZe9bPqRouWtHGA
         Z/gInQTvZ49/eMMlradrCmiWIy9+ZhONO0B08Ll+se2csM/r0k3JjD2L5Nrk1Xog3Uiy
         h8AyY5KvNRjrdADbJszPBKLfPUnURX03uQ059OHfhh70+nA8tP7zr9WAuBujqxnUt+Ih
         PWVu3zaFizusLtCGLUS0AYqk1mt49QXXOkdJ9XaTcs+ot2Sf0OMhYBYIrmi8Xqd3movL
         VhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710930654; x=1711535454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqX+KnAanv2iuqfGETlGsbj1uZm9TQcxB/bIQKGRSN8=;
        b=k7zd8pEL6VM4sw8WvIMjyADyyZQypCvdecr406alOOIygmuZKosQL40kULVqG0MVim
         MJEgn2SNV8huIcjGSBx7hSTTqJihspVp+VsuHzWbrM3oRRdWXGTZwJxRBPdm85mCWcnm
         0yf+m0dFaRp6tyndNiUXBPYU1inuHYLRLOUPWX1Ii4emCo0ezSjvbVyWAVb15rt26DBf
         3L6BHSCyhxePEV89SVV+2+pdPoXyNBf7KCF6Kxy3aQOZzaTg6Vc8x1pHYQc/CovT/A/P
         MjY5MvTgbAsno3bEMlaBGMDK7JjKqwJvs002BGIeYJfP3Lax26lt6hyMDnWxci+g7Ws+
         fEGw==
X-Gm-Message-State: AOJu0YyWuoJhl4Ecj0DUWhlHECt6snK955lvaGGi1XfLfU5nRFPkT/r9
	wMxuF9+xo3BWC1uk1i3Gprw7FB/hFx2fAEKgyluqXIxIGiGzx7Tdpkn7DEKTF9zpCQ==
X-Google-Smtp-Source: AGHT+IHGMmZhBPHDN3av5lN90uOe+UWcbkos5SqSfjc/wOChZ+7tof+BX1+8ciuk9qKJWmwhFcGSBg==
X-Received: by 2002:a05:6122:d9e:b0:4d4:3bfa:ba0c with SMTP id bc30-20020a0561220d9e00b004d43bfaba0cmr12638708vkb.9.1710930654066;
        Wed, 20 Mar 2024 03:30:54 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id n136-20020a1f728e000000b004b723acd1e1sm1692891vkc.11.2024.03.20.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:30:53 -0700 (PDT)
Message-ID: <95b4f98948f1c3a802d185e947ad0bbcfef0a779.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adxl345: add spi-3wire
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, eraretuya@gmail.com
Date: Wed, 20 Mar 2024 11:34:20 +0100
In-Reply-To: <20240319212713.257600-2-l.rubusch@gmail.com>
References: <20240319212713.257600-1-l.rubusch@gmail.com>
	 <20240319212713.257600-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 21:27 +0000, Lothar Rubusch wrote:
> Adds the spi-3wire feature and adds general refactoring to the
> iio driver.
>=20
> The patch moves driver wide constants and fields into the
> header. Thereby reduces redundant info struct definitions.
> Allows to pass a function pointer from SPI/I2C specific probe,
> and smaller refactorings. A regmap_update_bits() in the core
> file replaces the regmap_write() to format_data.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---

On top of what Krzysztof already said I would also like for you to split th=
e=20
spi-3wire (which is adding a new feature) from the refactor in two differen=
t
patches. One more comment inline...

> =C2=A0drivers/iio/accel/adxl345.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4=
4 +++++++++++-
> =C2=A0drivers/iio/accel/adxl345_core.c | 116 +++++++++++++++++-----------=
---
> =C2=A0drivers/iio/accel/adxl345_i2c.c=C2=A0 |=C2=A0 30 ++++----
> =C2=A0drivers/iio/accel/adxl345_spi.c=C2=A0 |=C2=A0 50 ++++++++-----
> =C2=A04 files changed, 153 insertions(+), 87 deletions(-)
>=20

...

> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_=
spi.c
> index 93ca349f1..e456b61c6 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -20,48 +20,62 @@ static const struct regmap_config
> adxl345_spi_regmap_config =3D {
> =C2=A0	.read_flag_mask =3D BIT(7) | BIT(6),
> =C2=A0};
> =C2=A0
> +static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
> +{
> +	struct spi_device *spi =3D container_of(dev, struct spi_device, dev);
> +	int ret;
> +
> +	if (spi->mode & SPI_3WIRE) {
> +		ret =3D regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> +				=C2=A0=C2=A0 ADXL345_DATA_FORMAT_SPI);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;

I think this would be neater:

if (!(spi->mode & SPI_3WIRE))
	return 0;

return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
		    ADXL345_DATA_FORMAT_SPI);

- Nuno S=C3=A1



