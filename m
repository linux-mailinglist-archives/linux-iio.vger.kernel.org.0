Return-Path: <linux-iio+bounces-16728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B97A5BC43
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7123B2C5E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3922D7A0;
	Tue, 11 Mar 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKJVjVv+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9F22D797;
	Tue, 11 Mar 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685275; cv=none; b=GO1UfX5/t5BjJmUi2nEQTkUJTXA2UugRIvN2d8mFfuuA0SDCUlFDJefCUGyvbvU4q/gjCCpEA4svYdOUfLhyAsWBeXzews/UQXPRQQhOyESmsYTk8lAvwfLirWst3tLZYLyV5oeKWzpsGR81WIwOKJlrvOR4qAZYb8E6H4ZNcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685275; c=relaxed/simple;
	bh=y2gjTDxmVQjUnOPl9CBQ9kISV5oz0JgLg8+WqPY2ldA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHAac2GsJ13KjcXMd+KPQGSrs68Ex3Lj5xGdsG0eON2K/IjES7zp2EeT3dhhb8G+1hTxicmuf9AIobWqjrxnM9/WR5LNWVLpySQMkucWpstMYhv326ZqCKbb/NOnAcPOjp38WccczcEgRb0nT5czlLXjgWOFNBOLO3J9mTVShys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKJVjVv+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2791288f8f.0;
        Tue, 11 Mar 2025 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741685272; x=1742290072; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJxVBC3fTIBw6C/my8f7QIhfonu3Jw2NqOR1IZcOgUk=;
        b=jKJVjVv+Ni0oEJCi/uInbJdU+BQ0s3YYz5rBa66Vz0t9zSrtt0VeyTCGG1ZXaHCOoq
         MHVZvSb3fHc/Is/Ie1SmcUvxDLI4IFayJ7v7hEHd29fXoBsR78YBLRZASRVgUTGonIau
         a7hkdy5l4WRjX9WGaIZCE063iKz59RTQsd2GNzb2XR7pNvGWLOtH7bZBp8QX75xsYEZf
         ND8qhxoT/kDJhTKPxOHk55hDl2yGvLk7UnX9ykBZPwcPmMMcPh3n9kts8dfui/oBm5Q7
         HU+Nyyqc+rp8lPMHGZtmktYSAGh4RfsR3VHqqv4mlYyRJDhwOftIwEcFBLjb6pQHVcxy
         Y7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685272; x=1742290072;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJxVBC3fTIBw6C/my8f7QIhfonu3Jw2NqOR1IZcOgUk=;
        b=A1t28xi3Ex6lyc078Anrg4ldn9NilcuGM0uCc86zss+u3cf4D0IzmhyjJrmEEvoMMW
         27mK0fP2F6fAdeXq6j1yiutkLMOxz0kHiO2hB+kkK2EiEcqC6sXyHuEb5nT+dIZiiKFH
         7ZEKPzsfCvnaZwr32Z0hSsnQHDQZtxTj+OMPL5fOAVB8F0m8TrJkDDYu9TIeBZVSytGB
         fYLPu4nDN/ym12HcWXwP/JLEolW+zi0HgaeZLSOtH73Qs3KCXZtSBFsc8qBsf2M7N4L7
         yaKe9pbLGdjAHaNLFlFbD3VTcCBmXnP7JVQqbR/Uoz0trP37v24LZ7SxQBfGpq2EoIAV
         NJYA==
X-Forwarded-Encrypted: i=1; AJvYcCWliOO1EO/r6IA2wTwPybV+sfI9MsrXugI7m5KL7vcwMneQGtj5Q7cYmijVFLmKJVzO4ZLhGTizBXaK4VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzqgzZzMz3ngqcTP4QjRA2KvrEcSH0a+x0nxe1ysaR+0mz3fv
	l0qH/lkuHKBC0VDe0MCfTgfknwv/df1niX28gFdXZ2HSPNr2qLOj
