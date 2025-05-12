Return-Path: <linux-iio+bounces-19474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFDDAB3BE4
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FC77AC245
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F38523C504;
	Mon, 12 May 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mbVsRsCz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27012239E81
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063346; cv=none; b=sXTE7gTgIHVjtjPsmZYeAjsIqAvXDG8Lcuf1yitusXQ0Tfxor1KZ0OL9H679TrkmRutlLVbqyfcwPtLhuRWslAXwFE31b+D2GmDQZpaW+xK5I42hsqMdOXAJEmyFbw2alGxB6mF3BNPvv0PpzzGkBCQcZ6QzKaAmrkxyParh0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063346; c=relaxed/simple;
	bh=Q44I9l9A6bvt+4X1Jm8yKDlsTfz7OTm9T4HQgSxLV9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6MvQO/l76yA601bHfX/d91IrjZxusJiwZIBRWD0chL08E/cWWgxLKKl7cd88DTdGvpT+loutwZIsZi4XBVZBPFynaxlkLxxggjmSOEpKaRvB359AmX+h/W7I6cpmwv3N7AP7ASN8yKwVA6g0lDk0CahWIvIR1CBxijl6QPt3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mbVsRsCz; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-731e277a6b0so4327014a34.1
        for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747063343; x=1747668143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehw97cZ7zSM30yNLRgq/QkB3dg1EfknESH7kBGZVvBE=;
        b=mbVsRsCzWPlROmO/4sbHdF+vsB/XjMas/p6KKCm61e2jARKKO21QzJNUOHNAE90eik
         cCUoHIuC68AuPvQCfisee/2dQPSwuvLuYeZyxyvzFSiUU13na2aUvSbhpTcgLGE67yvu
         hzYeel2U5bdLbqAdpdHInuzxUUXA805ybrC4sZjgchOY7joGVEsxUGuLeXV8/VUK9+Jr
         n5DTrrNw75QgBuMdrSMoMXYb0HMWVIrIOMrsRtqYEWDkuoeY6olKjcRgIt7HyUQTAyRG
         GIdxbxfD8Xlql016VfKTPzCG+avLge9HR8Tt/OHLsIFlJY7/lqUkNR7Yd+2SGeBZxqk7
         HGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747063343; x=1747668143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehw97cZ7zSM30yNLRgq/QkB3dg1EfknESH7kBGZVvBE=;
        b=XeR0FAv/VeZvDsf+MnDWLU2vS8/KoLWs9YIgqcJOHQUKt/HAFGaKSDreQyMePyAObZ
         d3hG6JaVRfvtFLearaemLG7LV1YuBIzc/olUaxakjqdjwSanrQ4Rnk3HOxh7EDxM6AlR
         gyAVgNpC70bP24U3OWV9G3KmUjI5ap3wUb9ZCHbtmGZyOVr+WTb0bKae04LBqnv8Qv27
         xUlMsoOlpYsj+W+y9lyhZQln+PkAf3cS81i9FRUFO1nSgBj5BYDdKm8XMid+jeMRBwZy
         5I+bSkYeXpHJ5JFuHk1/lypHlMJZIS4twb2QXoZ73N2PyyQu8JF4Qp3cpk4nJp9b10l4
         dbIA==
X-Forwarded-Encrypted: i=1; AJvYcCUkGweQ4Uwi5sdagph/AGL04MQBqxZqYJZ1RoXxyoZc+c3rzRimDig/0nL39FWOz5ppxVfwgcoK9ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wDBigw2lgiRA6E2ypuzSHvOMTWnaENrUNwu1AjVMEGV9staP
	q1AlPxRefFGeLtm9cz/tabiAcGuPpB0R6GaRwa9L5q8ejNxgJjbkkCEeKqK4UVE=
X-Gm-Gg: ASbGncsHWRwHbmczgJ0i1+tPabLrfr1lqPrI9gM/ha8vnBa8uYq2uWF9TTZd2r2Q506
	eab6NZGj4X03+F/3X8IRMMuIyXPxaLIh3cLL66DQxg9IpBJHdqZsfLPkMACHbvvBxFvZB8aaux8
	PfNMmkQAie/GBmBHSINkrv+OJU+Jv2xlfZ6Erx4IB46Lv+XL8ghj4db/NP0oeCAoq+rmEHhg9KR
	aEOkz6rNk+Ya9Jn1zFwQN5NztoU6l9mkDCjhaGzP6/3jpeB5q1WQeEk7s9Y/Kz0bSq/En7vqIZg
	+wFOI3BiwR0784pNyxIaYW5UXytCrLPIBz94bKgFyJMM5jgQtksphfClZZ4cHwe1koocgMBJdFH
	B/xu4dR5PlezNohWVC7CXOo9XlcDUEW9FI82Ibzs=
X-Google-Smtp-Source: AGHT+IFg8Sgjr8yxeNG/IhUScUIAVa1OFc7m7FxlwqSYuIM0xhwp6QZ1req1LRFjA6ZAnmsIbAxIvg==
X-Received: by 2002:a05:6830:648b:b0:72a:47ec:12da with SMTP id 46e09a7af769-732269d6a12mr9682527a34.10.1747063343145;
        Mon, 12 May 2025 08:22:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d78fbsm1584954a34.32.2025.05.12.08.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:22:22 -0700 (PDT)
Message-ID: <a810d8ff-535c-4d6c-bec3-8a275bcbe483@baylibre.com>
Date: Mon, 12 May 2025 10:22:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] clk: clk-axi-clkgen: improvements and some fixes
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
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
> 
> ---
How we added the linux/adi-axi-common.h include to the clk-axi-clkgen
driver could have been tidier, but not strictly worth a v6 just for that.

Reviewed-by: David Lechner <dlechner@baylibre.com>

