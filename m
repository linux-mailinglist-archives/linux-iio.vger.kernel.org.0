Return-Path: <linux-iio+bounces-19714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D9ABC554
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDA64A1115
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399ED288C05;
	Mon, 19 May 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW1pHrb1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E961E9B2F;
	Mon, 19 May 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674816; cv=none; b=oFnarzFbwEJMdbl7PrIX/PWbEDT4+ZMEe4jU6Lv+O5SR+waB5z31Is6r9BUCUJ2QZC94D4FoNQpx2nfPu2iUlCw719URt8NRSz6Ggz9WUYsl1kw5nEyu70CqYEjXpgXKbb3qRTSgC1DKNSkCS7mJpA2mumXZXcbIZKUm202TDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674816; c=relaxed/simple;
	bh=Qdi2sd5zKiaqiOmyDGmwmHhX/Extxxcs7bTo59RLOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTLVoXXV2LWQQkU+VXqJSWqCEA2QfMr7zPPNsnMIdcDg536qlr5bF5eGXb3t8rF9OYcFSgEe0o2wCeKkzZKPeZaO0oSJoI4cJ4G8krbKhFnOarYHT78wRJb5fl5siwW/RUZeAqYDa1nJYO2qqPv+sQVXLeQ6amL4pLwQIEtkUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW1pHrb1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47675dc7c79so2173601cf.1;
        Mon, 19 May 2025 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747674813; x=1748279613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfS2K+nToaIQZXiWRsqqBr1PnTaklIQKpwVqODFItlg=;
        b=jW1pHrb1jkLoUIGGJIU3+D1jDSX1Jen+CcYH9FSIBZu6G5GjLfmagw23zl50DDcDbj
         Ekbwdl0JC6hMPKv2cibu0iI8chDf7pICFv7Tp0Di2gE4k2M3rw4MHo8pkwunghEKqvsv
         5edlDwt97wfEMQKTE7s/ImTwItbZLwSJJgUvaj1fpCTLSokiNyvswJRT3k6UybfrNmew
         IPfoIbQ4HzvDu5lxO4cl72fb/pvzdGcQ3ROZMPimD8o4cIQnnPYB/RvT19uNWYpf/3qT
         JNmxsWTGhVVUXA+cdqrv3EPn+aZ9/gpPPaC0DD5KrkuQquHCYb3rkdYqE5p5cZurbUCy
         sKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674813; x=1748279613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfS2K+nToaIQZXiWRsqqBr1PnTaklIQKpwVqODFItlg=;
        b=scw4/sZKRCSvXAQohjo35e5Brd4TaFm/zqZzKLqrSrQrQ/rX+LJr6eYjWqZM+2QvGs
         K5SS9q0K8tsVLJKWLJ2NN9ukDPSzVe13NQ+c9+v8tu2Jf1Dz3Z0/EIeQX9cHq98Wrg/P
         03UJnWL8DNh7utFgrqHIVDQ3lXpACxjLddAMDhxazrifDek/Vz817yznLclMNpuf4NaJ
         rL8o9JjkHxeMWSdic7ZUZ2shEILEghxXP8clJSW7ovm7MqM0xPT+bnAPv9QrrhZGr/Cz
         dGT3rBZLmSkP4C/kE28LY0zm+iuqEtKbt5KUn62/hO73lNf9tfEv201ByDUmV98O8iE3
         ZomA==
X-Forwarded-Encrypted: i=1; AJvYcCUVIJnW50Hjy4ImBW7gELbqsnEC73HKqSKhhc85D/tWEEDBHUxKLNuWMCI9Bef0/PFqt2reaOgl1/Ru@vger.kernel.org, AJvYcCVCglWw0IBMYDd4KkuqbxaptAxWG3+eqcQbyRm8tumi/zhUv1gJGigZimPKL4kiz5JdtVuBaknxA9iXiSJL@vger.kernel.org, AJvYcCVxO90fSKrxZhfMcb63jJ4ItQKcT3Jnjg1KRlMWeJrb4mLjJAV2UFt2i6aKd1f0HBpQNNq06TayeNFiXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpdLqpZjaVCc+NQfDN40B8DUM9YExHtqKcRD3l3jJ8nI+KGLz
	xvzHMsNgiAmcynHfiuOy72Q89y7eOmbEOHKE2FEWSEbjA2q3284EtvrA
X-Gm-Gg: ASbGncuRGxmqdrVX5zqWpby0VYsIbuCkE8DE77fr7KMKjbLvj5V0x6s7JO/+WFY7ls2
	g3Lkw+nl0WIauGW4cHSduT5Kt1OFFziHER9TyOxj0pMjC45Qy1E+zyieOpvoeZVquYoAbLUvXDd
	vXIHlthMfTXeKjpoGEsxIYOxZy98i8XiJAxYZvnRXASU7ptBW+kEkJXChJ2z40gBApo67O92YxQ
	9zVd1iEG8Pu20imSvDLTCxTNO3um9pyvbYCy1MVqvoQNhRIYfQnvCi2rlHAX6WU41yy95Yfp+Ju
	jfjkWAauCBJGAIOiASuugmRjh1FNzVPOm4Eh8G0BWkiOnnQQ26rAAZOOKPHmwJ4IcLHV1BH8
X-Google-Smtp-Source: AGHT+IEmerFA7UG18MKd3PESkSiYA42y9Lh+jF2d/0IAMd3d1SBK/rdF0xGLenMpT4omCyd/haaNlw==
X-Received: by 2002:ac8:5703:0:b0:476:63e5:eb93 with SMTP id d75a77b69052e-494ae3a253dmr83340531cf.7.1747674813024;
        Mon, 19 May 2025 10:13:33 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467dd34csm607046285a.47.2025.05.19.10.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:13:32 -0700 (PDT)
Date: Mon, 19 May 2025 14:13:27 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com,
	Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v8 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aCtmt+ozqSRDGQxi@JSANTO12-L01.ad.analog.com>
Reply-To: 1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>

On 05/15, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features. Sampling frequency
> table is updated after every digital filter parameter change.
> 
> Changes in the sampling frequency are not allowed anymore while in
> buffered mode.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Pop Paul <paul.pop@analog.com>
> Signed-off-by: Pop Paul <paul.pop@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
...
> +
> +/* Decimation Rate range for each filter type */
> +static const int ad7768_dec_rate_range[][3] = {
> +	[AD7768_FILTER_SINC5] = { 8, 8, 1024 },
> +	[AD7768_FILTER_SINC3] = { 32, 32, 163840 },
> +	[AD7768_FILTER_WIDEBAND] = { 32, 32, 1024 },
> +	[AD7768_FILTER_SINC3_REJ60] = { 32, 32, 163840 },
> +};
> +

Since we're still discussing some points — is the `step` in 
`[min step max]` for the IIO range additive or multiplicative? It is not 
clear on documentation, maybe on purpose or I have missed something.

Here, decimation/OSR doubles from 8 or 32 for SINC5/WIDEBAND, and is a 
multiple of 32 for SINC3. So I'm still unsure how to represent this to be
clear to the user.

> +/*
> + * The AD7768-1 supports three primary filter types:
> + * Sinc5, Sinc3, and Wideband.
> + * However, the filter register values can also encode additional parameters
> + * such as decimation rates and 60Hz rejection. This utility array separates
> + * the filter type from these parameters.
> + */
...
> -- 
> 2.34.1
> 

