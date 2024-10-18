Return-Path: <linux-iio+bounces-10705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EC9A3784
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215341F22F95
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6D18B48C;
	Fri, 18 Oct 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6EtqhJH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0818A928;
	Fri, 18 Oct 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237597; cv=none; b=kWAbGPQBlMEm/TnRuL4/WDEtBbPcWudtM9isfuHmA5nGWpsOMbu9dEGUUvrWO7+lsnnmjsp0A8mTde/hPayTIgiq05ULWbEpHgrwJ955nQPtRImEZQH55nEvU5oHkOH9QYW/dzZTPIegIOwItoT0uHXqjVZoHVPFhNtcRxsx4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237597; c=relaxed/simple;
	bh=2G0lBZrxk40Gh6C1p9VuqFsJA+teUnp0gpTDfjwhwOk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=RVklgAQhKhp8J3hW/wL0M0/arNlmjof1wS8W8ZrirhUCNBZ1HLej6d93ukycpDCU/C7OhcjRBUsLje2BbUsPjhEso/juj4bmAzWoUWQf1VuIy9DJAT51DcDDOOICcMQkm23Wv2H65sETgUeu+ZBGSEghCdah0Q8tLz8nw5gfvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6EtqhJH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43159c9f617so14529955e9.2;
        Fri, 18 Oct 2024 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729237593; x=1729842393; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf9kjstuR07nuz8Nuoi2gpoN6CQD47KN0sOWzgELBRE=;
        b=M6EtqhJHe0w8rNR+c92X6myc6V++B+1GaSo+JI4EE3BpzgRRN0v2iqEjrdzgw6i34J
         6Zl39HF21eKOhZSiJc/84i2at8uwCvYiv7jdHqJvHqXdvItwPlAV5kzmVAp7CzJ4KjwM
         /Ld2PAWkpNym+ygNMbAWopczcyYxysZxmpo8RfxyfRX7+B4b3Y8c6/8ySHxHmfshjOMu
         AnImFi+Tx6v1jF6j5ApOio4mEqOXybhQVlBKXZ6UihczjOKfI4IwgPdboAqD40BAS1vU
         Soo/8JCz0+3nBreCh6TBC6Sop6CYEGd+bddUjPY0Y+62D394x9tVSfGsAjQpp85Ncpjj
         QZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237593; x=1729842393;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf9kjstuR07nuz8Nuoi2gpoN6CQD47KN0sOWzgELBRE=;
        b=S0UNfRRra0NMYpww6RnJIrH7z1cQKjCU8o+e/crweFLgMfoRxof8iashaM4tWJDio/
         lI13GoAabrGaW4iJxjY9l3+S6AY4tWAgK2q/m0gy5WmLaeYqmlmcrEdB3B7P2g9EfbvR
         obbRRqOXwqt3PDT05AwRprRTbYZGg9VF+iFO5G/P2lRHdeagzdiIY+M9D8VjKJvizutd
         6ZphpRdqe0uUWkA8xA2aVbYehKFSOQ7HlEdK296a6ElJORuJG+aIrLfBS5zvBTrYQflN
         QpNlSK6ejqtCb0Xw7YRnnFZemB+RSWkvFbSJGnU31ZG289kouRCDzczRLA3t3u1kQpGx
         nlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhmxnt0JkQN8E7pvMyk0h1iQvjtxhg9HKuO0YvSjQL436U6nGkx1KG/vdEyNYLw2Kr9d5dc4dwbo4=@vger.kernel.org, AJvYcCVyTvJMEt9hz5/m+CPBUVSD6py/Q/izlPYYvS8ZUdHBIyr1w0Jzwvxwav2Zt4Y+ELSa+nh4l+5SlqgWdJ60@vger.kernel.org
X-Gm-Message-State: AOJu0YzHx2fOUahTuvZhZLMDcNPiFlWVvKBshDgLSkdMRMyfljVnkuV6
	8mfSi/7AbevZeqNpfSPSPgcOXL/YXoHWqXoVwsQyfc6OQn5g1Wc6
X-Google-Smtp-Source: AGHT+IEZ7OuNKwo4uHoS4qY0it1GmZdXBxcLgJdG6fNKWOtk2Do7VHbDiXwUl7nJqIATudlx7pTHnA==
X-Received: by 2002:a05:600c:510f:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-43161631435mr9584075e9.10.1729237592943;
        Fri, 18 Oct 2024 00:46:32 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e0a87csm16258085e9.25.2024.10.18.00.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 00:46:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241015112441.11745-1-victor.duicu@microchip.com>
