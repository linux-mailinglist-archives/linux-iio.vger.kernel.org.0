Return-Path: <linux-iio+bounces-22259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58893B19BEF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 09:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DB63AFDAE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66B230BD2;
	Mon,  4 Aug 2025 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC/YnefB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0B1A08A6
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291408; cv=none; b=jJHc5gKrrWFeYSroz5A3FGVxr/j4hNbcMhSKzQ65B3pPMEZxugKYUo66CRnqfdo0wmEioSMToJqcmt9nD151QvGTm+YI2cpPdLepEgRY8HMrp1ArlRvjYeLSj02km90MwzwOEEUxlRsFU9bIFA7e80jJMxPpX0fMvtukawZTrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291408; c=relaxed/simple;
	bh=uJNl6ncRdJ7Tz698Y/QhnPA1WCy5Vdxn/cpAEZjjkOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EILHY02DrxwjnM9EOkSjEwNMV4OI5Mn1M1U6KNf0eldvBIKsgh0JRd9lQvSwlzAYCaRw+qT3HFXuPd3Pcbd2x+fLUg/c2u7BB5eTSnHRwBYxwg9Cg1VADeZwm7+ckwKe+qdM+Ci7HO2pUDCycFGAbNl/ISgUBqc5mAKISYKJDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC/YnefB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ba26abd62so859706e87.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291405; x=1754896205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Kcd4Zqbo6PlJr124/+YzVc5TUMum0fgVHMMjXLW1QI=;
        b=WC/YnefBudDmHS82yE8XR1eIwuL36H1O+Xf7PmuFk4o1brEPySqSfJGYsdcp2ZkGjI
         lY9lfwtwoQ84KL6f0aT7oXnB+BEuaf6GYbFWRM3wZGrKztzVF0VC3WQnYLb2jrjM4z+9
         9xmizAqKrE/GuytWZoav0nEgUHeuMUaGQ6Mw0szY0Cx/V3KSLwGSlQWIxusbhf1pJksB
         ZSfmcwvNrchV6z1VJfUx2hPTjOWQPI11FNpRlaa554Ru9wHrs0sTIsAGQLnL2gThPCDs
         7ElN3C37DjlL7pWB5lS1jY0dhvDy2fRSNPLpJjnRYKy2U1IX6lJLVbD1uCECnHdrKZDy
         SAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291405; x=1754896205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Kcd4Zqbo6PlJr124/+YzVc5TUMum0fgVHMMjXLW1QI=;
        b=dWPXPefPdT3fcbZ3RgujWtYJAw8XKmA/zjpZ6dZtboTLxWuBToAk0bHOw8LtW3SIl4
         JkZpcZlf5f5trwZ3DsRYLNhx8/+0uIAdYmt8zM8gwwGFFwOoVmu2Zjb1ontz/aQdBUzz
         hjDZSgWuFCkSRSXuKpb1J9LgmQLpaYuLbIbTp7vj7XaJsh3vGH1YrkxcQKzW5VQXn8fm
         Mr0Du+7PxELlL5cZE1ZQawGy/JPsTi2LkybGJrtwJqlBEptvBBa2txuHZCoXjFdXezIi
         xO7ip29rtvylIOu39WYzcxPlwg+v/QLKjGltU5BWMAI8tFK4R8ZnUV8T7zqaBbDLTUI1
         FU8w==
X-Forwarded-Encrypted: i=1; AJvYcCW/5/npa7te+8lbE5ZFG23ZkKNUhD3EzuR9ty9zWOh1YkDJcR9QqshC0U80zvOO+TMPAa1NYLoHgeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqbTMIRVZYnrvlSh5bflPzn1AaweW44ZFOB1kp1ONIE5RykJD
	OOTDC4/MacjJ3D+DPcYj90drLt1g6rW98tgGpBiITEb5N4sawQYHPDRX
X-Gm-Gg: ASbGncsw8k2ct/ey1lkzbmEqLsmd1s/VzvO9XOrTwBRpNQ21MLfCAKE6Lhv12bT16m5
	Vz6PIlZTGFlasp9mUi0N5vtggczBgS8XD2Py7M3S/0k7zoOXn4Vi4sxbnlQfEoyx/8kOEiKLurj
	Q5A4pxMDQMPxvsfJ8mHrp9NDyJPofBOcwo6V3JeE9dkh0/VBo4pENUM1tfFPQl4Rb+XqgQMDPif
	Y0tS6LTrpPNUHWYuRt/CTVkE/NVRTESdy/kR8TQ+e2FmFNyj/zJuvpGExr0Z21R/xmg6EJ43p+Q
	5kc0QbCqeja0jetHh4mDcJYjK6MLoPAW/pSyTu+lyNFlCcNEYTj0uZR0HL54UOOjdXlj309zMm+
	kSAtHqH6cWNKDi4ExHJUhDjYJk9KKUagzfv28NY1ocs/Pu4EngUMSDCEC0ud+0pTAJxysdSVREF
	1T4HCkduTGfsg7HQ==
X-Google-Smtp-Source: AGHT+IE5I/aFVaMEbWwkjQalRFwbiocmC7j9qaG9JaKTAj9ymopCUElcuhkRQOtIt/HuSQQDY5GtHQ==
X-Received: by 2002:a05:6512:234d:b0:553:d702:960c with SMTP id 2adb3069b0e04-55b97bbf7a1mr2345114e87.56.1754291402979;
        Mon, 04 Aug 2025 00:10:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c158sm1527365e87.14.2025.08.04.00.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:09:58 -0700 (PDT)
Message-ID: <2d5a629a-3e95-44f6-ab8c-80894013b968@gmail.com>
Date: Mon, 4 Aug 2025 10:09:56 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] iio: light: st_uvis25: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost
 <astrid.rost@axis.com>, =?UTF-8?Q?M=C3=A5rten_Lindahl?=
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250802164436.515988-1-jic23@kernel.org>
 <20250802164436.515988-12-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-12-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/light/st_uvis25.h      |  5 -----
>   drivers/iio/light/st_uvis25_core.c | 12 +++++++++---
>   2 files changed, 9 insertions(+), 8 deletions(-)


