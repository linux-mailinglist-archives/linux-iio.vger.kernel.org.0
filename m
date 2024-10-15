Return-Path: <linux-iio+bounces-10638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB099F005
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9023E284E7C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791851C4A1D;
	Tue, 15 Oct 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2ssUReZW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633A1AF0C3
	for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003704; cv=none; b=pcCHV9YgpO+zQDB0WmAs3P3HF5K1dcqSkmDSNrZ/INo1mO2fsvaJIoy1JXaGXBV3o3L7YBX+kw9wdkdzX5vVbzI/824cdxeX5fTCndrROMh2Kgiw9O+obqhIfPTmnhZUiV/jIm8tTj3MjO2JLgBkNHCSahaDf1EkqJWIC8FvEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003704; c=relaxed/simple;
	bh=1ZKbFqq5xIztMsJdbLYu9Ok3agkULQ0nUqv7argX3yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdYRA3xB5Lc1YANDojgNWXs33qxuWemvzyt4AUj8aVdJEtSynYhutMxZ4V/dhB7wbF2kb1vOvQkJ6/5g60pYh3w1LMAm90wOSDUBQQs+DAPqP3OoIqkbIdgvJN/x/TqSiAxQgUXs+36Bi0cRvdBH702pmWcgq2Fmwtd96iY7BSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2ssUReZW; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7154e7b915bso3467737a34.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729003701; x=1729608501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUVW0w4TahcLd/Tf8bTFKOH/+gu9J1Ctw2P3JJAhxMU=;
        b=2ssUReZWojhEj+Ek7OgVqglakTyup8dshveg5Ky1T4DQZZSFTRv+ojSxlj4dYuiRHw
         9sh9TN2im4S35nrIbr0ByQF0O8Y46iwo0CG+AjlLinz8XpovI8DO7H5aFLMUzWi7S3zp
         Y+t9jyJRkKvKRVdq9mwkRtRisTPt71Xr37gIBQJNVd0YYp1rRaqyFllKOCQvOwCRYD8C
         OJTu0VE+f70KcoO9NmDphtgzttZCk/uQZcQFqOoC/SK47IMROyDmh6AutHMRoZf/4E7O
         vgf9kY35EiCposQ/1Qypuf7i7x0zPwMQUphIFT2POWvgsFdbuUfjbMo3Ogq/KRFEjvLw
         HMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003701; x=1729608501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUVW0w4TahcLd/Tf8bTFKOH/+gu9J1Ctw2P3JJAhxMU=;
        b=jaQ5OO7FJv2NlBI8eDTa/BEgeVHr9bDkMXs1Lq4INmz9aWHYj6lRp/Vp1ZVzN7QKlZ
         c2sLTWkIBT4oiemE4vW/cHzHus/EG73GZnYX+hA4oHaBsulIC1GHRy6T7/9VkBOuUMd+
         kyJtLmZJdsH0NnJAHkqruNtdSzR3/NWjSdaosFast2UYsb5iJy4F8/ZaNDuhjLyUWgWv
         f6IW0efVBe9v0nJptRR7MT0tpYMrI7cYpPFS96zIHH4klLgCyaAAbYBR3bEMsh9FX0PG
         GrzZz30aupyYaAsKI7rRnH/b5MSCHTpV92y1kcRDke12HBxlqhJnK9AHPudkiE8zrHJO
         iWzQ==
X-Gm-Message-State: AOJu0YyMw4Oizl6VkPrgJPCjzqoPk67x68A92VumZG71HAkvpu1oNT3E
	DjrMoCgvEntZW2lveav39TxvF7sZJQeGF7QwJFoOI7I+iXIlMDzG3uZ+1EI/n7s=
X-Google-Smtp-Source: AGHT+IHF1LHG4GcRViICSmBgqiP8SHfhXVmF8tDnJrqAqe6yocnsYDdQLqSDrYOeyZh9hqhH5NspiQ==
X-Received: by 2002:a05:6830:3482:b0:710:f3cb:5b85 with SMTP id 46e09a7af769-7180342d344mr774702a34.6.1729003701442;
        Tue, 15 Oct 2024 07:48:21 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eb4ee121bfsm266967eaf.28.2024.10.15.07.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:48:20 -0700 (PDT)
Message-ID: <f1f7f187-f1d4-4d81-9187-ac238c0ca964@baylibre.com>
Date: Tue, 15 Oct 2024 09:48:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
 <549566b00524c0230a6a970b74a38dbe58e2589d.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <549566b00524c0230a6a970b74a38dbe58e2589d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/24 2:15 AM, Nuno Sá wrote:
> On Mon, 2024-10-14 at 12:08 +0200, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>

...

>> +	} else {
>> +		err = ad3552r_qspi_update_reg_bits(st,
>> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
>> +					AD3552R_MASK_SOFTWARE_RESET,
>> +					AD3552R_MASK_SOFTWARE_RESET, 1);
>> +		if (err)
>> +			return err;
>> +	}
>> +	msleep(100);
> 
> nit: fsleep()
> 

fsleep() is microseconds, but we really do want milliseconds here.
Datasheet t_18 is 100 ms. (Internally, fsleep() calls msleep()
for anything over 20 ms anyway so makes more sense to just call
msleep() directly and avoid 3 extra 0s.)


