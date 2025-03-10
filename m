Return-Path: <linux-iio+bounces-16652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46062A58BE8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 07:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038483AB095
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A121CAA86;
	Mon, 10 Mar 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcHkPltc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74919DF52;
	Mon, 10 Mar 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587801; cv=none; b=rmM7xjHWDhNGtAKZ0N1TgsX3Yh2Fg33tkLnZR5SXwPAl+wgwO1svBrjvnXKMKIbkvCW67RTliYfqtkQ9Blh/zJRb64TA4I45YOCBi87Rt97F2QBr3SwZyS2OofYnJEpbGZvpVj3HpiRmuChYN4qiRgQu/9Oox54A/kGNRJvCfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587801; c=relaxed/simple;
	bh=y1WLy5Q6m5GCQaLq9SLKzBI+xlyIHZSpXTFXkqz4xNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5CWYcyDkpLujRINx3fw+Sc5plL9zMzm4juIQjFhcdhs7So+0/Ey/NfFIO+R0wUi1pCES0CAjVUf716GrEdmjn3A/TX0hu2mONpJKlOMIYlJPogpyoy7s8XzcFU8lhtJ9pxsmHfOV3X5a1z5YcOhqbbsc9/x+3lmwA55aZybcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcHkPltc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30b83290b7bso43358751fa.1;
        Sun, 09 Mar 2025 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741587798; x=1742192598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAmQnryV5yX4Eifk2YIq8zjRl5ptnm3MWltewWinEHI=;
        b=AcHkPltc8PI2loeeFyswo8bsj+NOrQmmGfn/XdctOFWVQWQ0oQZ+tibhAOjhoc50Fp
         OFrIPXRNuRQWj6PA3LcQ0jy7ELFOkuMpYMFNp6ZWetShWmxz61iMbcDxyJfuAjKid+R9
         Y51C4FZ0sy3DTLVn9EBJE8VAzTQpQb43xB0N4babKFSJDrkKEEZbj0FzlbSfS00A6Y68
         cS2UqdJMDEFb5U5rqgNdWgvle8o5wUdBqXG6OYwCkHhvNMQ7SjnE8FKpf21M3qWtthZi
         FQ03EyeHwU29vP+Mh5bVsHS/S+lvQMmponLgajC1dnek9s4pzYMhwPhbTAS/r/3BRzmF
         Tq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741587798; x=1742192598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAmQnryV5yX4Eifk2YIq8zjRl5ptnm3MWltewWinEHI=;
        b=mmPvycw/E0ylzpbCYh4gHHt8HPLK1IydjAxtLekeAccM/mwTeoK6YX0QX2nCOLdvzN
         B641mSXS3yoRJ0YL28NUB409eV47i3bJU6tgpMhlfkafhee0s3obpZ6pLc6Q0h0E5vDv
         2Z9GwM+J1t3dIXDai34/p07AlU5E33DkZuyhYq4h+B5ge0VI5dNDxalWwUNphPMH5lVf
         D/Yo6PKJvwui4/adJYvbiyhZb0L1Fe2AfVl5emcz7s2aLcAXhsGV3CAyD2xatxDGxvQf
         0g3vc69Jz44AxhsCpW6NpNVrO7QFmM/qlR21LPepd9GSpGrEfA9PB8aQhql8jqCRCFed
         wBZg==
