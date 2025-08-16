Return-Path: <linux-iio+bounces-22851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD1AB28FC3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02800AA7765
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70C2F9C40;
	Sat, 16 Aug 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gOqQ0K2k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6D1D90DD
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364937; cv=none; b=KhfkoT0trbrdPyXtosg0ex+uE6gSWd6I6Bcl5zmVZXlPwP1R29v19Ocm2zMmFfcZ8hOt5ce9OfqkRub60BxJDHPwEsh63bQcAC8s1Nvvt8bS0lnq1njH8BAFoCpYEdfNGQiVh3SM0vDKOp09/tkMljFZrRJznIr9RbkVSFSb8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364937; c=relaxed/simple;
	bh=uo+OncJI4Myjpz8f2aJumPsc1iN2S7NFiH4P5XJOOOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWqgredF0HmBigoI0YW2F96QuvtuO5HkHB2y4hGyCEVvDuax08GTFhS6aqWjC6cnjclu3hIqE7Kk41qEzvDPVs57QHjmTYs/iEfTcNbUp5jcnAm9+KeSMq0gKUBO82HtwoI6Xg3op/PPV66sFNz4OJCQMDUfziSXWS02Jc6sAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gOqQ0K2k; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cceb07f45so2114634fac.2
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755364935; x=1755969735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABxHftxzLrHC817RM36mVaTvJR4++06Og795T+rFPJI=;
        b=gOqQ0K2kLVhZXsQMfIO5N4M3JMsSri8urwqRoaHwe45tPq7ydsg7QJ7tyHreSHAdaT
         ZqNIY4GAdlCStKWow4mWFM38CHmoE78P38UMZnBXbUsg4URBUDKBvvxhEWkZEtVQyK9z
         jdzK/iDw0mQVBm9W7K8RWDPd6p43RR2ao07lG8G1zE8enkE8JfkSLM8oWQf5DQcdvgHq
         RGRXOhOz0ztbbyalvia5jEX4Cw07neZMoSyoeBA54LWPYlDg9cTzYSJL3oCGHsTdcNjv
         yFjgy2qrAHsszmWEV5//DnboV+xncKgqhw3PR+JmtsLAmzjYzewhTq1G66QzzzVvKUFp
         IppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364935; x=1755969735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABxHftxzLrHC817RM36mVaTvJR4++06Og795T+rFPJI=;
        b=KE0UMOJSqQpie1CzJksKsC7mm5vSqXsIh/T/ZfvAsbosEXp3XcVP2WnypRLSkhuPDq
         xg2lYr29Nqt3mcNSIV6QZv256iQo/zkSlsalHb+J5aRmrdFYxnkm7TtdSYWSQ5LiuFJd
         NrAMw1wGRKY6mxEuDT4edxf/ul1yKs1oAejowOmzRRindDcHUkIR2o/MTXD0fEC7kDBI
         5ey9n8P3pR4QfxIxU+uEsrFfSv/PCWRDZmjYbw5hQ62qM4uGsb86WPdIkJXlqKzxJHBG
         dedmamZw/9E0by/A723MDzdxcGyqFSYFtr0W/IeyC699aSOSFvDIy6zWhzecnbsqePvs
         AGyQ==
X-Gm-Message-State: AOJu0YztRLeTc2qMQel38qyx1gC2vfyRaJUIfwoQUAXfaGNKpuYh6CIj
	UaFRIcYUSJXyfh9nZxwCLlttuqAvkui60B36zUtyvqHblKWwhLnYPlDtqifr51ZnC7k=
X-Gm-Gg: ASbGncsJsphGCAeLhuuAVnsnQRHf5lbN1ARuk5u02EQrLPqMlA9pKe3MtFCWB4q3nnn
	ZF11oXEVUkiP8sQyjkX9fGpHExR7R8kmSFVqMLQlZoMiUyUMPFJYB9I5dPb93OhvX4v5E7u7VTx
	17nLHEQVabIsGjtu+BgevbimyVy1+AaMRGA63CnjcyJNy6YzJhAVO0zVGbMhbbbca+N9ZP4oS+g
	utog/azgeXUK+TLI/2oumjFuFPllyhgfeKRyf+2QkUeNNCQMKWATNYnqFDlh4uIZV427L242rmn
	J1yPl5X32NNlo+Z+5pCO5XdQH1HTHsssWGMCvXimechlk7QvpLGmxlgsH8TjM64fxGbyPAi00ct
	ekVQjeUKotH7mz0W8xsITcLpWU6Bfb4O9sIT3j4EPAr6F57f+Flhs/f4rC0BJdYW/nAaIB70A
X-Google-Smtp-Source: AGHT+IF/Ida+uaip0/WJfage6wEN5F2NxxDcGtxRMU+BcoaqB7p+zdaxJBA5J2D7Usg9YF3tOg62yw==
X-Received: by 2002:a05:6870:c907:b0:30b:85a0:eb66 with SMTP id 586e51a60fabf-310aab55b9bmr3559443fac.12.1755364934826;
        Sat, 16 Aug 2025 10:22:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abb34366sm1329353fac.23.2025.08.16.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:22:14 -0700 (PDT)
Message-ID: <c6fb37b0-e904-4fbc-8666-9eb747861af9@baylibre.com>
Date: Sat, 16 Aug 2025 12:22:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-6-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250815164627.22002-6-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 11:46 AM, Ben Collins wrote:
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---

...

>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -191,13 +200,36 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 62;
>  		*val2 = 500000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +
>  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>  		*val = mcp9600_tc_types[data->thermocouple_type];
>  		return IIO_VAL_CHAR;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = mcp_iir_coefficients_avail[data->filter_level];

We already calculated the correct values, so we should be using
those instead of made-up values.

And the suggestion of using filter_type takes care of the
turning the filter off so we don't need an "infinity" value
here.

That does bring up the question though, if the filter is off,
should this attribute return an error in that case?

> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

