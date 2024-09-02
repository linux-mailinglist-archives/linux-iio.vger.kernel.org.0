Return-Path: <linux-iio+bounces-9014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C21968BE8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3852D1C22B4D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3A19F139;
	Mon,  2 Sep 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oboYHzKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C601CB53E
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293816; cv=none; b=uh3m+9DmbI6V/xoAUcHu1q0Zlaui6fYSzFGmOzTrYApfUHfjsfv1hmRUUU6U+oZRt9y8dycO/5WyfquOSNM7kPcVscvyTdMWYmSUDH4WoY1hdHqg7O+41f3Xm66pQV17wlF7jURYJuI3dq43fxhya8+g/h5HHhcgsrRVk0EZN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293816; c=relaxed/simple;
	bh=279AYoB6M6LUfQWrroj3/71+NSd4D3D9x57DTZOMsl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxntHNtcV8gvpSbthakNvcGBdu/jTJHAzG+l3cibW6oVfpftQeKbEKpjNwMINbIA9yf3fkYz7da1OX4WQVg6Nt+onZVgFPfVf+Z83z9kc6xSXcmFq8F/C6Tjv+DTI2H+YbHKnPpLGksrwkayNNYkRW48vxK9qTGn0pnjhxPY1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oboYHzKE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bfb50e4e6so20240795e9.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725293813; x=1725898613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8h/EGszP6xFdvE6sZAaqQlIirsRwUlWC1I0F8vKGJM=;
        b=oboYHzKEXDObutJxWvlJ0KXsvupktBkpbbpaW8yVC+AeNBh96phKjumM0oKTGB7CYh
         1NtpTkr44mwUWx2VK8khLz9TnvnhbRpHuQM4XCswGvEQBt9zimoh7ORn/G5ZlWSbKXav
         wdAkl5PfSssyh9uWxGzTVLkx2pI+XLDewUQvV6kyKFTU3OG0NHQtjXU5ppt7pTR2mya9
         rDvG5+wfxq4KIY7kIuWNrNMt8P+GsM5oNHIuUIE/k3kk7RBASsZ4Zr2EIKdAeweOXQOt
         pWgAj5ZGqPBsZJZlU1d4+asETGFKu8oaxVkMt/LE9eFokGsK5dLbS6ub2VlnbWjezOh0
         qoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293813; x=1725898613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8h/EGszP6xFdvE6sZAaqQlIirsRwUlWC1I0F8vKGJM=;
        b=dYUDEMSV0ayDnrW+iBMI6GFl/UK5ew/tI84u4MKgTnZYWXE/f4SOUrw+inPouETbcv
         3cwToKTO5J7+pf1VG40USLNgcZO/rQvTKFNmy4ANrBLbuxjQEdezGSMlY7CEdNoF4nOD
         5EoK6HiZu64REj/oUVRhDAzczhvQ2lwE+/ZasP6s5V2v8fkgxODBwie6AJ6EH1wb9oBn
         ne83v28kX/sQvXVvv9jUdwDZi4yFycSHW/zSQyhXSUTPAsRM2kvoQPWgjzcZsijtlXmr
         H7tJl7Ux0Km3oSpE/D36iBvKZuI/VeP0UKyDUmJqk3pzPqbPePs4hXfy0NYLQJUvx1ei
         a1PA==
X-Forwarded-Encrypted: i=1; AJvYcCX4dN29/NZQAh0ZuT4S06t8u7A8LfcHI/eFegWjAU7fu8trp+cra+8uwJCXx/88e7p6OunuNFhmhag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+sT3BCAhZ+5Oh5SZ6lTfoab2a8fB4c2ryuLdrUR9M7QS8m/j
	LfCmRfLoq8EBlCEIBWLux1xaX78Y9vopa44kl2ZlxiY1HzORmhlQokK16Ku5oHY=
X-Google-Smtp-Source: AGHT+IEmOkVDfJIoDWZjj/iaAv98BJrAju1GPOB28FkfzY8GNSwwTPs7KU6TSWiaChCcdpz0zMtN7Q==
X-Received: by 2002:a05:600c:4505:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42bb27a9ca8mr116220405e9.28.1725293813003;
        Mon, 02 Sep 2024 09:16:53 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb273sm143693955e9.8.2024.09.02.09.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:16:51 -0700 (PDT)
Message-ID: <b305c86a-1dab-41ef-ad04-49526389dd97@baylibre.com>
Date: Mon, 2 Sep 2024 18:15:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-5-b6da6015327a@baylibre.com>
 <20240831124847.5c679e55@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240831124847.5c679e55@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 31/08/24 1:48 PM, Jonathan Cameron wrote:
> On Thu, 29 Aug 2024 14:32:03 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
>> is removed. Variables (arrays) that was used to call ad3552r_field_prep
>> are removerd too.
> removed
fixed thanks.
>
> LGTM

Regards,
Angelo

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


