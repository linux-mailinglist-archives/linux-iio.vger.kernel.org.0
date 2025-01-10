Return-Path: <linux-iio+bounces-14106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D72A096E8
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 17:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D43A1E39
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA0212D6A;
	Fri, 10 Jan 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="roJdMb/H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64997212D65
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525654; cv=none; b=hJx+UVg7jhKtNfpkMHZSuXCA8ML9AKsXYpobNV2sflswp/1xC2DzT2Fy2gd10LvSouZhK7434uKhDhKbnz2caCVq5aL6i0ceFLFTwAPGfbbBbYhTRoiIQuM50OKDK9ZRitQ4E4FDRTzzKgqz6NK7wLkv+cq3XH1LOXxTLi/rTq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525654; c=relaxed/simple;
	bh=CUcc1KsGhmwdCWJ5UXS/a+OjWvNDJzw5kzI4sQPQhi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXpSEIrzs1HfoRLrO05u+PlzycfckhXxLZjSQBLoitttrrYefWcYkarfVTBl2VOZVg7TLqLxisnb3MN7TojNJi5l6SEgconlPX6/oayVfBkzNHj8GxULZYjmJEtk1OFXzgn1yXYuVGMjmyg4zHKn18iZ6GNmLo0RTYaZuYiNmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=roJdMb/H; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb7ecc3c54so1132420b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736525651; x=1737130451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YP/B6txSDV+Xuo8fhFJcgx+tWiRy3jljO2uml8P7Ic0=;
        b=roJdMb/HleNyBaZnT6iT2mTqf1JahqqNJxyhtJvD1vTW34ibUGteLmiLc06rlyIHsl
         80/1wXL/QLwqP1vax2z5ahQ1TwrmtIsQLiD4sOi51AFxTfPSFy8/hc+jKPPyyWCAspJT
         fbVUrpGb0X2781X5kj0WpLo+iOu5PFWDOrW/RpS8yzlEDhHhFaPB/ANvlPqdPGo55FEL
         zB429Zy35RuhBcEZedjV/IXIpgew8qNAUAhpiumUSgIjv1F84clws6NFXSMSanj+g32w
         4fnFJ6NkbriiL4hNk99EYmECmtEmD8xps41reS6JDtVvPfSthtVfY3De7Qkba156mwXv
         ThIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525651; x=1737130451;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YP/B6txSDV+Xuo8fhFJcgx+tWiRy3jljO2uml8P7Ic0=;
        b=p3wC3TpFnmCdJidawZ/jpwK9GCapJnBxNWx/RFFfkQKrt0mb+6iNYwXiPx/bE2lWKg
         jmrBVff8tURh8wKotlaF+PZT+gZRgrSqOoIhJFkbWCuwqtBsujgO7gsZubolU5mWlI0f
         vMjBeUHirb8mMayDWcR/D7s7Pp/R+8umbNvFy9W1chHkHpZJhAhYZvzpLEwgcDpLe+PB
         LoCldifzpzLJBOFirFWGP3RoVXn9QEEM4CdJdhiAxzBgToHfvsP9MbwjwNlJZ1cFAjTt
         T+gwf4UqSFwdYO9qbjQRiMOy9qYZBhKtFoTJn7FbSxNomNHi965Wr2xEgQuBASUpkEHn
         SVtA==
X-Forwarded-Encrypted: i=1; AJvYcCVihhIuL/bS0LCSxDIt56lQ9fUYcoZlWts4aNSGfAuC+9dwyOyeL9xhVNCMarI2I+rCxhiPBBbwBQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbd0GxmtwHT2+cNJCbmidjqTQoSCyIOteneJX4fIRgn1AxRktB
	1+f5kpYmHRTxLK6O7bNjsiMFPxl0+lhzGv19AStxHMcIQHJdjrvBXaA65MNjlLQ=
X-Gm-Gg: ASbGncsb+41vv30tqshexdYkA2g+2naVznMBiroi03VXdqROX93ywy7i0huoL8BgQfb
	bUn6D5wqr5KF8mbuzq3Y4iBdY0yuEAcP550kUmn8PJKftH+GLYktF94AQ675JT33JH0EdUiI7/e
	thGZEqrcYlflum/4UUvdcx9xepogZTHo7QiBKCFa82sqje7HbwzBgjpRxVyKGK1HB0+WiUsd2lt
	poOlVNAgfWm7/kEQxrrudZbaXcpWQqsHmOaTgw53kN3CQJQv1jCbjcFKqOlLVlKR5a6ZNuxiDFa
	fsjM+sXTnt09SZFZTg==
X-Google-Smtp-Source: AGHT+IF+fbbn5YdTrFiyQ3S6Sqwd4wPQsajQsc+A/TdRDNjsoP4/3jXHtTi7/7sAlCN3jQcvxnbG4Q==
X-Received: by 2002:a05:6808:170e:b0:3e6:4f5b:aff1 with SMTP id 5614622812f47-3ef2ec47eecmr7507578b6e.8.1736525651610;
        Fri, 10 Jan 2025 08:14:11 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f037a22f53sm783650b6e.46.2025.01.10.08.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:14:10 -0800 (PST)
Message-ID: <806aaed8-fddc-40cb-8d58-23d1b2289f6a@baylibre.com>
Date: Fri, 10 Jan 2025 10:14:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-9-ab42aef0d840@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-9-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 4:24 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Update ad3552r_qspi_update_reg_bits function name to a more
> generic name, since used mode can be SIMPLE/DUAL/QUAD SPI.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