X-Gm-Gg: ASbGncveur8nfaprDat+bBVUnAFu6QyrxRu209RkrQM4vFhdNa8LK5V30Q8kpek3KXb
	A8AEcxNtIzMTu9oCOqnoe3ZQ7WMQZGOolMttTyPtCMjaNnOWHicE+OI/S5irqaBYfABP0pOrVEu
	e4VPFgcOe6nIFcvYEdZW++EVZ/jgKIW+bjvW/aubjAzgKkIewUkJSHLxgtV9tuB3aQ8w+qqpzfW
	o9kz7SXGSs55LkweqtIBEUFYWvfjKX9Q0YqgvIYrbcN0uCxTA0mdCxjoqDPu1FGTatFSQPLWk0k
	C2PaUWB5nkn/qBRhN/Cuv/suPhw/Scmz0f6BxMpVihV8PD+8MBq7pFaHJfLjmJqVET4GSAvIDf+
	GW05IRjpjJhZmPQw0
X-Google-Smtp-Source: AGHT+IGJhsuvALgmt87StK/rP/qW1kKY09wV9DJ7L8VCwqPbpdsMXpTFxs+tlOh2R4zMB3+Vh7CI1A==
X-Received: by 2002:a05:6000:1a8e:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39132da9221mr13116818f8f.35.1741685271466;
        Tue, 11 Mar 2025 02:27:51 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf892d380sm64561295e9.24.2025.03.11.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:27:51 -0700 (PDT)
Message-ID: <822dec830a7e64dbb791a7e28b1c5fa182ccf993.camel@gmail.com>
Subject: Re: [PATCH 3/5] iio: adc: ad4030: move setting mode to
 update_scan_mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 09:27:57 +0000
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-3-589e4ebd9711@baylibre.com>
References: 
	<20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
	 <20250310-iio-adc-ad4030-check-scan-type-err-v1-3-589e4ebd9711@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 15:43 -0500, David Lechner wrote:
> Move calling ad4030_set_mode() from the buffer preenable callback to
> the update_scan_mode callback. This doesn't change any functionality
> but is more logical since setting the mode is a function of the scan
> mask and doesn't require an "undo" operation when the buffer is
> disabled.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 13 +++++++------
> =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index
> f24b46164a477f9b6b5c93ffeba0a335f7b3de5a..c2117c7a296f22aeeec6911c8a8c74e=
d5762
> 96a0 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -868,6 +868,12 @@ static int ad4030_get_current_scan_type(const struct
> iio_dev *indio_dev,
> =C2=A0	return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORM=
AL;
> =C2=A0}
> =C2=A0
> +static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	return ad4030_set_mode(indio_dev, *scan_mask);
> +}
> +
> =C2=A0static const struct iio_info ad4030_iio_info =3D {
> =C2=A0	.read_avail =3D ad4030_read_avail,
> =C2=A0	.read_raw =3D ad4030_read_raw,
> @@ -875,13 +881,9 @@ static const struct iio_info ad4030_iio_info =3D {
> =C2=A0	.debugfs_reg_access =3D ad4030_reg_access,
> =C2=A0	.read_label =3D ad4030_read_label,
> =C2=A0	.get_current_scan_type =3D ad4030_get_current_scan_type,
> +	.update_scan_mode=C2=A0 =3D ad4030_update_scan_mode,
> =C2=A0};
> =C2=A0
> -static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
> -{
> -	return ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
> -}
> -
> =C2=A0static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask)
> =C2=A0{
> @@ -895,7 +897,6 @@ static bool ad4030_validate_scan_mask(struct iio_dev
> *indio_dev,
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops =
=3D {
> -	.preenable =3D ad4030_buffer_preenable,
> =C2=A0	.validate_scan_mask =3D ad4030_validate_scan_mask,
> =C2=A0};
> =C2=A0
>=20


