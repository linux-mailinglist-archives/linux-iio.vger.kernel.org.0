Return-Path: <linux-iio+bounces-12926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F69DFA9A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 07:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCDA2818E6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE41D63FB;
	Mon,  2 Dec 2024 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV7VdaRU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52B17E;
	Mon,  2 Dec 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733119598; cv=none; b=tFJtBT61piDMeLL23NdNYNa/TkuWt7EDNbJXv3E4Dloi2ze04P9lRcgCGtJ+kPvG5fu4+QHBO0vg8jDYsBcRyYTWxxVCl+y7gPypwKyPCxAvfJJpKXaPJRxKItoPhQxNMwgKBcMkMrLVy8Ksjl9ktH72xRYfgKgKGe4kGoWaxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733119598; c=relaxed/simple;
	bh=VcOStvxHj8Z+scSApM0IUCw33Ucgul5bnv0mWS086PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scxWOWJXjroWRr4/euVTtMbLNySof358TZ9pTwy9zhIp8SC7mnCnWsAjNqM1pRueFBcMSbi1oEWH8VcWg74clODZ3QnK4UQNB9Lx6yma+63kaU/eXh8u7FnocsM8FwfQVDNMZ91OFz0Z/VoMaEGFCTD+wi6tdWxHTYdwNndDZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV7VdaRU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so38025051fa.2;
        Sun, 01 Dec 2024 22:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733119594; x=1733724394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Py1+g6xpJxZI8cr6wr8SsaAw1VlWsqIN/NQfOIFnPCo=;
        b=GV7VdaRULvZU9jFvSsPGe9g0huYtk5NCzW2EGXCxqxpGb0LBTs88DooX7qDY5isVpX
         fvpz/eqHtn1d8XmTHIw5K1rtazig1QdsO3u1bKPqmJt718qeOrXMME4LZV6Kmxm+GqZe
         BF03xSRAVmM4+ZdVTWaBWs7h3j1233BOjgfFf9JunEtz6izRp7evTaXmQdgw5FynuoSh
         W2GY/NV3anCmJ4d1H7FARl29wXEQbPAjlYkJ9xUKwBD1V+SC7meyF9wQBfWkEpozZkE6
         7Wme4K6Jtq75uQFy0SHCLi1KiJK9foSAAxYVhNiIVNVMkHW2LLJf403f6CGNvxvWDkkf
         3GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733119594; x=1733724394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Py1+g6xpJxZI8cr6wr8SsaAw1VlWsqIN/NQfOIFnPCo=;
        b=Djss4jC7RoSvOfM8+xAnSPLpMaqBmu6u6fHNUNkjFZOhBjv6nYVTydXiKNG40yvtQF
         uRZIRaobgRYYaILeivqSKJU9VLOvzpUWjH9F95cGkyj+Oqu7OjhIEB+t5dhEZo63K4cb
         1+eZpaHFUgKFX9F7cu49sXtAdJJIDtmk5q5EJrraAhQzun388wSA+uvedMrW8czXQnZK
         F3W2JQzxejfO9/RlP48FG9MmFDTjsRe6kVyK4GNaJ1yNKBUbwwLW1kEfwV0xzGwO1cj6
         wBmJiYFDM7ZOYCAK1YzkKuh+7KJ9dQrcUTwZK1VPFVZbMWiMWl3W+ZQOvNGSjr+SpqvT
         KWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmRplmP/lDNH7zZH63fnAMemFVUApMytqR4PCnPA7iM3c/fBuyua1mqqj6EtQioWxOylD54wZVjEs=@vger.kernel.org, AJvYcCXtpyIJxKqzJDpGDaue5uXxTJpAWnQz8ksPg75pbR/4lkD6BMu8X2DDYKfOX/5aGvOw5XNyEXQYqHQIJXwf@vger.kernel.org
X-Gm-Message-State: AOJu0YxUbkJVQt11e2jIiudS+skNBZVxR7FXJe/2apyeWBEy/n1GRB+u
	XGLEBM1AiJwKmAx9+eDq+HXipjsaCIR+rmeIsn32ktojNMZB/oq7Y18JIQ==
X-Gm-Gg: ASbGncsUZGFO0oNOoXFDf+KoBo3qoEF/H75gKITSdxMK0XX1efHUCm0x0TOqwZmfUGm
	uqM7SoxoDL/Brgqvdrp1/Kul+VtoUdd26fjUMlk+7EioSqJq3KY/zbH/aNgTB4qbkZdxEAuk9Ic
	LaYnKNaCuUawiXlz6czN/YTvpUKXE+xzKh45ut6I1eV6dgS/nbmiY1ZncwPw/jFRqk2Uczgx5FY
	fYSNs6ulCvk/IumGAUb4zVSJO4tXxY6vPO2mNJjNdQqspkikSdURdEi4P9Zr3e5JMD+da6aNuI8
	X0zroeA7Tzv4AcNskCr2yc5fpw7duIA=
