Return-Path: <linux-iio+bounces-14294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2089BA0BCC6
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BAA1887287
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8C1C5D67;
	Mon, 13 Jan 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf0ZXTO3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B624023E;
	Mon, 13 Jan 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784042; cv=none; b=gxZYRtJTVs3Xdkg63dU5GQ57U9Vf/l2/3orD7herLwnWGjblE3WOrDhcnj8kbo5X95T4KfgSq+RYjahkpeuWtrM7MIYpp/822snPlA30iSiH0vVQU73FqnucYGBgBprM50RnxxLshLmit42+PJYS6jdJ8C1v0CdFYRLIQApaNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784042; c=relaxed/simple;
	bh=aHVmLwXFp6qzVq9SGpc9bQPcMw6MTjHPemkEBGoo0FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5F50r/dFSWeTubhJcUtX1Nf27i5NJpZYbSDVxI6RofQFDtK+DLehhYQ4jCjQamWLi5TOCsNV5E707yjW9jn6H7YofVb423DWypdCnyjDIv1GBC6tKmO4DmqyAoF5CnCuQZr0KLgjaSF0Jzct8fazqvDmT01Xf/pcvEeSL44kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cf0ZXTO3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436341f575fso46798645e9.1;
        Mon, 13 Jan 2025 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736784039; x=1737388839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XeUFIni3eMkSInbhAtw8KR/DrGm1QKHcF12Ofa3rFEM=;
        b=cf0ZXTO3FbvZV7EVMynEv6kkgaJpBU/jJYEXbZQyfA1YWj7rLh4+dWOuzgpFkyeiHA
         A/cOD1NutpjhzTmP2hrcacdlenXChIMnMevVi1qVpNIWXPeacIlHWXZ55mTHBUC69mYD
         nNFbAWu5iaH7cu8Yn1VQ54E7VJMF4GUwiaZkwcl78+RvM/FGm41FC6Y7iFdCZxFPhUra
         CgTYZCbUP/PfHDeDXxauuGyhlfCtDmJVEbT6407zti7pPfwuxna+AadxmBHRMHpUKdLE
         xi99+gYHjpKMxNY6O5J4/TXw2fNME0/hQSnVKmEiJanrPQ4Mk3LoOrO/QNETaj5Wtc8c
         V1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784039; x=1737388839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeUFIni3eMkSInbhAtw8KR/DrGm1QKHcF12Ofa3rFEM=;
        b=hpgGQg8GgLdL83/UbZQbYsZ8KAbCYFAyVXVhVv26hPf2edDtSg4FdORdrqEcKlL3XR
         WVQR7OVTmz9XYC8s0tfRLrHtw+qrD/bybxv8u+W9J1BIFsjnA8d1YRqnUG3EszcGmTS5
         wPcqJ+tpvEQcYaMH4WBWy8wDO8wHCmUiltjaHLLH+jb6oAHoY/wCyZTeU+g93lxnavWg
         Ru7+HO/Uh3UZTMzpAgVAbs4c2OdVshxVjiT55BokA7uy0gaUjTjD+hrDCxtKMBhYn5Vr
         k42oLp+L+U6jHTkJDf5wPbVBTyJ7lScej8JnACNcmzwemGsyK7nLqwI5Y8dz899MtTov
         QWvw==
X-Forwarded-Encrypted: i=1; AJvYcCWFSNTGPk7Uuw8CizsZqmlEr0YHz93calq+bA4cBN3J1T3c4C5cZY3G8CXC+V3z6CnugEkh9pQnar0=@vger.kernel.org, AJvYcCX+lLqq6KQ8Yg0yKtPngBwFE6lRc6CawkYAmGqle0QQPpzq+Cx/0yk8lIf+x2X5sLHKGteU1NBYi5nU9+ol@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoAoZFEL+POF1DG7OkSEoPRAOuooWTEbVmp/ve0asm9Fm4exb
	Lk+JoHFF3xxvhL/m9EkHt1j3z5cCQW6VWvcqe8w3NeqMbq3/QKUn
X-Gm-Gg: ASbGncso4YB4xwy94WhXMzbEUXklQjDPSIo1S9xNaRnVfv44yS94aJRu2EOdG8W0c2h
	TWmBRDxjKHiMNCrip2+3ohNNg89yECrgOBd8CZX0Dc9AUz3NMq/nT7n/J1g6qeQ7dkp1Wmh5jc6
	4VICNxSx/sOc4Z+0Ek9TvII1uvOAQel3rBR0f+VNJvtDlHXhN4ootvyS/Q2EgvVsGND8JpLSNR5
	siVIrjyvl61zAuHMsS/T0d2xyuxSXPDluabAnFStbNCM+Kp3bgj7b8divHovMM9utcmixUBIyf9
	U0Gdv4nnhZzaOybHclYbbV0KFMic
X-Google-Smtp-Source: AGHT+IEeNFi34y+Ga/KM9+5vyLLVYjDYEvVYpW6UnmFumWw8l6ZsahDaobWuhloVg6DCdDdNt8ma7g==
X-Received: by 2002:a05:600c:314e:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-436e2697947mr225903795e9.14.1736784038404;
        Mon, 13 Jan 2025 08:00:38 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0babsm181606245e9.14.2025.01.13.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:00:38 -0800 (PST)
Message-ID: <e8d440af44842507b100fb6c66b7c456175c517b.camel@gmail.com>
Subject: Re: [PATCH v3 3/9] iio: dac: adi-axi-dac: modify stream enable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 16:00:37 +0000
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-3-ab42aef0d840@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-3-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 11:24 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Change suggested from the AXI HDL team, modify the function
> axi_dac_data_stream_enable() to check for interface busy, to avoid
> possible issues when starting the stream.
>=20
> Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

LGTM... One minor thing that come to mind is that if it wouldn't be more
intuitive to return -EBUSY in case of a timeout? Anyways:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index b143f7ed6847..ac871deb8063 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -585,6 +585,14 @@ static int axi_dac_ddr_disable(struct iio_backend *b=
ack)
> =C2=A0static int axi_dac_data_stream_enable(struct iio_backend *back)
> =C2=A0{
> =C2=A0	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret, val;
> +
> +	ret =3D regmap_read_poll_timeout(st->regmap,
> +				AXI_DAC_UI_STATUS_REG, val,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) =3D=3D
> 0,
> +				10, 100 * KILO);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM_=
ENABLE);
>=20


