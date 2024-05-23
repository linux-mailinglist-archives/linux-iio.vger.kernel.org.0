Return-Path: <linux-iio+bounces-5213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3B8CD272
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2741C20316
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712E149E08;
	Thu, 23 May 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKBcYf1D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8D149C71;
	Thu, 23 May 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468208; cv=none; b=tdAgIdQ+l8uRy4ie7A0k1VF6SyoZ+TFDJolWL3zqStOJfzSyTsqLr303dCpKSbdiI681dcJn0Tl3zIZ+XafKnwsHqx/W22YgRJ0qRyppKALBQKNBwK+qWl5IOCd8kk9HZ6oow2d/ymL14Bd24wbeP+RCtD0stW/zn7HoVgFzbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468208; c=relaxed/simple;
	bh=xk4xnHqN0grVK7+fCaiEcFYz7W4saCv3WHp+/xmBYhQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dlPCVdRhV8zlpZA7UNYSBbJjUejPbG5ggaga3tc2r7AWNWFDQ1TVARQmlTNRru6Rw+ezwFSCWszaZdTagH1CDG74AUD5n9z8KkGwSaeYBvdTHnjgHCkhXtiDhxAg/A5hb1XIF+bAoJi7+QJkfBso2vG9FcsZhCaL3UftFFTCOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKBcYf1D; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so992551f8f.2;
        Thu, 23 May 2024 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716468205; x=1717073005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3hOvCdCz3/jqUGYWDYqxQaKJIB9B1Pmy+qUcKaYVmB0=;
        b=dKBcYf1DxbFx9p4PYAYIvvb66MbdsweXIo5aC/xj2tBgB7tTLdwuxlVfpl9tNH0Vq3
         eP1WgjOaJ2jqf1O/6Aj9BgIu5+5ZYTHkjyPiErd+xLmnT43vTaFfu9YbHya6Rs5W2LEX
         PVvr9k7E3lGd86ZQ1c1f1H5+xwTC34yw/iJTlGDe4sG3nOPsM+BaFCVLyB0yIu+P6Sm8
         mA/VnWDCKLuAoJWyJ4S7bjJOaahDH21YH2JB9YgZl3x2RaK/SoRCqnaq2jhBj/eVEBUK
         87S2616QjU4/8WpBX/wpR8BMd35NB5NroUWq74atDD0aTIkpxEYkAqeOAWK4ISArUYAf
         A0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468205; x=1717073005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hOvCdCz3/jqUGYWDYqxQaKJIB9B1Pmy+qUcKaYVmB0=;
        b=aJGfht6HuBX73zoa231tLe1qYZNxJgwx2xtn6mFaj7psLE+4SbL3OzSCiIhRprCe7X
         HgtlGzgJV+zJXTjE2Qzm01Rhr5z8P6oaUbmdVoxTe6G5mchHwelIMCqOulhVHlrr/rGR
         zwlSVotQTz3snBs8+JBCCLQED9d9LBlCj59jnWnCEJe7R9FnNk4CMGTBaHCxU0e9kIXK
         WNjRLXWhu1w201sTIa7ZflmBWJbflfkE4Kui2c39oeyPQ60VxbsZcyoNk5aL5Ht9ZLXE
         ut3BlQ7ikx2WlfxwqCoQXrKpLcYkeCCF17k+zyoEA7M8oDa3+SmzDd1+IoCevxknv73Z
         JUIA==
X-Forwarded-Encrypted: i=1; AJvYcCWLOWCWA1oZo8v+hVIg4TWZE7K5DCSnf5urUqI4Zb0U9vLtX5OWjsy0nlFsMQxYeZ8cPFLjSANFsp+4Ex0KTbhpv+hxST33s4AO3jX7pSmZqWbtrr2xz+rVw0t2Qu5lpGPP5CuY/XaZa5fB20s2wXV1yV1kys+WlLsiE0PAEP1/nT4lAg==
X-Gm-Message-State: AOJu0YxD17+orCYWMC4JSNZepDA3jfdTMTb7W62l7dr7IM69SyuQsc7E
	kKMmIIsilgAXA6mNGAI90z02YJmSDkLGr9Lqd+fBwQA9Fh4QPxtnrkKo8gJJr4s=
X-Google-Smtp-Source: AGHT+IFrsetAgfxlaH3jKAc3SxFxgFAtfwlIE9FtlnNu70i8hs8ya/Bq9UEMF2NGDCfqstzkruRRTg==
X-Received: by 2002:a05:6000:459c:b0:354:e775:19fd with SMTP id ffacd0b85a97d-354e7751b2cmr3081085f8f.26.1716468204755;
        Thu, 23 May 2024 05:43:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc077sm36479176f8f.104.2024.05.23.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:43:24 -0700 (PDT)
Message-ID: <6cf8a292252aafce6ecb787c0e28e30c35b98fa3.camel@gmail.com>
Subject: Re: [PATCH v2 3/6] iio: dac: ad3552r: add model data structure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 May 2024 14:43:23 +0200
In-Reply-To: <20240522150141.1776196-4-adureghello@baylibre.org>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
	 <20240522150141.1776196-4-adureghello@baylibre.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add a "model data" structure to keep useful hardware-related
> information as from datasheet, avoiding id-based conditional
> choices later on.
>=20
> Removed id-based checks and filled model-specific structures
> with device specific features, In particular, num_hw_channels
> is introduced to keep the number of hardware implemented
> channels, since 1-channel versions of the DACs are added
> in this same patchset.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Changes for v2:
> - patch added in v2
> ---
> =C2=A0drivers/iio/dac/ad3552r.c | 98 +++++++++++++++++++++++-------------=
---
> =C2=A01 file changed, 59 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index a492e8f2fc0f..6a40c7eece1f 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -261,7 +261,17 @@ struct ad3552r_ch_data {
> =C2=A0	bool	range_override;
> =C2=A0};
> =C2=A0
> +struct ad3552r_model_data {
> +	const char *model_name;
> +	enum ad3542r_id chip_id;
> +	unsigned int num_hw_channels;
> +	const s32 (*ranges_table)[2];
> +	int num_ranges;
> +	bool requires_output_range;
> +};
> +

nit: we often would call this (in IIO) ad3552r_chip_info. Then...
> =C2=A0struct ad3552r_desc {
> +	const struct ad3552r_model_data *model_data;

*chip_info;

Anyways, not really something worth a re-spin. But if you need one, somethi=
ng to
consider :)

- Nuno S=C3=A1



