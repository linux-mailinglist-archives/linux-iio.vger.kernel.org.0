Return-Path: <linux-iio+bounces-15905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A5A3E79C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 23:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538E87AA7FD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA142264634;
	Thu, 20 Feb 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fNKlmkCe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBA1E9B35
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091112; cv=none; b=p2DUUyZ5mhav7iUnSxRYtX1We3iIVd/024DSjc+DEeFOtlHx4AU6SgaD971ZiSp/Cfh4qPK/bf0ce5Q2vqol/xgqWEBwHx8HRqpLmfKJtzS+CMVc98UGCa8L9f7tFFEOYpqW8LKaJ3hz6u216nBCRftIWoOFGOfX4NlinPqclhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091112; c=relaxed/simple;
	bh=sWMtMJhIGgZDkwBs1wdeFaJJtPcHRts5l/4w38T2rfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU1p6AU2XUhUwBTNr5B+oxvWIzDZrvJotZf59wX92aZqzBL9akCrgJ4/tNaic3FZU7QEpnoJ35/95aomiEHmZ8nFJ0kTy9WPG09rQmZKxhvorxNlyPhTNwP34/AurSv/dmTDIIQKbFCbsFjgdsnUV06PWTDz8dhgZZhiDAemDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fNKlmkCe; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72716c75f20so434845a34.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 14:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740091108; x=1740695908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZvnme7tRdTD63uQFjHp0iE5fgweZwPuVbaZo06CSNU=;
        b=fNKlmkCeOyqBMIADau+YNglc76AOrOmhQDFNSz2eaZF1tODfP5NcxSn9gfc5fwfgMD
         Tms4gc6lkuE/ydOWKs8DhFxgfTUKg3p/61QmC7O1hQEK5bgc/Ds2Xfja5RFoLWDJavBk
         HL9KtkCTtVF3G+xhkZFWO/MMm/8rl098PrckC1+GDDeDkl3nIQ+4VzLAZIIM4BE+iDsU
         Ugkn6xnCwlGdjYyD9WsbS+E484CBFJ8PFWg9l4uuxPP8/JZNdxwr1oHGYgkg8JQ1yKRs
         Br+9AYo9lhx+akioUQnaKKeeznxd1NYjE9t6uI1auOEGFAxjTmO4d4t/QwrSOkHxzARw
         Dr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091108; x=1740695908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZvnme7tRdTD63uQFjHp0iE5fgweZwPuVbaZo06CSNU=;
        b=X54TSAE5776FvUQZUQJWUEA+VoZ52ezWx42sQ7fzNDDq3Fq5OJjGB9NAh26MxVPZ3u
         C2A1EKeGZG0JT3EQw89R9C+MfL19DQ0+68J1RTq/SXJT+1O4qY6+py4dHM2W3PpuX5P9
         1gc9pp1Rp3KJlaxcDiqYyMNK/nP+9bwDrfY6rF90EZmrMZBH6MZgyoWxQ+UVdgdee0VE
         qN2ohP/dM/nK6SK+firalv/WZZmDOZLgkt2taql/RVnYfzsN4LkQuGx+/h3CaFI6SCJD
         gQ/Y4qND6eH2wFGb8za2oJgo/8RH7GWRfe5/hS4ZQkCfocqMFAfaJgbwIgQ6zo9Eg1t2
         uv2g==
X-Forwarded-Encrypted: i=1; AJvYcCWNXDJb/14bJfqv6zbijQKIz0Hbu+pH0BgK/sbyJ4NB7MzktNcJSvb1VnCrtiQATPx7obfgYa9Lnxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRM3VLQl9y0m8UdrbnIZ/KG59QFY7uAv+GhGXsQlPCaUHBMWp
	AerQNNQdAxVduMkj/B3CJ9nw+mghdahZeuEeOOaKBxVXyn0hZMwZf5zI4/Y2UzU=
X-Gm-Gg: ASbGncvWPbhpP/DVbNncF4rdK7k2x1fssdkp8+EvaCe9SZbxJUX9WuTko55PV+Jig7h
	hlrzlKWnkctjuNo2Q0ON9sb2NfQnAuKQTlWi1hBA9mxnq+w3C/ULWbjASJWKDIFuWpsOdmBn09e
	SsjDxCaij57Q2sZS/h6IcRRH1jJz+HHMUJ1AHTv13RPP0/riAVAPApW5xeUJVw7Jz1klPifpTXQ
	lF932IuDG1IMGldepVPHRB1qkEA73KqN6P7d5jt0KhSoRbui7omuv6nmFGVb1xyvd47BnsKvalG
	iesMgwE0st0YBv27fLgklr9D4k6NSToTyOogXRVjabyD1nG9dO8i
X-Google-Smtp-Source: AGHT+IEzdfjmrp9J+sxTdexLYB1VUUUSlpEgBRUKFEO5q3qrJomkJEMgCb7UY4Y09D1Vyk3fevqGpw==
X-Received: by 2002:a05:6830:8d2:b0:727:2751:6b93 with SMTP id 46e09a7af769-7274c25bcedmr785372a34.20.1740091108688;
        Thu, 20 Feb 2025 14:38:28 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72732331fe0sm1729171a34.43.2025.02.20.14.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 14:38:28 -0800 (PST)
Message-ID: <3c54045c-6001-4f13-a421-f7f4844b6ccc@baylibre.com>
Date: Thu, 20 Feb 2025 16:38:26 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 13/17] iio: adc: ad7768-1: add multiple scan
 types to support 16-bits mode
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <854d64a0b431e66e70dcfeaf75bc6e40c4c25a78.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <854d64a0b431e66e70dcfeaf75bc6e40c4c25a78.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:18 PM, Jonathan Santos wrote:
> When the device is configured to Sinc5 filter and decimation x8,
> output data is reduced to 16-bits in order to support 1 MHz of
> sampling frequency due to clock limitation.

It would be a bit more clear if this said that x8 is only possible
with sinc5, so we don't have to check the filter type in the code.
At first, I thought the code was missing that part of the check.

> 
> Use multiple scan types feature to enable the driver to switch
> scan type in runtime, making possible to support both 24-bit and
> 16-bit resolution.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylire.com>


