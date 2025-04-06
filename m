Return-Path: <linux-iio+bounces-17666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0577A7CDF8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3894C3AEC3E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC71A5BB8;
	Sun,  6 Apr 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="lcedeUlR"
X-Original-To: linux-iio@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1642069;
	Sun,  6 Apr 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743944945; cv=none; b=iKLUYTl+HW3fblMwoLXEi/vYu75qS7eSTHMTHO21ZYrw2p8Q9w8rKrjbixs2NS2liucuOMZqBC1dMjDU/JKPGuQLK5OoSi1FS+lALv+tJip9yHScxq7MATvw59bDD9jIKdMIGEYI4rrS4lbLmz7MjblWAWbDrqzTmheDDYFFruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743944945; c=relaxed/simple;
	bh=nP7dzAyLTdUJ12o82sA69ek59Cqdjt+o0paJYcMWOXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7lYF+j1QKR/UGG9bZbbjUvvYULc0S/X01U44r4yVj5o3QSjP9roh971TGLLXj71Nf2QI1ZgPnNiKoawHehGgSuKExcbkgqBOEfA4nQW+0pp5uB0szF23+zw74lKyX/XhvZ4pVH4cdDWxmOYpU2Z6IbuMGV6OaqyoZeFlb8viI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=lcedeUlR; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id AE946166D55;
	Sun,  6 Apr 2025 15:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1743944515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/d5EbyZVQvwDlkHqxSACSqLg/KWI4g2IQ4NBcRqHOqE=;
	b=lcedeUlRnKhNVmiN0Xz9tzSN484qaQpn6IKyeDty0ZMW+RBaCnRkXMxfg+frEnyEiFtbQI
	P4KmOpOA+g6v/UFZknQgHgSxn/UXr/Ta1EUPlYPoEA9o01IYydxBNbGIiO/EHjZaw9goKJ
	DeDuAbZ2/d88yn/mhQXnEjVCCGpaNY8=
Message-ID: <eaaee7da-f068-4407-8795-facea347a0c7@ixit.cz>
Date: Sun, 6 Apr 2025 15:01:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] iio: light: Modernize al3010 and al3320a codebase
To: Jonathan Cameron <jic23@kernel.org>,
 David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
 <20250405181210.5e7a181a@jic23-huawei>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20250405181210.5e7a181a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/04/2025 19:12, Jonathan Cameron wrote:
> On Wed, 02 Apr 2025 21:33:23 +0200
> David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:
> 
>> This series aims to improve code readability and modernize it to align
>> with the recently upstreamed AL3000a.
>>
>> Apart from slightly improved error reporting, and error handling
>> there should be no functional changes.
>>
>> Module  before after
>> al3010  72 kB  58 kB
>> al3320a 72 kB  58 kB
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
> Applied, but with tweaks to not add print messages as described in patches 1 and 3.
> That meant a bunch of hand application was needed for 4-5.  Please check the result
> in the testing branch of iio.git.

It does look good.

Thank you!
David

> 
> Thanks,
> 
> Jonathan
> 
>> Changes in v4:
>> - Fixed mixed-up rebase changes between commits and added
>>    regmap_get_device into _init functions to get the device.
>> - Link to v3: https://lore.kernel.org/r/20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz
>>
>> Changes in v3:
>> - Stripped patches merged from second version of patchset.
>> - Dropped iio: light: al3010: Move devm_add_action_or_reset back to _probe
>>    in favor of opposite approach moving devm_add.. to _init for al3xx0a:
>>    - iio: light: al3000a: Fix an error handling path in al3000a_probe()
>>    - iio: light: al3320a: Fix an error handling path in al3320a_probe()
>> - Link to v2: https://lore.kernel.org/r/20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz
>>
>> Changes in v2:
>> - Dropped Daniel's email update.
>> - Dropped DRV_NAME introduction for al3000a
>> - Added DRV_NAME define removal for al3010 and al3320a.
>> - Splitted unsigned int conversion into separate patches.
>> - Replaced generic value with specific raw and gain variable.
>> - Use dev_err_probe() for error handling.
>> - Separated devm_add_action_or_reset move from _init back to _probe.
>> - Dropped copyright update.
>> - Link to v1: https://lore.kernel.org/r/20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz
>>
>> ---
>> David Heidelberg (5):
>>        iio: light: al3010: Improve al3010_init error handling with dev_err_probe()
>>        iio: light: al3000a: Fix an error handling path in al3000a_probe()
>>        iio: light: al3320a: Fix an error handling path in al3320a_probe()
>>        iio: light: al3010: Implement regmap support
>>        iio: light: al3320a: Implement regmap support
>>
>>   drivers/iio/light/al3000a.c |  9 +++--
>>   drivers/iio/light/al3010.c  | 85 +++++++++++++++++++++++--------------------
>>   drivers/iio/light/al3320a.c | 89 +++++++++++++++++++++++++--------------------
>>   3 files changed, 100 insertions(+), 83 deletions(-)
>> ---
>> base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
>> change-id: 20250308-al3010-iio-regmap-038cea39f85d
>>
>> Best regards,
> 

-- 
David Heidelberg


