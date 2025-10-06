Return-Path: <linux-iio+bounces-24785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B949BBEB92
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 18:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9EC3C0425
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF542DE6F8;
	Mon,  6 Oct 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LhTE/nSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160B28A3EF
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769074; cv=none; b=k4n7c374QsU1wsPzrFZ5/fHbP1Do8bh0+JDCOHctSwiJbb/r/iIeP/sh0a06ONBrEi+9piuXV4tPraRQsBEKHDQ5asUZhdk6a2Zrb6wkFOBouG9T+qAV5UWNjnO/sV3QGIsi6VTS8ysROGVrwHsDtUKvOtLbMjoqIdlB9IsdBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769074; c=relaxed/simple;
	bh=aS8DHPhfdkLC1tCtAdARWrrRBS4/KNRMppS1z1bQeGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXcvc3un1e8oolcB3esYEooEBHFUH6dwJQFSl0rnSKctWTSt0SpBFsAOWXLwsi6gmlLBVwhg2hIIzFDT4lsWfWO2DqNbRwgb2QymSryLsiqcRuEilqqYgDytcZ1/fOLsc04dhwKkeb2wy5gGAccObOrgGEz/XcBvCd5tMHm5nAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LhTE/nSm; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3799fc8ada6so1787712fac.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759769071; x=1760373871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpiAWiK/9gl7kXYpIGL8zpOpeJcq8aBMhlNX/1cVAiI=;
        b=LhTE/nSmgqNldERKIf6mNQlJGyyFzsTUuRawcKyH8/1iOBD6qY3y4W+bq0aVE52E6g
         VYE/DWosb4psMsmLP7P5ewz0fyHHm0ONPqpc18iggA4uIq7jGsj6Bch/H5atJVkagFXQ
         Oa7MMCWDO/A/QpZljZGCrnhDPiYL5Vqa3wgxO/F+cvV83QE/AnC7CU5nMkMg34mwW4j6
         ow6jY8BFYDkBEHwMHlAyjYmOugi22vIg8FRhsJ7FUA5xSll4wHcwos8l+DD8VwDlw+Dz
         FlLnYYo4MRBuPYcORaoTlnl2llvHMhlJqx97IRHVhtsdvygasoOVCOH8QLSbFh+zI9J9
         ucRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769071; x=1760373871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpiAWiK/9gl7kXYpIGL8zpOpeJcq8aBMhlNX/1cVAiI=;
        b=ZbhPIkfgsLf7btx2vl1dbFH7tlKQAsT3b95wVC3mrBfEh7MBYvqi+utlrBZsS+oOgS
         uMUBIq1EDKTU1q/77vmRnUPxpF7mDEJ82lmimIlZk05Q8H5iNfeyEn4x12JGog/oIRr5
         5WpSUhdrs8BC5GfFdWn3Aj6AU8c5XoVwUtqUt4FofCwKNUO4jk68/NcPl4BDIQo7wr6n
         zzvwmP2QZmPPUlKY84LTNKdo7hl2EVAyFpFrWoAoRJuNfSYUwub1G77FA9j8BvK2RMoz
         bXU0XXK8LM6syuvXf1U6B9wgAt/46FuGmsAbYz2A/cT/ThVR04psnUpC6m6XnDcrVOmM
         WKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYClJssbWq/hfSVS9P/kbv0WKRfHdPvlRKPEEMm9jJ6vMHtuCPk0K8+31CZBiXivCSnsl1IrbjNTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4b078e+00mJamoVoZXReRroq2sbXFYLGDS/x0f22YShd43r85
	zcT8QVJzA/CLj6PoHzKzZzjRiOxFmx38fWcgeiGG0wf2u/Qee3lmnfLKMuU+gNzwC08=
