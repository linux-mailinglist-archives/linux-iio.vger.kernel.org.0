Return-Path: <linux-iio+bounces-22989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB7B2C75B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBE01BC61A8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C12D27A91D;
	Tue, 19 Aug 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GDuzY4BJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60B27AC43
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614633; cv=none; b=pT2G1Xk9dEY4w6PLiJmWRS20yJcv3696d/d8we4VlpjEbmFEJYxg3bX3LQ2UqnF8HrqcWtilX/hhPPhHazHJEnhMK/gay3KAuMwXWP09aqS/SnjhQdmzHfKBqDd+Il9g0nnQlwRUmfShzYbIdBkbnEWaHCjOLaR4xb6gp1OuVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614633; c=relaxed/simple;
	bh=3rHhLrHoLFeMwz9Y4IfzVNw2lV4GWZAwvlCt+1eLQBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BMy6GOu5e6S48zdZwpSh26sCfF7r1nr+QsOrZQauiDjKMcc/3hqAZFFSKRS+PaoDxCNzx5TUzPzU2BB96UlOrPHDfrMeR6C8Vf4tJdPf2xeAmAiF7sYVSG1/aSbtr85JEJwCVfrEe3q2bLckvf5cfY2VF/942eTjZcIJOVTBPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GDuzY4BJ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61c13125417so168716eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755614630; x=1756219430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Z5bxvYBSBLdym7Nb1x4kR9TKOagtFVtWVEo84Sb9OE=;
        b=GDuzY4BJD4rFR3bQ5hR41Vz2YErKB8SZVOKGgOigxMgsFoZE7QCzCeHyjFrJw39fEj
         iiSdIoMAqPhs2KmTO84VIqT2twaxAGApwhiuY0pO9IdMqG/AQ1DFsKuYIJAZ7q0WYZf7
         6Hw7SkyGcFB0FP2EX1YESyuKQoI4EUTTs51LOuF1920SovZUphFpL3T+4Dfdz0sRp6Ns
         SMrIrzzeEqWAFpFos8kKzqoxsx3HUlHu+fg7EauATHJG2wmrZMJAK5QDgH+0k+zh6Wr2
         /5y6w35txG002sH1H8U2CcLQy/l6f8LJ9SFJZ995j1MBykZIn1Yoy850LcLZ+ChQl5dr
         9lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614630; x=1756219430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z5bxvYBSBLdym7Nb1x4kR9TKOagtFVtWVEo84Sb9OE=;
        b=U6kvQbmLF9c3ebvi6M0AgqQ0L6tUf78EP47spXenu+wLRhxZVSyrmNiRrBGLfbAAbR
         xMXHVLAJ9g0cqNvjQTTSv3rV40UwK1TtRdPTAwpCWZm0BUllsbVxMZtZP44hpHdeHPn9
         jJuXA7oClnKP7JC/8RjS3yn5yi8Tfx9rkPIqJHvKcFg8P6py4YLWd0eRckm63rZq9DeH
         nMj9g/MF/pdL7dkql740oPpHoKXM9VeHzYwz6LALWSJiOCD+uaYXSFd1+QTVE9YK03CE
         ieT5PDlXjtntF51QAolrkaZ5md3u//RdMMY9sW6NwgZF80n2BqZphaRWptKBi9G7MoD1
         r56A==
X-Forwarded-Encrypted: i=1; AJvYcCWGcLuKA4JpEP6DuG6Xt0itNMqCMEK37/IfnxyNlDGa1+HhLKCs6bCnJPFF2X3CrH3weWnTORDtEgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkrlE6G7nRsxNyTsg3SPg+fNq7FIZSWTT+9/0TH57itQ/jF2x
	o9vYrNeJhDKQ8SGT9lTdEswx3db9KBGvmKhJbKICESdmvFXFQGWWIZUzf3KJz04agSs=
