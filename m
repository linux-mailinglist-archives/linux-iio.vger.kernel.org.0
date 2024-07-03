Return-Path: <linux-iio+bounces-7240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68233925E9C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE72B3814F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9C17BB11;
	Wed,  3 Jul 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW3vkDvw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DD13B280;
	Wed,  3 Jul 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004665; cv=none; b=d5RVe1ZNU8NB7E0n2UbjdgnPZ/J2BH1GlBSCfPpP4eWUUpfD87x/WsFdf5ihY1QfzDmJwbB1eUy+VstzA/pwXfPIvaQ89Sk1qY6zpNb1J6jGZ9OtaqwxtK9Fvx9xx36oCGsrA7vyiheFnZ/2fqmV/E4whHvqZJLJ3NNAR/f4+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004665; c=relaxed/simple;
	bh=dPv8j3AZknsIxl1gBk2gsmjRakfxu2z29E0D3n2D7+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDlAsRDkkAG8x04TbgXWb+Txv9bvKV0KGmU5OEUjV81/8eHnv1pCJbhafsPk/0c7GKfSog+aOVdNzs5XzD9chLraTTUoWSl2EUUl8kkh8GfYQ8NvWdoiMSdG00tsCQZ6HQOBTsHmEYjLRUl5zfwuiz6q603i2/ZByA17RTi8ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW3vkDvw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so2222948a12.1;
        Wed, 03 Jul 2024 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720004662; x=1720609462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dPv8j3AZknsIxl1gBk2gsmjRakfxu2z29E0D3n2D7+c=;
        b=bW3vkDvwt+mId4w1fXZW58Fk03YjcIrPGZvakKj5n3poKCBNccXPssrxg8jwbSRXbU
         17rG8dSrtiHKhAZV6PSxAkRFhb598FM/Q7A1rhlzKkXMQDya5R0hvmcotn9uYeGzDaj/
         NdXsP5jT4Co6BC7H4or2HYFYjUKU06c/opupBC1yKMyI+oLo+0cBaWx3u/Bif7v6YMOo
         ce9nsvz4kmywuKltGC+7Zh0DRbnfTrn+u6pfqc5ifmrZd1epVhJYuECxO6dHNdaRuV3Y
         J96h6h8kVYMq5GWQ83xppmQa2x9AWgZE1yM10ipVB/ryXWOaSoj5H4UwBmLk5D785WHD
         6hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004662; x=1720609462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPv8j3AZknsIxl1gBk2gsmjRakfxu2z29E0D3n2D7+c=;
        b=r2lvP0jCATOq8hoImaNlSm/TxrL7Eh5zBI9uk8kgvBANG5c6lEG3ysjMbJ9v+Q+GnK
         QQsNxCnCaL9WgnjLBj2OYGvE/okNUdXUUW1BV3Vmkb8ZAYgox48N/nLEUSkeiybIcPWb
         ufEfqexgjpqesWTublrIN/z9ftzE9HtIn2ziDVYctVgU/Q3IKDwDvGkflGGRz063i4kc
         mPLE3zo8PUVPd+WLfYKf52MSizzbxBcm6WCodxQ8c5jyWMROcijvY4Z2Tqgk+VNpwM9S
         bkzWLt2ClLr0OHLhSrohcPNl+n0ikgJFKBB0wHTgpiNRNq9HXcegtCsn/hUhMtXG8gfK
         ENzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcDQFKVMdLJAF50e+4bSUzGWjHGEc2oo5nyhH2BMPzF5c3Lp+BHwxUmYEEktNxWlP2eNiHixRwaBx/auVTOMlebI1TRuictTb9LLYeNemQu3CnNcIPahYXMiSunrhUBNB8X65vju69p64cOc3h/WmwZp3u8O464e4iCWG9H9kzb9BjhLTz
X-Gm-Message-State: AOJu0Yzgb/Suf2KAgvYxMouGCruZwjpyNQCmMMpvsUl6SIY3Tu/qFRZH
	XgzLGE3Dsw6FatTZgAi+n0S8kSbsjt3ylciHKweGiHchmYzMgCN1
X-Google-Smtp-Source: AGHT+IHU2KLPLGWXDB7x828X+uRMpbDtGnbMvtpnuP8OB+XLaqjCWlOJygChOdkQDtrN6m7qwBFSAg==
X-Received: by 2002:a17:907:868e:b0:a72:7245:ec0a with SMTP id a640c23a62f3a-a751447b348mr881307466b.58.1720004661443;
        Wed, 03 Jul 2024 04:04:21 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7478d33ee7sm404063666b.143.2024.07.03.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:04:21 -0700 (PDT)
Message-ID: <17e484a2c07c0a521120a6a3cab7dfcf5f3c2fee.camel@gmail.com>
Subject: Re: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, jstephan@baylibre.com, dlechner@baylibre.com
Date: Wed, 03 Jul 2024 13:08:13 +0200
In-Reply-To: <20240702-cleanup-ad7606-v3-6-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
	 <20240702-cleanup-ad7606-v3-6-57fd02a4e2aa@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 17:34 +0000, Guillaume Stols wrote:
> gpiod_set_array_value was misused here: the implementation relied on the
> assumption that an unsigned long was required for each gpio, while the
> function expects a bit array stored in "as much unsigned long as needed
> for storing one bit per GPIO", i.e it is using a bit field.
>=20
> This leaded to incorrect parameter passed to gpiod_set_array_value, that
> would set 1 value instead of 3.
> It also prevents to select the software mode correctly for the AD7606B.
>=20
> Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
> Fixes: 41f71e5e7daf ("staging: iio: adc: ad7606: Use find_closest() macro=
")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



