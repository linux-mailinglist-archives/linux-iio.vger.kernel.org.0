Return-Path: <linux-iio+bounces-4431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0728ACC42
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 13:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE4E1C20B19
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16281465BE;
	Mon, 22 Apr 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO9n9bww"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6614430B
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786353; cv=none; b=aLBoqhsbbSgK/W/EBk1dr2BuHa1MnxOM1YayCZe/48beVpueYN7ZKOjGhNoUiI1I8P179JSTH9UEI4BQtEsFMpKH82sT8MSzTSW4c/SVBio27YYn+0JUtbUVSDimUoeZVPuaofhCKupGbp9UVrkjmP/lVhPa4MqleSUapxzZaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786353; c=relaxed/simple;
	bh=VewZmz2FPY70zmQBK29bE9SI8Fhsf0MxD3GJGO1JHmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oq8h6zv0A6hWac9wTJHpcCG4c+pOebEyYmiZl/vdSaSSWdd3ZD7IeTCNHg2mFyDxYdC/LmcCvTwi+SVVXKO7wfUvySKooSmLoYQbkWk+Gncn2FT7B96TYX9q/aGaLIoXvkR6H6pzY8x8cTQZVn3wx3EMqdyqMvcVUE1IlIswEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO9n9bww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713786351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSVNOiP03+U3RTcQwsX3oH7pwlsQ2kw404w3SlDVhD0=;
	b=YO9n9bwwJ6VA05gj1mgAi8FobHRcWz8u74Krwy2n6sPVVSf27HIFFvHlnHxPDYq8yC/hna
	xYZrqcAPRPHqMC3B5Gsa++dCJs5g24lJGODAKxo3sjmN1mHipthpliOkWGEb0YpxVIxI/Y
	+WcICDi0vm0qp+Nn7STCUQTd1zYb61g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-SN03tl3KMCKcDkMk9K5Ewg-1; Mon, 22 Apr 2024 07:45:49 -0400
X-MC-Unique: SN03tl3KMCKcDkMk9K5Ewg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2dbfe2d860bso29974651fa.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 04:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713786348; x=1714391148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSVNOiP03+U3RTcQwsX3oH7pwlsQ2kw404w3SlDVhD0=;
        b=bwFR3Q1t0++IZBbTPIXOnfp8fFdoOEdvBvcdXsadn4EZ06tWbj6y1/FG6X5qreBJ6h
         fgxnf2D2sF6CkgY6QzrLbLg+qkPixna1ik1KH+MO7KPIpVqSRU5ubJJ/KgD6Z8qJN6xR
         HeGd4OAYs9mnJshNuVjFFpOMx5R6Tte5PLOcVflXh/On57755wFdLvvCISADDMgriVv+
         w+8ZiEZj94SG4iWpOoSKymwxAM2TLvIGMXVmqcOM2f/YF2pjwxODUGKJcM5npKAXKIsd
         8OvVIMAqVKX2bTUXO/JMpXJUW3CmGtq9h1hRd7bNaroRKhpCKSiF/A5iOBxLd/xefsWf
         8NHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0GDimFWF4tX18C1xEMIWg6xcyfh2L0PPVgoaq95U1GtFfkWnQGTY8E9DcmVFKHNmVMByKEU67NzkgtUwXsO2XhFAnjTwU8ABY
X-Gm-Message-State: AOJu0Yzu/Ac+TClntg9j3VvfV2PTQ513DSH+iRC0CYCGB7emXzDkJlmb
	u3Mpoymnd76oij6uE3EwRBen5YBvq1ZvEUs+PHVZ7PsnBbJFP7Ah/Hdh3NKs0PFUqCspoWgrk1S
	tHtBz949+NViqt3YAxIywLhDLW2f8WAhcp+4PXTxJ6x4IK1RLRPH4vNVHxnEKjF6I/oHq
X-Received: by 2002:a05:6512:b8b:b0:515:bbe9:f208 with SMTP id b11-20020a0565120b8b00b00515bbe9f208mr7198406lfv.19.1713786347285;
        Mon, 22 Apr 2024 04:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkP8fpE0uMz7hZXEazyTAxZleIyrrueKmV/gYosMvCKM7EgYwdsRpWnlg9DiHOywYVxQeAYA==
X-Received: by 2002:a05:6512:b8b:b0:515:bbe9:f208 with SMTP id b11-20020a0565120b8b00b00515bbe9f208mr7198389lfv.19.1713786346857;
        Mon, 22 Apr 2024 04:45:46 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709063fd200b00a524b33fd9asm5633040ejj.68.2024.04.22.04.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:45:46 -0700 (PDT)
Message-ID: <1b497e81-3e2c-4b07-a922-79d92054d6c8@redhat.com>
Date: Mon, 22 Apr 2024 13:45:45 +0200
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
 <81f83cd6-6d17-4e11-97b6-7f1f11bc3078@redhat.com>
 <CAHp75Vfsnffq8J=j9-8w2VWHyMp4e5gw7F11S8XMdMN8TXMwKg@mail.gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vfsnffq8J=j9-8w2VWHyMp4e5gw7F11S8XMdMN8TXMwKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/22/24 1:33 PM, Andy Shevchenko wrote:
> On Mon, Apr 22, 2024 at 11:24 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 4/22/24 9:55 AM, Andy Shevchenko wrote:
>>> Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti:
> 
> ...
> 
>>> I have briefly looked into this and I like this, except the part of the big
>>> function being in the header. Why? Why can't it be in a C-file?
>>>
>>> Note, 3 users justify very well to me that shared code, should be shared in
>>> binary as well. (I.o.w. you may argue that IRL there will be no more than
>>> one of such device connected, but in case of DIY and prototyping it might
>>> still be the use case.)
>>
>> It is only 1 function and it is not that big. IMHO the static inline
>> in a header solution here is much better then making this a separate .ko
>> file with all the associated overhead.
> 
> Look how the i8042 RTC header became a disaster. :-)
> Nevertheless, this can be part of the IIO core for the ACPI enabled
> kernels. Which eliminates a need for a separate module.

Putting this in the IIO core, with an iio-prefix, so say something like:

#ifdef CONFIG_ACPI
bool iio_read_acpi_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix, const char *method_name);
#else
static inline bool
iio_read_acpi_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix, const char *method_name)
{
	return false;
}

in include/linux/iio/iio.h ?

works for me and that also avoids Jonathan's worry about using an acpi_
prefix in iio code.

Jonathan how does that sound to you ?

Regards,

Hans




