Return-Path: <linux-iio+bounces-3526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F63C87C1C8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCA6284087
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B5745E0;
	Thu, 14 Mar 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAtIjkg2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64E18E20
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435936; cv=none; b=TTlVI7ViY0EAvQmqWrhZ0GWQAT5m+mF0j+fIMgd9fL0/Y3BtPmxD+zL6H1Qlfh+pBy6JAk56LdWOt/3o9EB8GFwEex+uro8kV5uNIkg8Ryu9eMxotZh9oEqJXnGwhVRUlS8TZ1u9DBF4bg5g/xS1OLkhfLDRwjGvlrszRdU2f5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435936; c=relaxed/simple;
	bh=I+yEakZLbc89Llm1zwNn5fxLD+wh2EQjZ2UFXgN8l+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeBntI6kFDpKtxEYvh+nzSOEYv2Owb9LTAQmHIYvuFnT3+O/NwQlhfsLiyau/THYxGsT3igk2VakFVsI+ZDWcc73lY7r6NqxdKbKfizNgQnTZZ0E85I1c3TTGthKJKh0qSlvZctE4tccmbWJTsUXbuTmnjnt59SoYVE8YyC5Hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAtIjkg2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512e4f4e463so1394261e87.1
        for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435933; x=1711040733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkLdvZnZB72+YMhb6+j/TxBevhgiJuQOwF79EtoYOIw=;
        b=kAtIjkg2jvuwD741qeihVZ92OyW68ldtAf1ukE3Jnq5tYTQybOV8LZZqt2zc1AtzpE
         gTKYGA/poUEIKHLL59vQePH9u8QMLqpCrQYh+2pNH3jBqaQaOYPTn/+eU3xWL4ScncHW
         +s0asg85ntM1llcx2M9q7YlvjDoAEounazn5cKVQnqR/xpd0m94DOMeUCwqVt7KQVjrZ
         zFxoIhxhTdy+/nUMQrLMPV22LIhragpwRoGRJ3bBXoyW68uQWHRjxMt/tU65VMILkPZl
         OvKjJ1jkwB+N8FSuea8OwISNAkpUfERX8jZ5Xm+I/9qyzZWFTxY3UPaKj3PWFj7mNZNi
         L4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435933; x=1711040733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkLdvZnZB72+YMhb6+j/TxBevhgiJuQOwF79EtoYOIw=;
        b=aJRDsVB0sjZhzTruj1T1dI74KrXQqR4anfMakQP/dUa2W+CS+nZbq5FfuMh9Ibpe6K
         t23PS+7ELTBB9ASKCg7eBK73rX5BIlibo9Xm+MchGJgHixxIqc5I05Z3ItjHjaNNMeaD
         U+IdJ0D+Cl9QJ0eD4rBUro2AIKNhcov5woVXbTv5fqTi5bxZIap/27aZBAszvqs/xLrM
         huubs/J9dyV9U1tj2d7GSsGl5VjnuH+3bOropCPhR6skdsm9oT0fP3XssOm2Uhh2V0tl
         ChDebsDeJ4ILrRgVr4pBJTDZYq66nkXKsYGPI/Gk5qscWjqZeQ+BRoN38yQwXIXid3yQ
         IO2A==
X-Forwarded-Encrypted: i=1; AJvYcCVY+N1k7F4R+iAHrbD0TDsk+wQYGKQPnc0WrvQMLZtyw/fvhUE3shsCvqJXaInsHSCXtHyGaZvv1TbjTZlN5TIFtqadDX0+LYjD
X-Gm-Message-State: AOJu0YynTLTtDFPjfLmPvgxzJx8U8S0U3jKQMR++UpZABBEkNr1iii3V
	Y5yzww1oQKIGFms42AV6BBhDZnPR4+UNCrF9uYnbcOTVBD/GVzieDsUXesv2
X-Google-Smtp-Source: AGHT+IGM80WreUp1Po6BPAlVtweTlZWq738jZRQ8NBxjcHId+d7WTPOAgK+ocn6IXjjyfaO7AA7BPg==
X-Received: by 2002:a19:6914:0:b0:513:bcaf:c339 with SMTP id e20-20020a196914000000b00513bcafc339mr1808666lfc.13.1710435932580;
        Thu, 14 Mar 2024 10:05:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::6? (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id t24-20020a195f18000000b00513cfd6d15fsm356431lfb.57.2024.03.14.10.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:05:32 -0700 (PDT)
Message-ID: <bd4e9aa4-71cd-4e29-a4e7-e00ad0732a7d@gmail.com>
Date: Thu, 14 Mar 2024 19:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>, Chenyuan Yang <chenyuan0y@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org
References: <ZfHM73ZqgnCp6CZv@cy-server>
 <20240314153656.493ee487@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240314153656.493ee487@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 17:36, Jonathan Cameron wrote:
> On Wed, 13 Mar 2024 10:57:35 -0500
> Chenyuan Yang <chenyuan0y@gmail.com> wrote:
> 
>> The sorting in iio_gts_build_avail_time_table is not working as intended.
> For function names, add () so
> The sorting in iio_gts_build_avail_time_table() is not working as intended.
> 
> I can fix this up whilst applying but will be waiting for a RB or related
> from Matti before queuing this up.

Thanks for waiting Jonathan. I wanted to run a set of tests before 
acking this - but I didn't manage to find the required half an hour for 
it Today... I'll handle this early tomorrow.

> I'm assuming there are no existing drivers in tree that hit this problem?

I don't think so. The ROHM drivers which use the avail_times have (by 
luck) the time tables already sorted in a suitable way.

> If there are reply saying which ones so I can assess whether to rush this
> fix in or not.
> 
> Thanks,
> 
> Jonathan
> 

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