References: <20241015112441.11745-1-victor.duicu@microchip.com>
Subject: Re: [PATCH v4] iio: adc: pac1921: Add ACPI support to Microchip pac1921
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: marius.cristea@microchip.com, victor.duicu@microchip.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: jic23@kernel.org, lars@metafoo.de, victor.duicu@microchip.com
Date: Fri, 18 Oct 2024 09:46:30 +0200
Message-ID: <172923759060.37070.4692932928966596704@njaxe.localdomain>
User-Agent: alot/0.11

Quoting victor.duicu@microchip.com (2024-10-15 13:24:41)
> From: Victor Duicu <victor.duicu@microchip.com>
>=20
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.
>=20
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>=20
> The patch was tested on minnowboard and sama5.
>=20
> Differences related to previous versions:
> v4:
> - change name of pac1921_shunt_is_valid to pac1921_shunt_is_invalid.
> - fix coding style.
> - in pac1921_parse_of_fw change back to device_property_read_u32.
>=20
> v3:
> - simplify and make inline function pac1921_shunt_is_valid. Make argument=
 u64.
> - fix link to DSM documentation.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw, the shunt value is
> read as u64.
> - in pac1921_parse_of_fw remove code for reading label value from
> devicetree.
> - in pac1921_write_shunt_resistor cast the multiply result to u64 in order
> to fix overflow.
>=20
> v2:
> - remove name variable from priv. Driver reads label attribute with
> sysfs.
> - define pac1921_shunt_is_valid function.
> - move default assignments in pac1921_probe to original position.
> - roll back coding style changes.
> - add documentation for DSM(the linked document was used as reference).
> - remove acpi_match_device in pac1921_match_acpi_device.
> - remove unnecessary null assignment and comment.
> - change name of function pac1921_match_of_device to
> pac1921_parse_of_fw.
>=20
> v1:
> - initial version for review.
>=20
>  drivers/iio/adc/pac1921.c | 104 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index a96fae546bc1..8b5127b7ee3c 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -67,6 +67,10 @@ enum pac1921_mxsl {
>  #define PAC1921_DEFAULT_DI_GAIN                0 /* 2^(value): 1x gain (=
HW default) */
>  #define PAC1921_DEFAULT_NUM_SAMPLES    0 /* 2^(value): 1 sample (HW defa=
ult) */
> =20
> +#define PAC1921_ACPI_GET_UOHMS_VALS             0
> +#define PAC1921_ACPI_GET_LABEL                 1
> +#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236=
-7a7a742e55cb"
> +
>  /*
>   * Pre-computed scale factors for BUS voltage
>   * format: IIO_VAL_INT_PLUS_NANO
> @@ -204,6 +208,11 @@ struct pac1921_priv {
>         } scan;
>  };
> =20
> +static inline bool pac1921_shunt_is_invalid(u64 shunt_val)
> +{
> +       return (shunt_val =3D=3D 0 || shunt_val > INT_MAX);
> +}
> +
>  /*
>   * Check if first integration after configuration update has completed.
>   *
> @@ -792,13 +801,13 @@ static ssize_t pac1921_write_shunt_resistor(struct =
iio_dev *indio_dev,
>         if (ret)
>                 return ret;
> =20
> -       rshunt_uohm =3D val * MICRO + val_fract;
> -       if (rshunt_uohm =3D=3D 0 || rshunt_uohm > INT_MAX)
> +       rshunt_uohm =3D (u64)val * MICRO + val_fract;
> +       if (pac1921_shunt_is_invalid(rshunt_uohm))
>                 return -EINVAL;
> =20
>         guard(mutex)(&priv->lock);
> =20
> -       priv->rshunt_uohm =3D rshunt_uohm;
> +       priv->rshunt_uohm =3D (u32)rshunt_uohm;

This explicit cast seems unnecessary (note the similar assignment in the
pac1921_match_acpi_device() that doesn't use the explicit cast).

Beside that the rest of the patch looks good to me.

Acked-by: Matteo Martelli <matteomartelli3@gmail.com>

Best regards,
Matteo Martelli

