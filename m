Return-Path: <linux-iio+bounces-16823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5940A60C36
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26550460C8B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C41D5149;
	Fri, 14 Mar 2025 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2DvmWPC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445DCA4E;
	Fri, 14 Mar 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942363; cv=none; b=t2ix0uUGjkWgDe2tJ4/5950qAd22KBOMZ6cthNq6PaMkGNFWSuUPuIZL2Ru9O7GLsDOTy9+Jdyjkpwxt16ht710zc4/SFqY3gN+3dR70xzG4fTG7zpUmPM5U+8gxGqPZ6iNM1r0jOedByU8ClBiEXjPUKbbjBiooQa+xXPk1AAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942363; c=relaxed/simple;
	bh=BoHoSEa4NsvV+dy2oB/wLr382g4IYcDMe9yZEQ2mwzA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lpxsApE/X1KUP6yeccESfzfjQopou/pijbVRwBWMPv+ZBNrLpM7MVobvauA3csTysE5CXXUs/uujGL623kv1l0JpEdhZdIGc/6tuwIb9Wg9DMgT3c29UKzRqeRi4GYPEDIHJjzpgucPVSt6BDG5X/oDZTnWR8xSrDTNFw3kJhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2DvmWPC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54998f865b8so1651541e87.3;
        Fri, 14 Mar 2025 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741942360; x=1742547160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TwkDJjW8tq5GKG2ABeakRbHyDFs82RN+GuIFGclwB0=;
        b=R2DvmWPCYZnGZx/3R52Gmk98l2sAC0hVpJuMEwEwx6vGRC9pX7oeHwmsuPMGsGxd2r
         UM9xI61eZU9BLBLM4WzV+f08IEtPt5gGC6/042k1dYYnARl3iamKHZgFrOzWCPjMgEoJ
         ECsnIXUBgKo2zGTIRnEp/JpGjfRcC0Xn5Lz//MpIxUxRuMT/42RSQPWZUbnTuL52J0jn
         oFKlspbBIR7DWuiH2mJMnZx2obLQqRvai/i4qqt8iHTV/1owJHXzvQvLyHhInPmvf1ra
         M6lim4kP5xBBYJCI4GwF+2tgjntUA6W645YCseXZ8KpXOsJP4+XmBwgVCCzeN7sAwyS4
         HNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942360; x=1742547160;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TwkDJjW8tq5GKG2ABeakRbHyDFs82RN+GuIFGclwB0=;
        b=jDQaS+YKekEiFk6EWomr6XZmy8N46U1n7HIYnhuPtSGeDIR4umXgUlTnRWM/W92PtB
         J45beDRYEK3L5hjYAEZz8l2tSG8FHLxrtgffNH3p5uvZ3L9nV0u3DDauBoDz4tveheLE
         wYe/xpOK+v9wt+VFmsb/RdBLo/ioRVaBbVQ2Lwp1+KXwMg1vAxpQ3KF4XoTqkRBQSXLw
         oflsvb+HJpnYjKDtbaON5DLhAKfFVQ2wMsUJxVvqyNz2SbmxIIadwe7qookX3tqp3GCs
         yc3UJq+5lSdjJrXL6IuHXLdc/gnEjewKnJDkTf33WA5aOCW+gx9xfQ+7lnxqrRXVF0t2
         5Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCUzRjNis58J4+JrCfXXntF0WpQnGD/Mu7LnHAKVMB/TRkvO/atfRWuQtSst4Hornuh/of9bhM1qqAk=@vger.kernel.org, AJvYcCV544IRIbKQluU+NM9zDLHbLTrzsQnl2jfZsBMPidS1O8ZijMB3o9SJtDJfcgca3UH5cR2q23NkBhzecWZE@vger.kernel.org
X-Gm-Message-State: AOJu0YzDByqzz4fJo6lwzZ66gx3pryGYmEye+52zpCN73lXI/IdnI3aK
	Ty5NZOBwYnjIpFF0tb1+26ow+jJk+JoH8kVtrIsvfQ+36EMmnnvH
X-Gm-Gg: ASbGncvU0wLgRLrd63/YF53zYoeWFeS5UclS1qNh+chIq95LkkNeRgjP2QPFwR1MVr/
	46WMSVNgsCPAmbEl2ipgQW6Hx4APiVbtDX8WnBF4NuAoP7DYEGitHYKSHLEuexYDSzrgTd8hxJq
	Unq1LLc2cT5gECP+KO7VnqoBY/V9/zxOLrrBqmTlaoZpaUQyHRyuoXghVft+jTCP+tXrBxhZmVH
	w4SrTntnnyGZJqOcXdsQlcS5m5AAC9vOKT0T3enWxQiiB40q9HmAx2qJLj1qGhpb2iawRVTwUwb
	DJs2wuFT11+yRLvRzmSIF4jbUGq4u/MqwmcIZzKsabj4NNONC3sQoqnJ3QE/dLkNaCbydpiu4Wj
	E+UECM24RPPpNjbv2WlTDzDv+1A==
X-Google-Smtp-Source: AGHT+IFJxG9OcgZxwn1QoOztfmdw2MN3atHuJTqJa5ztoqK8h4tNerCOSGqG3rOb5xNECd1Z3BEUkg==
X-Received: by 2002:a05:6512:3c8a:b0:545:5d:a5ea with SMTP id 2adb3069b0e04-549c38eaca6mr560643e87.3.1741942359678;
        Fri, 14 Mar 2025 01:52:39 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9350sm453323e87.243.2025.03.14.01.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 01:52:37 -0700 (PDT)
Message-ID: <8de67803-e89d-42dc-ab4d-e4549819432c@gmail.com>
Date: Fri, 14 Mar 2025 10:52:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
 <bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/03/2025 09:31, Matti Vaittinen wrote:
> On 13/03/2025 15:19, Andy Shevchenko wrote:
>> On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:

>>> +static int bd79124_chan_init(struct bd79124_data *data, int channel)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = regmap_write(data->map, 
>>> BD79124_GET_HIGH_LIMIT_REG(channel), 4095);
>>
>> BD79124_HIGH_LIMIT_MAX ?
>>
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return regmap_write(data->map, 
>>> BD79124_GET_LOW_LIMIT_REG(channel), 0);
>>
>> BD79124_HIGH_LIMIT_MIN ?
> 
> I think I originally had these defines but I was probably asked to drop 
> the defines and use raw values instead.

Please ignore my reply here! It seems I still have the defines in other 
places of the code so they haven't been dropped after all. I'll replace 
the raw values as you suggested.

Thanks.

Yours,
	-- Matti

