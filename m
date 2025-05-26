Return-Path: <linux-iio+bounces-19917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B54AC39F9
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 08:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC99172E66
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224BE1C861D;
	Mon, 26 May 2025 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU3KFZ6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3511876;
	Mon, 26 May 2025 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241297; cv=none; b=fimHknM3GTsTbSMOCuVzuJlqB6ofox4zubm92+bu8BRQJwW4p93xTAaxdE6NNj++M1WBJp6h8Xfe8z22lNpw8+DfmSjbRP6OyAni6vSYKu8wC+dZvEfqpj7dkvtFbT/Ktp2/zCBsWwIDwn1WBdGvRdSMHfwIYKooxH0zWbVX5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241297; c=relaxed/simple;
	bh=94OdaYNEygfup+oQPYOAJ0AdhtbuUnh2LxuOdssRxBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SU6ECYGIum3tOjnB10ov4CkKmwAvMwyfqS/X9E8O+Hz75Q7zfPRbyfvpq6y+2S7MwLsuRtVnCkIs41hHc/4GjlYPHUgnL4decAiN3/My59OjCBjK9uPEkqC8wpBNWIGe9FEreqm0uWECpnpvRO0sC/fFsVFrfRt0M3hlHtODl7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU3KFZ6X; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-551efd86048so2613637e87.3;
        Sun, 25 May 2025 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748241294; x=1748846094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gI8FOPza4v9Smn8LowCF+XjFHXXgnLrt0WA3pq9kUEI=;
        b=XU3KFZ6XcC5ymtYjkwUV9MYSiuKjdo/jIdNN0k3rmSqW/rQPn4p2R477EY7RUApTJI
         4tTV4NvRmzKwC+mSOtKVzvXpVfM3+6+weAFIPoo++yvUWNy/5DmRj4zkDAIivo9VU9dI
         mJugV/Hw/IheNY8SkwVaSQePi6Rx7+PGItoUfGyqMssu8nYfZy/wgvTUf+3eWiN7wl5f
         m33MOEV8gBus7z81b20nbW0UkK9Vw/MPtGnQadwTEkbRZXKLvhMIRsmWPa8aYakaqttn
         ckGB7kzYQ2aI3YSE+DmB2FvdqhYTtiT4t4STVHORjcpIaARjdQVvOA4O3pqAktVcbznH
         dzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748241294; x=1748846094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI8FOPza4v9Smn8LowCF+XjFHXXgnLrt0WA3pq9kUEI=;
        b=nNTIlnijrNSkdnrqZI3Z4ubZREm23tKMJh4h3MiXfzKYYwL5xeRLFgsvcqZonLy7D4
         lCM0GTMSq0eXwS75VV2U67CBMI8Zpn4RMdlqeJaxLeHEra43g1r95wG1tEarH3rZImso
         ib1Wd/WB67IPLtXTP1TmxFFPwhcTMNJEya3Pj9nLMsJTuLl8mHPMfrpAnYCzKFDeT98i
         L+qd8ySHlY7QbzUWx+D2+NQ+OTkIw4gh30JfyJ8AhB60NOdkhYlmJiuEFSAsBpf59KO4
         NOTceqk8PqPejBY0nVv4iLYdlc4Cm3yd2WHAoB3+OnejgyLd2FRBcVS+rVH21yFawGZ2
         +QqA==
X-Forwarded-Encrypted: i=1; AJvYcCV5V9x943u2oQxA8h+7hUtxtrIBhB6leUTRmt+hO8s963sExJPbBBudmCJltDIqS8jNujMAJVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzICXm/JzYEbavM6tVx3l6AMVUtCVVyfrbvDgN/KEhRWFt0HF
	yEHFYra8wYfD6AA4tXSLlvt+aP+RmgNePl1o3ZpFaLdFCd0I6jJH0IT57NfbBg==