X-Gm-Gg: ASbGncvYVg5cZkFGTFt1g+Zj0eBKmKQqHnCvXjCD5Fn3zxJo8+X5Yya7LvA7pK6qalR
	y772PsFsNcdlZwZ1bonn9ZkefGLPOlwJq49BZtD705a0vXMCfD0+LrmowW57fOzj05JlvEaw3kb
	5ig6/8oiijrNew1d3GEPzim8iZLgVt7Jo7W1GI/t28+Mr3J6ldRg4qMaTOdMV6yMZDEAbJo6ht+
	jHNFl/UMYVmWzMopWpzH8zZial6epLw7nWqGhGUat4iwpGwy9ywI0lVh/f65lzVZDSPGKlx/Fxn
	CM3A2ZV1kJf/G8GoJKRE2UqQcnj8jZYTSxrxLzMA7VBffyiEyfCr+zI3bjKYDU5A5x4w/phn5Ct
	zwHHG4iKFR/Pl0vPmA7JgXXixrbwbTUY5al6PHLzXvlpfwohSwch1EW95ORJ8iFn66prM72FG2A
	0=
X-Google-Smtp-Source: AGHT+IFkLLPLg9PAHBHu7Rh5I0VIsdYwpUy55zZnMg13X7zvG1V5lI69odJR7k84aEPt3VDT/VtFzA==
X-Received: by 2002:a05:6820:1611:b0:61b:924a:b798 with SMTP id 006d021491bc7-61d919da03dmr1721044eaf.1.1755614630002;
        Tue, 19 Aug 2025 07:43:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebfd18a8sm1120838eaf.13.2025.08.19.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:43:49 -0700 (PDT)
Message-ID: <3e00a420-0db7-4df4-8164-a48dffd864e7@baylibre.com>
Date: Tue, 19 Aug 2025 09:43:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
 <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
 <f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
 <2025081910-shiny-trout-a937ef@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081910-shiny-trout-a937ef@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 9:32 AM, Ben Collins wrote:
> On Tue, Aug 19, 2025 at 09:15:23AM -0500, David Lechner wrote:
>> On 8/19/25 9:11 AM, Ben Collins wrote:
>>> On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
>>>> On 8/18/25 1:32 PM, Ben Collins wrote:
>>>>> From: Ben Collins <bcollins@watter.com>
>>>>>
>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>>>> to allow get/set of this value.
>>>>>
>>>>> Use a filter_type[none, ema] for enabling the IIR filter.
>>>>>
>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>>>> ---
>>>>> +		if (data->filter_level == 0)
>>>>> +			return -EINVAL;
>>>>
>>>> To implement Jonathan's request from v5, drop this error return.
>>>> We'll also need a separate bool data->is_filter_enabled field so
>>>> that we can keep the last set filter_level even when the filter
>>>> is disabled. (i.e. data->filter_level is never == 0).
>>>>
>>>> This way, if you set the filter level, you can enable and disable
>>>> the filter via filter_type and still have the same filter level.
>>>>
>>>
>>> Thanks, David. This is exactly what I've implemented, plus the
>>> filter_enable attribute.
>>>
>>> Adding the ABI doc updates as well.
>>>
>>
>>
>> Don't add the filter_enable attribute. The filter_type attribute
>> already does the job.
> 
> That doesn't solve the problem at hand. An example:
> 
> - Driver has 3 possible filter_type's, plus "none"
> - User cats filter_type_available and sees [none, sinc4, sinc5, sinc5+avg]
> - User cats filter_type and sees "none"
> - User cats frequency_available: What do they see?
> - User cats frequency: What do they see?

The ones for the last selected filter before it was changed to "none".
If the driver starts in the "none" state a probe, just pick sinc4
as the default.

> 
> Without filter_enable, [none, ema] driver works just fine. But the
> above driver does not.
> 

We can wait and see what Jonathan thinks. But if we introduce a
new filter_enable attribute, then we need to think about what to
do about the ad4080 driver since it was the one that recently
introduced the filter_type = "none". Ideally we would change it
to work the same so that we are consistent between drivers. But
there is always the consideration that we can't go breaking existing
ABI.



