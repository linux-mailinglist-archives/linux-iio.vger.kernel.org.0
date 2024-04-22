Return-Path: <linux-iio+bounces-4420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FE8AC6D9
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6317282ADC
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E24F213;
	Mon, 22 Apr 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXsJQno4"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D3482CA
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774257; cv=none; b=dsZJAQRdUKNRmGqNTK0IrIHkJlSKplzhngSVkXCS05EfO69p+m3SGYw1Af0YYv+HvF7pT6A1kpnR6HX4UX24QDRSBns4F41GPyLC6VceCbo1RyPEphCKcK8cnaWJ4L1Sz9MNZ+6zkr6vCZbBh6eeR+zwbrqcXIDDDGPV1FI5ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774257; c=relaxed/simple;
	bh=IuVTKV5ygbgHVKz2YztmaxHxtTF9vC+auWE3gvxzutk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I45fDSB5jqwo+SXB8TUUZWi4Os1DwtfHX4Qq8OeD82UUNql3J8sH6Oi56i6AO4hGVG8nfJmrA3gZ8+3j+85AycEpeU76Adb+SKMd4WSkNAWUw1bRheS3YnkecnuKf6jnsDxcyzlFphVwNFzeJrXn+DsW5jezMFI2HyA+CJAD2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXsJQno4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713774255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE4dUwNkWaGPk4l745VLfFvewtALv4dUdVYKrcrS4sk=;
	b=QXsJQno4rSVF8G/39Uj1hdtaZcwW+LcT/ASgzLHReciSs3fPV9tLbzy7+Nj2GnxaJlejVu
	5FGMDUNRxpOE6Gino/EMu/uoQrDSQJcxwKtjxU4lp3XBD2Z99t3zXH0s4BupWPXEvy+vgw
	4glD4DzoV7zop3FEhEkSbWwEW3GdtJ8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-I2l5hM9MOZOwdMqvEzWdZw-1; Mon, 22 Apr 2024 04:24:14 -0400
X-MC-Unique: I2l5hM9MOZOwdMqvEzWdZw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516d6c879c5so2384463e87.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 01:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774252; x=1714379052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE4dUwNkWaGPk4l745VLfFvewtALv4dUdVYKrcrS4sk=;
        b=MoDus/r44rYUHHG0JrBI1qWiBqqS57/lzwYhzBPHDyH8tSEnjyhUX3nsFfO5hkcqNh
         leabC6h8FaBX092FxjbVR5tOl0KQCmS6exE/NDYVI+jIeX6WwxeLw5NeRAvWiCpwVu4H
         DVDzPYYwwd9Nrrb555dTlhva/jePYuu3AOrLImwgIjdX8XG/R3/+3AwYNy6WcqcReGTi
         Oyz57Z62ITdcjvF584DefLDy1ayZ35llTgvL5/XeFGMi3VmFzG5BYpziAC4Dyt2F9XjJ
         sNlhnO0GMok8H1IynFCVSy47t+kh2GFRpZj22ktKzHw/mNj2/Z3ECVIdVRaAzPFB0Ozm
         wRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLV/PHC9LXdyFLKiBDa3uoz/cmxJBG/gmpObc13rcM8u42eNa26587p2MExdk3tua4QYR+9A7Aq1uBHHqDVIN/gKOKUu02wj+k
X-Gm-Message-State: AOJu0YxMwFQYK+Z41TPhMaiSQyDKgJlrKnLngF+CThD7Ruz/1/GKPdif
	my0v0AWLSswdHiUYy2FDV236zQvc4qDMOcL0OwPhlfdfq+9ZQyfx60ZfduPvrmSVXgtN0/i+mhQ
	hUernXz6DyMQpmPeGjdBYV7Z1fsdX1pWsuXlF8I8ZDAz26uVlNRwgsRJkl4cvUddmZYff
X-Received: by 2002:a05:6512:36c1:b0:515:c7c9:b14e with SMTP id e1-20020a05651236c100b00515c7c9b14emr5309424lfs.57.1713774252217;
        Mon, 22 Apr 2024 01:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHScNTucjVN7bmLv3VWGkppH1UFmB9Tgcd1dfvp50ZtjS8+nWm2bMOsFSmrjo1Mu7RXQtST/A==
X-Received: by 2002:a05:6512:36c1:b0:515:c7c9:b14e with SMTP id e1-20020a05651236c100b00515c7c9b14emr5309411lfs.57.1713774251839;
        Mon, 22 Apr 2024 01:24:11 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm5443400ejj.218.2024.04.22.01.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:24:11 -0700 (PDT)
Message-ID: <81f83cd6-6d17-4e11-97b6-7f1f11bc3078@redhat.com>
Date: Mon, 22 Apr 2024 10:24:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Sean Rhodes <sean@starlabs.systems>,
 linux-iio@vger.kernel.org
References: <20240417164616.74651-1-hdegoede@redhat.com>
 <ZiYX5JlwS9nGkS2Q@surfacebook.localdomain>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZiYX5JlwS9nGkS2Q@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/22/24 9:55 AM, Andy Shevchenko wrote:
> Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti:
>> Hi All,
>>
>> Here is a patch series to refactor the ACPI ROTM orientation matrix
>> handling in kxcjk-1013 + bmc150-accel to share the code instead of
>> having 2 copies and then also use the shared implementation in
>> the mxc4005 driver since some MXC6655 ACPI firmware nodes also
>> include this.
>>
>> Note the mxc4005 support is untested, I will ask the report of:
> 
> I have briefly looked into this and I like this, except the part of the big
> function being in the header. Why? Why can't it be in a C-file?
> 
> Note, 3 users justify very well to me that shared code, should be shared in
> binary as well. (I.o.w. you may argue that IRL there will be no more than
> one of such device connected, but in case of DIY and prototyping it might
> still be the use case.)

It is only 1 function and it is not that big. IMHO the static inline
in a header solution here is much better then making this a separate .ko
file with all the associated overhead.

Regards,

Hans

 


