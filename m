Return-Path: <linux-iio+bounces-9947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AC498AEA5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 22:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667B21C219EC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 20:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778AC17BB3F;
	Mon, 30 Sep 2024 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4T/DpeS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754A1925A2;
	Mon, 30 Sep 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729170; cv=none; b=NvH+sm102dpPKu66FlxoBQ2D0aSWxsZlA+AsML+NfRVWwb6dRxFWP5DY/Dg1R1kWgXxQ2fWUAdZXI/Z8pfn4hARmLf7LY/vh/CLPobImoOqf6bxCqM+RAF4kmjgSpVGpERQYqUXKGlH6uTLeHrW1s+luKYsKnYwcp6yymff+GQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729170; c=relaxed/simple;
	bh=9izmi5veQPemQfUYkQWBdx9f98WFityEVLTULSD4KaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9DfeCNeHw0vbfYihOqp03ipPxpTSmDetlZUx3LmvcGSGCGaO3WPoER6kbu8bA0q6ve5TMfr7BODQmf4vfhEFBUDGhF4hKgOTOOBxoBeMQs7c4sEIwjFLimcU2dTZbi4itBGxHBnHRZox8iIfpJGyc/JLUYNIZGwlqOBvjo0Gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4T/DpeS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so3196714f8f.2;
        Mon, 30 Sep 2024 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727729167; x=1728333967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1yrxJnH5nQnXbPyHVjxBJoXIBi7Ad6qhWyJ8z7RAAM=;
        b=E4T/DpeSGbt8Vb7gEUMXUWmagkl9NNd7lE5E4hRKVqieIZj+RvhcEIPTGeXh7QzSKO
         fsbqSRUHzkjI3tBQvgWmMGqLazNoszkZCWRZURyqEDAFXZPm471+OHaxaalxoEVVIeA6
         9ktJc50PakaVk4Wp1N809DanM4sGhD0/y+gj+mh/Sq1tv6Ye1yB9vbPvpa4Tr4wJP/a1
         XYA/7rWvxKStJWyj15f4wJ9gyIbsEk4aKyj52OolPLdIRHuiD7CaNlX7OmYaHuVsuQVM
         kXJ9gGP+XyMObUX/GxRCIf56ddinb1inA3HRsfgI0U8TK0XzRI+Ik86ah41Nau5dlwkl
         68lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729167; x=1728333967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1yrxJnH5nQnXbPyHVjxBJoXIBi7Ad6qhWyJ8z7RAAM=;
        b=jtXWmxUw7r0T145NDlQd5G0y0BrUJ0sghRYhRza0nvHiCp1pTzJYewJMY14JSrkWPR
         DW2TfX7pbITaBdyFiqkJdxn7hyUNvvfKwBZthktsxUops31AVIu9Xo3FhNx+AMUwc6fI
         +AWd9UKBFNdur60I1v9uBC75VTz7jwi2TfUgeAJFTC6jD6npWmjA8+153OlgST9La1Pq
         jd5DlbAJZwZXG1LgHkjRRYOAbLs19Jb4mPoRTeYPOeMz2/7p6QykIFgkvGaQMxLg2ns3
         kuApMk/S8vI7odxANY3rY6VzJTo6UxLWwEnV7HRG++RvvYXNBPp6k7ZQxryuzs5Snrj4
         InQg==
X-Forwarded-Encrypted: i=1; AJvYcCVy5MbviBtMM6AdhyBHULu4Ti9LyELUPK+AFhIg0aqmaaliAYjvZ9dAfaDVP/H5jpQbT7n9MSclYCU=@vger.kernel.org, AJvYcCWMD9MaDsyK0d2uW/PqeUpXzOnFuTEwW+LC8zv4QZ02dnqaDLCU8VKiaA8Fp3AZG49zdxcw6eRA+3hbOJoP@vger.kernel.org
X-Gm-Message-State: AOJu0YyrpDBPFgdW3F7yNj/orFsN07Z5bmeKVdQdDmdUZNcte/UFRyR8
	3OciEhFt5ZNr3yXYpEOS2H6xbzHRhKSg9B4HLRNnHtQR9H2CW9w5
X-Google-Smtp-Source: AGHT+IFN83IwpYxF7n0KKmGF0euKzStr7d5ZcOkwyLjUGk7ldPttwtSPY9/JRgjF6RHhWT3y2zV3MQ==
X-Received: by 2002:a5d:6448:0:b0:37c:c5fc:5802 with SMTP id ffacd0b85a97d-37cd5b1ba9dmr6944695f8f.36.1727729166919;
        Mon, 30 Sep 2024 13:46:06 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:91b0:e3db:523:d17? (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6587sm10154402f8f.47.2024.09.30.13.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:46:05 -0700 (PDT)
Message-ID: <f12447b5-e26b-4f28-90e3-b5f61fdfcd6b@gmail.com>
Date: Mon, 30 Sep 2024 22:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Binderman <dcb314@hotmail.com>,
 "jagathjog1996@gmail.com" <jagathjog1996@gmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
 <20240930151542.GA3556370@thelio-3990X>
 <0342111e-47f7-4981-a1f1-e694392fa741@gmail.com>
 <20240930202642.GA1497385@thelio-3990X>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240930202642.GA1497385@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 22:26, Nathan Chancellor wrote:
> Hi Javier,
> 
> On Mon, Sep 30, 2024 at 06:50:14PM +0200, Javier Carrasco wrote:
>> But if that wasn't the case, and since you can't use sizeof(<type>),
>> should it be marked with __maybe_unused / __attribute__((unused)) even
>> though it's known in advance that it won't be used, or at least that its
>> use will be to get its size?
> 
> Correct.
> 
>> Is it then just to silence the warning, or does it have other
>> implications? Thanks again!
> 
> Yes, the use of the unused attribute would just be to silence the
> warning; the variable would still not be emitted in the final binary.
> clang's behavior matches GCC's (aside from the special warning):
> 
> https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute
> 
> If the variable needed to be emitted in the object file,
> __attribute__((used)) would need to be used, which explicitly has code
> generation implications:
> 
> https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-used-variable-attribute
> 
> A contrived example:
> 
> https://godbolt.org/z/oGGbqK98o
> 
> Cheers,
> Nathan

Thanks a lot for spoon-feeding it to me :)

Best regards,
Javier Carrasco

