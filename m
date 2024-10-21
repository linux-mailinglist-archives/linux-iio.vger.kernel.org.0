Return-Path: <linux-iio+bounces-10883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09149A70E7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34611280F96
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9E1EBA07;
	Mon, 21 Oct 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l8ZXMYaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627D1E9077
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531187; cv=none; b=RqrS6Fq3EulPE3nqJx9gwi+5G4C7VC5KlmL7Mt3qblUM0m16o9PDRRSeKzSc+t8XqutM1EP5yKMX3cP9yjadZ+JTCiR1zfVGvD1owo6HahUtnx0NlxV3QansebzAvmL1A5W4jIikmKcYim6CGDcKXu8Vyt3XBppNjtsoeoCMbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531187; c=relaxed/simple;
	bh=VT8mmAKrwqeCy2RkDHrrEva2qPRp2pxEkmo9EA7vyzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my+KMtzlsxLmzrlsuoG1PCzR/uuhLFaY2WiaCjz+BVrB23m206sFn1CzWKndw7flQxBy6fxQWLhe19gtpKP3ToUMUzDZGUHtkVK7yYDJXYvfUy14n0ImfW39+aj2msMfpzpoJPPR2H3dOXPmbA3Lfk6eRnj6QV2toSucB0rgpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l8ZXMYaq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718065d6364so2136050a34.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729531182; x=1730135982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOFL7ofhLfrgIiFV4c6NydCiKi/kbPEnGF3mniiUaXo=;
        b=l8ZXMYaqPVQ9EhZi425gIUsTd/DYF0O1PJjYegy/RVXncrzXiO8BS1Ebe06ZTxcqH7
         mOru4y0HzNdAvkikS72N0acHWGAZovmhuntWtISE5fcuMLjkYk1n+bobm50UgNE9XemC
         BMsTKUVJAgXJnfbNMiGiBjpYh84Oc/IM1ZMEwLswgwr5qDU6/W46XzVVqi3vIEDdfY2u
         CAzEQa7xQ6GSs7UMxP5V79MPhtidJzyXY5HN3DpFibJ5zEXij3bdoM9mWBAeg8mJ4z74
         FHVjDZLbQ92NbfNWzpuZn9avWKFGIVeW4ayn+hXfLk3q/eY1kj++Nw9tkWX0PHA4c7yd
         u3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729531182; x=1730135982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOFL7ofhLfrgIiFV4c6NydCiKi/kbPEnGF3mniiUaXo=;
        b=f+jDrQZ8Ed1NKgBDLij5gS53tg1QdZJjP8ZLQdc0fK82ReNW550dDGR2MWpmuNuUwj
         b2/pwiv8Es/Gj/nLEDiTlFitejmydyZsDOplm5NC39ku8VKuZuGQ8rA9OzgCxeLidUyW
         YGtRIGL+I89j+H3lDxlxiHwXbefCmC4tt+H0Y9vzsXl0meymURGhLyXiUkDXW8WuMLLz
         r1kzW6J1KRdMJSBnBJMavExFhbgMElk/fjb9PRWZYQ6bpw33NU3HkeVzdhwToFdG2AAy
         8ogLE++ZZ3ePvZ8d/9yFtyqV0PkEgzV2lhiBcEA+e2AEi72e0kw9Kccorzd4mJN7NJQs
         G7nA==
X-Forwarded-Encrypted: i=1; AJvYcCUGcWF6FWvOCQ/UmVSUc5FGmIDBHM67nn0L89SMFzrn08vq8FH4j6maiR60xZjrK3lTte3362//jXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimdkfnHaHBUJApQXNBwzS8DD/QLM/Zm5DTG4P0iO63iQsFAMW
	Hxtuw+gd1EZZEbxFiU00cACzc77uYSyjoujgIhUXiV6pAWY5FQlwmoUoCoH1J6B2Y91z+SzQJDQ
	s
X-Google-Smtp-Source: AGHT+IHfZS4g8MTE1WLtwwQiDfsSzfQjcyzq8KaqPIPnfPd3Ox0b4I0TLEYr65leOuEDGiV0yu8G0w==
X-Received: by 2002:a05:6830:3155:b0:718:186a:497d with SMTP id 46e09a7af769-7181a5dc591mr9990344a34.5.1729531182096;
        Mon, 21 Oct 2024 10:19:42 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182ec03211sm836933a34.67.2024.10.21.10.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:19:41 -0700 (PDT)
Message-ID: <f319c8bd-1edc-451b-aeb2-27ec529267a3@baylibre.com>
Date: Mon, 21 Oct 2024 12:19:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iio: adc: ad7606: use realbits for sign-extending in
 scan_direct
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
References: <20241021130221.1469099-1-aardelean@baylibre.com>
 <20241021130221.1469099-4-aardelean@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241021130221.1469099-4-aardelean@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 8:02 AM, Alexandru Ardelean wrote:
> Currently the 'ad7606' driver supports parts with 18 and 16 bits
> resolutions.
> But when adding support for AD7607 (which has a 14-bit resolution) we
> should check for the 'realbits' field, to be able to sign-extend correctly.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d0fe9fd65f3f..a1f0c2feb04a 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -568,7 +568,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>  			      int *val)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
> +	unsigned int realbits = st->chip_info->channels[1].scan_type.realbits;
>  	const struct iio_chan_spec *chan;
>  	int ret;
>  
> @@ -603,15 +603,29 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>  
>  	chan = &indio_dev->channels[ch + 1];
>  	if (chan->scan_type.sign == 'u') {
> -		if (storagebits > 16)

I think it would be simpler to keep this if statement for choosing
which data.bufXX to use since there are only 2 choices.


> +		switch (realbits) {
> +		case 18:
>  			*val = st->data.buf32[ch];
> -		else
> +			break;
> +		case 16:
>  			*val = st->data.buf16[ch];
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
>  	} else {
> -		if (storagebits > 16)
> +		switch (realbits) {
> +		case 18:
>  			*val = sign_extend32(st->data.buf32[ch], 17);
> -		else
> +			break;
> +		case 16:
>  			*val = sign_extend32(st->data.buf16[ch], 15);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}

We can change this to:

	*val = sign_extend32(st->data.buf16[ch], reablbits - 1);

Then no additional changes should be needed to support 14-bit chips.

And similarly, we could avoid the need to use the more verbose
switch statement.

>  	}
>  
>  error_ret:



