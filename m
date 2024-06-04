Return-Path: <linux-iio+bounces-5762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F438FB3FC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FD61C20A56
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE12148304;
	Tue,  4 Jun 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls1jumE0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AC146013;
	Tue,  4 Jun 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508314; cv=none; b=G8xsK6Q6kF6Nu3y6pBY7nKK5utKn/cpVJhH4aCKXCzAbazb++V1A0OMOIeooX6BH1yDMqfTCbIjbBeslRxYRBDIwf8m8woY4TujkTd7Egjr+g8AnVJy8xHp/+1dRu8zvY9dnw9GzrA5SUz3lqB390taOP4kWDc3fUneOUsBhMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508314; c=relaxed/simple;
	bh=981/QqhUSMzgIxUQtx9ezdolZv3NUY4Z5O51ISsZLnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWRmXoOoW902HkobL3b0fIdQFIDSwyzc+yaR01JePkJojVsYcP9CqNRfFGqLK2DdvVb8UpzQWRqSoW+TCp/1YRbYrQhSLTLeSqXsYGvh4Ft4Fb59uUizH2/hB4GmXCJvizEe/hgE12DPEboAkD8ecrJU+P3BdTX1tlk9tDo81Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls1jumE0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b894021cbso5107893e87.0;
        Tue, 04 Jun 2024 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717508311; x=1718113111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDB7A/H/VZ5MlDIB5Z1XvXuMlPAslnCdsAIH4mBnMFI=;
        b=Ls1jumE0StrOkcgQcPN1fcgXnTYBiA0uwKjasLiJBSQWXOK8LTCqHBEiMw+l4vWliz
         H2rNdSrCANbsO64QY0cm0b+A+y5zfNrRtihhFh7PRNXrHqtGFb7zyrzTfacZ2MuzK+KN
         n6FSehmdg9XA8HItoN1loBQHNgX53HWWkKA6X14qg840GUXB3RP0JRyCJJtPpNewXbnK
         SxoZ+YTs5ksT7HXi2dMaFn9PXLDQE8bTgFNw+l45BYA0pHpKRXQuKOoJRrzjptf/oi1n
         lzM7i6qUWUpfQ6pHKrL7yNy+b1iV/j+ZsIzenXb1DkzLgSBMVFAKsgZoh+V0sLr4U/jX
         d5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508311; x=1718113111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDB7A/H/VZ5MlDIB5Z1XvXuMlPAslnCdsAIH4mBnMFI=;
        b=hHYK3L2uQQVeUObSN6Flq8rbhMXhy0NmUlBD5m1d8hpxtIhXdbVPNsojDS91o/507t
         Ua844oayzP7/HkKNxFtDQiIPi1ig9YtJ/TCZEc8/m4ZDUzDKgU5tcN3/Ir9FGi5wM6bZ
         bpR38e4WrPrMBbwcefq6ZeIvGSghmMdGQezm83M3XeHFgyL8cOC27JxEqJemyGmdBngH
         tAwRUdeGdwyuGPEh6byG/d6AD+YGxZO7Dnh3S4VFJQVPSPQ279DmyfWzqP6a0SwLrPhy
         XNvRzHP7dxbkfne6v21Poj9QXranwgZatmTSgl6UZbUPrV3V1ZfaouWogJy5IoI/G4qv
         yGKg==
X-Forwarded-Encrypted: i=1; AJvYcCXqNFWyA0/zxE+HtYY0ZXQeJn201ZTrf1jiI1A4X3yxdMFI2lXVUluCmYtnBR9SIksEuP1XQaVUHeV1meOppRd6o7kvnZW1smvE2jp4a8hYMyhS7ZYw0kglgxxhKRVcv+CX6sab/w==
X-Gm-Message-State: AOJu0YwpfSXsXAy3eUd8H+eHFd0yecmRYmgHC/Va8oUw2e95pI58EKLI
	r8/MNZa+WevFv5C6wHnuDIuKqMGb5yI9ed4tbAbYWEKgxD6x6Ejy
X-Google-Smtp-Source: AGHT+IHMG7g7gUQyOP7IBzRP7Mvor81DV9nO1tbz6GXI2rFwKiMWR+p5QJtsTqaei2Fw+UAJK2U+1g==
X-Received: by 2002:a05:6512:70:b0:523:9789:4c8b with SMTP id 2adb3069b0e04-52b8957ff6cmr7229809e87.5.1717508310621;
        Tue, 04 Jun 2024 06:38:30 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75fb7sm1536590e87.133.2024.06.04.06.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:38:29 -0700 (PDT)
Message-ID: <17b23723-d0d0-4744-9828-cef316cf3fb7@gmail.com>
Date: Tue, 4 Jun 2024 16:38:28 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mudit Sharma <muditsharma.info@gmail.com>, ivan.orlov0322@gmail.com,
 jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-3-muditsharma.info@gmail.com>
 <a628db76-a48a-4492-a3cc-f93c0f67ad04@gmail.com>
 <961fa617-a76b-4b79-956b-795a55fec959@gmail.com>
 <f241957f-6f4b-424c-9ea2-d7eb564daa4e@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <f241957f-6f4b-424c-9ea2-d7eb564daa4e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 15:53, Javier Carrasco wrote:
> On 04/06/2024 12:44, Mudit Sharma wrote:
>> On 03/06/2024 23:37, Javier Carrasco wrote:
>>> On 03/06/2024 18:21, Mudit Sharma wrote:
>>>> Add myself as maintainer for ROHM BH1745 colour sensor driver.
>>>>
>>>
>>> is there any special reason to have a separate patch for this? The
>>> addition to MAINTANERS for new drives is usually included in the patch
>>> that provides the driver itself.
>>
>> Adding this in a separate commit was just a pattern I notices with some
>> other drivers, for instance 3b4e0e9.
>>
>> If necessary and/or considered good practice, I can squash this in the
>> patch that brings in the driver.
> 
> Although there might be some cases where it was added separately, it is
> much more common that it is added to the patch that provides the driver.
> Some perfectionists even include the entry in the dt-bindings patch, and
> then add the link to the driver code in the driver patch. I believe that
> a simple squash would be ok, though.

I believe there is a notable case where having MAINTAINERS updates as a 
separate patch makes sense. When one creates drivers for a device which 
touches multiple subsystems, typically a set of MFD drivers. This is 
usually done as a set of subsystem specific patches, each adding 
subsystem specific file(s). In this case adding MAINTAINER info 
separately for each sub-driver will create unnecessary churn in the 
MAINTAINERS file - which I believe is already now a major source of 
merge conflicts. I am not sure of this is a reason to have MAINTAINERS 
updates in own patch though.

Furthermore, I've been instructed by Rob (AFAIR) to omit the dt-binding 
files from the MAINTAINERS because the maintainer information is already 
contained in the bindings itself.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


