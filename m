Return-Path: <linux-iio+bounces-13272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A89E8CD8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 09:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1EF281B62
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C9215F48;
	Mon,  9 Dec 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFD2Goa1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80119214A9C;
	Mon,  9 Dec 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731209; cv=none; b=VHtKOAQJ3SaVZp3qZwTWQ8uo+J2Hmmv6OL4sW7RaMmBeZTLXFYZupppzIyRabUTD+pmJLMDr4FI6O9Pu9Yq+XDIlOKtTgmvN0gaDdnBGVejOzAtyJ6GNJ77YJrz78RoBCM44xLHrlVLHAnzTRTk1I2/B5mOA6MJoQCttLfUFx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731209; c=relaxed/simple;
	bh=y+K4oSxwDC5uMdruxfk6LckRBcsqVkZzO1erQE0VmWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUxXoYunFe3oB/eSPYH/D5gNTqFUzbuFKqS3/3V14QNtrRdzQJ8RIapITIWEXQpgMqV2qvC2IVDnr7bJUzoC6Bm4CyLoQh5soKAfty8TXP77sKOSB/2Qv3LNC3RI456OIOn/Ya3keMZTi2tBq7y8cnJFd3laVSXXz8EYt+K2ErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFD2Goa1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso998574e87.2;
        Mon, 09 Dec 2024 00:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733731205; x=1734336005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwmNpJ3S7xwUtDlUWMg9YXHKfvFKhtm5/OG9dzvrxmk=;
        b=XFD2Goa1rwZqC1HZFybO6hyAqRV/r/QrfwbxoTzMxcZLyP1fVhjiiG/+9nwrEuy6W2
         FZCMtJz0LoOsCkVFx9KnC9UZ3VxlSdP5qOnzl4IXtQTUR40SBfmKjqwKpONrbZ6qySiS
         57Tk73hELi3niittc5QGNjlqb1Su573bGfk7PXf86Gr8+ytygNo6UkyeOMYRDq7/Zhbx
         ckt3rvQzOaYQI/OEOjHZqeCqjN4idDdikIW+cPsI1QZkSAE7digV23bVaWV5URHI/o3d
         tCDQ3syQfpK3yLYfPuvR6T8lHdIMs/4bxg2jcyBKYLUVbukckysoaeZy78pAspUKLkou
         eOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731205; x=1734336005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwmNpJ3S7xwUtDlUWMg9YXHKfvFKhtm5/OG9dzvrxmk=;
        b=I+20U6iZAcQbrpoHzOjdSWvYTDRAvjjYh5iVtURKiCzAWBnuMIr7FCaL5ugUO+lDif
         Q7Yf5Y3ZSOgpshpp0kRNeYE+9tbstscU5gSfNVeU3UOL9LMrz0+KQU2bbtfzOmjkI/tw
         sw8zoAIbaTL7p107PPFZ5r1ttZ4a0+tOYjZdkKYNt+T+FLjqczAHD8IYivHo4eR9a7Qt
         LPmu1vZyijLPNkXqc33eQgdwSGshaGuA3Im86tOvcP8HQ356fmwOYZ/U3l+3bGaD5de7
         1g8ag3IdheliD8eTC+MDcOCQ3puBmZ3GaERHZKwyoN38S5B3xqlhbO7lNOu8bn+6sRWz
         8FBg==
X-Forwarded-Encrypted: i=1; AJvYcCUDYsg+tSX19a0bCnqxPAejCpeWDjRFkimEQotb6hKJRICW0ryLJBXyZiXdFuSqO/YHxnwuneeLaRY=@vger.kernel.org, AJvYcCVe0UgOoLl/J0pnEPz3EY5a6l0uADZ7jz62JX7t9FUVahArX2t2XoxRkwEvT7Jomk7cB78oEw8mEExEy2nQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhavNHAoeWjxg5AI4rUHW0b+Whywxk//Ix2oG3XiTc2KMlqZj
	D7jt442Zmf/kJDK0Y672oLmq3VeLOGVhJWg3OsVPFK82S6mRQn09kw4tcQ==
