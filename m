Return-Path: <linux-iio+bounces-19654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D44ABBA81
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99109188FC0B
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD7204C3B;
	Mon, 19 May 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RrUci1Lw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868B3FE4
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648783; cv=none; b=IvLoMSuqX3cQyHJEcHc5wKAy+/gyaNBOPEOPteHfzMUlhm+VhtKqFnb6ETbSmBydbthyHtFlIsJBuTV8U84ru6qw6RQ9WU5WDm2kk1YnbgiGnj7CpE9ZRVyk6TfKl4AP7QeFn7ClL5ZAJSDNCtBiMuPimjhjFVg2sUsp/kBLLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648783; c=relaxed/simple;
	bh=dSxij7d3UNEnc03Iwv5weNptcq49Yp5Ww8xB0LEZHn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqjkgqIptyqcvK1dk9M3VEnv8+xVqh149QjbOibUwcgvS+l1kq/lOXBW6WP7rHIyQuSAJINr+AHTQe9ff4JKKVXRoBkyBoIhVS/5Zsnw41mJ6XVsGjdk3sgRJCDg5YLR+AynEnPP0nCP5wkGzya3x62fwzqIDKxoQ3nbCGHK7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RrUci1Lw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601aa44af77so2701425a12.3
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747648780; x=1748253580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=squm7R0/ZL3X4Ww4+m9myAtwPnq33Yj6/51YuPwNRrA=;
        b=RrUci1Lwi50rXkdR60SsIy/4BWKSs449RUNskN/0F7yQQ284T0Pg9I7Nk2SLs2pbGR
         010wn37lrErfrn9nvFQ8aDWAV2O3ZVXMt4vadNttWUWrQwlPX6/l7VyXT26ypEmeyYqZ
         gXWh28MgocwIIBwmocOGfJUaHq5GYQKIk6HqNCSNOqJU/j8dX58TWPMw0EdtBWCbYBsp
         ChujWVVmcdT4/2BNiHPGtR6g2Ob22JtgkpjT/JZjehmqI+OP3P20x1m3hGQdn0xXpp3a
         t/ZpIVBCy6bRrHMFKMoL8Tx5M522CKRdpyS/NIK4ik9MaItdfWakh5Gz8sGExprdbOT2
         VwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648780; x=1748253580;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=squm7R0/ZL3X4Ww4+m9myAtwPnq33Yj6/51YuPwNRrA=;
        b=csav7b2VftPOdpBZUGS2b6XvoCbgbxWntOnMs0haDfqQf5UZdPAU/f5aEcez2XC+ZN
         2WGKpNOsftDudrCE5nLWTFy4kGes+ozJoWak2dbONbc8S0Pwo/ojKfg2MlxBrp4fScI9
         IVAkCUg+Pmo8MUTcpvRZx2sY2EyafjSG/dvSkz+VcGq1v6WF1c8BF7qhqigzXh5k5UJO
         tNKjFw9l0linzNsmvPEmiy3WBlsMlPHHeHKQe2CbrTIcVk/4t9EDT32FpZkyRuEUvWb4
         At7wO4aPYTv+cOcs8EsF+0fOz+HUmeiLI89Iy+GYsjgnJlFsy1S7S+zLxTUIR2aGm0Zk
         G9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCN6v0TmKFrkI+qR+i592nqPx3o+kUDXetWbWNykZL6tdfsY49nK+MGRDg3J7J3WjRorYhMUHgQJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj44RsItiSTFz+bLIBRGeyQQWRGTqFYDVoe6yKrMu6Jee/cb/K
	BxPZQGgLedp49QS5rA1HWaETM64bgG2rN1xpS76qpbIyExa1qQk1PdH9nBg6qNBPk44=
X-Gm-Gg: ASbGnctXRMERdDolx3tbvoRfHFiHBzsfClx6BWKF2sisurfdmkU4/9KZK31op9TVdfR
	lDxtQU8rztXCju4J5EBnbTw9FoScy1q7wQH0168Q0OR8mYqWrp+NKJPWLTGQuNKF25KBQRGDlfd
	l/5z2oqxSjjvJ6s9e75aWBhD7KYzajESBP1qAVWnGlJOkPVf3AAAwhBEUk5yAjYU66H6BPG2O0p
	3pSHdSu2kGHYEOE0RmwjjYB6P+QJNpnCsODfSBJd42piXW4gDATeHXQ58DOlalKAKLibP51lxld
	uPzu81REljqGpCz6MDxQswI7Qv7GXDcoAAVi0s+PYa3VsYYFjGPdLemLTcY=
X-Google-Smtp-Source: AGHT+IGOf1zbVEfv3sqxO0+3n3nY9cx70R8hKHEv43EChu67h7Euqo+U4eNL1rpDVaHinhCtY9Q/Ag==
X-Received: by 2002:a17:907:72d5:b0:ad5:2077:7a71 with SMTP id a640c23a62f3a-ad52d557911mr1094441466b.30.1747648779618;
        Mon, 19 May 2025 02:59:39 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498f18sm562159966b.150.2025.05.19.02.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 02:59:39 -0700 (PDT)
Message-ID: <42ae4511-43db-4896-99b3-f203d52433e3@tuxon.dev>
Date: Mon, 19 May 2025 12:59:37 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
To: Jonathan Cameron <jic23@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, rafael@kernel.org,
 ulf.hansson@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
 <20250327153845.6ab73574@jic23-huawei>
 <2025032703-genre-excitable-9473@gregkh>
 <20250330163627.152d76ef@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250330163627.152d76ef@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan, Daniel,

On 30.03.2025 18:36, Jonathan Cameron wrote:
> On Thu, 27 Mar 2025 17:22:20 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> On Thu, Mar 27, 2025 at 03:38:45PM +0000, Jonathan Cameron wrote:
>>> On Mon, 24 Mar 2025 14:26:25 +0200
>>> Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>   
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Hi,
>>>>
>>>> Series adds some cleanups for the RZ/G2L ADC driver after the support
>>>> for the RZ/G3S SoC.  
>>>
>>> This doesn't address Dmitry's comment or highlight the outstanding
>>> question he had to Greg KH on v3.  
>>> I appreciate you want to get this fixed but I'd rather we got
>>> it 'right' first time!
>>>
>>> Also, please make sure to +CC anyone who engaged with an earlier version.
>>>
>>> For reference of Greg if he sees this, Dmitry was expressing view that
>>> the fix belongs in the bus layer not the individual drivers.
>>> FWIW that feels like the right layer to me as well.
>>>
>>> https://lore.kernel.org/all/Z8k8lDxA53gUJa0n@google.com/#t  
>>
>> As this is a PM question, Rafael would be the best to ask.
> 
> Sure. Perhaps Rafael missed previous discussion, so I've messaged
> him directly to draw his attention to the series.
> 
> Claudiu, please include all relevant people in +CC.  Don't trim
> it down to those effected by a particular solution as has happened
> here. +CC Rafael, Daniel and Ulf.

As the discussion [1] is progressing very slowly:

Jonathan: do you consider having this series as a temporary solution?

Daniel: do you consider having the fix in [2] as a temporary solution (of
course, with the adjustments suggested by Geert)?

There is also [3] for which a similar approach was proposed. From what I
understood from the discussions on [3], Bjorn is OK with the current solution.

I am taking the responsibility to do the necessary adjustments to all these
drivers once there is a resolution for [1].

Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/
[2]
https://lore.kernel.org/all/20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com/
[3]
https://lore.kernel.org/all/20250430103236.3511989-6-claudiu.beznea.uj@bp.renesas.com/



