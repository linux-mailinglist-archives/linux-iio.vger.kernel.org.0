Return-Path: <linux-iio+bounces-3244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200386D2CD
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E151B21FC2
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD013B792;
	Thu, 29 Feb 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxnjBHj1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC8134435
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233614; cv=none; b=I8tcOBa0ez7wL4iZMvBYU11+gMif7ApPpkLJK1ooNP/810c7haT9EV+Su0BF1mh6hs55rcd6AHSmBeSOwFgSpErXHXYYV/z64WaaygjAw+xx3dWz4NPfM4fpW5dJKHDc6pdTdvryWn6sUlQu+JS1GdR+zKUg578Nj/fnrc3vMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233614; c=relaxed/simple;
	bh=cvBzs9lLYilkxC4ILAVJnxBxncOeLsaV186D3Cgz1VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6rNTrUmejvwSJnERatHhZkcoc8r9NcywktwhEDU+QTjeCf1EM9UoUtH18twwmC2lLAiMaSDJ6Grx5TqMDyc4kH4yFBJHThORWQiZTGqs8m1AnGNwxCvkFCN43gfYQmz1pmcEKhDc0tcxMl6hrsNqIQYFgh2YE6EWnUU1mRKAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxnjBHj1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412c46a7195so569665e9.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 11:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709233610; x=1709838410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6C2bXPH86iM1wIE2+OdewUkS7BtP29sQZelrAG7pDTU=;
        b=kxnjBHj1tFt9eBvtoCdD6PuI740LcU8GMuo3Oek8GTCSo4BdNZ07ydaVgf7DXUhfD4
         JfxdXZxzLhb+pF9Id1LMkI7I3vs5Jb6DBl6kfVUPK01+y9aQqJsgev5UfCMCahIdHvGF
         fd9vC+CF7mE1nfRGaR9Bm29JGwMGLk/JCqr2yCtPcSX8P6cv+/XSPC0x3gr58wX3NzWm
         MgK3C3GtHrd2OIHceDzOXxab0ab0IRTVM81ABSASIbLZWQIcryh+2tnpKIZDQwkYjiXG
         0976SSIlgIMK6rjnGqembA5VR82ylsI8YSRxJtLNpXbk/d8Gvagg0rsC5u6ecztoNiYx
         xZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233610; x=1709838410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C2bXPH86iM1wIE2+OdewUkS7BtP29sQZelrAG7pDTU=;
        b=s+rwdPpnQUiknF2oVQdNFzon5lppLjPN4LYCDgk+oTfEjwGtafuQTjtdT/ZDRi/sqk
         BEOpD2iG8FYtrZDvWnytHP0q1UWVvUDTmcbA93RSxuQ3vFphsDPgaIdR/6XFSIyN+dmD
         0DxOmEfqSbeTDggFAH2mIezSW/cpfbbX2LfX/I/jmnYX28unrL1rkzZj+UyfbNU1WXXh
         Dz0AaV+xH/LT2nsXJzw+5wIsPlowFnapKKvRXn0Q5weEwY5CGVKCl0IVAWMOkpoeRq30
         8oFH3uxbLQW6GwQUrUpr9uLL+L5EBuze2/TlCDIJRes1FFT3vyEpD3d7Fjbfimmf9Irp
         dt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwromMEWVrq05Ng2jUl8L9Zi54vWwO8ElxS44AAnevz4wJXPJ9TK3A8qSw3JVm4xOqXt2Yz32yeCUutHKOws8zGdqyuAaK8FQn
X-Gm-Message-State: AOJu0YzQPAaRGqYaIffXpTpxd/omj9RaXs7rG1mkzDex0W9gcVG7zZtg
	Nm2FrIAztmwWrEB6TAv7UsohBn/ndWbRLKmILJUXkmK2Urjq3uJe3lgz9rNwd2E=
X-Google-Smtp-Source: AGHT+IEfyXff5Z/Catutq/9H1tJ1Tcp6NVWBS0uS4QEHmqL14qct73+IMdbYhpAanS6tRs2B0CzIBQ==
X-Received: by 2002:a5d:58f2:0:b0:33d:29c1:c28c with SMTP id f18-20020a5d58f2000000b0033d29c1c28cmr2219550wrd.66.1709233609591;
        Thu, 29 Feb 2024 11:06:49 -0800 (PST)
Received: from ishi ([185.243.57.250])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d5341000000b0033e11acf84asm1996039wrv.15.2024.02.29.11.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:06:49 -0800 (PST)
Date: Thu, 29 Feb 2024 14:06:43 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v4 01/11] counter: Introduce the COUNTER_COMP_FREQUENCY()
 macro
Message-ID: <ZeDVwzOKEpV48cXx@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8RbYN6cnf/6A/iU"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-2-fabrice.gasnier@foss.st.com>


--m8RbYN6cnf/6A/iU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:37:53PM +0100, Fabrice Gasnier wrote:
> Now that there are two users for the "frequency" extension, introduce a
> new COUNTER_COMP_FREQUENCY() macro.
>=20
> Suggested-by: William Breathitt Gray <william.gray@linaro.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  include/linux/counter.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 702e9108bbb4..03472d7407de 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -602,6 +602,9 @@ struct counter_array {
>  #define COUNTER_COMP_FLOOR(_read, _write) \
>  	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> =20
> +#define COUNTER_COMP_FREQUENCY(_read, _write) \
> +	COUNTER_COMP_SIGNAL_U64("frequency", _read, _write)
> +
>  #define COUNTER_COMP_POLARITY(_read, _write, _available) \
>  { \
>  	.type =3D COUNTER_COMP_SIGNAL_POLARITY, \
> --=20
> 2.25.1

Sorry, would you make one minor change? The "frequency" extension is
read-only so there is no need for a _write parameter (it'll always be
NULL).

You don't need to rebase and submit the entire patchset again just yet
because I will likely have more comments when I review. Just submit the
next version of this particular patch separately and I'll pick it up so
we can get it merged into counter-next.

Thanks,

William Breathitt Gray

--m8RbYN6cnf/6A/iU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeDVwwAKCRC1SFbKvhIj
K5a/AP9ESChk0LtM25VBIa/YG3unlk+bBAuqQsCttKitBbei5AEAnS35RlwlEo91
tAqqQcOWaRtMdGXsFtre4ov5nr6/HQY=
=Az87
-----END PGP SIGNATURE-----

--m8RbYN6cnf/6A/iU--

