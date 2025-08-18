Return-Path: <linux-iio+bounces-22895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36357B2992D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 07:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D475E17F2
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68927057B;
	Mon, 18 Aug 2025 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T1IMr5Lt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E726FA6A
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496462; cv=none; b=px546mCJVoqFm0QSuxAEBEosLUJ6ezdHdl4WZ1U6Z6WXUE7GpqUuX9jR1+gngMgLX6mTzHHFiJ11HYHIJ6yDV53kPgAo1EUSBExv6qUV0Zf8grLD2pi9TFh/uVJcSLQtNPa1cxyBfKB5fYhKY6oOKqFdqzEsr2Qyc4gRaIMQQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496462; c=relaxed/simple;
	bh=rSwNLEEae3P9QEq2Hme2YrXdZ7yJVM2ZDx26GAa5T6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEMqq0czBKJjzjLIOp8yKK+TSGXXj8ubzUTOQq3nVbpSR621PtgAI6D8tz+tFCbtfWFZ5qmvrr6fozjg8/XI/w6p3TlNsqu6V+FvAEdxaajlprIUbt41wGpElSdtBZyxcuYXjA2fF+L/YySS+sSz8NutWDXJQ3ndHUiMtIoCCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T1IMr5Lt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb79f659aso564754766b.2
        for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755496459; x=1756101259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSwNLEEae3P9QEq2Hme2YrXdZ7yJVM2ZDx26GAa5T6A=;
        b=T1IMr5LtRbt3st3jCDW41Yg8CU6X2qUVL/lH48ElYepRtMAE6v9UFbJKs25YYRLSpV
         1iMJ0iqYKK18zY49CDvyFNfgkT8kPZynccAw0EJwGVo3a8iR82jIDMCFM+5qeKowrk5K
         dEnhUVfFclYginAwaIMlfdRgb4Yod0vHRT1TJ6WH6lfIvUoPIEzMOKmon3RFL0GSoYZe
         00DdRvRPWhAK2tiqYN0d/wKQhuJ/ecZ9K7wWpYfAap4GNo4y824DA8glgOv/+mMufxnk
         kDYSkaH+FOOJZumRYxFLUAPin1YVrMISm+/cjS8phbOYeBJrYaAK38Xecgm5FnD/eSrd
         /c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496459; x=1756101259;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSwNLEEae3P9QEq2Hme2YrXdZ7yJVM2ZDx26GAa5T6A=;
        b=q+ruOzDHl2YJH5cEhmiXrZr9KCiB1c4Z1VJlJcGHZpjV8/MS/OTvL3V+sMTrgZ+v0X
         zt5YFkD21DRpqiwgSbVTn4+Sn6qZsbI+kTZYoSvubVM1U2gtll1yPLLzB1jS1XJfPpTn
         +iqpuPhHpRvMj9fLQfPxJe1ulhmlIJQ2vkpMLglTbQiFNm588o3+TNnM29Z+rz46+me5
         PGlxWVyfNxIdi6jgzW93KvnxmI118abEqR0GpQZZRdmF04L1bhsjCAmtQPD/fv2XJWC0
         UdpMzWIdVnGstfvErURsrLEuw0a8lCn6VVxrvguYpeqiTlCSGhVdT6bHqMGggYFopvVk
         JFuw==
X-Forwarded-Encrypted: i=1; AJvYcCU/A79rk90El/D/74VYbEbbUHqmNypXTpnKZOeu3uDP/5uEIa17ZoygjA2mCJ/Cyf3faZ69vb91szs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKPsiKuG273IipvwE0dXpLBSQWkSR1IcDXhm7/SP/PFSEh///
	pnrbwb5l7O3DlADLaqLv/AkVbemThN7NUa/kycMM9CTwN7jLgKTZ3sVVXZ8cpmThMzk=
X-Gm-Gg: ASbGncv+sUVJNbxbxp99/0o6ocpdgojWy43QwPmGtPe2rvMjLj1NxibnLG7Z54T520P
	NOKZIRkhzwjquU5KuLdBlQnqczi7GnLKlSSKF0yOGg1Hn9BMVt00yj7ai1EISPN+Dh3uTzrLZhO
	SKBDFnW2IdfJ/isEYmpdgjl+BuNNX10k+ZwkZCguKQRFFwJr+nJngXNockMiB4o99lCbzDoxF2G
	W98X8VYXNz9xvZNareX/jKa3AAJUaqFYcblWAckPQFBvESHxc8a7KVanVdEMFv7uLZaCM7rsh26
	s3f271mOIJS1ROFXWhtSSRSMsDP7NACixtHCTzJPU7/YfqiNmkTa75FxiBbr2xrvzkkXpxk+7hr
	gmrPfVnrCxe9+M/FcqocOTv6KtzoN0Vh0sm0Lr69b
X-Google-Smtp-Source: AGHT+IEOCX/C/iBLx623bOubuTqA7Kdn4TAgxaXuZzrmlCOVef2rZUF+MeuUI3aZvz9jOtGjq4uPMQ==
X-Received: by 2002:a17:907:96a7:b0:af9:a486:412e with SMTP id a640c23a62f3a-afcdc237cf9mr964877366b.26.1755496459172;
        Sun, 17 Aug 2025 22:54:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01ab55sm732429066b.97.2025.08.17.22.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 22:54:18 -0700 (PDT)
Message-ID: <b064e3cf-466b-49b9-a66d-399441e1913d@tuxon.dev>
Date: Mon, 18 Aug 2025 08:54:17 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] iio: adc: rzg2l: Cleanup suspend/resume path
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
 <20250810123328.800104-2-claudiu.beznea.uj@bp.renesas.com>
 <20250816145334.7a538a19@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250816145334.7a538a19@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.08.2025 16:53, Jonathan Cameron wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> There is no need to manually track the runtime PM status in the driver.
>> The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
>> already call pm_runtime_status_suspended() to check the runtime PM state.
>>
>> Additionally, avoid calling pm_runtime_put_autosuspend() during the
>> suspend/resume path, as this would decrease the usage counter of a
>> potential user that had the ADC open before the suspend/resume cycle.
>>
>> Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
> That SHA isn't upstream. I think it should be.
> 563cf94f9329

You're right! Thank you for handling it.


