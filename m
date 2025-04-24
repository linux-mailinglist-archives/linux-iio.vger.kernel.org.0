Return-Path: <linux-iio+bounces-18602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4FA9B3A7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43801BA4379
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B48280A4C;
	Thu, 24 Apr 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pr0xzVQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117535BAF0
	for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511437; cv=none; b=lD0/JPbtVyHmv7haVeIIyj+ZEUPyybhuXkbBGTciRsKnEXK2mwQEHrJFj//zIqI2HGnM8TLWuv2KiLBOy+eJ4Zz8JuzEx917BQlX9z5n+g9SqykIleINv5t5MW1Rq/il/Co9Upgm4ITzXa451BaJMecYBX6TL/T0/gWsORbR9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511437; c=relaxed/simple;
	bh=titktJptRoaayWPqbvRUNSGF680iVp7T7IBr2ktAgjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsweQBJKz4mKa4qGTPSQbAjr2xIFYxN1arTZCrlr2OIfMRQXX/bOLgPDBlTvblvAIHowoxTPeeMJnlmIxc3RO4RrJ8pUampmHuOhL2Pgyi9NTPufqpgtX3jIp1Y4yb8AHrstxT1rQ2KVkxuJl4TL6TyPff/esHi/otzOxHw0Y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pr0xzVQC; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bbead793dso1026446a34.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745511433; x=1746116233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMDSe2gyY7VT/4LTz9u2YpY5KEIDQEp0d0WnKerW0I8=;
        b=pr0xzVQC0NtZV/XeXnstGtO7nb4NIyEHMRv97JbA6CPZ09BcUp4irAkf1BPQFjmHSa
         AcdNJlS1NUXD18SSJsIwmqyS7N5VkdNlNZ0eJmH2JB1pqG3d7D0S6BMLvZlFkOEFyUBR
         MXW67FNW46a3NQNDpYkF6/3feLvIOheuAP6u2VxPl0COuYbPLgCJije+qElA7qBbprYq
         lDVYuT4Wl1y2r+f0no8sdRLoMe2c/YjDw3ss2FHUaVdQ1jQYwzyycq32z3w63ubg3gdj
         G1CIZ2aC6xe4KyUHXX58HGSnzbNpCxtOa8QNA5YU/s990lO6Gy4PNr1p7tQLzNjTCiJ2
         HsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511433; x=1746116233;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMDSe2gyY7VT/4LTz9u2YpY5KEIDQEp0d0WnKerW0I8=;
        b=EagOkmX0g9knlP75xWqF+bqQ0dYiajCDHSH4ZLm3ZSx8iqdS8U1cn2dQZVWm0Pmj3L
         b24/juEQDlkEP/qYouIENjxXhF521UhACHJ8CqHmQS8lyQTB8QjY0pR789DLCxJt7qgk
         CQMed5JBf7d/9GKkJdSoUFzpXdWVJU73fYkNaRZ9km74SXi3HpcSUVz/Kh0H1XtJxD5n
         nKgYuxqPWxpD7jHhzR84Zioe6IeE9Y0nb9NW3RDAaHHh3KTafbckY8rZl1Ylyu0jaLBz
         UuLgZQhaInb9PXuMMchOqeTfnPdX5x+snNudxRRuISO8FT1vRbkhRUKyR9us2MtE+uhX
         J3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/gP4ODHULlU0wk2cj9vi/VIMeFl2w3I6XmW1+q2yMDKItNvgA6eAi1sLL7ljtDcDISU7scvX9Uoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2khRQ9tqSLlSGxoEVafSi5UKk9isXaaV9rHJNVyh20lanaiUm
	P7CAL5Gu/RfHC0THt8lMr3cJd/P0PhB0diE7xUjnUizhMz1j6rImWdIV+jKxCZI=
X-Gm-Gg: ASbGncvI/+YSuffTyiohwaGjzO0goG4yzJyaMgzsN2lcusmydA5JuFd/I9zPOL8KBoE
	T7xTR5p83y6DFi9+IkhqhqkzOXT3hvYkHnFJX75I5eLtxMeGJRK+ymOR3LENGSWbC3PKWWfry4a
	g7y7dDupESwuDnlq/18BPnMioE/sOTHqVg0JT5WI/OGDKEMaNtn6lYEnrhBm3K4MATksoFWCjv2
	J0Z/dmrT1KbtkitrqYYpkIC0qEf6H432MMWxDMUlgugzaq1ZCUglQaotf479tcV1IoH6of2K1wJ
	SR9Y5O1fCLKmSj2RIZo53TS1A3W1/PLZF80n8t8ES5QBs8R57P7Ci3V0vnLUyz0eS98Kfu2WtJF
	IXo0+Hd0rEnNzEh7/qA==
X-Google-Smtp-Source: AGHT+IGYpdBfV2Zzsk0/8jMa28e3BnEWDecgbttEk0HlgDIzoWmi2sopZs6+yVh5h5dJX7VRxbT0tQ==
X-Received: by 2002:a05:6830:2586:b0:72b:872f:efc8 with SMTP id 46e09a7af769-73059dc7e88mr305240a34.24.1745511433030;
        Thu, 24 Apr 2025 09:17:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:68de:6c1f:6d0d:b32d? ([2600:8803:e7e4:1d00:68de:6c1f:6d0d:b32d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188882sm291036a34.5.2025.04.24.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 09:17:12 -0700 (PDT)
Message-ID: <ab3dcc4e-bb85-4a5c-82f3-36bedec3e79d@baylibre.com>
Date: Thu, 24 Apr 2025 11:17:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iio: adc: stm32: add oversampling support
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250424151604.626758-1-olivier.moysan@foss.st.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250424151604.626758-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 10:16 AM, Olivier Moysan wrote:
> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
> 
> The current support of the oversampling feature aims at increasing the
> data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution, a right shift
> is applied to keep the initial resolution.
> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2^n ratio <=> n right shift)
> 
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
> 
> Oversampling can be configured using IIO ABI:
> - oversampling_ratio_available
> - oversampling_ratio
> 
> Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> ---
Don't forget to pick up other tags. In v4, I already gave

Reviewed-by: David Lechner <dlechner@baylibre.com>



