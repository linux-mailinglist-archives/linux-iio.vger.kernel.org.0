Return-Path: <linux-iio+bounces-15071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B1A2A593
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 11:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31487A380A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1222655A;
	Thu,  6 Feb 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJqjs/s5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33988213240;
	Thu,  6 Feb 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836581; cv=none; b=mpZoCe3MFnRctp/ID/6eo9g34SBqIrz48fmjj0eROuK/Eh/W617IvOqurGdnae6F5Qy9k3z1jQ8jaCxva3xg9thvtHj6zVr/mkzN/Tq8yjUnoBLAR/TsYvfjXFvbBO8C+7Fo7P4bV5HkZIy1w6apuaoVGG11FyiN7VhagQHKvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836581; c=relaxed/simple;
	bh=7eqh7K858NH1AZrNBNH9wQrXQPBI8B/6RmUW1r2TAcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9znx17xy551BBhEiEHRJE3J29yVwOQMqud3y77fCJDGB5+72+YaaoZo+1KBdNeo3otslleAehw9hlE73gDibSRyHiUWPmYR+w7F4s4p4PHBbCsmwuZb2NlLUA1DPsAc3lzHDeq/l/9pQbIfqiDVJFtopfyf7sr6jxxB5W/7ESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJqjs/s5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543d8badc30so894729e87.0;
        Thu, 06 Feb 2025 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738836578; x=1739441378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3J7Bg0TmAUJrOo6sonChdz6dfz6pIJ+CpqIwcnqSIEA=;
        b=QJqjs/s58/uaYmH3tIvsLFnrI90KUVSGpX2DD0NvD+rT32mYG51O8Q+ivpRx7r4Rq7
         sRTRo0qF5lDzDljoehxVIdztat4ACUQkzC5MIV6Dv5VwLGWcugsJNgxwKAWcf7uxO821
         9OqJ4w3YaVWqcnuFWAWnxYmSuU+YRcNnP55SuOaOlveGiVYSKNqOVDyIVZoW5o2vq9Rp
         hviqZqpp4f4ti4NOemPy3JDddocBSExjtlojvr4Mr+ONdBXkAH+52lROGNMajOFNc3Mp
         ppIU3YRET8aZSznEWZQsjnvt0vXCkCFndvJIKJDAuDQu/3JEZ9R3NaAjqqEaJnmeoGWJ
         qSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738836578; x=1739441378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3J7Bg0TmAUJrOo6sonChdz6dfz6pIJ+CpqIwcnqSIEA=;
        b=hx+bQ2OOqL8Q0F6U3Obp2MUs639CXxECxYvvRRSlkoUEp/q048A4wSNVOw0APP1pRi
         tVqSgWW6Wn16LGiWAy5pSFS6zBcrbxNu78rOavX3PBIAByBGR1ZTh6MMJnF6C9unXLW6
         MB62KFFKLhxKTqOwxs1k1Lf4uuzcY/OIjUGiUetYttiRnTK3V1z+tpb+6Au1t6pmClk3
         rWAdsNxr5Tijfk3TBhSh8rd2y5h/ckKnN7ChwdraToIi/nsisyVkQ1chKvTSNlVUpH6y
         z9xxRqXYRy3JKsGSHuQnnFJsSXzbKzS/M+4iJJhKiX1K7Mj60YtvoO27AX5ZdBnADlIz
         A4dg==
X-Forwarded-Encrypted: i=1; AJvYcCUUEciFFBExJsdGEU3HPnE+kwRi9JKcmBbPNGgkpNxIPr/+WxjTNVq8dsOaBCt3qmXYq/2o7E93EAX3J0H+@vger.kernel.org, AJvYcCVCIyRVfFPSu31eiPySpN3hSOTMzUaE124Op4LlexCDMgqYBJ4yXuPQZYcdhrwfvhZjmC56MYxt6y9Atg==@vger.kernel.org, AJvYcCXHFGJz2wIHBA1HzWMvkx0vc+1Uo+if+kgxek9jW6aQKYLCqR5pkiSs8MUqbmLqsLO7mRd73M+GgzcQ@vger.kernel.org, AJvYcCXObyFbbAW84lPoRYWYTH2ax/d8cn6/A5Y/1IqAHSRCo0+hqAQPUkX0TLsMYF8bGnz2/LhIUJsoqObB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5BVk+BVCDsIs02wUoFXFLMHxVcVCwa6dqF5zLpDZAqzV7J31
	bvLya5HKi3Orest9yEBmVQ7rlrW/MJ0h1+5BVBpi4bCIiPNVy+00
X-Gm-Gg: ASbGncvkDQGwJxJgZdwMn6rlymJ9yh5hAotqnza42TIDClsnLZTpLSQfyE3jhjVJ52S
	b07clC2WkkzAj62r96WFnrpd14QxdDLA49zGzTXjd9+DRhs0z1W4+LVLc5VavopHWJBEBMgMG66
	FyLAqxgKm/JVVdNeK7ZwYin++lsIRXHZ61FF4r/Jukdwan28fQpPgEpcYTZVadB472+kVfFkPC6
	etWLHhyoruiq1NFC4ICdc2jh//QQz2PIBGy0u1hij/CpAfAYchedTOleJQ8hByfxfR5JwmGARA4
	AzZg5q4QwxVxQeMDIze9gZeFyu6I
X-Google-Smtp-Source: AGHT+IGpHJYo74+wxQ1D3J2yvrx6IQcEeGEY/UGt8IL44DX+DiZjLtuOLLwZrbFXWEFrFRiTbVt/Rg==
X-Received: by 2002:a05:6512:2207:b0:542:214c:532 with SMTP id 2adb3069b0e04-54405a19d21mr2153436e87.13.1738836577877;
        Thu, 06 Feb 2025 02:09:37 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053ed63sm93621e87.41.2025.02.06.02.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 02:09:36 -0800 (PST)
Message-ID: <a52933a2-8b87-4e49-a346-91266fe3b675@gmail.com>
Date: Thu, 6 Feb 2025 12:09:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] pinctrl: Support ROHM BD79124 pinmux / GPO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
 <6867812e-7269-4686-9fc2-55afd9fa91bf@gmail.com>
 <CACRpkdaP6biD8ueeezBDw1P3LP6ARoJw0zfkmxC-QKK0fw79YQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdaP6biD8ueeezBDw1P3LP6ARoJw0zfkmxC-QKK0fw79YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/02/2025 11:39, Linus Walleij wrote:
> On Wed, Feb 5, 2025 at 2:40 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> On 31/01/2025 15:38, Matti Vaittinen wrote:
>>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The AIN pins can be
>>> used as ADC inputs, or as general purpose outputs.
>>>
>>> Support changing pin function (GPO / ADC) and the gpo output control.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>>
>>> NOTE: This patch is not properly tested. More thorough testing is to be
>>> done prior v2 if this pinmux approach makes sense.
>>
>> Just a note to reviewers - I dropped the pinmux from v2. No need to
>> review this any further.
> 
> Why? Gave up on the idea or want to pursue it later?

I just realized I should've shared the link to the v2 - which may not 
include all the recipients (because it no longer touches all the 
subsystems - and the get_maintainer.pl probably reduced the list of 
recipients). So, for anyone interested, here's the v2:

https://lore.kernel.org/all/cover.1738761899.git.mazziesaccount@gmail.com/

I do still appreciate all the reviews of the v2 even if it does not 
target subsystem you're specifically watching ;) But reviewing the RFC 
v1 patches does not make sense because the v2 dropped a few of them.

Yours,
	-- Matti

