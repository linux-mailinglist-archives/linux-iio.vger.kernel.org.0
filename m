Return-Path: <linux-iio+bounces-18749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A57A9E7D0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3503A9F7C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAE19882B;
	Mon, 28 Apr 2025 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAW7GPuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D318BBBB
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745818718; cv=none; b=FgyooPDoxSN/kyujirK4xp77l2KRlOXKASnkgBSGwmS6NA2TlUnnotsnigOGMarP1j93cBeLLtcHX21frIdJq2pbyFvKaDyfyIvk5l9YT4XOOqEztRkUheedBKgqxQNAnMMr8fZx+I1WDZXlIjy0pxo0U7oChWGhGGUuagTD7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745818718; c=relaxed/simple;
	bh=PROFAG54vtPUCa2biqnhdOCrXOiyrBWDUnCdPsRbRL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQlQwATHUswOvBUlaSENJYDix8D4ECvLApnWbyhQUON/SFuSDP/U3ma6eYwusoYl7Hy4IHj7bHEAaG5hrUzKqD/fV3xDLuM8y5xzwC/qc4ZW3uaSYwWUfDTGTRZ6fNAUrWqHkfq37xSM+3Jbmyjzpp1Xk73C1M2LBXlUpXXejls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAW7GPuj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso43573981fa.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745818712; x=1746423512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpkreBkWmEH1bGwQun7KblFPtCeI9D02gNYAg3Rbfqc=;
        b=JAW7GPujdt+lePlLE2FUWifesbvl0xAUkWKDuMTzzXeXSh4k+1d3x/ayZQgpF+SlFx
         H2Lpw2wuQBlnvezp9jsXEZ98uvX74iRPD72rnfxajwk2gInjpSx4fO4nHx91rtbDCq4P
         +oQ/FF/O0D8ElzVkZ4wigvISi9tTyuDk+0yH/QjnK3YGQ0uFqvOnP6I+3uT/ILAtKGV3
         imdpNe3qHhNjbVYmx9SIyjnOlwMT+iCsDx/nhac30nrb5NAh8Kje1LxEG+OJbO+b9+DI
         gaRar7ZJpQFXkz8QieNIJACz0tHi9Tu/LIfJCmgZ8EQIRVHk/0fJvq210ZlBUNvb7MAr
         UOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745818712; x=1746423512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpkreBkWmEH1bGwQun7KblFPtCeI9D02gNYAg3Rbfqc=;
        b=wtbzRnVDA7Ycp78gyIqmGtOaVsMzFspmomQTPoL6H+GCfb2WiizazD/OW6lDK2FbxG
         NdMHKkoNKc2qEX1oUY+6+EwCZZN0r+c7j1B9FvVI25husQg+k3saKKdLcPDcrXaJ+W5l
         agh9KPHyCeKaVGAk0bNVD+Tr+xH0oAed+Soezr7rU9EtSrDLueoQaCmORnt4/5mrmFjV
         dBHrb9krp7YyGrmNwAFbeUm8/gMDPpnFkOVBIwpku6OoACMElN0n9lJ5jDws9XKiOO4f
         OJDa8nvlyNC2RVsNygSmxztRncGjNzN5HhgMhJgnloNP0UB9JD+Latw0962bihNwUkc+
         gK1w==
X-Gm-Message-State: AOJu0YzAnmWD5nTA02HaVhA0Cu+j53TDN2ufekSw0XAm/OFhfvr20QpX
	C7l4dXwRAXYo3LvKy3QFn+CgmlRyzEvjHNXL6osMJOfPDy0+rjNm
X-Gm-Gg: ASbGncvX+4Yk2HfNQTZ0MKmXcP48k6VOPItwt3wKrpDKD7Dn8e9Imn5mpSp3wTjs1XY
	8C/Ub5tIL3NSa0WklARyu/vjJUpV2bkTME9MUU2dUy1bl2SqaKWyib/NQvvotZUKPZoGFj8uB4b
	GlOXZs3rAQte823vvrGOI+QPyIOsf2Swn5JaFFWChUk3XrWctmAcqGiptKxycWwYyUdJwO/KqBo
	nkMgfWonqxRjH/3UwWe6V3dkytjA6bt34B0vnLntGPY4MzxiC0sHLAxMdNgc9a2snOuLfT3tsM1
	AsGT454kudRmInpfcT2I4Rdv3oQDXfEJu+CLrjML1xeKpVLqiJ8OnW3LuUqixI20O7b+GEgGJmT
	eIagdeb1Q145sYQiKQIoG9g==
X-Google-Smtp-Source: AGHT+IEkhAAdXIXe7+qjTGu+Us8aEMl7h24cW98TIk1xeuKIyCHceOQziGD8V36pEGLORmxNoCRpog==
X-Received: by 2002:a05:651c:1542:b0:30c:2efb:6608 with SMTP id 38308e7fff4ca-319085be535mr30273641fa.34.1745818712145;
        Sun, 27 Apr 2025 22:38:32 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659e59sm20176301fa.3.2025.04.27.22.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 22:38:31 -0700 (PDT)
Message-ID: <de99d175-a571-43a0-b254-606ba03948aa@gmail.com>
Date: Mon, 28 Apr 2025 08:38:30 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250426160009.161b9f08@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi deee Ho peeps!

On 26/04/2025 18:00, Jonathan Cameron wrote:
> On Wed, 23 Apr 2025 17:23:28 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
>> After upgrading the kernel from 6.1 to 6.12 (also tested with
>> linux-next), I started seeing the following warnings on a board
>> populated with a Maxim MAX11601 ADC:
>>
>> [    1.554029] max1363 1-0064: available_scan_mask 8 subset of 0. Never used
>> [    1.563627] max1363 1-0064: available_scan_mask 9 subset of 0. Never used
>>
>> What is the correct way to fix these warnings?
> 
> Ah.  I think we have an order of modes bug.. Later entries should never be a subset
> of earlier ones and we only recently added a sanity check on that.

This indeed rings a bell :) I have nothing really to add to the answers 
by Jonathan, but I just noticed the warning print isn't as clear as it 
could. As far as I understand, the printed values aren't the actual 
masks, but indexes in the mask arrays. Now that I had this stuff 
forgotten, I was puzzled by the print until I read the code.

I believe it'd be more informative if we printed the actual bit masks - 
but I am not sure if we know the size of the mask. If we keep printing 
the indexes, then we might want to add brackets [] to indicate the value 
is an index? How about:

"available_scan_masks: mask[8] subset of mask[0]. Never used"

instead of:
available_scan_mask 8 subset of 0. Never used

Would that be more obvious?

Yours,
	-- Matti

