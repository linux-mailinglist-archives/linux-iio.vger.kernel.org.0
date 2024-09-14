Return-Path: <linux-iio+bounces-9535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940F978F71
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236F31F23C7E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3831CE6F6;
	Sat, 14 Sep 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bMFxqsqy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFE145B3E
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305702; cv=none; b=YmRikG/1ZFjRqYnR3EV8YcVlW2+Xt5mnMRsoyJG9x0vVkrQv9NMRkX9+iJ3/tE6wvmuLW/r83uI3794EEUvE8hE9+8EKw1xjlnzbYywGD/6V70l74rG2/nxgx4OFBvoopcYJpEhkaK6gUxJmH32GJ56ye1U26j6nKTHeAL9ZYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305702; c=relaxed/simple;
	bh=QWLN81duHcC98U8Wgfo/hW2STVBwULFC4YNBCXuyjVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp7Zr5yCfiu45tELXrAjsYG4kvSrBBBTaPZlChvqR008m4hkId1xGrDhYUfuG3ur37Iw+0+h33SK+y1HHCxBq8rdtn1Dt1EEQ7m0bYjwygJ/K9nGvgSdHldyBuUGqPYUW6ZkGZCB5GZ2wfRYLbT5FyiRDgNAghitrdqsTS9nwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bMFxqsqy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-375e5c12042so1605255f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726305698; x=1726910498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0vwYUdOyrcmqsU8fkyOeRsFNoi3+GuwHokLYeTePag=;
        b=bMFxqsqyWEjPrbHHUC9TCakNJgnrB5KppFykmlFKAaHSV8UbbR30zYdJlZf/LMGJVV
         GNIO14YfippErn0PqCSVgGgsyxzCnuooFOpQ2FmDCKljxjL4fJNJjd62AhYOlLs2i4NJ
         U/vz2577IwD1NG0cRrOgkMTDWPB0WcD0037Ml2qqU2I5KWDZsD74OJ2FiK4dVfAIemiY
         XgcWdBrVtUsFd3ewqMC5vKwZK0RKEQQ7FH6zsEfKIYYbrC/F8PkCGv06c2REWPNN3ICl
         6qNxDzvsk5r6jqEokatD20dmfFyi4RYtsIcLNvaiHCsqxywpRz5wWm+E29A+XDkPQYvM
         IseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726305698; x=1726910498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0vwYUdOyrcmqsU8fkyOeRsFNoi3+GuwHokLYeTePag=;
        b=xIsNbu/Nmc1bg/npCBvxilN2sipCAEkafEdfoxlYsVGAEVvI7ztEcgAyPWYbWbAMux
         qLyqf+5WvJaL05P7nT4OD9T291GapkDdQk34UKsv3ON2C+jcIkTmO2BTsWtOVqgGusV6
         0hjRJcbJldYj+J2iQ9we2uZwdCgVGnzLnm7nkWvNqkOoym/0NgZE3+z4IqOZlKoT2f3Y
         X2xI/ZXIvwq7cCxMxsibJ9qfteEu887zyM81sSnIFuV90ozuhC5wGL/RGzI72MxxZThZ
         FJRz1W5RZ58D/swfFQhFKJAbQlj31euCfnNQr+TnY2xXhnc77vX/lw3ik0O0qPVmB5vk
         3I0A==
X-Forwarded-Encrypted: i=1; AJvYcCWIeyTD4bgtmEYu+DBzBeObXkgPoNFPYBH+q4ZdwEx0h88N/3WWmAz7JpWrmrKe17acttEjV7quXps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpGK0uW0eWURToSfdA4goBdjCkangd4/Kp8FuKnyqkiDY+2hJ
	ec49BJDvGWDjzehudP/BTSom2n1bBUmVp/Scxo2V6Q50LRZtz6xRlu+tSuuoewQ=
X-Google-Smtp-Source: AGHT+IH45xR6Gog1ZY7V2YLrPhCGhfQF/3R1gLbHp9LuneqGr615sJyZ4/UcDCFDXXJAze+fTRg3rg==
X-Received: by 2002:a5d:4f12:0:b0:374:ccb0:66c7 with SMTP id ffacd0b85a97d-378c2d0623bmr5708624f8f.16.1726305696892;
        Sat, 14 Sep 2024 02:21:36 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:24:e9b5:6dd7:b979:f3bd:3baf? ([2a04:cec2:24:e9b5:6dd7:b979:f3bd:3baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e837csm1242741f8f.27.2024.09.14.02.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 02:21:36 -0700 (PDT)
Message-ID: <e6d3926a-002d-445a-8ac5-8d47b2be27b0@baylibre.com>
Date: Sat, 14 Sep 2024 11:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: adc: ad7606: Switch to xxx_get_device_match_data
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, aardelean@baylibre.com
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
 <20240815-ad7606_add_iio_backend_support-v1-7-cea3e11b1aa4@baylibre.com>
 <20240817163354.68ec95f4@jic23-huawei>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240817163354.68ec95f4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/17/24 17:33, Jonathan Cameron wrote:
> On Thu, 15 Aug 2024 12:12:01 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>
>> On the parallel version, the current implementation is only compatible
>> with id tables and won't work with fx_nodes. So in this commit, the goal
>> is to switch to use get_device_match_data, in order to simplify the
>> logic of retrieving chip data.
>>
>> Also, chip info is moved in the .h file so to be accessible to all the
>> driver files that can set a pointer to the corresponding chip as the
>> driver data.
> This means each driver gets their own copy.
>
> Better to use an extern in the header and keep the actual data
> in the core module.

ack.

Given your previous comment about introducing 
platform_device_get_match_data, I guess I should instead do it directly 
in the driver's probe, like its done in axp20x_adc.c ? Somehting like that:

if (!dev_fwnode(&pdev->dev)) {
     const struct platform_device_id *id;

     id = platform_get_device_id(pdev);
     chip_info = (const struct ad7606_chip_info *)id->driver_data;
} else {
     struct device *dev = &pdev->dev;
     chip_info = device_get_match_data(dev);
}


