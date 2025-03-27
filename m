Return-Path: <linux-iio+bounces-17291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233EA736E4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E095A7A6923
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1B1A5B92;
	Thu, 27 Mar 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Es4wJgpW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EE1991BF
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093307; cv=none; b=gXA+HDs9z7YkaDM4KwKb67i6HdLuGAQm9wp0EYalSOG8nqPoJyrkU1mmiCicxDzNjv3mdz4RvuetYYLAomsJZan3t6mgabeWHLc+VydUUNl1JK1xf01uss3KdElSfoGELJga8mVWxA1OlG6Q+opZW2jB1aozF0SbUNUN3++4Syo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093307; c=relaxed/simple;
	bh=yrLrJ07jSyEkRNOIGSnIx6UIH6SW0uwq2gx5Xt6MpTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfENW9nMpOILAp6Gy6hkb3T4cr/r2HkiwukZ5tjq5HbrhG0Td1q7L4i2dNKcosWL4N4SAEZZpvjMDJYTOvELLHFL4ZpaP+DcVj3Jy3bL2om65UvXXoYcwaUopU47QNq/Di5e1rqJ4sl6CAmTRgM9ZnUNuX+jEG1nr5TlD3fw3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Es4wJgpW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso11763685e9.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1743093301; x=1743698101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGjDGhXvhOctDrW1nI1udXGMONQSxA0lH5by2Ntn0tg=;
        b=Es4wJgpWTP8jzV/2d74v1syhkB6P/YbPKpMSQpi+7LHCy3AmT1Hdh+jh8vz4xdzbUp
         2TLKwxYc81UpK8LTlzqTw5tLbjKtsxOrkbAXhZB5v31/tl+UH60puHzPQJ9SMSvpRHLG
         TgbP+GOmJCIPLWmiPdTNy2PJnCEhAYJB3Ss+eM7HNNNePe1AzN+O6VFGCaL1wmyrPsEG
         Ged4/X6chrEGM9B8V9FLwpuNzpyoeYwVMmJb1HLh5ahDDeR4o4ouM/6T/+xDKj4JR00r
         Zhd7HBSIFYaNzZ5xB7DbfadSmxhwgTkKjRLE+cquz6cvQs8jsZIIESTMYDDYfFhsnyBr
         PVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093301; x=1743698101;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGjDGhXvhOctDrW1nI1udXGMONQSxA0lH5by2Ntn0tg=;
        b=W0aXtH7uuCS/OEO6cvrINidmJTJGb0rpuNsiF3hMIb94N0Gug2AK0cvacViuf9TUET
         e5fn5evlx18Y4l3bCrNc5zAsa55FYAq5oXcZ5zpsDEgq4zbXkuB++dysoAa5fq83vRIi
         qv9k8clp7vu2dzvN1aHhDq9pceqT5D7jlow8wH+vc26QvuuH0AjhY25x4HvTQWG+VFmH
         gXRCMvPq3k+cimMcYZX1+I1mnkMP8jfE4q7ECoGdoLj607dIkMYiqxDQ2e9gSYmw92XE
         HpuYWQ5hGbGSqvOdvoo1ywfG09tQnP8wocqsGlB4fT1ZLyQCUAgEB4/ZHhlMgTWOt9Us
         j2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXspv8xM6awedxGxnLUuUv1jm/f/B050fTcnSRSITYtGEVHIwbvBwHSUQeZ2P2EtZPXTnFKhewFJjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNgw06mxcu9Zx5W8WqX/7PSMq6NFE2rkOV4JnpOjG2JS7MBz2
	/fL5McBadXIoo8DhboXferlmyLEUmzjRih38qR1+9CFh4Xq4f1Xkv0yTsa1xFUY=
X-Gm-Gg: ASbGnct/ncV4pZ572APxay+z6qaWxUztO14VHHACg0edAgnGylidelwu4ZAEpL90ULJ
	wzrWA+1376kGSg7DIYrDWhN9m7UPu6y4dUH9+gJOoLzS3nE9b635I40ExILcPRbguctuO0r94kv
	35jDwss3qjMskcFrNRtGcifthLkqIq/QZKxb0IFX99l9YLAjr6mPcaJTaziWB6Hvo8/VyRrJeJt
	vqdYNgFAyivrKkVTzCisSEphUXmL81c4N7CwMMJdC99cQBt8enA1lxLuTDw8SN3jFNFIW9Ug8zn
	DP4VArv7vIfaevwEer01EcVpop8dVlprp1VRpNiQEHMlYuhBhU6ApP6Fpl7Pu6ZT
X-Google-Smtp-Source: AGHT+IGawtvFBb4fS5ToIj7CyXU2x5hbH3B/DoIrPXE5LcvhbfIugmJW/IZ0c8unwGyuVy6PG4hKmQ==
X-Received: by 2002:a05:600c:3ba1:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43d84fb5ffdmr36069095e9.13.1743093301462;
        Thu, 27 Mar 2025 09:35:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d7ae6a206sm39611675e9.0.2025.03.27.09.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 09:35:00 -0700 (PDT)
Message-ID: <a66f3c88-0fe7-4e9c-83cd-1fe4bca8b14e@tuxon.dev>
Date: Thu, 27 Mar 2025 18:34:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
 <20250327153845.6ab73574@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250327153845.6ab73574@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,

On 27.03.2025 17:38, Jonathan Cameron wrote:
> On Mon, 24 Mar 2025 14:26:25 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series adds some cleanups for the RZ/G2L ADC driver after the support
>> for the RZ/G3S SoC.
> 
> This doesn't address Dmitry's comment or highlight the outstanding
> question he had to Greg KH on v3.  
> I appreciate you want to get this fixed but I'd rather we got
> it 'right' first time!

My bad. As there was no input on platform bus patch I though this is not
the desired way of going forward. Sorry for that.

> 
> Also, please make sure to +CC anyone who engaged with an earlier version.

Ok, will do it.

> 
> For reference of Greg if he sees this, Dmitry was expressing view that
> the fix belongs in the bus layer not the individual drivers.
> FWIW that feels like the right layer to me as well.

To me, too.

Thank you,
Claudiu

> 
> https://lore.kernel.org/all/Z8k8lDxA53gUJa0n@google.com/#t
> 
> Jonathan
> 
> 
> 
>>
>> Thank you,
>> Claudiu Beznea
>>
>> Changes in v4:
>> - open the devres group in its own function and rename the
>>   rzg2l_adc_probe() to rzg2l_adc_probe_helper() to have simpler code
>> - collected tags
>>
>> Changes in v3:
>> - in patch 2/2 use a devres group for all the devm resources
>>   acquired in the driver's probe
>>
>> Changes in v2:
>> - updated cover letter
>> - collected tags
>> - updated patch 1/2 to drop devres APIs from the point the
>>   runtime PM is enabled
>>
>> Claudiu Beznea (2):
>>   iio: adc: rzg2l_adc: Open a devres group
>>   iio: adc: rzg2l: Cleanup suspend/resume path
>>
>>  drivers/iio/adc/rzg2l_adc.c | 67 +++++++++++++++++++++++++------------
>>  1 file changed, 45 insertions(+), 22 deletions(-)
>>
> 


