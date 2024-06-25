Return-Path: <linux-iio+bounces-6884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4147A9162B7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70F01F21D35
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362D149E1E;
	Tue, 25 Jun 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfNoElG9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BD149E16
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308329; cv=none; b=nLJ5ugNEC+J+BcUZk/OQhu3QvVZntUZLzoL4Dte6mWjILad1B4k4OYmOaeqb+zYg8MXQeCFnMI/MHu1jFVgMwqg41XDNhbPEEZEfMb9wjXnoPo3JPbe45dfcAjX+n1G1+zPR+7vpzcfE6hw4HONIv0CQfP91Uo4LPytVTaA6eKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308329; c=relaxed/simple;
	bh=K+IiaiLoJmLJyaFh/JrMHu+GjC39e9sUJDGWAwIpgO0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LQejHP2mrHtfXSi3DOwE+Mx8GjQbX8kwr3+sDRHSl2CZgDDAyfolYQ3AolCidYAwIuutKjTyin7q/uAjJGZnpA/MBTdrfuKJFT/fraJ48KrbKCyY/detxT6/yDr1sb/OHUSZ4GEDdrLMiQl1KDs5lrxh912N3Gcc0cyPve3LtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfNoElG9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-362b32fbb3bso3512117f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719308326; x=1719913126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHsZCkoq8YrIBeg6L5civsW1RJ5veolYvQN+FJ9/Qb4=;
        b=jfNoElG9yYDv43fcmSQneFsXASJ2aPNIhT/wGxfUmxqblR53DigwXfHob9HcyBhv0r
         +CRXG06XkRQIyicz31OvJQIm4yDw3lPIAxXd9WTsPaHO0cFrLKQI1TqJ0AMUR8cukmox
         rvgWUT5eqtJdYJDRp6TPduFkQTZYgCE9w7TuemZj/LZzGXYqqLwlZCB1nCe+J+SvYB38
         YlRHyA3wr+9pDp47kTUGTpHWVCsVKWBhTnPJO4NE8nFrW7h5kv4CUMDH5nZHpq3YOTjT
         Z9W9kJkc4ub9H7d7v/tU6TYQA0z8I2zUdPX+HexqTuwMLONY/BpgrmoyAtc4qqHsvN75
         Mr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308326; x=1719913126;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RHsZCkoq8YrIBeg6L5civsW1RJ5veolYvQN+FJ9/Qb4=;
        b=hSw7jiXr4ahJXp5oRoCkwHIQvoVhMu71xSCHUuUyV33Qev5codsstSgkTDSSntaWJq
         0Jr3VhLcBkPomW0kb+JKu3pGC9Jc050r5PA+1/fSfNm8lCNyE2cCunOnoGJ1CWLa7aQ+
         sYgmPwuxkj+e0gFLFDxV78hX9VcpVgj3nFSEKMJuU2ANuTtBNoBo7l84nGJN7rYATI55
         ys6HlZ+ehPNouQ0Lyexuap0U8b5b5Lywym7FCgO96bEcE+jV45z36fmMwEpaYt+RDE5L
         qiz28j0FJZmtrps6pe51mi9sTe0EP9K8ygT81J4N+si5YYms/qpfQm3NTduo0axqvycd
         r3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVj9CJ3pEcBwSOITPrp83PO7T99sMtAQovq5F61phowC2Jwdq7+rSZ4edOZgKoV9GG7Ca7Fk/81Q5rM8rwfXu47nDX5v4PFXI6x
X-Gm-Message-State: AOJu0YxjQt00aWNarfG3AGEdez5LrS5UFaupr7mTp7uMxWGzUqrrh1jC
	rBxEY6jWuWn5zfSOhZjykShUkY+rHuaoUZPqVxoMxxIFmkfj/oitV4r3xU/ai10=
X-Google-Smtp-Source: AGHT+IFA7K/K52topEkP/SOJgf7qzSnQq3MCtcizZ8ZhFQwdc4eqMFuNHG0MvgFRUfiOSwUtuolDeg==
X-Received: by 2002:a05:6000:184f:b0:366:ee84:6a79 with SMTP id ffacd0b85a97d-366ee846c15mr6347407f8f.51.1719308325966;
        Tue, 25 Jun 2024 02:38:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bd71:2ff1:592d:f52a? ([2a01:e0a:982:cbb0:bd71:2ff1:592d:f52a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6977sm12489752f8f.80.2024.06.25.02.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:38:45 -0700 (PDT)
Message-ID: <52fab9b5-2b44-49c0-8b90-cb2a74eb6633@linaro.org>
Date: Tue, 25 Jun 2024 11:38:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock
 measure
To: Jerome Brunet <jbrunet@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
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
In-Reply-To: <20240624173105.909554-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

[+cc people from linux-msm]

On 24/06/2024 19:31, Jerome Brunet wrote:
> Add support for the HW found in most Amlogic SoC dedicated to measure
> system clocks.
> 
> This drivers aims to replace the one found in
> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
> 
> * Access to the measurements through the IIO API:
>    Easier re-use of the results in userspace and other drivers
> * Controllable scale with raw measurements
> * Higher precision with processed measurements
> 
> Jerome Brunet (2):
>    dt-bindings: iio: frequency: add clock measure support
>    iio: frequency: add amlogic clock measure support
> 
>   .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
>   drivers/iio/frequency/Kconfig                 |  15 +
>   drivers/iio/frequency/Makefile                |   1 +
>   drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
>   4 files changed, 868 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
>   create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c
> 

While I really appreciate the effort, and the code looks cool, the clkmsr is really
a debug tool, and I'm not sure IIO is the right place for such debug tool ?

There's almost the same interface on qcom SoCs (https://github.com/linux-msm/debugcc) but
they chose to keep it in userspace until we find an appropriate way to expose
this from the kernel the right way.

If it enabled us to monitor a frequency input for a product use-case, IIO would be
the appropriate interface, but AFAIK it's only internal clocks and thus I'm worried
it's not the best way to expose those clocks.

Neil

