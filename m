Return-Path: <linux-iio+bounces-9553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8E979121
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9FB1F21132
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE471CF2A0;
	Sat, 14 Sep 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt2McpUL"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE81482F3
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321647; cv=none; b=CHm6Q1PjuTi3QdqTa4pbCwTntvGbwXh86zHFpT+srKXtm1sxuD1iMYCvc55uXQtkG+Jd6Jz+r/4hSny3c1VZEZR6aHCT62mp932gyS8BJJ22npsMwznw2KexdMoyeG+sqHRdfRu8+8G2z9rbmoDmHQ3qqbAfiS0Z7CwQbZbIQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321647; c=relaxed/simple;
	bh=2aUSAWq9PMKnd3bXhMP4hf8KrWEx1Z33mDmimkWdq1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG1VSxLPkF5OH3hNsJn39Kg3R0/5SvWokrFm2DDTclozDTKb6sapcNF4rpScyk10rdJLHF5/o2QIEsP3nWKQJGkheFvVXWpd6+kHkdzUi44jQrCLwkUjsbeO4i9GMporF6KSQ/V/WL07omJ2g0lbyNYZIy22jky+ztsN28deyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mt2McpUL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726321645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UrBWJboZVlP+TK6YL/vAFOG1Z7ivRqSHOs6x+zzkZE=;
	b=Mt2McpULDcEn7wje8l61Hq1J7oT42CW/mR3a+89DSd+d08D8ZW58s9OJXk6n/bupog5dGH
	nkRzPovgKwu3JnKqOnUkz9mIlIXCrgSK/toKYM45rj2Gpvp/iE48jcQML5LegEPw04U/6S
	pt4sn7FisrNHGCxoP5ZmfaLFISdOLBY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-j7SrMaRIPu2H8zq_cajEwg-1; Sat, 14 Sep 2024 09:47:24 -0400
X-MC-Unique: j7SrMaRIPu2H8zq_cajEwg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a8ee13b44so158559166b.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 06:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726321643; x=1726926443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UrBWJboZVlP+TK6YL/vAFOG1Z7ivRqSHOs6x+zzkZE=;
        b=fFXXAAJ9xziwcN5U16FDqKWabqPE8g0AC5F7/i4VAWCOt19b07NKcmnaNRr6XvhJ7X
         aIlHvTRDVZF2pBLe5WOn7mzIdrJETDZiAh3XS0Nxhv5CaNyZgjXX9LWksNvNgMLBAEUm
         q6O4xYl37GdlCnvi9CY2bXG3ch/yN7cPQDKFy1PpbcZIlRgtQGjiLzYOCNgklDZkBhw8
         phpMy4SsZewA6nYGw1LQqWlUOvvc/V4EumKY/s9molk6JuiFFeOsv/cwJ2HbMwJs8h70
         PHqLYdx77Du2g47dV3lDu4vbnfgmchJfi3AQOIeZgVmvkHlbmAXJbYPWn5q7YcMKQzOh
         BCew==
X-Gm-Message-State: AOJu0YxZetBdwoepX1iD5mMxzirmKhHRv9w6nzK/fW3rnO8qYukldkl3
	CNsQgg5tBEWzryDEs/ICZMr07EywZwnWetnTX30YakPvO2QeHq3yAleHm6vERu3QMF2fe0mchGn
	F1V5RO/+YUX2fvvKTCJ7sni8iIxzjPwVewTl1UNabP3M0Scax7Sa1A9Uz6Q==
X-Received: by 2002:a17:907:97c8:b0:a7a:8c55:6b2 with SMTP id a640c23a62f3a-a902946e6b8mr992195966b.14.1726321642868;
        Sat, 14 Sep 2024 06:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeVtEl540QCdPDElJLsU+3E7gzfPsv+l59/grcOEsHW8pUQY8YIvfpkxUhpKZYk2He3o8c3A==
X-Received: by 2002:a17:907:97c8:b0:a7a:8c55:6b2 with SMTP id a640c23a62f3a-a902946e6b8mr992193366b.14.1726321642300;
        Sat, 14 Sep 2024 06:47:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610968adsm82960966b.7.2024.09.14.06.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 06:47:21 -0700 (PDT)
Message-ID: <aac0e587-3770-43c5-a9b1-4da4890c979a@redhat.com>
Date: Sat, 14 Sep 2024 15:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
 <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
 <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/13/24 11:32 AM, Andy Shevchenko wrote:
> On Thu, Sep 12, 2024 at 03:52:34PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 9/11/24 11:31 PM, Andy Shevchenko wrote:
>>> The commit in question does not proove that ACPI ID exists.
>>> Quite likely it was a cargo cult addition while doint that
>>> for DT-based enumeration.  Drop most likely fake ACPI ID.
>>>
>>> Googling for KMX61021L gives no useful results in regard to DSDT.
>>> Moreover, the official vendor ID in the registry for Kionix is KIOX.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Thanks, patch looks good to me:
> 
> Same Q here.

Yes I did look for KMX61021 in my DSDT collection and I did
not find anything, neither does:

https://www.catalog.update.microsoft.com/Search.aspx?q=kmx61021

find anything.

So I believe that this one can really be dropped.

Regards,

Hans



