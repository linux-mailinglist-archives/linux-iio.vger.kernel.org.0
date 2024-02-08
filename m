Return-Path: <linux-iio+bounces-2310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49284DEB8
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 11:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6859D2880A4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30446EB4B;
	Thu,  8 Feb 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="gWyHURHL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098416EB44
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389488; cv=none; b=kFkfOPjUtPtBKNNCbrRPo/N4YhBRjbvIQFUnfGZtFZ6c+KD/io1K+FB7FUtIfXVQtDQvMqFec9Q2nu3Fj5gjW1Jfx8qejHRwMDuUB+T0jrcJhHml7BxkzXqOldU9bzrGBnq9gBQnHF+MofsSYVks6vzoK6zRS3u7CIhztNjnquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389488; c=relaxed/simple;
	bh=bc0FK8CLAJw7fRwrx3DNZEXzs5rQi3YK7pzMVlHS+P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwwlBQ8EzEfLPMt9ILUcDd1xHOwQD5Zl08LTjrwqFDLdDqGWe3vG+2lIRrLylcTFmyp7p7J+estMDDs5/aAVpjO9VsPP3UYq6jbgYc3zKCxyVcsEVyj1BGe3HtTf0pr4pftJ4vGpjpYQ2ZKRQUiO5hX/OM9d+UvR7e7bESdmO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=gWyHURHL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1285944a12.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Feb 2024 02:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707389486; x=1707994286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U81mhrQtXLSRhyU8Eow+19b7E6wnZMxfsagdIxnP7q8=;
        b=gWyHURHLRi8RwXbjaQhpuaWsSkfwBnVALTZxxyF/OQG8PMsRlgtpWMYCyZy6I5/GiX
         aLPTuiL1pzu5NUjvnSJGGb2KKnJ6eghqfrheuNOXZlxIfCfoPIUZdNuSc27QZs1JCJZr
         8NI7qPi5h4bc5pWNVv/tkg3WE2jszTc5UkngB5VeR5qwqYr5iWUaI5h38bNrs0rKLwyk
         jGTO4wPsG7+0LvMdMOO5TfntkcoN8MvtdaGDETpd8u3wXxC4mdjYPmuWROQuODOVqLUx
         eIa9buW43/HzyqlDlaVQJFuVJoylNCcVdRjQwZRmR0Xeksd9m6KmRKf3BuN6Y7EYsZ8L
         js/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389486; x=1707994286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U81mhrQtXLSRhyU8Eow+19b7E6wnZMxfsagdIxnP7q8=;
        b=FqD/FN1zEGXxYR1fUzvk1LxfI86wJUwsVDKiCriemkRxUmetjXOUT29A8ACueJyjOM
         jcznFrIOM0uWCvoZIfIh3oOapGLiwWbLDLelT2IPIrbMAMxTgMeK6mbo1dZiuu1oe96W
         68R7GXyTc0ZnhmlY72srIrIxXwlEItFW7VyHWBZAk4icQyvU6Qvedi8v6pb+RatfoVct
         oqOA5MHBM52QAYMUMIUiCiqkbLXSNwp5Vn1uOYZRpQhdbP4dDzAIwDbCwbrmcNKke61f
         eFsH1PSkY2g8CgGG5mi0kR8k0uAxtRJkzKDXxdXqE+nrbjc0g+K3q3EMWTnNamFLpEO9
         j3xw==
X-Forwarded-Encrypted: i=1; AJvYcCWV+/4vuEkOjqVd1+5EX2MPU6YVWbadj6Llgr/9Qth35X610fp+nneD333Xf+2IheBXpEYNmk1MYQDSp1p0rizLzdR0qOYQ+Sco
X-Gm-Message-State: AOJu0YyqETTsZTovDuD9hXJbscVRMZPHCZH4p0QwsR7j1OlESdGOaHF+
	q9s++X4/Z5fGdshXVvgNzfM+spUHPl5vAJukeIY5Nc0dMqBF4Hb2WU6BOgQKJeE=
X-Google-Smtp-Source: AGHT+IEkG8Cewlu3zaq01ZBUh30BUa4UE+D0bA+40onlZOyJWUK+AQj8qO02AeoTl1g6mcod6qtB6Q==
X-Received: by 2002:a05:6a20:760a:b0:19e:9967:4e0b with SMTP id m10-20020a056a20760a00b0019e99674e0bmr5896921pze.14.1707389486153;
        Thu, 08 Feb 2024 02:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqFcz3QpdPEjofG5XyYyb7LWORJeKeHYvfeN5ybE5e+ptGzdLAik/1N20M5LmNlFP5LB89gyYLbgS3c8v2aaPvEBscpyZXHhw8jIT1YLSc/kb7f13Qupw4OumrF/LsQSb/IwNEVn6+KDyXlmgpIIEEDmZi3/uXO2p+92MgNz/f6mkl+lCd8PwrrkiZ6sdBV5mzotQZS6bqz6hH5E674l1QiUf3D3JuRQL+v5PcdNioxyLpCPVTGcmtsbtRgbF/qQmQ8y1xwC9GA6amK74w9MxsilweCTNA4FHkCWFDAXY2FDgdMXVanjL3CJXnYrra066H70fP07rqhSHNhBAT9hYCgFPk+UJo1PhLDlih9Bwq1jy+NEHN8r8ITjM5zKrpwRI9nORCh0eSnLg7sv3X5NhEMQis2U67URDh/D4WEuIXGMT34GFJMJl0VE2ylTHbqRmBrfWTIxP9yPTUBLJTKOpx3ClGvyhSiwxKBDb3Ozxcp90=
Received: from [192.168.20.11] ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ab88100b00296b2f99946sm1165917pjr.30.2024.02.08.02.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 02:51:24 -0800 (PST)
Message-ID: <f7c18fca-2a85-46b2-a671-2409e662520f@tweaklogic.com>
Date: Thu, 8 Feb 2024 21:21:17 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-5-subhajit.ghosh@tweaklogic.com>
 <80e58f2f-b98b-46de-bcd4-fccbab11422a@linaro.org>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <80e58f2f-b98b-46de-bcd4-fccbab11422a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 8/2/24 18:48, Krzysztof Kozlowski wrote:
> On 06/02/2024 14:00, Subhajit Ghosh wrote:
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
>> Extend avago,apds9300.yaml schema file to support apds9306 device.
>>
>> this patch depends on patch:
>> "dt-bindings: iio: light: adps9300: Update interrupt definitions"
> 
> Drop the paragraph, not helping. There is no dependency here.
In the submitting patches guide, I read that if one patch depends
on another, it should be mentioned.
If I try to apply this patch with "git am", it fails without
first applying the patch dependency mentioned above. Is that fine?
Again, sorry about the silly questions, just don't want to assume stuff!
> 
> Best regards,
> Krzysztof
> 
Thank you for reviewing.
Regards,
Subhajit Ghosh

