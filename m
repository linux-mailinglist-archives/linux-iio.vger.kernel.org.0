Return-Path: <linux-iio+bounces-17774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1BA7E6DC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DDB4266EA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CD208977;
	Mon,  7 Apr 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmTrFdMw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6AD2F28
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043134; cv=none; b=ANcY0OIZ46nEL95aiyqx7rAH7PEbMrFybif06emT+3qcoULGGR0PbvpSIHVO4yyuQ0Vqp/IxBKYHbIc7eFQg2zKEfrtnoHyAb1uEYlyd+7rnkvtgz+0WO76VBL+WvYBHGw3NsMDddspmzObomaEs1e9NCnU73qcEz3lBqRvLM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043134; c=relaxed/simple;
	bh=q908o1dGTwgj1ek8M6a7UcUM1CZ6+cDYagJsOQJ3fb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kiaOqbYiYahPYrr7ZDODjqYiaZ6JzXJXi0yrn4w0gCaWFYVebqDezV7JeeB2DkY1RX9XwBgnebdTSoYD6Z4e1Otb7yegrX4nYId6Z8VpXtm5h3bolwWietGVgwI560o34XTEQowljoVOz42nncK9QSZ+BqUUTGGBRuwXs9t71ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmTrFdMw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so24691335e9.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043131; x=1744647931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dwn5GGtx4KNh1DmN0fQ46atgq6r2774pkwzhkqvFjKc=;
        b=UmTrFdMw0Z6bFkaMM6zdhxzuex0cQUi3cONer2BL1AMbW9kiZZqeBQE6zozxN231zu
         /ZnxFJx9WpzxI/x/yANUVJu/Q8SeN61IOk0hJVFQoxp4+giP2hxTZJU8D9XzNChOyCk2
         qn88UeoQGMddspWNd+LQRNDgkihgU/UKAWhIK2+EvVcuC/EylswAfgPK2G8UmdiwqIRc
         PLzSl2aH634QhxOOPh1yQOYF2+gsq4GqwS94lJHO/85wgduwageTuIBzaKSUp93pfQx3
         f4IJwgsbTv7YEFQLc/YiWLJkzwkekRq5eThneAHF6rhLOma6wj6Gyvi7KwWRtYuGTbmJ
         bOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043131; x=1744647931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dwn5GGtx4KNh1DmN0fQ46atgq6r2774pkwzhkqvFjKc=;
        b=YrJAOStgQ6mPRS61luwFEShcTBFlIui1zh0U11iPOLWhFhrDbUsyoPkqaNOWUL9tCh
         2/wF5hiZ+xMRodYp7f0O+jGdS9Bi08oTBgj2Tr72B9EWqnb6JGj+Z6YluV8BH6NLVKPT
         NYHpAMcalcQN4Wk3/DxRcFP5sey5WDh89MeehDblYaxoeSbWGCbAaKo+axzu1CcoAT/H
         fvJBXXq3l3NUyvx1fH4FhN3OYNpwSxmBjko7SUc02iA2hm6RAoUG3vaUO3i0TtSCsarh
         U2ewgSP5kFs1Kgx1B7UXZ5qcphX78Zb5yasSe+Vmpjw5DcEJGUpcqQrgVuoGcxoDXtNI
         6r5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmGntgIBsgqrHDiGvqRpZXbElgmtT4gGVFsohUvX4/0LIBJRZaqLd+JT4i7wxdRNEQIEMTyY9/d84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3kIOeWCKRRlMCkT5JLW/sufNc0eH0efvAX/ESe1/9+WWtf+S
	JThezt/ukHGOXoequRWNMt1DeKj9CUW+ek4FVUlTF5XAA2BM2ilO
X-Gm-Gg: ASbGnctWS/zPhV85uRa9uCn+/Pf8vlW8FI95CkEf0ionvOfRtq+x72Hr5cpEJZybSJw
	TpWn0m2cbwz4iTHIyVZaWxMGaE44XAC8930cWsDuqe+XdK6hEeLFdbu5BLbbqkLBBv66+sOaq5O
	oImmKvP0yXdUmkvhrSEBAx+/NTjTjuaPap3bR/vKKjLdFCSiygZiHduM5Ps9/9p28RTuO4tLFoW
	+ZVg5zzkIaWonFqpeMyvw+1lG6WTgqDoXD0K1thXIIyv36a8fBxAC/YhZL2oej2L6vf2L5dCIe1
	GdM3KPq1GDePS6ZdKuAF4O1r3i/CUd9X6P91aN5rW8ZfTu8b60nZZJ0FXTlZov5JOuG3tvunp6v
	wxjpv+x5+kdz04hv2
X-Google-Smtp-Source: AGHT+IGfYItEG53+AvjymUgeMSYzHoOA8l3dpaKW8srtLnOCdylbdOx8O5ASVxwr3shwM61VuvzvgQ==
X-Received: by 2002:a05:600c:1912:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43ecf9c2be9mr94602525e9.20.1744043130993;
        Mon, 07 Apr 2025 09:25:30 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea8d1673dsm155555945e9.0.2025.04.07.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:25:30 -0700 (PDT)
Message-ID: <ff565b8a175e06be8f1e69655b5120c4a4d98d26.camel@gmail.com>
Subject: Re: [PATCH v2 05/20] iio: introduced iio_push_to_buffers_with_ts()
 that takes a data_total_len argument.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:25:31 +0100
In-Reply-To: <20250406172001.2167607-6-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-6-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-06 at 18:19 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Check that data_total_len argument against iio_dev->scan_bytes.
>=20
> The size needs to be at least as big as the scan. It can be larger,
> which is typical if only part of fixed sized storage is used due to
> a subset of channels being enabled.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2:
> - Rename size to data_total_len to make it clear that it is about
> =C2=A0 data but also that it isn't simply the length to be used.
> - Added an unlikely marking.
> ---

Would be nice to do what Andy suggests and move to s64... Anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0include/linux/iio/buffer.h | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=20
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 3b8d618bb3df..49c5347f35ea 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -45,6 +45,19 @@ static inline int iio_push_to_buffers_with_timestamp(s=
truct
> iio_dev *indio_dev,
> =C2=A0	return iio_push_to_buffers(indio_dev, data);
> =C2=A0}
> =C2=A0
> +static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data, size_t
> data_total_len,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t timestamp)
> +{
> +	if (unlikely(data_total_len < indio_dev->scan_bytes)) {
> +		dev_err(&indio_dev->dev,
> +			"Undersized storage pushed to buffer\n");
> +		return -ENOSPC;
> +	}
> +
> +	return iio_push_to_buffers_with_timestamp(indio_dev, data,
> timestamp);
> +}
> +
> =C2=A0int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev=
,
> =C2=A0					=C2=A0 const void *data, size_t data_sz,
> =C2=A0					=C2=A0 int64_t timestamp);

