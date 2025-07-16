Return-Path: <linux-iio+bounces-21729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF268B07E51
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 21:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48EC3ACB9A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11D2BDC11;
	Wed, 16 Jul 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="e2pQCgjI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0126B97D
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695113; cv=none; b=FGHw0XMSdKBzlwW//hh3NueVY9rhSaB55BFWN/RPrs0BQzQ2gbLHU0aaRucpo+HflPJgFShxSvMVM8os9uJUa8WbIrX/SQ23cOgAe/AJ/VOUpzLmzZ0Su8kCHszvX87mXN5bcAH/2ugnNn4hvlnMiF8ETyexgqYUF/ZWEBjGPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695113; c=relaxed/simple;
	bh=RGkOEBpqICnvhmeOYzzN5GVgVhT25gPV8lnMMG3zMmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+EEZXfqSp0gNEob0i2j79mi6dy+E0OI3TlIgxDqrk8YZUBT368Gzf7dPrrfj/YNVcSf5WaXF+dDvONFdkc3JZ2NP/OFP2Zovbpja+G5+I903T9ApG9qCKrv/Ql67CTxGdWpUv00VixATFW2ZKsBdnI37DarDtvVTTrC364QVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=e2pQCgjI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so36103566b.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752695110; x=1753299910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fu3ULFheObCECo8wTxTWjnCgZuWUy7rpHr/QaDan+q4=;
        b=e2pQCgjIG2ZR3lbAHArPfNWZ69KQzr7SvHoEbeLgeCj3Y3Z5a/ykEpILgUN2d9EHso
         aTHYl3HhcSsysYSmNRyphvSuahNTd0cu31UsbMIl6B1WVXkSQGzwI7VdOmE2xCsH+D0Y
         1JQ2WXW5ZrpwN8zUuSSjB0bzESEURjuW5vNbSPGs9vK/c5O5oyini+efrMOvTkSbPlpr
         h0QjID9ORPnSI6CPagVW1INyr5OTE6HYyD2cFICk0d0bTUhpbMnx/wWCATDSXRKHvlf0
         c0zcrAt/84kOOMiMZffOlA9gsrPxYN326Ko0lPHje81/KH+YN7xaQS80e4syUK0Q62Z+
         QEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695110; x=1753299910;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu3ULFheObCECo8wTxTWjnCgZuWUy7rpHr/QaDan+q4=;
        b=fFd0DcAj8O4Uh+GXVu9Qif+WDLCBywdu7kDAmnG5pxwK10GMltxDIwggPMJXV1QEHI
         1NJkvqT+Q/54HtE5cB+KM/ydw8oquM2MFDAIO9HK89CxvTYMbYv8TNqHuBRfUSMHhshj
         WUK7FnbacQKxU2PLHtjmOstQN3tAdsZIGkVgUqubBYsUI1kM5uj+FcjjTj4IK1jzFfp/
         qk/ULu+JwZveKLy1NZbHh012RVxFbKzI4ER2M9i+P7Eh+34OAHz3mG1D03RDdTl1jW29
         hORGPvWU4pSjURtsBb1ibglaLX9Nbujl8Q/loStThZD5asu6Nmxq23/9xMO1p3TEQ8bI
         M9ww==
X-Gm-Message-State: AOJu0YzKFwyU+d3/VxYZuXld1lc3BexXgQHkd7zPN5uIgA1LVnoaH/1t
	VyocFsXF0jxbdUIZFlgUx376oYoTu4h3Vr8Af37pTzHg3pkFli+TdMQpSfxfPSWO3bI=
X-Gm-Gg: ASbGnctbxAnnx9YskSWeo3ii/CsTCRospDQmxam6972iRCRwR37YdVGen83NjjkWJCl
	7jn7CbuW5UxaILTCqai6bvhmIXBmBSO67bzFukdYLvmQHXaqns5SuJwJb3Gj7Z0Bo7A35xuokiJ
	pBmicGiI9BB96RrE6Gpw9COTS6GMXZBKggdXSv4z3AvTpbtsCrhaA7kIt9OvGEnD9NU31HkEhRY
	JQ1vCVNfhyfKrHQw4xeNObYhG9l1Wr2poyfkTZDPnrzRihqIdF1TZKx96BIqzPAoy+l81l0isRN
	eHJHRk7cV14V+qF9YwepPfV+ZfjQWm5B3gAwJC4BEkOdK413pReNseYeWMJqIwbru49PIiIDpm/
	u9VakmEtZpIvm9zWrBNKCsqceovvQBKjWtK6Yv2T1JBuT5OAzcgm/O2M/6tq3FUZW9ImxtKgUbQ
	==
X-Google-Smtp-Source: AGHT+IFc3d+mTsUWeTNd+/oR4C/XzLatVh7VB9R1V1EfsKL9AIyUZYvShKQ/9DHyriukFz5fMMVzqA==
X-Received: by 2002:a17:907:3f95:b0:ae3:4f99:a5aa with SMTP id a640c23a62f3a-ae9cdda865fmr347230566b.4.1752695109860;
        Wed, 16 Jul 2025 12:45:09 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a864:eb02:add4:d64a? ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a42sm1221762766b.27.2025.07.16.12.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:45:09 -0700 (PDT)
Message-ID: <018bf0f9-e123-42f9-8817-bf1a597f1f2b@mandelbit.com>
Date: Wed, 16 Jul 2025 21:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20250716192231.30337-1-antonio@mandelbit.com>
 <CAHp75Vcysq584=nVHEB-PqKBtTaL+CCKMEdkM_X0wNOaYzeU=w@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <CAHp75Vcysq584=nVHEB-PqKBtTaL+CCKMEdkM_X0wNOaYzeU=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/07/2025 21:38, Andy Shevchenko wrote:
> On Wed, Jul 16, 2025 at 10:22 PM Antonio Quartulli
> <antonio@mandelbit.com> wrote:
>>
>> In inv_icm42600_accel_convert_wom_to_roc() multiplying
>> `threshold` by `convert` may result in a number requiring more
>> than 32bit.
> 
> 32 bits
> 
>> In this case, although `value` is 64bit wide, the result is
> 
> 64-bit
> 
>> truncated because the multiplication is performed in the
>> 32bit domain, due to both operands being 32bit long.
> 
> 32-bit
> 32-bit

Thanks for highlighting those.
Should I send v2?

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


