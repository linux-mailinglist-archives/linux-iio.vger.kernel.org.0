Return-Path: <linux-iio+bounces-7827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228C93A512
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 19:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EA11F2322E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87306158842;
	Tue, 23 Jul 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LosormX3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52117BD5;
	Tue, 23 Jul 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756426; cv=none; b=ryKzkSKoDzUvwZ5YG96EZsekQ8eJ2HqeuZ308P3riGuqORtq5/QqRvuEcLOyzIWDP7EG14wQ8zwv7LypQEczBbZxOYjA7aE7Phqc5WqnHPkxAZbQA3vtlsaqpnNN1ihoWRWZYdFirRoAkEeJbArX1TXI9+aE+mMYPscyXLbmy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756426; c=relaxed/simple;
	bh=RSRCqxursOFG83xu24Rg/zY7XRMsTLA7GJR4OB5mqoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWN1IESPBxOcrPtUOD09t+KAGiQAfFzZZXdnvihNcKvT9f0+0qPPyg2+ejDoAPOx49CBeLT3WP0wLO7P71XtEBYSXD5Uu0/lxsppJwkPzxNrjMlQXApugSMfNpwsww52kXbL5mHEbyhoNzdl+x+oia69uF8fzZZgO1+svEZedWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LosormX3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427d2c8c632so41571815e9.2;
        Tue, 23 Jul 2024 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721756423; x=1722361223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLxwM2QcaETAwSelqwRu35+y1sReQfVO3Rz5RGIgoEg=;
        b=LosormX3zTieUyApDwZmYhkCIeb7clQs+huAU+lH7UNTSNboKBpGc0gcfYPq8WEvEg
         yyqIeVij7sUGUWsNuoOA+j8TavkkfhuFRMZx8/3Ami0EJrAcGNaX2u5yl6mDlWrkKseg
         TjlJOwcvHPrs44svOgEOUzfm8BH2x/aGz++kK/W9i7nJi2AYta6b+BXA3vaLIEWa0kI2
         st5QIiJkn6atzvX56HLiHmMmnMUL4gVMx1gpQxneOe5HoNuzgc/0QNgE5IK6copWapvl
         z2scsiwybR9UDKo7kca7SaFr6ZDUM/U7teR9ubIjuj1UzD5G2NJyWAAaMRFZPtF1h2vz
         3Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756423; x=1722361223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLxwM2QcaETAwSelqwRu35+y1sReQfVO3Rz5RGIgoEg=;
        b=qOtHbciawzJEwEEmNfKg942elwHSqh07VV37ZM5KfYV2VWEszSfNfi46AzmpfvIZII
         W/nKSgVWp7fmUUKu6QVccCiTz6vZ0+LDeiL2WXin0Yodk9kRju/wcJ5/tgKFHbfyW+qL
         xEqH8xYh7Nl2sTA/ZAOfF3/qJagT1i2TiXSiowgQCSl+F2ILy1hApWqE5eDt6aCh6i+3
         /RLnIHxao72O4H2kfIIUJtCU716pqW+CQ35zMrWwftjsL34RLytqZzKWrMg5gBFK8dZm
         EpuK+mRlcMerXg2/HXtKRkp9PRAwoL6976DHB+IsPeAYy/T3TVfzkJ4XIBNTBe5GxBvg
         XI+A==
X-Forwarded-Encrypted: i=1; AJvYcCX17G24An8wHU8KU/c1duRbloUQMYY1T8ohMONV6MSB+d4E+WNEy1d2cKbHM3eFKjG16EWN2+UlGeBpImP7T+QvocrgUXYyFFM6GBLvGmhGuPozW9wh7Zyv1EzW/ZPlW5EjEDq9QwkCjAYkZMHeQW45THj+PnesfVDb0AYVUTXs08xi+g2B8/jT
X-Gm-Message-State: AOJu0YxkwrFetEm+dYFZKxzdxplZFB53BlLiWvwL53FSPJ5BVbEC+QBx
	b1ouwxCQag4mwP9sGgTtWGDQ09mkSewr2kqQzelO707rEH4AWjD8Jt4TEbyX
X-Google-Smtp-Source: AGHT+IEaJUyuqn3nMKaYt3qxlDonCo2mG9R8c5t622wHjlD8nREtKHqgDlp+N7WPmsxY5xKcYNBSug==
X-Received: by 2002:a05:600c:1d17:b0:426:68dd:bc92 with SMTP id 5b1f17b1804b1-427dc53b5eamr74009055e9.5.1721756422914;
        Tue, 23 Jul 2024 10:40:22 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e42bsm212157675e9.30.2024.07.23.10.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:40:22 -0700 (PDT)
Message-ID: <f799b77b-ff17-4379-9b95-ab7d8ab521dc@gmail.com>
Date: Tue, 23 Jul 2024 18:40:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: pressure: bmp280-core: Make read-only const
 array conversion_time_max static
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240722151738.572913-1-colin.i.king@gmail.com>
 <20240722210111.49e66c4e@jic23-huawei>
 <abc73704-17c5-40c4-a92c-b69c571a006f@suswa.mountain>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <abc73704-17c5-40c4-a92c-b69c571a006f@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2024 18:04, Dan Carpenter wrote:
> On Mon, Jul 22, 2024 at 09:01:11PM +0100, Jonathan Cameron wrote:
>> On Mon, 22 Jul 2024 16:17:38 +0100
>> Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>>> Don't populate the read-only array conversion_time_max on the stack at
>>> run time, instead make it static.
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>
>> I'm almost 100% the compiler can hoist this off the stack if it feels like
>> it but sure, it might not and adding the static keyword probably obliges
>> it to do so.
> 
> You would wish the compiler would do this correctly, but it doesn't.
> (Or it didn't the last time anyone checked).

 From what I understand, a const variable that's not static is either 
put in register or on the stack since it's implicitly an auto variable, 
hence it's populated with the initialization data at run time. Making it 
static will populate it at compile time. Assuming anything else is 
problematic.

Colin

> 
> regards,
> dan carpenter
> 


