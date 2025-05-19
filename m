Return-Path: <linux-iio+bounces-19709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1CABC357
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633D74A1061
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF11A38F9;
	Mon, 19 May 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OOA6fHnq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB0286434
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670277; cv=none; b=NfQp94I2p+5aBR2j0QgCGXHia0WkVGbqr6Y+3g0uC+9oCj/2ceZrHudJQnMoRkHQDonYZgjWwZn20QVS1s9nkyQ0YyUoivdmecurcNUXQSp/8quqofC+QmTBX+l26pC546PvRgqlS7YtsVn/J0EPad5dQTjCyDQ98sogw2r54Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670277; c=relaxed/simple;
	bh=kDzZH/2//KqHjtRhP0MAmXrUXCabtr3kxzCKj86U3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW+LqrLBR5mjSbb8jD9H5+X43QAsLmXMvIsQHgC12vd4uVOSkihxXug8zvlRD+7PUHbi3Wm9zi4VsJcJFTr8sOb1Vzp1i4FXcQYO96WDv/+oYtpRsWoc1fFk45kiMS4dsMTOJE85fZdP1BhvlD2vTbT09GdOo+QBla/399bz0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OOA6fHnq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c40235c34so1528309a34.3
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747670274; x=1748275074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNI7NcwENluO3zokSTsjvdClRmMPUb+KHUbQq6ykMN4=;
        b=OOA6fHnqrd8XpwQtTyQdHYmaSZpFJumVIbFkClc705xSbXWIGCW+QbGlkICp9cyLml
         HVoxuLjaMzrqxhGyKk0Hjs2Dp3Nz2hH2mtD2ilAx+4oLfzCewT7oBaHGW0yhr+eESPqF
         YT1OUyeXC18C2xq6s3wIE4dNZWqWaM9132fBM8KaqGSl1HAPabZ7gQsamyG9G8a06NF5
         YBq3KW1tquKYGwoaNY/QfBBawFLbQUg+5ckpO5HL7m2gpJ/OKZy5tiBPyLWa+iwU4/Uz
         t2T9JecbqPwLdAekw468cBJBEZMMtnDRM+d14VmSZPyUlxVj91uc80sicwP3xAW+WWRp
         VvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670274; x=1748275074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNI7NcwENluO3zokSTsjvdClRmMPUb+KHUbQq6ykMN4=;
        b=bHpMA3eajyDftWBCnPqkHo7iqt8pSe72yFDm9D45K5HwSxCAaHfB9l5V1CSwzV3s4D
         TPV7Vj8nFqynrCrma95HK3kJwfVpyKTlqb1SkIyU268uXMSn+TlWI+JNArVdFBQd/I4M
         1qZXhZeXNSKa9DkXASUfa55gDH8vL/5CT5Nj/jDzbzjn6fyHBP9BIP8yiBGZkAT0K8rm
         IL5TA7usAJNwfTgCWJbgRAwyHUr484Kc0UUFCC4Juj3v7nbMWDqRR1l20xmNiMVY2lUP
         H9PuvSYZsSsq49XjYLMErvvMiKGfwBOGrPNmBdOd6LiqnAOMJ8EI51jtT3rsYbu7BLrk
         wuKg==
X-Forwarded-Encrypted: i=1; AJvYcCXV5Mt2zIylA2sWwKQ9plbYXgGA663s250RZAmTbgbILI4uK2ImgX1njw5ysMCirDDUbUrBaFqxPb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKM8wp/TAX/iy8inrSrc7KKEyxJyMszI2IptABFV0DilsX8gA
	hFh8RmAecTyVBKTHrwk1Py7QzoxRNeq4Aez3GVsbldnMSX+bDxlinZRe4pqg+wEpZpo=
X-Gm-Gg: ASbGncvuCglX+iSHuzZ4NZdkzYOSLNEvMytYYs4Zh4BWKlHPelqHRBAlGU9KOkxzhZt
	YMz9K8G9UlOdG1rNm+SK4A1pUL1C8VRh+QpfCwCJKjMZ9xsZzXN3p2QIuaLiWJ1KUES9ATM+gdQ
	YKO7p6JKMCbDWuTTRfmmfJ/NqohCIJHBYkWNvS8ebcSk+QZKcrGd8hJ1iGFtiOgOPmzPrcnxm29
	AMCIkWQwSlVtZHbiPYt9+neMYferJSVE3SXQDu4WbIMBOnLjP+gwwcezAbtEVAo+F35Kr+PxhbP
	6Z8CFs3XcEv7ts+FeU25ANILLIyOWgPYnIGPOvfcIPNcknaEE21obuD3T/diUw6l4M+aq3cYERt
	D9am/f2eRAFyeKIerbV7zmXl+RQ==
X-Google-Smtp-Source: AGHT+IH8T8zg0xomQN28G1hezc6Z1gZDVp2eCOEmtHqiL0f9gIeNGI+bpJuOCxDdS9NlFECubITNsg==
X-Received: by 2002:a05:6830:61c4:b0:72b:a020:a2c0 with SMTP id 46e09a7af769-734f99582ddmr8068793a34.17.1747670274203;
        Mon, 19 May 2025 08:57:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b5f5e7sm1463565a34.65.2025.05.19.08.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:57:53 -0700 (PDT)
Message-ID: <adc2d646-06fd-4a9a-bebe-99d2a6cfd2d5@baylibre.com>
Date: Mon, 19 May 2025 10:57:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] clk: clk-axi-clkgen: improvements and some fixes
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/25 10:41 AM, Nuno Sá via B4 Relay wrote:
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
> 
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


