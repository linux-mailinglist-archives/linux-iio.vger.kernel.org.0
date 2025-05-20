Return-Path: <linux-iio+bounces-19738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39C0ABDBF7
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036138C59F8
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA988248895;
	Tue, 20 May 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2TLDPNZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBE246773;
	Tue, 20 May 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750166; cv=none; b=i55OmnWkfCAUK1Cu2aGURpMq0nD2r8l+9tG7q6KnmFK5Nhkd/cI2RzoSGdEOuGtNcdOvLmxgQBSq/UHeLDEi1lQWXwyK37FFaTcncPVlYtb74uzwjnnO9MvZ9SwuduEFCjQ4FLXxAWtpqyA9gLgDwQ0UbckBkjptZdjzPygG1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750166; c=relaxed/simple;
	bh=e8K31LOWlnlXXttOAQXevqkJDPrYDiCgd1D5Tfw4d9s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcNlO2GHZ1Wzgbul/suQp3LjP0Peec4mxfPzT5IeaxJ4vWHH4iRG9+QXo9QoHHVFTOAP5PDXwqbAcK9hKYleWYf4l/983y/u3uukNnuzGXrp/LPZoIl54yFv6RF0jeVZIRqhoTMD13uZO4O3si99QMdr84Bkxqf/hgDBmdKl3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2TLDPNZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a374f727dbso1414796f8f.0;
        Tue, 20 May 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750163; x=1748354963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kq9ZmrH0FhY6lpwpF+dSwBW4okcgAAitfUaBL1Vu3c=;
        b=T2TLDPNZR0MOdm7idcQlM4qDhN64SkFJGVe+uAz0VAcBOTTydLHYaagsPReMWl3rTQ
         VlLsYl3VO1sT5KpFZ0QHcfL3cXc9adY3FYdilItAK4/UMyhUx3VqQPUElzP0aaZkpz2x
         1ybHKkK25hTrnlQfP1DJbyjeuMZ2Z2PQueXQj8IFjyKDPjEbaqgwNfmelPP+MFzZAgd1
         xvnraZrAwnJfFF6Ltju0GFpAtnGFvcaynvgB6u+Q7H4HXDbwseb1rO4M+eI+d2CYndQU
         It+Sg1pKIzgNog1Oo2hTteNd5dCePQLAj4CF3ev5TjVgttWt+BHf5sT+3/POHLdtzmIl
         d3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750163; x=1748354963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kq9ZmrH0FhY6lpwpF+dSwBW4okcgAAitfUaBL1Vu3c=;
        b=q1PxaAKUwY1bRD/zTDZvRoK0NKtt6AnGWkxajA7fiemzkj9Jh3f9h/M/8wPh4vm8Ck
         mtDs+cvZIFpo+JGKATpUin2AaNuhT2elwdB86hE9WhWTSB6EkhVLyaTF5q9N2aREwx0o
         ITNFRRwO7FhhCp7qcMNmERhodOkPOppFhN2N5pPEn/VZI83wEGK/o4wTagJKgc5uBynf
         acpjOmKd6ZCCBV+OFtC6uR4XkhajeilP4CoAWLrmgvgicJzFPt70v00SF85kuKZOqvLI
         VHQ6mHHhs45E6WJSWCa7gc9a3Ojo/GoeAPcUx5tLuMVXxjfaT3hov1uKSvNwH/NADf2F
         nACw==
X-Forwarded-Encrypted: i=1; AJvYcCUbCzhinIz7gbWvSE5MxfezKGIPnqaDWe1tjQMgulZp90saMm2WyphajXqKvG7mup+t7nBRfAWKvdU=@vger.kernel.org, AJvYcCWgj3Fjq0AtG1G3n/xZ8XOBWtirv7GYNFhwUdOAQb98Rg9XAxD5+6l1LmEseKyayLyDgZWM0C1bpp3C5ya2@vger.kernel.org
X-Gm-Message-State: AOJu0YxLx65t/XjCnoxyLnlfuSp1tnauLfdatCfIy1oHwNHe5YCtojxu
	rkEvm3HIBo75rY0M387/AlqEmppUIFxTGgTDlLRbeX7dbqVVJWeTeF3/
X-Gm-Gg: ASbGncv8TjgkqKmXySgpU5L8K49I0j5A7edmbmmWUgcs3eHE5D/vPTqynKqZGxTFO1w
	j7mwAreqIsLEZshJJ7kQ3RocMWpcY6RN+hB+07AVL6LY6WmHT0yH8RQMlznzpqAjU1cmhH3stTf
	PwM2cHQJU1FXf6Ni4Oj0YvWromIsuCQZPu70RCc68rHEndD24IgK1P3kIq4+sqx3qkIFG7RJ1EW
	ssAvSoIsmPlmtQd08V0Y6gkYg66wIYdiXJGzUICchbqYt24J4OvSA/y1BHuRBOM7yA4ksmCAoR3
	9yTV7uATVLa8c4XXWq8gQKqPNlitW6pOF8FOyGjb4gVvyu/9Ow==
X-Google-Smtp-Source: AGHT+IG3xLD2kDqL20EVTJM5jSjsZFRlXQ3owNEBgPAao9TO7E7PoOUeC5QcqWf/zcYa6HONXQ5vZg==
X-Received: by 2002:a05:6000:2212:b0:3a0:b9a4:e516 with SMTP id ffacd0b85a97d-3a35fe677b0mr14229265f8f.17.1747750162776;
        Tue, 20 May 2025 07:09:22 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm12017977f8f.57.2025.05.20.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:09:22 -0700 (PDT)
Message-ID: <8b24ec167ebef4947eb9fe122d546ea8410bc6c2.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad4080: extend check for data lanes num
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 May 2025 15:09:25 +0100
In-Reply-To: <20250520110101.29478-2-antoniu.miclaus@analog.com>
References: <20250520110101.29478-1-antoniu.miclaus@analog.com>
	 <20250520110101.29478-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-20 at 14:01 +0300, Antoniu Miclaus wrote:
> Extend the check for st->num_lanes to ensure it is not greater
> than 2, preventing invalid configurations.
>=20
> The AD4080 only supports up to 2 data lanes.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4080.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index c36eb41d738a..6e61787ed321 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -516,7 +516,7 @@ static int ad4080_properties_parse(struct ad4080_stat=
e
> *st)
> =C2=A0
> =C2=A0	st->num_lanes =3D 1;
> =C2=A0	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
> -	if (!st->num_lanes)
> +	if (!st->num_lanes || st->num_lanes > 2)
> =C2=A0		return dev_err_probe(dev, -EINVAL,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid 'adi,num-lanes' value: %u",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 st->num_lanes);