X-Google-Smtp-Source: AGHT+IGo7ujBlAV0LYkJRc/7SS4Dttf3fy47ADg2rHlcf8yZ7+TUfQiiKt3dExCzE8UgY5LgsmFxxQ==
X-Received: by 2002:a05:6512:3b90:b0:53d:d242:6bb0 with SMTP id 2adb3069b0e04-53df0112153mr7127049e87.49.1733119593953;
        Sun, 01 Dec 2024 22:06:33 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f10esm1324677e87.227.2024.12.01.22.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 22:06:33 -0800 (PST)
Message-ID: <4a06a31f-1b3e-4ce3-a801-138d2d21bacd@gmail.com>
Date: Mon, 2 Dec 2024 08:06:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: gts: simplify scale table build
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1732811829.git.mazziesaccount@gmail.com>
 <4b05448b65969f9f433f7ac3aa234c33025ad262.1732811829.git.mazziesaccount@gmail.com>
 <20241130180117.088352ce@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241130180117.088352ce@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2024 20:01, Jonathan Cameron wrote:
> On Thu, 28 Nov 2024 18:51:00 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The GTS helpers offer two different set of "available scales" -tables.
>> Drivers can choose to advertice the scales which are available on a
>> currently selected integration time (by just changing the hwgain).
>> Another option is to list all scales which can be supported using any of
>> the integration times. This is useful for drivers which allow scale
>> setting to also change the integration time to meet the scale user
>> prefers.
>>
>> The helper function which build these tables for the GTS did firstbuild
> The helper function which builds these tables for the GTS first builds the "time specific" ..
> 
>> the "time specific" scale arrays for all the times. This is done by
>> calculating the scales based on the integration time specific "total
>> gain" arrays (gain contributed by both the integration time and hw-gain).
>>
>> After this the helper code calculates an array for all available scales.
>> This is done combining all the time specific total-gains into one sorted
>> array, removing dublicate gains and finally converting the gains to
>> scales as above.
>>
>> This can be somewhat simplified by changing the logic for calculating
>> the 'all available scales' -array to directly use the time specific
>> scale arrays instead of time specific total-gain arrays. Code can
>> directly just add all the already computed time specific scales to one
>> big 'all scales'-array, keep it sorted and remove duplicates.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> Minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>
>> This has been tested by IIO-gts kunit tests only. All testing is
>> appreciated.
>>
>> Comparing the scales is not as pretty as comparing the gains was, as
>> scales are in two ints where the gains were in one. This makes the code
>> slightly more hairy. I however believe that the logic is now more
>> obvious. This might be more important for one reading this later...
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 109 ++++++++++----------------
>>   1 file changed, 42 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 7f900f578f1d..31101848b194 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -191,86 +191,61 @@ static int fill_and_sort_scaletables(struct iio_gts *gts, int **gains, int **sca
>>   	return 0;
>>   }
>>   
>> -static int combine_gain_tables(struct iio_gts *gts, int **gains,
>> -			       int *all_gains, size_t gain_bytes)
>> +static int scale_eq(int *sc1, int *sc2)
>>   {
>> -	int i, new_idx, time_idx;
>> +	return *sc1 == *sc2 && *(sc1 + 1) == *(sc2 + 1);
> 	return sc1[0] == sc2[0] && sc1[1] == sc2[1];
> 
> Would be easier to read in my opinion.

I agree. (As with the other (ptr + 1) cases you commented)

>> +}
>>   
>> -	/*
>> -	 * We assume all the gains for same integration time were unique.
>> -	 * It is likely the first time table had greatest time multiplier as
>> -	 * the times are in the order of preference and greater times are
>> -	 * usually preferred. Hence we start from the last table which is likely
>> -	 * to have the smallest total gains.
>> -	 */
>> -	time_idx = gts->num_itime - 1;
>> -	memcpy(all_gains, gains[time_idx], gain_bytes);
>> -	new_idx = gts->num_hwgain;
>> +static int scale_smaller(int *sc1, int *sc2)
>> +{
>> +	if (*sc1 != *sc2)
>> +		return *sc1 < *sc2;
>> +
>> +	/* If integer parts are equal, fixp parts */
>> +	return *(sc1 + 1) < *(sc2 + 1);
>> +}
>> +
>> +static int do_combined_scaletable(struct iio_gts *gts, int **scales, size_t scale_bytes)
>> +{
>> +	int t_idx, i, new_idx;
>> +	int *all_scales = kcalloc(gts->num_itime, scale_bytes, GFP_KERNEL);
>>   
>> -	while (time_idx-- > 0) {
>> -		for (i = 0; i < gts->num_hwgain; i++) {
>> -			int candidate = gains[time_idx][i];
>> +	if (!all_scales)
>> +		return -ENOMEM;
>> +
>> +	t_idx = gts->num_itime - 1;
>> +	memcpy(all_scales, scales[t_idx], scale_bytes);
>> +	new_idx = gts->num_hwgain * 2;
>> +
>> +	while (t_idx-- > 0) {
> maybe a reverse for loop is clearer
> 
> 	for (tidx = t_idx; tidx; tidx--)
> For me a for loop indicates bounds are known and we change the index
> one per loop.

I could've said that :)

> While loop indicates either unknown bounds, or that we are
> modifying the index other than than in the loop controls.

I'm not entirely sure why I've used while here, could be a result of 
some review discussion.

I'll fix these for the next version.

Yours,
	-- Matti