X-Gm-Gg: ASbGncuo8eu/P9dHFVYlAo9qEUFUGe1bt/nOFeXm+vzG3X63ZPgeEDrDLatXy9xicHC
	0An4nviDdPk0K8bKbIZqBKCNjHduU4SqP8scrWmFcUHl6KRkcJRqrgyA6Sk+WhUGIZnsZF53OHD
	fjLYpqrSBVPJsEqoy3DxRH9vD2xzVljHv01Vh42TJ7J+6TYTnpRDCn7ihruY5LC0m3H7RUKsxRg
	6Lo1cbeXvhkr8R6FqofUNyVRSo0JTSE0j3gdys5f7BkCJBBS7yx5GWWzVU/61B9+gbjQVt8IG4l
	oTVxbmIRoQpj6qpBB3htx6LCqRPJCFH432gqO7M63hLfApfp5qzCLkEHceqQkqjr825PHT/8Qzw
	wzOqbg0xekikqDoNlYwwITvFVhnr9flyH
X-Google-Smtp-Source: AGHT+IEa3xEE0v3l6txJ4zP2wIhrh20i1me7aOHvrEkNgUi0xcocCT9fDN0mCQQrvjFo4A6qcV+uMw==
X-Received: by 2002:a05:6512:159b:b0:54f:c33c:a5ec with SMTP id 2adb3069b0e04-5521cba3c41mr2235023e87.45.1748241293960;
        Sun, 25 May 2025 23:34:53 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702da4dsm4972136e87.202.2025.05.25.23.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:34:53 -0700 (PDT)
Message-ID: <4e058703-0d2e-4d98-864a-2e12af44a580@gmail.com>
Date: Mon, 26 May 2025 09:34:51 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: max1363: Fix
 MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
To: Fabio Estevam <festevam@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
 stable@vger.kernel.org
References: <20250525115546.2368007-1-festevam@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250525115546.2368007-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/05/2025 14:55, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
> booting a board populated with a MAX11601 results in a flood of warnings:
> 
> max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> max1363 1-0064: available_scan_mask 11 subset of 0. Never used
> max1363 1-0064: available_scan_mask 12 subset of 0. Never used
> max1363 1-0064: available_scan_mask 13 subset of 0. Never used
> ...
> 
> These warnings are caused by incorrect offsets used for differential
> channels in the MAX1363_4X_CHANS() and MAX1363_8X_CHANS() macros.
> 
> The max1363_mode_table[] defines the differential channel mappings as
> follows:
> 
> MAX1363_MODE_DIFF_SINGLE(0, 1, 1 << 12),
> MAX1363_MODE_DIFF_SINGLE(2, 3, 1 << 13),
> MAX1363_MODE_DIFF_SINGLE(4, 5, 1 << 14),
> MAX1363_MODE_DIFF_SINGLE(6, 7, 1 << 15),
> MAX1363_MODE_DIFF_SINGLE(8, 9, 1 << 16),
> MAX1363_MODE_DIFF_SINGLE(10, 11, 1 << 17),
> MAX1363_MODE_DIFF_SINGLE(1, 0, 1 << 18),
> MAX1363_MODE_DIFF_SINGLE(3, 2, 1 << 19),
> MAX1363_MODE_DIFF_SINGLE(5, 4, 1 << 20),
> MAX1363_MODE_DIFF_SINGLE(7, 6, 1 << 21),
> MAX1363_MODE_DIFF_SINGLE(9, 8, 1 << 22),
> MAX1363_MODE_DIFF_SINGLE(11, 10, 1 << 23),
> 
> Update the macros to follow this same pattern, ensuring that the scan masks
> are valid and preventing the warnings.
> 
> Cc: <stable@vger.kernel.org> #6.12
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Removed incorrect Fixes: tag (Matti)

This looks good to me now. I won't give an RB-tag as reviewing a change 
like this would really require me to go through the data-sheets for 
these devices to understand the channel configs - and I haven't done it. 
If 'acked-by' can be translated as "In principle, and without deep dive 
into the details, the change looks like a right thing to do" - then feel 
free to add:
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
although, coming from a non maintainer/reviewer, I suppose it isn't 
worth much :) Anyways, my comments are fully met :)

Yours,
	-- Matti

