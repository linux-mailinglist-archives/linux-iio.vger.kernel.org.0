Return-Path: <linux-iio+bounces-3253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CE786E4D0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779B5B24241
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A771EA9;
	Fri,  1 Mar 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkXU8XM2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81B71B44
	for <linux-iio@vger.kernel.org>; Fri,  1 Mar 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308549; cv=none; b=XQ2PVVZPw8EtLTrEI/xr+mUPRcrscIQ14Ss88/SvXCrYIYVJmAI9dQQLxFBNwN5EZrtuO6b9aQsOQFpprrWPFKWY+AQjO3Z08dqpJI5Vk/oLPnGq5XsrVtmGdzd2+56hbjGiTUuT7uUyjCVkdsYCFCOO2+z1cIIxJF7IaGsQ18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308549; c=relaxed/simple;
	bh=xU2424lQTKxKZg6MHne9qfkBy5cOcIamXDnnHV78UpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWkIxTHoo7Bi7uVuR+tdce70CCP28gAMXXpWrd9gLMGn0Hia8c/RauAKMW2gg8+iFuS6Fr0U6ljw9YjRrBhuFzBpPx2phAs4x6QdjuPGRs24eHiwetqZ1CjL3jdVpmVuXO2ySMww2wmvDB4BkY7L+3Fjuaxf7G2YkUHgYL6i2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkXU8XM2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412cd73ca83so1716905e9.2
        for <linux-iio@vger.kernel.org>; Fri, 01 Mar 2024 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709308545; x=1709913345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEf+rbXNQvLvB9iPkH1P+r9uBHTvmiiyJwMOWWoELNo=;
        b=xkXU8XM2AlxDhUXHrsOonXihIuEhwmsT5WezvjUChW+s1A+sL8Zhn1MO1KqJLS5NJD
         u4sZ40IaW4+wPfwvPk2hccRo+oYy7OYkTUBPVbikI3qOLGrvOiksdKhrWNuEjcsnVN1P
         7HvJNGsoMvpHcedZ0GIS8JLUKxdSBYiHbZqOEznrlRtAeTUN0VscVdDVWs9ApTjA9ayr
         MOSHXS1f93Hfp9sG7FRy1ADa0/K01/GwhEuVtq/ylytNzCDjC9LIDZotA8DLIPqBQlwW
         JUGtRW1rSafFww+/qVZC6wJAv8GY0Mbp5xczCdcH/qcAbDTTTkUjDl4OXerzes1zqQnW
         Noqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308545; x=1709913345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEf+rbXNQvLvB9iPkH1P+r9uBHTvmiiyJwMOWWoELNo=;
        b=KNzMuPta3eivtBgK87pyM5r1N3tGh8c2y3Z9OrbZZ9S1ALhcSThXAnEWz7A8d3wb/U
         BlZSVrrST3HlBBx/MLsGC35p7RfAJjShS+pTy57OBoBHTEel9sheHHGJA53XlQzLd+d5
         ULdFHxdN+S1AmIpl102c/gQq0J8EZEj0ZmUlTU5HIQf6+GSAUVAw3w7R/mIoCTpbHFxb
         wx5dxGkKEYpVaHEm6rk2Hl0J3roLKiMFA6vp0HPYNngbL6k0MRSj05CyiwYzaOVRayM5
         AkDIIBFWNNkzMEPBR2i1thA4gyjBZLOCYGUKh0GCFD+uz0DCSXBSLJNIAehIvIhOTrW2
         a50g==
X-Forwarded-Encrypted: i=1; AJvYcCWbGIMyj7kJnxHJoVSw2D2MGDBNXMY77TmMlZfs5VfDQ3S/hu3M6Hu8LgRTYwcH6Lic+elDMwh4Zwm352YfXJch3zCVl9FAYSOp
X-Gm-Message-State: AOJu0YyAEkf4oRGLiZFPCScRjxtz+Ai09ikzUC/9S/0IQXeF3OZLpLVI
	eGduWxUiijjOmxdDje2k+A4ovEsFEY+nwjrmYXi0dVEIgnrhl/9PCwByaneUTO0=
X-Google-Smtp-Source: AGHT+IHXfsf1QVNUUheaEgcb1fKDrYSnpwanX1F3NHauzqf3xzyG0GvJEj7Pf7CKoluJk/kSHAeU6Q==
X-Received: by 2002:a05:600c:1986:b0:412:8fe7:4e06 with SMTP id t6-20020a05600c198600b004128fe74e06mr1813507wmq.38.1709308545005;
        Fri, 01 Mar 2024 07:55:45 -0800 (PST)
Received: from ishi ([185.243.57.254])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b004129a1097e7sm8774972wmc.12.2024.03.01.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:55:44 -0800 (PST)
Date: Fri, 1 Mar 2024 10:55:39 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: syednwaris@gmail.com, vigneshr@ti.com, jpanis@baylibre.com,
	alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Message-ID: <ZeH6e02zzfAjw-sd@ishi>
References: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NVfMO94wBSa46KPR"
Content-Disposition: inline
In-Reply-To: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>


--NVfMO94wBSa46KPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 11:25:05AM +0100, Fabrice Gasnier wrote:
> Now that there are two users for the "frequency" extension, introduce a
> new COUNTER_COMP_FREQUENCY() macro.
> This extension is intended to be a read-only signal attribute.
>=20
> Suggested-by: William Breathitt Gray <william.gray@linaro.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v5
> - "frequency" extension is read-only, so there's no need to provide
>   a write parameter.
> - patch sent separately from "counter: Add stm32 timer events support" [1]
> [1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnier@f=
oss.st.com/
> ---
>  include/linux/counter.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 702e9108bbb4..0ac36f815b7d 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -602,6 +602,13 @@ struct counter_array {
>  #define COUNTER_COMP_FLOOR(_read, _write) \
>  	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> =20
> +#define COUNTER_COMP_FREQUENCY(_read) \
> +{ \
> +	.type =3D COUNTER_COMP_U64, \
> +	.name =3D "frequency", \
> +	.signal_u64_read =3D (_read), \
> +}
> +
>  #define COUNTER_COMP_POLARITY(_read, _write, _available) \
>  { \
>  	.type =3D COUNTER_COMP_SIGNAL_POLARITY, \
> --=20
> 2.25.1

Hi Fabrice,

Setting the structure members directly works, but why not use
COUNTER_COMP_SIGNAL_U64("frequency", _read, NULL) instead to keep the
code more succinct?

William Breathitt Gray

--NVfMO94wBSa46KPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeH6ewAKCRC1SFbKvhIj
K217AP9hJmpnlwQnUsdqaZn6twmR5QyJBT3lfeSMtz4eusnWowEA7uP/8rZ0WZLf
TDqIuD3w+89Mcs0vrikcijgkauAOigs=
=Zn8v
-----END PGP SIGNATURE-----

--NVfMO94wBSa46KPR--

