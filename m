Return-Path: <linux-iio+bounces-18940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C5AA6036
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF54A52DC
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A81F758F;
	Thu,  1 May 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="USFeTrTP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3241F12F4
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110965; cv=none; b=OBB2/XrFiWmZ3D06ATpl0mvDAVjC6hwZSk0pValK8523p9nZ5DqDhdsdsWP1llTpKz0t3/hY+LLGEKLcpIKBO4ZrzoYdLa9WA3Dl5PV8IZyl4NNxPLyG88yiPzxATgRMgnoT4Y6VpOKnCwuIEkE/lKFhUYF2G7P8+wYIT7PXmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110965; c=relaxed/simple;
	bh=Nj+Buzt0el1DKRoyQF913fIBNhoC13kudc2w1c3kB2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McoHn258IMkDkKzwcaoQmXjTtKBYcgt9DZlleaDqcDPG4ujBjRBL7HqQRhk0ndmhmGiHDUJCJ2wXJ94zC6/8Dk6euQs5z6TbdLuVY/ar/O1whTVGAxD4NM+tBXOu3RGgylSN7+dZwEIOX96QyrZ1J1DW+azZBLEhr9S5wnjyMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=USFeTrTP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c14235af3so611297a34.3
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746110962; x=1746715762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEs6umMySeLBJDEE1y2srlfEtA4e3pHxcXG4IeDmkZQ=;
        b=USFeTrTPkhdXxAd7WkSfn4OAjwOwVD2HAJO4uaUBIfotv1a6ORmVRaLKq+mHTPpNjb
         AEoz2Iy/2+FlFZXl8pYrchfyi8QWR7JjbZsWqApOcHQe/NXQP3UnvsC03s/DaLpMXTmz
         Og1MbSNTocB0ycEPs7zsE3FESJ6nlhlener3/Wvm8aexLwJln7ZfF0lgRI1VWscoTb4Q
         3VsKXbtDykX428vUQkQMViv0RSrRPQ5gCypp0qP7oNL/QXnwIuYtswelxcJ/BxXte+l9
         txJ3ch8m57nUbeQZ58OpnNwWCxLfp54wILc0ros1izps2laTAgrkK4nFlKdvGbwcDn15
         fr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110963; x=1746715763;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEs6umMySeLBJDEE1y2srlfEtA4e3pHxcXG4IeDmkZQ=;
        b=XNFycUAH8iRmS9DtuFMPxDiDTkZL1m8XEP+D5Aq+5o826YjmUSvkGZIopQLgs5w7dw
         MD/QpUR2Pi0m2et4136D+6yqI3uqvZ874flNCluJT0tlxnmnTRVQ/KXhaKrhlv2o4v7L
         2MnPihE5WFYZTvCp5NIH/RFXKx2Dgy7WCDClJsv0KgZIy/Kf6M7hSEMdt0Uz8OiWNpqz
         p8SOfpPZUbZ+6CBj9KTxmiS17qeIkpp631uChPl1kXIkblbNs50Deu6pR0Trbai79dWi
         p2gMkV+Kds7h53RJ20kU4GGqPw00qtKohm6H8VhBuE5xCSnwn5QOve7x24NxTGx6WUsI
         TnNA==
X-Forwarded-Encrypted: i=1; AJvYcCV08TJX1XqANgrYXYC3S7dQvf16fAVI/ttzGco3AtYTCWUtAfqi5hqNsp+71wmPuPbmE+AIdZnKjk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3NicvHcUYht2t+HKutKekSZ11TvKXfpQus6ep82gsRrRBPFH
	aDf9DGm8P/Mm5D15koF3562CogIfMFZ9/jNAJpYiw43ZUJTu8HQns4k6MCLr2ro=
X-Gm-Gg: ASbGncst7eFUJdAOouM5dyH8Z81ofhHXefzfa0HdEsvI9lEsbPvQFl/2v7mWlUY2xBq
	LKRFa7LY8NzwldN1W9Lraqu+cUKtf3Yn0T5/oeTnpVwCkmLKE0eGrVDucZekLKgkn2NTDM+RANM
	3ucfCQLHjo2FyDJE0goVxnY6vQtDN3NVj+nb9M5V7RiApuxRNYB1yFYTkvZI/a4xgmc+lYh8nO0
	Idu5QmoHb9jvadjn2oPbpDlryfeLZD6EvOjKinJTjOn4Y06ffxrPDyX0Kzn+Gs56gVfhYffg/U4
	AWtDzPeFYtU/ik91PNqLX+qeWsJJeXzjOdGCZUhkLIztegyP/u1KD40dJesi+ViBebZP11jItUr
	JN8hxNCVAz4BqBf/YgLx5e5JIBnn1
X-Google-Smtp-Source: AGHT+IG/sAO6ZHkviN2Ne0zUJ5m6cW80bEv+JtsGzgP47IWE2BU/C39yiIzIqJ5ZMSvTiqGOzJM5KQ==
X-Received: by 2002:a05:6870:47a3:b0:29e:65ed:5c70 with SMTP id 586e51a60fabf-2da6d167ea9mr3635683fac.30.1746110962642;
        Thu, 01 May 2025 07:49:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa126b723sm147495fac.49.2025.05.01.07.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 07:49:21 -0700 (PDT)
Message-ID: <df11dff4-7641-46f8-a604-8727918629c3@baylibre.com>
Date: Thu, 1 May 2025 09:49:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Refactor filter config
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20250425132051.6154-1-alisa.roman@analog.com>
 <20250425132051.6154-2-alisa.roman@analog.com>
 <6d0ff620-ec1a-4b17-9b5d-b9c48078271a@baylibre.com>
 <20250426133241.7d14c776@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250426133241.7d14c776@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 7:32 AM, Jonathan Cameron wrote:
> On Fri, 25 Apr 2025 10:43:29 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 4/25/25 8:20 AM, Alisa-Dariana Roman wrote:

...

>>> +static const char *const ad7192_filter_modes_str[] = {
>>> +	[AD7192_FILTER_SINC4] =			"sinc4",
>>> +	[AD7192_FILTER_SINC3] =			"sinc3",
>>> +	[AD7192_FILTER_SINC4_CHOP] =		"sinc4+chop",
> 
> Is chop really a filter? I had to look it up and to me at least it
> seems like it isn't even though one thing it does is remove
> some types of noise.  It also removes linear offsets (some types
> of filter kind of do that, but the affect of chop smells more like
> a calibration tweak than a filter)  
> 
> Maybe we need a separate control for chop, rather than trying to
> force it through our already complex filter type attributes?
> 


I was looking at the datasheet for another ADC that popped up on the mailing
list today. https://www.ti.com/lit/ds/symlink/ads1262.pdf

It also has a chop mode and filters very similar to this one. So perhaps another
reason to make chop a separate bool attribute that could considered a "standard"
attribute.

