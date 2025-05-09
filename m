Return-Path: <linux-iio+bounces-19382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E29AB13C6
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C2B1C27F2D
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF728ECDC;
	Fri,  9 May 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DywruXM1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E03139B;
	Fri,  9 May 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794865; cv=none; b=pm1sIFzYNpzmuDK0w+P2blz7mFUESX9zUSHAQeKL43czNSeoRLnwL6S9PFFZ0J8DyHhSU+mNYWZ8IZYw8DLocLFsYijRXjECf0wwm7PNKKzv105UOlVGz4G5SNfjw0UIIsC2nc0+J+HPBuWFxnA8crMn2TWmNcpUBNKUMFsx2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794865; c=relaxed/simple;
	bh=lE1yrC7THVc4nzkqlGbFuHn6zVttoh/FamryFZZzE0U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XM2HDFI0l9VWHewCjhCQHcljFBbCbNq+PzU+hMYwx/d+0E38lE+po6AGaClVj7E5T4NIdN+HyK3/rYkJB8tjl+YNaQOPjaMgYe5WfL7bA7Lrma8PwyZTEhxC2Wa8lqSWixAddkEtxtFiouPKgaROx1VTax+XV4e2rn9Tg2UFwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DywruXM1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso3648728a12.3;
        Fri, 09 May 2025 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746794862; x=1747399662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8ZIx9Wf+0ssahSZtddtwRmi5eBnM6hzKyzjSP+8iMc=;
        b=DywruXM19zzntBw4f3P6zpkGB9mxsNn8YmdLmXfjJPDydvfUkGsQvth6VjQ8jqEuGp
         wlI638ZLUIfqx7ikttLEiD6RhOO/nOHccAV4/Zw6LFXQ5qOKf7mMfbfzHG7HOuW4QN9B
         kHZdWB2gTmQajS3v2AEGuXUlm4WXAx1kZlAJMF33ksRc2bpf0CL49sFfQHHmxdvlT2AZ
         x54wyd2GbW9mB7UFQysATTFBmr8sYt+jiuE+4d8+2xZaJ0NZ3NFz8P0ewulhOqeRoVxK
         veAY/X8LDTKGM2QoEiUKHG9fVv6SWoU4GdWB7l/M/waROiPkvkN2eQ47kb2RDCb9OpGe
         b8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746794862; x=1747399662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8ZIx9Wf+0ssahSZtddtwRmi5eBnM6hzKyzjSP+8iMc=;
        b=AQFITubvis44RDXlwpEMyqRaifAhPyctvKKSN0reRp8XLJh8S3RY+l2BXaVrU85l3D
         KdVXVgRFN3iz+Xzp2/7f9vCzsTcqBQTIYPRuNFbqL3VBfKxP6etuVZol9CPe1zg6K/lz
         BDi5yio28diqu72VC7uN7PHN9FcZqILd9mu9VYuDh4+Qg2tLqo7a7aQxbfn2Z3CrpeeU
         +zN1GU7epyXyRKGlpBj9C+e2Dddv/gnOCfZ9JdwBT4EqtYfAvbMRXUVgLRE/cmBLFBOl
         BfYnZ9qbPktTMZYgQqijTvDTAPuUNBOqyuTuxpL5VYst6pwyXlXqNoHxFShaELpvqz0d
         LmGg==
X-Forwarded-Encrypted: i=1; AJvYcCU4TbBwT0FnvzK+RkPYD5qxJObgIo8q2fRiMWDNQdmUfBKcrTKDRCza54pQQKRwa+Uqy93nHIiH/gQ=@vger.kernel.org, AJvYcCVhhIux+MrfZ38w9B2sww2sToIIHIv3gYxjpY5QoOXxrKo3rcj3ljy8QSjCEe3C95DkE05AQUvG06T2w13b@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCilHEpTaj123MorB+oJ09NMotm6vOtePKzCyCi4zijqwsMN7
	4MsWf1Hh0DUgtB7axWwibe4xN6P70ikBRJm6IQZ32N5kEFg0UwU/Pbrv8ny7
