Return-Path: <linux-iio+bounces-18811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F6AA00FD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 05:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF007A520F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A326B2C4;
	Tue, 29 Apr 2025 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCB6O4mZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065E1F19A
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899188; cv=none; b=jAjuFaZRmyMJ/E5hETZE4NxPVcUkFSW7Qt9GS46FYOc4C7VcJ0Csc/zF3KLSXrrIVGLkItYntiqYN5EwL2FUnV1jFnQr7P3RiwWNqRiMhbjdOHMM5pddZEd2w2KpoMbPLFuEzwV1ZcmPu74qOv/e6v1CImwDg5/GCCfV1Lv6Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899188; c=relaxed/simple;
	bh=To8fwUckT19z93FWDCf2Xny7W5ZO/K6ASCD98EMdCaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbYbtpHWHauU5U8+swxMT48niCaV1DCANluopRjmb9SCW7nCBUQP7pZ0vKVXX8xx5HOqNDy1cFfnTRJYGTnSkneVX4LNrouqcc2Qm3XnEP5HHYLcFuNMZv3IsRX03cdoZMi35B9NBlaiIEnlXTJEfIlKEACdAy0/jv6B/xgOmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCB6O4mZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e816aeca6so5821200e87.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745899185; x=1746503985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8iXcPdxyx2hk2mP+mFAKHjH3LdwWTMIOPwnPl4SbBw=;
        b=fCB6O4mZ2/LUC1dD8K681zzLfCQ/9pKBopt3+9Bxswa3t6OrrKfsLIAyYHf1G8yXK1
         1rdwFrFjcPxnX8xqNGsCfCDevU+8kb9/r/O0gb2/rhTuWnzAqpr9WgNZTu3i64D2lKiy
         oM35+6Zf7Hh9h1djlRbkO7Wt0jSzHj7PsIuL7EfOJUuwXRyftdjRAMwtZDbgBP2XHR83
         MXBlTVRUDBOEkb2KngSu4VUit92L4k7ww+XTahPTRq07p2YzXwbcnAZnvLE6IL5bE1R/
         k422YKaxRuR2xc5bfYjDOcb3cB/MJbmChfNF3XBmFMyzh0f9ZxoGii7B/wYjM04V8Cce
         mGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745899185; x=1746503985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8iXcPdxyx2hk2mP+mFAKHjH3LdwWTMIOPwnPl4SbBw=;
        b=oHDCaW4tholG4CE1Ix5dnT7wEWtlBd09SToWxKgxCcF7UXNR0/8DmoC47HU3JFplr1
         oewWnWxXT7cZV9t4Ibv5RKCWBaPa6tDX5gpM5mnF8Gpxgl9KNRc+HuicTzTu/Jj0G+Sb
         Ma+QiqkvRznYraK8kuXLAMEWsoBbJHLTuzwVtn6VamdR+AWOLDGur9XvAm0ymlYuMBIc
         P+8DBc7AA+3RuCHSQ1SsCjuyjOgWq1c2reJF0GVaUruZ0fD0ZYPQVzNGIyW3kk/AAlNi
         cG/RpuScZ0HiAfJWHjrRbS8LAjinJ0XMzLVjLqSvP9GH6tVKRUSe1OoNef/PcyetWrpj
         ih6g==
X-Gm-Message-State: AOJu0YyT6d4J2qeL83Hu9i+rlssa8JjB1sBgUzcDv9YvLre9EtSEow9B
	dq/5r7+VB5LBvzQQQga1mwjEKruU04Hps4gBsH77k+4bqn+51V76