X-Gm-Gg: ASbGncsrL5ftYpT/oNYOvqgvGbEXb7t5Zb1PjsLDbYGQaOlnzU6hjz6fTStDGJIMq+J
	ZbwOekfTpogsF1HpWczSTNLL7nDjiS7lFRQkvZCgKB4qBGuv8VzOvnm/YqGw9idqXLDtH/NUp5n
	PPDabvmunULd21t/5TsV3Q8LZ0pSSqWb43Qfd9Yq9eE6Td94e7RkwYvmCz15X6Pn0bnaU70iLYn
	RWgiqtJ68Lv9nr8RGyeHFGy/cKgy5ZzvjjYzieJFXpCL3hQh654ARVpJ2oRywiOE4h0KSKu0imD
	JgySvDDeMc7vfwbFLH7f88e/eGMfZoM=
X-Google-Smtp-Source: AGHT+IEi/oLBPGYCBSxyMcjjMVdEpUpHEA25QRXKfDpHu6vfovQRyHCTkv1JWZEChU+InAKenR/pYg==
X-Received: by 2002:a05:6512:3195:b0:53e:3a01:cf4e with SMTP id 2adb3069b0e04-53e3a01d038mr2119799e87.13.1733731205290;
        Mon, 09 Dec 2024 00:00:05 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a4d4779sm737743e87.207.2024.12.09.00.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:00:04 -0800 (PST)
Message-ID: <1db3b390-2b24-4582-8965-9e2d08b428de@gmail.com>
Date: Mon, 9 Dec 2024 10:00:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: kx022a: document new chip_info structure members
To: Jonathan Cameron <jic23@kernel.org>,
 Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z1LDUj-naUdGSM6n@mva-rohm> <20241207180201.51deb7ce@jic23-huawei>
 <xfjchvcsoeuqz4j2rnqait2jqok7p3jzrs57n4hgzykkqhqkoj@so7z326jfrzv>
 <20241208182553.42f13c05@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241208182553.42f13c05@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2024 20:25, Jonathan Cameron wrote:
> On Sun, 8 Dec 2024 18:42:56 +0100
> Mehdi Djait <mehdi.djait@linux.intel.com> wrote:
> 
>> Hi Jonathan,
>>
>> On Sat, Dec 07, 2024 at 06:02:01PM +0000, Jonathan Cameron wrote:
>>> On Fri, 6 Dec 2024 11:26:42 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The kx022a driver supports a few different HW variants. A chip-info
>>>> structure is used to describe sensor specific details. Support for
>>>> sensors with different measurement g-ranges was added recently,
>>>> introducing sensor specific scale arrays.
>>>>
>>>> The members of the chip-info structure have been documented using
>>>> kerneldoc. The newly added members omitted the documentation. It is nice
>>>> to have all the entries documented for the sake of the consistency.
>>>> Furthermore, the scale table format may not be self explatonary, nor how
>>>> the amount of scales is informed.
>>>>
>>>> Add documentation to scale table entries to maintain consistency and to
>>>> make it more obvious how the scales should be represented.
>>>>
>>>> Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> Applied to the togreg branch of iio.git. Initially pushed out as testing.
>>>
>>> Mehdi, if you want to give a tag (or more feedback) I am happy to rebase
>>> for a few days.
>>>
>>> Jonathan
>>>    
>>>> ---
>>>> Revision history:
>>>> v1 => v2:
>>>> - Improved wording based on discussion with Mehdi.
>>>>
>>>>   drivers/iio/accel/kionix-kx022a.h | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
>>>> index 142652ff4b22..d18d56cef098 100644
>>>> --- a/drivers/iio/accel/kionix-kx022a.h
>>>> +++ b/drivers/iio/accel/kionix-kx022a.h
>>>> @@ -137,6 +137,14 @@ struct kx022a_data;
>>>>    *
>>>>    * @name:			name of the device
>>>>    * @regmap_config:		pointer to register map configuration
>>>> + * scale_table:			An array of tables of scaling factors for
>>>> + *				a supported acceleration measurement range.
>>>> + *				Each table containing a single scaling
>>>> + *				factor consisting of two integers. The first
>>>> + *				value in a table is the integer part, and
>>>> + *				the second value is the	fractional part as
>>>> + *				parts per billion.
>>>> + * scale_table_size:		Amount of values in tables.
>>
>> I just noticed that the '@' preceding the added members scale_table and
>> scale_table_size are missing, but I guess you can add those when
>> rebasing ?
> Good spot ;(  I'll fix.

Thanks a ton for both of you :) I concentrated too much on rewording!

Yours,
	-- Matti


