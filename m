Return-Path: <linux-iio+bounces-5887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3588FE036
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FEF1C24ABC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9E13B2BC;
	Thu,  6 Jun 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ommvAfEc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC013AD38
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660467; cv=none; b=Ht+MShkZ10J9HJFocdXsNmrT1IWgzdlNFkrpLCPF4lepJBbTngRKLrPAQ4BLilfj16cxUmK+DLBlIa3RlP84RDb1ncSNqUuDkSY2ZmT8N1eWuli/xp3J75RnPani0xc6/z38dlQQoFXulI2Q5rfOamWJDikiQ/KeEBjXg7MdOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660467; c=relaxed/simple;
	bh=kFiTBzr+9uxPDhZuEKTHcAxsHLjfIkq43/MvTdE9Rt0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MdAZfdph/yfdgr+86qpiaK5206biZ9LLJ9nqJes8PLBQDS1GQTThzCF/qCtoWeTd3ZMTRVCjqH5R0mrNoHgsUsXy4Bv0ZeTUEn7oHlm0M5SMpl1i2m/sojb5SL3jN8Gn2Y/HXr047cDCPXUIKcZg1jq8M/SV5ID9RVaDIIYre8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ommvAfEc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35e573c0334so1013412f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717660464; x=1718265264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmYn9rMjzNzeNgtppFDQy4tGwULHDIGKKfhkuKp/Fsc=;
        b=ommvAfEcOVsmnOspMTkmBpha+KqSfEOBUGVS9KSVckx6ndmlC9l7fDeW2Eq3zH5nnI
         OQCoyh/KwvdgTsNt76aZmfobW04vWAbDnmNH9Wk3BnbnYWLalxJw2S3s0ATkM2bQkY89
         ADn9V3wX1UW+YUm5JJhq22sldW1SRCjzTM5aAWccqanrFB91/E6upo72yhGsy/1n8lgO
         VhmbJAk6oKhPpFhinqfOTNqDQPD1HPWdUymWpDVEjEOnQoIhFSIWjdqQMMuPhglaqOMC
         eYI3oh/4Bewe2QG6cGp9/Snq3Y8LPgQki0E1qsKC2gKCt0sp/ztOTqFDZ79Z/HAbetwg
         Rckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660464; x=1718265264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmYn9rMjzNzeNgtppFDQy4tGwULHDIGKKfhkuKp/Fsc=;
        b=tJwfrexiRMbpnss+LJ+m6m5COw3Oxb5vJeQOkJudm6Jf9XyichI40iyNZjrVXhgEd/
         o0BU3/81cBGl+hGBp+C1mbGt3+4W9TjFrKWWQooyh6PNhqFVgLCcx2OAO7e96Y0RbhTV
         D2Ht1F3y6qK1/vpnVvjs4p2MttsCwXMmZPJZr2nwhH0Xr77hRiSP5x1F3wiELUJk+OO4
         7m2kEKbRwuWdKwomXGdFmHM3PTy2TXn+P/MmQWYoKNKtixBn2uR3CEtK4Z7d95YhKEWT
         ow11lKPjxhU7caR8Te6mHHd62ppF7v8EqsM3jXXF3kTIZ8FmHfiwmItliDhfl6jmXHeE
         VBIg==
X-Forwarded-Encrypted: i=1; AJvYcCVGEYlptkcJXQV9FwLQqO2l1rtcNi5G+0yMqn+HwCFJkU9BmI3/yi5mC4KgdecFDq6EGgH4Zs86oHHYrwsqtsxoAIFoYRfhJ6rj
X-Gm-Message-State: AOJu0YzrrwjntjrgSd10B48a/nRxK1C8DGh7kpd1AVHhkMava5nPpFj6
	iwJCXvCmaqU3alvMI92TKZboBCGFpvavZG3HwG8I9wKQUGdb/NobFxyjjqHd1HM=
X-Google-Smtp-Source: AGHT+IH4KWb4XVK34xYY5tEiXvzfkgFMx11vnQnrD9YBFyNgpHbpBdy+mWtj8PG7uu3umEeRvRNHwQ==
X-Received: by 2002:a5d:6a44:0:b0:357:16f6:71dc with SMTP id ffacd0b85a97d-35ef0d7a2e0mr1635823f8f.13.1717660464551;
        Thu, 06 Jun 2024 00:54:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2? ([2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f66sm47781085e9.32.2024.06.06.00.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:54:24 -0700 (PDT)
Message-ID: <1a82eeb8-bb95-4fad-acce-798ba0cda170@linaro.org>
Date: Thu, 6 Jun 2024 09:54:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: add optional
 power-domains
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>
 <20240605-abdomen-starch-4fd4d7ead431@spud>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240605-abdomen-starch-4fd4d7ead431@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 18:58, Conor Dooley wrote:
> On Wed, Jun 05, 2024 at 11:37:08AM +0200, Neil Armstrong wrote:
>> On newer SoCs, the SAR ADC hardware can require a power-domain to operate,
>> add it as optional.
> 
> What about the older socs that don't have power domains, the property is
> now usable there?

Old SoCs doesn't necessarily have an associated power domain, or was handled
by firmware, does it harm if we make it optional for older ones as well ?

Neil

