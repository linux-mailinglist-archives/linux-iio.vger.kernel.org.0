Return-Path: <linux-iio+bounces-14272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B576A0B47D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF7188690B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3121ADB3;
	Mon, 13 Jan 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2BPtVW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF992045AC;
	Mon, 13 Jan 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763958; cv=none; b=UqPpzknBxTBHeFNNGl1Tm2Gkk0WRcPkWaGBPAUkjlfDe7OqtFCv2G/DojxnbbOGI+FgUvXBgEGLEqJuCRBAloF23/KPoAWY0HHOrEsL87WnLMYeZzyxT0Vwtr0yL5ZsI7gefEDpYYH1zuKRBbn7vMgfYfS8pMYF3/PUHO6KcF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763958; c=relaxed/simple;
	bh=YVKDW2Fy8ph0o0TCQI4bVKrCTbqPGO9PVWmRfBPLbkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNII0h1DafoZeW35QQDd2EmlsRBznYMwm5m0pV+lmTAKrpwx6SyeckFslA86CMnAOqEiA/yRWj8uxqKmYdOB/UfEqiyKMrPbP4WaWma2G1ShABB/Q72vWikQ29pVp966sHICB7Ide1fVvR8x5Xo2T4lyI8fSU/LTnkXaULtbWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2BPtVW/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30225b2586cso47014971fa.0;
        Mon, 13 Jan 2025 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736763955; x=1737368755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQVO+6EajBSRp27E4XFcaKr1qGrairLkHVu/felpVM0=;
        b=E2BPtVW/AVLOayfavRcN/XwdbqBgaW7Vdu1Pp9Q5f8qMIm/3xEGw8o8BmlGlbThjPI
         jRgrjbAbWBKTPhivFRCrQIuVNyDOYQfWtbbrP3DkRD/9HsHLyePjkfx5KagOlytsVVkL
         L1MZODFGSYgSW3q+F8HiNIWVL9RksJBRiGBLVFTq6JT3SKZDnikBbgqviJ2V9PGk/reY
         lH4fidtLBVi4vf5AAXsjRJUXidr8Ws8UhZV/1YtvjpSK25fWcdSpyCzqHSyEbL5a75hZ
         BnOeREcrbAlVSQvNJxUttayU1Rhrcpn7bYA5x0puXQXNHVaZjnDCQtiSlDXffXKa/6Qi
         7R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736763955; x=1737368755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQVO+6EajBSRp27E4XFcaKr1qGrairLkHVu/felpVM0=;
        b=JX7SA4/weY+qiZgJFq6m0Y/WKQ+XjKIO0YRBZdqdpzf4TMBChdTb3AYlvu9zqgUerJ
         UD//KmLGMU4jxmLwDNQd5gI92dRROi7OMwW69vSI2Ke95bf2DlJcyli1qjyZxtfyBju8
         4dmsJzJcT34fSduqO3zb+P7g6XfHoR8xmJ9gtDIPX2L5uMR5iwlI1rIDt5AcSE/8gB+R
         ooyXct+kVERfp9D0Ten/PEfecyUqtMGBep/3wBIkASSP/9RhHt1j8JZIP3kgCIwPxqKH
         qChpg1Ig8WGGUx2XwLEOOwivV8XnVQoWkQQKD4Dn3hR+8qDailjlg6SdcOZ/bbH6i8Ee
         9d3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/9Qtoo5aczaqPTF+0o7EnOBDiRlTnj1i1zLVV6e0c/v4RtTb2A/Ru3bAbczegl5ReAzcPoFxgulZ3dtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8MUtGzzsrdWpz8+2Ot9fCJIzw3x4D1HxbXOnh4n/JW1ucyef
	0f2a+kM97+cwY73dNgcDSS9BvvCJrSFQPYSWvluu/2mylC2LmO07
X-Gm-Gg: ASbGnctbS+u+Cberugwj75bqvoEtKnPlBayxSgtAtgdw93w7vlZbCs6jcTCWFmElDbC
	8GtEzD5zW3gG9f8x5QhQM/AvPIgesb4CPpRKLdQJrvyNeiK9cdm3CQG8K6KmKItQV7hHCBICW+X
	/wMxc9nw0UA4ftAg4FgfDiWDkl6i1QIovT3BugzcCYEv96b9cclOIPiWZhM90AAr2PSuGRnKcz/
	wrLh7bqNNbt4909F7V9LDDWaOesB3TIWeYQRmHvD8yOP562VAZzvwXV5DClNpz5/ZHuoA==
X-Google-Smtp-Source: AGHT+IESjg+EXdZZz+eHnOKpndblzO2+ImUkaoV90/6hTk0OljNy51uPIySC/0bhpTuclHJ+NCsJfw==
X-Received: by 2002:a05:651c:549:b0:302:23bd:354b with SMTP id 38308e7fff4ca-305fcf85a34mr48197281fa.1.1736763954455;
        Mon, 13 Jan 2025 02:25:54 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff1c7a9esm14355701fa.73.2025.01.13.02.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:25:53 -0800 (PST)
Message-ID: <25d5ff51-8a1c-4e34-9f0e-e11778313d8c@gmail.com>
Date: Mon, 13 Jan 2025 12:25:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: light: fix scale in veml6030
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2025 22:50, Javier Carrasco wrote:
> This series follows a similar approach as recently used for the veml3235
> by using iio-gts to manage the scale as stated in the ABI. In its
> current form, the driver exposes the hardware gain instead of the
> multiplier for the raw value to obtain a value in lux.
> 
> Although this driver and the veml3235 have many similarities, there are
> two main differences in this series compared to the one used to fix the
> other driver:
> 
> - The veml6030 has fractional gains, which are not supported by the
>    iio-gts helpers. My first attempt was adding support for them, but
>    that made the whole iio-gts implementation more complex, cumbersome,
>    and the risk of affecting existing clients was not negligible.

I do agree. If one added support for fractional gains, it should be very 
very clear implementation so that even my limited capacity could handle 
it :)

>    Instead, a x8 factor has been used for the hardware gain to present
>    the minimum value (x0.125) as x1, keeping linearity. The scales
>    iio-gts generates are therefore right without any extra conversion,
>    and they match the values provided in the different datasheets.

I didn't look through the patches yet - I'm getting to there though :) 
Anyways, I assume you don't expose this HARDWAREGAIN to users?

> - This driver included a processed value for the ambient light, maybe
>    because the scale did not follow the ABI and the conversion was not
>    direct. To avoid breaking userspace, the functionality has been kept,
>    but of course using the fixed scales. That requires using intermediate
>    u64 values u64 divisions via div_u64() and do_div() to avoid overflows.
> 
> To ease the usage of the iio-gts selectors, a previous patch to support
> regfields and caching has been included.

I don't see why iio-gts would need regfields? (I have never been able to 
fully decide whether the regfields are a nice thing or not. I feel that 
in many cases regfields just add an extra layer of obfuscation while 
providing little help - but this is just my personal opinion and I'm not 
against using them. I just don't think the iio-gts needs them to be 
used. AFAIR, selectors do not need to start from zero.).

Yours,
	-- Matti