X-Gm-Gg: ASbGnctW3emXwqtmhM+GPxYMiiIIngN5ukszlfmoMhA5UNVfxY2hJ+3ssQmI1RCbgNo
	6tqfhR1NdUGy3VW5v9S0+ea0jwrYIHWDwijfJt8GZO4Gs+G2odk8nbLstTH84K4ylrM0vpTULbY
	31Cn/YtIxeiCV/y/FaYiQ96Mv9zOYHMZ49ENbhcBW6sTjkO0BIvLBg+Jw59/TfX908/yaWvvsAd
	zmMSazNUb8krHFDM0WpNlR4qrp6DLfZSP2fbORr6c5MfHSEi4dZ5Ufk4JJ1XGmsiaJwY+gDPlRH
	3s+SUiiauAr84fEkXhyyJ9yTqDJ+RKLQUb5GSSh7
X-Google-Smtp-Source: AGHT+IGSI8Tnw7s989vnn2nfEYRSiAHvuBsmKY5a3i+2m1Q45ERIvfCDzWPGQm8KGBi9egfzmyVk7g==
X-Received: by 2002:a05:6402:2115:b0:5fb:2105:c62c with SMTP id 4fb4d7f45d1cf-5fca0731354mr2818289a12.3.1746794861819;
        Fri, 09 May 2025 05:47:41 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cc4f790sm1335508a12.38.2025.05.09.05.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 05:47:41 -0700 (PDT)
Message-ID: <310975db928bbd57411da9ff18746df8836fe642.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad4851: fix ad4858 chan pointer handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 May 2025 13:47:41 +0100
In-Reply-To: <20250509101657.6742-1-antoniu.miclaus@analog.com>
References: <20250509101657.6742-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 13:16 +0300, Antoniu Miclaus wrote:
> The pointer returned from ad4851_parse_channels_common() is incremented
> internally as each channel is populated. In ad4858_parse_channels(),
> the same pointer was further incremented while setting ext_scan_type
> fields for each channel. This resulted in indio_dev->channels being set
> to a pointer past the end of the allocated array, potentially causing
> memory corruption or undefined behavior.
>=20
> Fix this by iterating over the channels using an explicit index instead
> of incrementing the pointer. This preserves the original base pointer
> and ensures all channel metadata is set correctly.
>=20
> Fixes: 6250803fe2ec ("iio: adc: ad4851: add ad485x driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4851.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> index 98ebc853db79..f1d2e2896f2a 100644
> --- a/drivers/iio/adc/ad4851.c
> +++ b/drivers/iio/adc/ad4851.c
> @@ -1034,7 +1034,7 @@ static int ad4858_parse_channels(struct iio_dev
> *indio_dev)
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0	struct iio_chan_spec *ad4851_channels;
> =C2=A0	const struct iio_chan_spec ad4851_chan =3D AD4858_IIO_CHANNEL;
> -	int ret;
> +	int ret, i =3D 0;
> =C2=A0
> =C2=A0	ret =3D ad4851_parse_channels_common(indio_dev, &ad4851_channels,
> =C2=A0					=C2=A0=C2=A0 ad4851_chan);
> @@ -1042,15 +1042,15 @@ static int ad4858_parse_channels(struct iio_dev
> *indio_dev)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	device_for_each_child_node_scoped(dev, child) {
> -		ad4851_channels->has_ext_scan_type =3D 1;
> +		ad4851_channels[i].has_ext_scan_type =3D 1;
> =C2=A0		if (fwnode_property_read_bool(child, "bipolar")) {
> -			ad4851_channels->ext_scan_type =3D
> ad4851_scan_type_20_b;
> -			ad4851_channels->num_ext_scan_type =3D
> ARRAY_SIZE(ad4851_scan_type_20_b);
> +			ad4851_channels[i].ext_scan_type =3D
> ad4851_scan_type_20_b;
> +			ad4851_channels[i].num_ext_scan_type =3D
> ARRAY_SIZE(ad4851_scan_type_20_b);
> =C2=A0		} else {
> -			ad4851_channels->ext_scan_type =3D
> ad4851_scan_type_20_u;
> -			ad4851_channels->num_ext_scan_type =3D
> ARRAY_SIZE(ad4851_scan_type_20_u);
> +			ad4851_channels[i].ext_scan_type =3D
> ad4851_scan_type_20_u;
> +			ad4851_channels[i].num_ext_scan_type =3D
> ARRAY_SIZE(ad4851_scan_type_20_u);
> =C2=A0		}
> -		ad4851_channels++;
> +		i++;
> =C2=A0	}
> =C2=A0
> =C2=A0	indio_dev->channels =3D ad4851_channels;

