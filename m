Return-Path: <linux-iio+bounces-6278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C19092DB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14553285387
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7B19ADAE;
	Fri, 14 Jun 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="umXUtDXO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B317C72
	for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392697; cv=none; b=ZJrXpF2j33S6BP07RIj+2OJwhHiMoW6ElF8kTE0fFVYt7MgWR3F+umgAD8uV4pYTXfGBvv7r34eallu5lil5TmKxKVKi9hLJ9FoNA9bQWA6blyEs4TasIKPK8XQRFTBeYTdHPTrqniLOIea7DOLbYeRa+2cVKuLoA7Ld3KY5MKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392697; c=relaxed/simple;
	bh=tdDbH+Puela8GcjBir2w1hVjGJFIMP0Q6vxjuEJvfxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXD3xMm+me9cvxV+PS5G8imaQ2/P3Bn3AVSDSuGoZD4UZi9qVkDDof0Z14GmzBXNZfRE6Cb0fHMcSNyrA4k8nxQRLsJui5c0GT80FdvkHxtZWRU91WHmiAwhn5u5NR/F6E/AB7GosBnnsZ85tOKD3FpXN01vMnMoIx98I7L7+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=umXUtDXO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b065d12dc6so12709206d6.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718392694; x=1718997494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdDbH+Puela8GcjBir2w1hVjGJFIMP0Q6vxjuEJvfxg=;
        b=umXUtDXO5jaQiYz0hqlc8uTaKPSuOlg7SAYBLD/hT0eTvgJ15zxnGr+z+Y/db3Kcs5
         2nIdu2Xr+jj1BUrxmZPDSOxvDd73TEh9goUDQ4OO+jFo9JPCLOZVmrr4ar68vKMGcuPG
         Z7g4l3FrCHCi+g0kv8lAYGu/v3hSG/IXz3xTBRG1mAR2LDMeB4B+esdqXGSzYnKwYL6f
         mv2n/1I47efR8iPb7tW0oRCZ3/WueZTrHj41dsHrbYfwByCUXzUTrvpqr5D7KL1OiH+9
         sidHAUGgznKTzlp4VMs3QkvRHQsu17b98bXKc+wwsT+iD+XSWUJYVZwavA5EgZX24ouw
         w8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392694; x=1718997494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdDbH+Puela8GcjBir2w1hVjGJFIMP0Q6vxjuEJvfxg=;
        b=mJJ6wt87imVlUAwxWQAHLqIyFCkTkf4yPRrg8XAr53R4mV1RHp7mvrA+6h4rzDhrrG
         oS2pEYuMS4XgmxpWbo7SJ0y4b6R8m0SWmQUxuNz2WQigkp8GQe4JQvBpRj4rHEqo9t6C
         zJJ3QU6PSpBJZi96ndyYEW35Ss+6nlmT+TLjyUVNonFm/iF16tov4Vi0o8SfcGMUc2wB
         tA/xL7ZmF5J1bwMNoUtKJfsIPdKY8UT5ObuStRv/HBfWhlEVC45aqIj5hSwAeIiqifcG
         ucMr3Rs67eUmU9CQRfT4nclTf4iRNR9DhXzgaPaI1xva6ZDPhFamDkdY37xWpvYtfyl4
         e/Rg==
X-Gm-Message-State: AOJu0Yx+Zkdl2XqbLl6mNzot2qvskIYn3tFwyaImDtDZusY/tY18WO3E
	KDachjN50ir8lRA4kAoUy88X+eArSV0Xp+HAmOR9fvtCMh+pcoYxcNhIjQmcwSg=
X-Google-Smtp-Source: AGHT+IESVCS+ALD38NVdIUc0A9n3fVnIRuJrt6B5Nfu3A/Str0yGuf4a0V+N4cgl4VIb5bHvl5yXhw==
X-Received: by 2002:a0c:9cce:0:b0:6b2:b2c4:90f5 with SMTP id 6a1803df08f44-6b2b2c49289mr29705686d6.4.1718392694328;
        Fri, 14 Jun 2024 12:18:14 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4a23sm21545956d6.75.2024.06.14.12.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 12:18:14 -0700 (PDT)
Message-ID: <964821b3-dcbb-42b8-9062-2366a4d30a76@baylibre.com>
Date: Fri, 14 Jun 2024 15:18:12 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: adi-axi-adc: improve probe() error messaging
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613163407.2147884-1-tgamblin@baylibre.com>
 <57d4659a5abb63d7c085865059b9d71c40371edd.camel@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <57d4659a5abb63d7c085865059b9d71c40371edd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-06-14 5:11 a.m., Nuno Sá wrote:
> On Thu, 2024-06-13 at 12:34 -0400, Trevor Gamblin wrote:
>> The current error handling for calls such as devm_clk_get_enabled() in
>> the adi-axi-adc probe() function means that, if a property such as
>> 'clocks' (for example) is not present in the devicetree when booting a
>> kernel with the driver enabled, the resulting error message will be
>> vague, e.g.:
>>
>>> adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2
>> Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
>> devm_iio_backend_register() checks to use dev_err_probe() with some
>> context for easier debugging.
>>
>> After the fix:
>>
>>> adi_axi_adc 44a00000.backend: error -ENOENT: failed to get clock
>>> adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
> Somehow feel that in these cases the error log should come from the functions we're
> calling but bah... likely not going happen/change:
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
> (As a suggestion, you may do similar work in the axi-dac driver)

Thanks. I'll send that early next week after a quick test on a board.

Trevor

>
> - Nuno Sá
>
>

