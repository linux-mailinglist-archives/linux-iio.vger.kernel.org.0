Return-Path: <linux-iio+bounces-13764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A781B9FB2FB
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0399A1881F68
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274771C07FB;
	Mon, 23 Dec 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fxU3Hqaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDD1C07DF
	for <linux-iio@vger.kernel.org>; Mon, 23 Dec 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971622; cv=none; b=RY86N7xtvITYxt7bAy950CmvAThhmXtIhB97aBJzeWComC9/b6xNo4eZryEKrnoSag05N/4xviTHP6jSeI2ZE8H9zoYwvfiJqBaawOf2RF9BDoRj4hfWVZJlA0xjWxKs0HqDhwtRM8WkTRxv8pEMPiA35up6hfu2J602aNBBguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971622; c=relaxed/simple;
	bh=gHp/getcUO7eTngzfX1tPLqe+VFz1jDhuvKQASC1t48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyBIOUOJtjO2Lt3GnCmG3AE+pi18YDlpU16LacJ5X3+OfDchH7tmdZFRh+1fcBWNWEzP9EHdmzhYri7SKDLqb2dwy7KNk/vCS5S5+vZI0tNFF5tsh07l95JXrdn4BGsxdxerUyzsaqCl7A3/vnBtUUDSmO2CsSE3JfR+ms7Tz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fxU3Hqaq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679eacf2c5so38152241cf.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Dec 2024 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734971619; x=1735576419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SA0lbMvAXbipK9BrrMsVmdVVOF+CvMmuegNIZAWTAw=;
        b=fxU3HqaqpJnh2CSOiIrhWoEbcZ0VH3juVGwQf6Blqpo8iqujjJY3INZXqHSXwrS9z/
         f9vfmlDsKdB7f9qbsiYtye5V0TNP201gJqSisXlDXMto44xAgMhDCD4vcH/aYrDe58Fn
         np3hZPnzpJCn85+bmgBbWZGDEhFBqQREgpBAg4WpQHaZymhEbg14LVvzcu8WQlDPMe7d
         WWGTnFchWZdvNbkenSX6u1IuugwkFczu9vWcPx9IMDLCXplOdKjlhB62Ut92+JPakGAt
         3A+5ZbgGN99eOFJo2tFoIU0s/xb/3QZ2GPS3SZz6AzLadq8ALKGt78pqapujaFS5pGX3
         63LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734971619; x=1735576419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SA0lbMvAXbipK9BrrMsVmdVVOF+CvMmuegNIZAWTAw=;
        b=NGH/GWWddzCVxTI3unpu1pgihaHu0ENK5NPJ4jc7D/+GgEm+SrF/pvTMpmFOPEg/mp
         pod7N4eOGFHMa99tAD4AVYbd2wwToHCzHowNpM+aXeg9uAzZ2wWfyNlVFwkt3bqkavIv
         8wh3TDrukKfQECi/whUmFP+vapPaLBKTm0zGXs6agwjn6PLzrcpLKghCetXRjDOaxzS3
         X+GA+lpOuj/ZeH0cJdai+MtEWpWK4BliZiZFtCR8CtsSwiUzXoDFQkcKLV19XahRf3++
         ZXQnhfprCXrLbuXySlBTFIpANIDv+haZxup/Ws5vyKWQ976SdigPAwlKn40+q/59D24g
         iGOA==
X-Forwarded-Encrypted: i=1; AJvYcCVv5EeN2DWrqqoAMqK51W8tgUFXh5Ecj6gjZpZvbk6BqKj3RnCasSu4byycInrc2OdUAc+zeg1jA/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8P49GQZVTyK05bnpJX0An2hKqLpIk8WSnl6fegzn4VR8fBqDU
	SW0SdKvXH22kqAn3yDdGS1tbGx5nXC84v5AUq+DBngaQIdS9ty28jTqB4FHxAkA=
X-Gm-Gg: ASbGncsyaZlwM26m1x1BL00SVNSQh/wp2053XJ/GnMsN/TsT1wy9qfs4Y7UHdwF9BIV
	C8C7rc7GG/GHNNkOaeWUoDTkcblmO0eJnytiPWTn+M57dIGjXQIWFbtWsBDWz9FJ082oJFAobxs
	k7iAmO72qKL7C5nhGYuGvYqcTke54Z/l3aLQWxDas+Rute/t9QsfQd0YVSGb7p7sDdZHrQDe2Gw
	SAkUCjNSMC/SPlFqinUY2CzEYZJe6EecZZ7fvBLiduKtBsApWrXVzNS4DMsnCch8SOf/3RmDJCF
	4no2sxFuuGZ5mJOi9Raddlpv
X-Google-Smtp-Source: AGHT+IEpUycPZNs5cOOouNZJTjwM+ffbSpYr89ZBbzgPq6xyt3OVF9nnjxtO1B7bzyodulThYgS8QA==
X-Received: by 2002:ac8:5a51:0:b0:467:b649:6a44 with SMTP id d75a77b69052e-46a4a970385mr208293661cf.40.1734971619282;
        Mon, 23 Dec 2024 08:33:39 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb17a2dsm45116571cf.59.2024.12.23.08.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 08:33:38 -0800 (PST)
Message-ID: <fe046df1-1868-4008-8999-97a9d0b90b58@baylibre.com>
Date: Mon, 23 Dec 2024 11:33:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
 <20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
 <20241219161301.3f708302@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241219161301.3f708302@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-12-19 11:13, Jonathan Cameron wrote:
> On Tue, 17 Dec 2024 16:47:28 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Add support for the ad4695's oversampling feature when SPI offload is
>> available. This allows the ad4695 to set oversampling ratios on a
>> per-channel basis, raising the effective-number-of-bits from 16
>> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
>> full cycle through the auto-sequencer). The logic for reading and
>> writing sampling frequency for a given channel is also adjusted based on
>> the current oversampling ratio.
>>
>> The non-offload case isn't supported as there isn't a good way to
>> trigger the CNV pin in this mode. Support could be added in the future
>> if a use-case arises.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Hi Trevor,
>
> The clamping fun of get_calibbias seems overkill. If this isn't going to ever
> overflow an s64 maybe just use the high precision to do it the easy way.
> I'm not sure you can't just fit it in an s32 for that matter. I've just
> not done the maths to check.

Hi Jonathan,

Thanks for your feedback. I'll look it over again, do some testing, and 
see if it can be simplified.

Trevor


