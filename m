Return-Path: <linux-iio+bounces-9387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E6971B14
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515FA1F22380
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 13:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274401B6525;
	Mon,  9 Sep 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4WOdN7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1261804F;
	Mon,  9 Sep 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888686; cv=none; b=gJyc9KHgyfMcq0g/UqvGv9VZvCdGXsJXlEkk2Ze3QynztEo4dZFOxq3muMdmi/9VWeRNCq+JE6XmKwGV+24R4hxCDDtW1iW5xj8ZkwMiRXWZyXy0Au/Q1BRfoGoWXfLuhayjQ3HWI/FUE28Gdx6lcttdiGSp36fG74AI+IGK1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888686; c=relaxed/simple;
	bh=U9/6GZgjRgUVPus9DXRmPCbnWZ1XQIE3UYnIYMoBDTM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DyUGwCfZ5aYzjI/YWHA0lD1tIp7ivpo3cfFjOO0SMSM5hr0frhtNMlUOVYlT5D3WVOZ+xmr6ErbVSBh6UTQMwuj9lSxlcPBSBYw1CRdUDkZluxxu7xIvG7NZ7jhzidF7O0dSfG048mCxwLRMo0oWjgGbdvfR0Qvf7SKzDjrsMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4WOdN7a; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so50877415e9.3;
        Mon, 09 Sep 2024 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725888684; x=1726493484; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWBnrkC0VHGoKlS5UYwMzz+fd0b7C15beJrEhKUWP6E=;
        b=j4WOdN7aF8IoiZMv8v/2ZM2cIiLa8XK2Z1za00KN/pCmSXDtF2pny00CKcFtgxW9j+
         xeVeUiK42Lwpy9Wz4eYzvwpcgz7mFlgf92HpoXG7o7tcNr9BeczJrVj7XpswGbRX15VA
         vtkO2TgiUW4BuHHYcdV5JBaIxHW4XVlMSDnpC/D0gEce+HGwW6NWJqojnW1X2im7VwIV
         gHLi0q3FP/8koS/vrNCIbIQBdYPIOESWMT2cC4DJM17V7Q8MjrL6S+3eSIRaRw4HPqvk
         AZv4u0EHzkcF6aChc5VFS71Yczt12Uu89pd1rYPXaP3D5jsc89+TDAPCPGyRdl1hDX+x
         BuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725888684; x=1726493484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWBnrkC0VHGoKlS5UYwMzz+fd0b7C15beJrEhKUWP6E=;
        b=rtKaCm1+i2KXzZFEiEY0p6H0fKe0pyc53gBXtYtQdE7WGsotRf6S4zuuMpuNl4CUox
         Xz/zn/1opYjVXosPxoFizTcoWYbjg3kqJE5BIw6f+YfpkyFhRmJrbtoUPkEMx1+K3IgH
         Z14LP57vVCQtUXIESOB5IqTcVkqHTyrZ79UgaUEVffmEMP7YUJlmqaKShH+mxMIv1Bx1
         V4rEkHLuhHMY7zdnvpR+5AgUlzNb3Tb2GIPi+558vyF2hhfWPKINwHU6lGMw4zOiwZ3y
         4ydU0fWXT9WW+yWDSZj19XcMJV0hN4hqX7hDqiP3UOtRlYQQorCsp5gAmkiccFRg8uTY
         GLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGZhRjiaPHW39LjEtZ+TqX1pJgwapCV0AlbTaFTjDTdDDB326Bv1KQHxuo745xORdf9iJ0uI9vMt7i@vger.kernel.org, AJvYcCWS8T1ccd9yUFEWrpOT70y6g+6ahBSQ0QrnZ3Kpbn9FrpKuydbxXeQJqODl2BA2Rytf3Bt9DYhCpyGnyFbx@vger.kernel.org, AJvYcCX7sDCMiV5CvZgT0XV7QTfadHNmG8BNzSVZbFOXdDqyKfe0KgkUTdxTwsxMGB002XPXbhPLlFosGVxF@vger.kernel.org
X-Gm-Message-State: AOJu0YzTF4sn4JoW4+rzszgtO3zsRjuR9dcHW3o3o8OJB+YJJ87ZcmcY
	tnCUC18yMg36dxdq7Neu+LNmJfFX8rhUc31Wba/QPXF0kmUjfmeu
X-Google-Smtp-Source: AGHT+IGHWJpfx1MPy9b28rSFKNx5bY99OU/mUzZyWqr6JkzPIFC9m3jv5MaaxqGJxrrtc7/mgf3M5Q==
X-Received: by 2002:adf:fcca:0:b0:374:c90e:990c with SMTP id ffacd0b85a97d-378922b7aefmr6266546f8f.33.1725888683153;
        Mon, 09 Sep 2024 06:31:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3796sm6041845f8f.80.2024.09.09.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:31:22 -0700 (PDT)
Message-ID: <345d8b6b1395a0181458e795006bc47748f865b1.camel@gmail.com>
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	adureghello@baylibre.com
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 olivier.moysan@foss.st.com,  robh@kernel.org
Date: Mon, 09 Sep 2024 15:35:31 +0200
In-Reply-To: <a6be8c40-5aa7-455c-8a15-55bda451ea51@wanadoo.fr>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
	 <a6be8c40-5aa7-455c-8a15-55bda451ea51@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-08 at 18:28 +0200, Christophe JAILLET wrote:
> Le 05/09/2024 =C3=A0 17:17, Angelo Dureghello a =C3=A9crit=C2=A0:
> > From: Angelo Dureghello
> > <adureghello-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> >=20
> > Add support for ad3552r-axi, where ad3552r has to be controlled
> > by the custom (fpga-based) ad3552r AXI DAC IP.
>=20
> ...
>=20
> > +static int ad3552r_axi_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad3552r_axi_state *st =3D iio_priv(indio_dev);
> > +	struct iio_backend_data_fmt fmt =3D {
> > +		.type =3D IIO_BACKEND_DATA_UNSIGNED
> > +	};
> > +	int loop_len, val, err;
> > +
> > +	/* Inform DAC chip to switch into DDR mode */
> > +	err =3D axi3552r_qspi_update_reg_bits(st->back,
> > +					=C2=A0=C2=A0=C2=A0
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +					=C2=A0=C2=A0=C2=A0 AD3552R_MASK_SPI_CONFIG_DDR,
> > +					=C2=A0=C2=A0=C2=A0 AD3552R_MASK_SPI_CONFIG_DDR,
> > 1);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Inform DAC IP to go for DDR mode from now on */
> > +	err =3D iio_backend_ddr_enable(st->back);
> > +	if (err)
> > +		goto exit_err;
>=20
> I don't know if it can be an issue, but iio_backend_ddr_disable() is=20
> called if iio_backend_ddr_enable() fails.
>=20
>=20

I don't think it would be an issue but conceptually it does not really make
sense. Yeah, it should be fixed...

- Nuno S=C3=A1