X-Gm-Gg: ASbGncsHwdQlCBHzdJ32/Lz0S9ZaTeNNZugtt7Y5dUPL9UHipwJbIR2nExeio0SiXc1
	Kgmyh20AC9yMEI5QV/9JUPZybnySaRf0nPlAFPv/O1UklAHms6ukKOnhKTkn+/QmV48KfpOLRbk
	mQ67Bd7j+TArKq0bcXIDffPhfF2UERY9BtKq/SlOhqaVZ4yp+lD20a14ZCYyKgWRVEJHBkAdFx6
	X9QD3Ws87or2YWI5DGmb2UQgrytLM5SCxAcx4iQQwb2SexLrBDRkREUPO2MPcBZdvzEhBDJpYPe
	aD9c7Fi4sARJ3t1E/+xSYKxyxQWV2m8uXMBhe21P6AYy9GYxySr8bwxO4/75Ci8AJ0LLs+o5cPW
	DAE9pT1dhcrJv02OFiidktkNH0kmeAyRDUMHMX8DtmAl9YHuVcStg+pcwPF27+PAphvnZtcHjOS
	+mnLLt4Rb+wlyZpVvAcSdkXeg=
X-Google-Smtp-Source: AGHT+IG2R+E8ZzkCqqORbj5+wGHvn3wr2c/m6d94G6/GsMG/6CC6YBkDJyByDmXCeketeFDtbQyFNg==
X-Received: by 2002:a05:6870:3907:b0:395:9e1b:b0da with SMTP id 586e51a60fabf-3b0fb6a0778mr7105123fac.49.1759769071129;
        Mon, 06 Oct 2025 09:44:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246? ([2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab7ce5655dsm4159051fac.13.2025.10.06.09.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:44:29 -0700 (PDT)
Message-ID: <118c3551-df86-4c23-b385-6f75d9bd5388@baylibre.com>
Date: Mon, 6 Oct 2025 11:44:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
 <7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
 <2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/25 11:25 AM, Nuno Sá wrote:
> On Mon, 2025-10-06 at 11:18 -0500, David Lechner wrote:
>> On 10/6/25 11:06 AM, Nuno Sá via B4 Relay wrote:
>>> This series fixes an issue with DMABUF support in the IIO subsystem where
>>> the wrong DMA device could be used for buffer mapping operations. This
>>> becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where memory
>>> can be mapped above the 32-bit address range.
>>>
>>> Problem:
>>> --------
>>> The current IIO DMABUF implementation assumes it can use the parent device
>>> of the IIO device for DMA operations. However, this device may not have
>>> the appropriate DMA mask configuration for accessing high memory addresses.
>>> On systems where memory is mapped above 32-bits, this leads to the use of
>>> bounce buffers through swiotlb, significantly impacting performance.
>>>
>>> Solution:
>>> ---------
>>> This series introduces a new .get_dma_dev() callback in the buffer access
>>> functions that allows buffer implementations to specify the correct DMA
>>> device that should be used for DMABUF operations. The DMA buffer
>>> infrastructure implements this callback to return the device that actually
>>> owns the DMA channel, ensuring proper memory mapping without bounce buffers.
>>>
>>> Changes:
>>> --------
>>> 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and update core
>>>    DMABUF code to use it when available
>>> 2. Implement the callback in the DMA buffer infrastructure
>>> 3. Wire up the callback in the dmaengine buffer implementation
>>>
>>> This ensures that DMABUF operations use the device with the correct DMA
>>> configuration, eliminating unnecessary bounce buffer usage and improving
>>> performance on high-memory systems.
>>>
>>> (AI generated cover. I would not be this formal but I guess is not
>>> that bad :))
>>>
>>> ---
>>> Changes in v2:
>>> - Dropped Fixes tags on the first two patches and Cc stable them instead
>>>   (as prerequisites for the third patch). 
>>> - Link to v1:
>>> https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com
>>
>> Did you not care for my other suggestions in v1?
> 
> Completely missed them, sorry! I kind of stop reading in the stable stuff. I'm
> ok with the helper function. For the clarification I feel it's redundant. The

I was thinking extra clarification could be helpful for someone new to the IIO
subsystem. But it would be quite rare to add a new buffer implementation anyway.
So probably not too many people would actually ever read it. :-)

> field is called .get_dma_dev() and the description "called to get the DMA
> channel associated with this buffer" already implies is for DMA buffer. Same as
> ops like .enqueue_dmabuf().
> 
> - Nuno Sá

I don't feel too strongly about either change, so either way,

Reviewed-by: David Lechner <dlechner@baylibre.com>