X-Forwarded-Encrypted: i=1; AJvYcCW8MGEPIKiT5YSs0L36aHT+b3HCUTrDQU75xc2uCWEHdXet8mLQFBbaj2i8c/kUHz7u68JNBsude7a6PXcj@vger.kernel.org, AJvYcCWR17jg0SaP6NOGyWjyUgAsNcygkJTpVewh7BwBciul2PqFTBFx0l1U5RvAiF19JOXz+nUnc5XPJJWQ@vger.kernel.org, AJvYcCX7rWaO7edXbeUI37Y4JCNqm6EZDEMw0F1ejWPAyg3OXdM4gaXdv7pWDIz2qUoQoXqP++ECgg9B@vger.kernel.org, AJvYcCXstdTiywWAn0loUDRISxqsb+d8E7SmEhHBews8kVw8Ql6/Fw6UkluDfLneKaLpCknIb81Rf7seTQRu3A==@vger.kernel.org, AJvYcCXxdvEp24ICJ51OFeMcrc/loEtE+Hc9rvt2K4Mz9Q3W6YrNDZtg7OQylFyf2ZntJpddCICkOSdt5Orh@vger.kernel.org
X-Gm-Message-State: AOJu0Yytw/AMYQgagaVKd07X5Nkfgt65V1JiTqWZ9LkKjUnA5UfZ84NM
	8c5UxZVzWjMxJ5IWh1Twj1x4HOBQ/mrOri1jH51eJVAs7FAPlGhj
X-Gm-Gg: ASbGncvOKbHbQjInHreD0U0V3L54XevR9dCnIOiW2Kp6G5GMtULNkPaVO5he+M926sy
	Lmp4Te2NXD1LdSqojTKmHVQLQNyZryBR+pBcYa0dw2bXgm3aW0VyAJOJIqtpCxw6wd9D7XyXO0O
	v+4wtDcRlXEdW6IYgPOI/70/N24Nzw1crIP0Mfj6l+VXpIqzdqHGm14OyMZvx0XMdblo2aolQFq
	3DDQz4J/ihscAXLLVfXYIZRFrjo6URCZRcpiSBSJWy2SDrHJrm5AM/ULhYkGYdK+jyE2mWWGhR/
	jygbHEZFFCpIX8dHuDaSSB8Yeu84lXwwFm6R68qSYuoCyetbpXruTE2Hg2KN1qYFkHOg+OoGlPS
	Tk3JwtrdIK8RFZLiQNLRofg2uzA==
X-Google-Smtp-Source: AGHT+IGJBZ5CCzAaFqmrdrM7KCGkRbTWKFMoKMp4dabz1hEs0dIexM72Iu1vZT6PUZaq5cwRhBMOsg==
X-Received: by 2002:a05:651c:4ca:b0:30c:aae:6d4a with SMTP id 38308e7fff4ca-30c0aae6dfamr13860001fa.26.1741587797306;
        Sun, 09 Mar 2025 23:23:17 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c0b1f3d53sm5395891fa.59.2025.03.09.23.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 23:23:16 -0700 (PDT)
Message-ID: <39cbe817-fef4-405c-b30c-79b592c0bcfe@gmail.com>
Date: Mon, 10 Mar 2025 08:23:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] property: Add functions to count named child
 nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <5e35f44db2b4ed43f75c4c53fd0576df9ad24ab2.1740993491.git.mazziesaccount@gmail.com>
 <Z8WZh5EzFqxvU5rb@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z8WZh5EzFqxvU5rb@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 13:59, Andy Shevchenko wrote:
> On Mon, Mar 03, 2025 at 01:31:45PM +0200, Matti Vaittinen wrote:

...

> 
>> +	return count;
>> +}
> 
>> +	if (!fwnode)
>> +		return -EINVAL;
>> +
>> +	if (IS_ERR(fwnode))
>> +		return PTR_ERR(fwnode);
> 
> I expect that this will return 0 or number of nodes. Why do we need an error code?
> If it's really required, it should be in the fwnode API above.
> 
> Also do we care about secondary fwnodes?

We have the device_get_child_node_count(). 
device_get_child_node_count_named() should follow the same logic.

> 
>> +	return fwnode_get_child_node_count_named(fwnode, name);
>> +}
> 
> ...
> 
>> +unsigned int fwnode_get_child_node_count_named(const struct fwnode_handle *fwnode,
>> +					       const char *name);
> 
> To me the following name sounds better: fwnode_get_named_child_node_count().

Agree.

> 
>> +unsigned int device_get_child_node_count_named(const struct device *dev,
>> +					       const char *name);
> 
> In the similar way.
> 