X-Gm-Gg: ASbGnctuxnfpOtqVRf2+LDmyHw6pYKVXXIzztheyRHSkBC1LjfgH+3h8uyB4dF9fus9
	uGEWw1lluinZUIXjFQZZkhMX5DEknLuPoyb6BWMruZG25fslwRtbi7fX0v2YVaqGFryL0wvXFQw
	JyK2pb6SHk+QWzJsefBr53FdCFR/0Nd1ffobYLIPhf02/9lTACDT6NfgKifkoe/v+EUk4imvP+r
	PDYgM5rnBd61kncUZ1iueMZ0JhofsLKYFyG5/1uvYx4p+5MB1onTTNvxJdGWjr/gU8Ix5EZNtqN
	MvNQhyn317VTdTncCNAxaEr12EWlUAqs+Oc6nlX0Q0oKAuopJvUYp0DGANvw6Ave54uz9nbKK6R
	qLIjJYY8j6DaTFuUZNmGNpQ==
X-Google-Smtp-Source: AGHT+IFpb7u1jh30Hbe6ytb6b8dwwNocijdfR279HEcrz4rPgqQ+E1drUeNAjg0Ha+AcJiPzFljNfg==
X-Received: by 2002:a05:6512:398d:b0:549:8e5e:9d8e with SMTP id 2adb3069b0e04-54e9e4f9f96mr320757e87.0.1745899184326;
        Mon, 28 Apr 2025 20:59:44 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb3bdbcsm1759687e87.96.2025.04.28.20.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 20:59:42 -0700 (PDT)
Message-ID: <ef215ea2-e283-4c89-9b54-61b84684bfe7@gmail.com>
Date: Tue, 29 Apr 2025 06:59:40 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei>
 <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
 <20250427112343.207918cd@jic23-huawei>
 <CAOMZO5BOXGcuuf7cyf-c6QLXVoKber2oWP+sgWA_RMHQtW5-cw@mail.gmail.com>
 <CAOMZO5Bzrfu14-mzaF+EbAq=xGKMc-FGwJsx-aZd_RraH2Gscw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAOMZO5Bzrfu14-mzaF+EbAq=xGKMc-FGwJsx-aZd_RraH2Gscw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/04/2025 00:16, Fabio Estevam wrote:
> On Mon, Apr 28, 2025 at 4:03 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi Jonathan,
>>
>> On Sun, Apr 27, 2025 at 7:23 AM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> https://elixir.bootlin.com/linux/v6.14.4/source/drivers/iio/adc/max1363.c#L1460
>>> There is where they are set.  Should show us if something weird is going on with
>>> what the checks are seeing vs something going wrong at the debug check.
>>
>> I am not sure if this is what you want me to print:
> 
> Sorry, I should do it like this instead:
> 
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1453,6 +1453,9 @@ static int max1363_alloc_scan_masks(struct
> iio_dev *indio_dev)
> 
>          indio_dev->available_scan_masks = masks;
> 
> +       for (i = 0; i < st->chip_info->num_modes; i++)
> +               pr_err("************ available_scan_masks is %lu\n", masks[i]);
> +
>          return 0;
>   }
> 
> which prints:
> 
> [    1.567841] ************ available_scan_masks is 1
> [    1.577203] ************ available_scan_masks is 2
> [    1.582032] ************ available_scan_masks is 4
> [    1.586837] ************ available_scan_masks is 8
> [    1.591644] ************ available_scan_masks is 3
> [    1.596452] ************ available_scan_masks is 7
> [    1.601258] ************ available_scan_masks is 15
> [    1.606149] ************ available_scan_masks is 12

Here, 12 is subset of 15.

> [    1.611041] ************ available_scan_masks is 4096
> [    1.616101] ************ available_scan_masks is 8192
> [    1.616105] ************ available_scan_masks is 262144
> [    1.616108] ************ available_scan_masks is 524288
> [    1.640493] ************ available_scan_masks is 12288
> [    1.645640] ************ available_scan_masks is 786432
> [    1.652223] max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> [    1.659028] max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> [    1.665829] max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> [    1.672722] max1363 1-0064: available_scan_mask 11 subset of 0. Never used

// snip

So, majority of these prints seem to be garbage. AFAICS, we should only see:
 > [    1.652223] max1363 1-0064: available_scan_mask 8 subset of 7. 
Never used

Or maybe:
available_scan_mask: mask[8] subset of mask[7]. Never used

Do you think you could send a patch to fix this, or should I take a look 
at it?

Yours,
	-- Matti

