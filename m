Return-Path: <linux-iio+bounces-2615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D0C857C3C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 13:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A621F2355C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D377F39;
	Fri, 16 Feb 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASg9qEdH"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420341BF47
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084904; cv=none; b=picB9Fhn4/wUTLifpbXZnV7gF8WH+Su6KmasoQbtiYab+efAUo1Hi9/Vt7JN8X4sqOKHhaMvBZTPOExCpncMJyswllz7P5Y26rCQjIckhfezr2UA6kXf621TMdzXIK/lMHdgc4dwZqldcKfMJh2sn3ou9r3iAwrsvz5BfJvQALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084904; c=relaxed/simple;
	bh=9gu71VXpPplIQCVyKIRsMqN/K3pjeloajfi+cFl6xkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQZWjSJEQ6EuRpY5Wr7i81hSQt5o8r/le+cojk+OrvQWFjrGT8OEzzE7y6zH+sJB+94slGQw9LR3hPQqpdSEp4Hsz0++iOH5XPTqhAW/pfkXrm/pc/9FUlR3DWDPn9mFOz/a9L1Fdu7CbYTXff6idfafcOeJRFBHAIumk5bzN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASg9qEdH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708084901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3DUkRDDrSoQw/eAY/hcM0F781LBQvqrfXwd3GPhzYE=;
	b=ASg9qEdHlTjRgmpREXtzRiHcIc8Pp/X2QDMdfsr1GM4o4WC32s5c3RsAUqO8J6iM+jdmw6
	uvqtM07qb76AFJH3qXbeD8Nwpb/00TwjN9pXrL0SMbkQZ/IIQOxsPPgMSKCdNiZVAznL2/
	KOT5DATZt3N81vkDg2RerOKPMSCZjEI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-QQwzN0oFNXmqbRxcHTZ1lA-1; Fri, 16 Feb 2024 07:01:39 -0500
X-MC-Unique: QQwzN0oFNXmqbRxcHTZ1lA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a357c92f241so35365366b.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 04:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708084898; x=1708689698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3DUkRDDrSoQw/eAY/hcM0F781LBQvqrfXwd3GPhzYE=;
        b=Bzjj5Au+3h7wmxHWv5HCvcO2Ps4se6dBBJRlV0gqypqdk4BRkC6mYOEgSBzHClzAlE
         +ZNqbcl57874OTLggK58VvmiQ4Mdfj0c3wyGSdjkyX7wES14iiDkCV2Of2JUPeZc8VOl
         Rb1EtQvbRVuSrX27Bjozeq4qZYH52u6k7jVhjbqfPi23i34cYVp64fm52WlwRp2e/xiq
         amWygx4EnDXcsTVNMQF/Zi0LfEbhACy8K5dS60nQsJRHGPSZ1Phpbp11c/mmiwKS5/Ua
         5fSXlutYxD+AyEdk/D/MPZjfuJaRK4h4KQpCWvXFhMy/yBYdjQ0vZT7VaTBd1aC/ubJH
         X2ig==
X-Gm-Message-State: AOJu0YxbQeFKzBL6N0M7Yp7uTWyETbitZGYWzHD7A3ladVXArp1ZCYFv
	0rClE0Q6nCxVj50zFOMa8/Fo/ixBE/uD9CjWuxXELSsR5XQbMb8ssNNqITviiER1nalwZsW4m9m
	pBeM/lb2CxYkaLvLTvQS9HCr0Dvxw6p/StjHEllHCDyxnzezN000sbwTKiw==
X-Received: by 2002:a17:907:bb8d:b0:a38:a6b2:b329 with SMTP id xo13-20020a170907bb8d00b00a38a6b2b329mr2776026ejc.8.1708084898600;
        Fri, 16 Feb 2024 04:01:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7PhlBqmq5ssg1aRGMpjDwfyDX787/IOQZ1EgTn6J4JHHAX/LhS5VFbJSgAEOcqErtjDeAxw==
X-Received: by 2002:a17:907:bb8d:b0:a38:a6b2:b329 with SMTP id xo13-20020a170907bb8d00b00a38a6b2b329mr2776003ejc.8.1708084898272;
        Fri, 16 Feb 2024 04:01:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tk12-20020a170907c28c00b00a3ce49ab976sm1480825ejc.4.2024.02.16.04.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 04:01:37 -0800 (PST)
Message-ID: <343952bf-8222-41ec-8eca-13e1008efaa2@redhat.com>
Date: Fri, 16 Feb 2024 13:01:37 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Add bmi323 support for ASUS ROG ALLY
To: Jonathan Cameron <jic23@kernel.org>, J Lo <jlobue10@gmail.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jagath jogj <jagathjog1996@gmail.com>, Luke Jones <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Derek John Clark <derekjohn.clark@gmail.com>
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
 <20240216113545.33b46e19@jic23-huawei>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240216113545.33b46e19@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 2/16/24 12:35, Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 10:19:52 -0800
> J Lo <jlobue10@gmail.com> wrote:
> 
>> From: Jonathan LoBue <jlobue10@gmail.com>
> 
> Hi Jonathan
> 
> Cover letter should always include at least a short overview of what
> the patch is doing.
> 
> Long term this solution may be a pain to maintain.
> The reasoning is the DT path where we have moved over time to allow
> for fallback compatibles (same concept exists in ACPI even if it is
> little used) to be used even if we don't recognise a ID read from
> the chip.  The intent being to allow old kernels to work with new
> devices where they really are backwards compatible.
> 
> If that gets fixed in these drivers, we will have to explicitly
> exclude ACPI IDs.
> 
> Hopefully we'll pick up such issues in review though so this should be fine.
> 
> I'd like input from Hans though on whether this solution of duplicating
> the IDs generally works out longer term and is appropriate here.

The BOSC0200 ACPI ID is used in a lot of devices and the ACPI
tables of these devices are not under our control. So we really
have no other option.

Having 2 different drivers match/bind to the same (ACPI or other)
id/device is not unheard of. As long as the probe() method then figures
out it is not the right device and cleanly exits then this is fine.

I'll run a test with patch 2/2 + the bmi323 driver enabled
on a device with a BOSC0200 ACPI id which does actually need
the bmc150 driver to make sure that the bmi323 driver properly
refuses to bind there.

I do see that both drivers write to a reset-register before reading
the id register and those registers are different ...

Looking at the registers used for reset then on the bmc150 it
seems that the bmi323 code is writing the last bytes of the fifo
which should be fine.

And when the bmc150 code is trying to reset a bmi323 it is
writing to the BMI323_FEAT_IO_STATUS_REG. Since the bmi323
driver does a reset itself and programs that register
during init I guess that should be fine to since the value
written by bmc150's probe() will be overwritten.

I'll get back to with test results of letting the bmi323 driver
probe a BOSC0200 (*) device, before the bmc150 driver probes
it and see if things still work then.

Regards,

Hans


*) which will typically be a BMA250E




>> Changes since v4:
>> - Fixed comment location in bmc150.
>> - Fixed signed off by portion.
>>
>> Jonathan LoBue (2):
>>   iio: accel: bmc150: Duplicate ACPI entries
>>   iio: imu: bmi323: Add and enable ACPI Match Table
>>
>>  drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
>>  drivers/iio/imu/bmi323/bmi323_i2c.c  | 20 ++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>> --
>> 2.43.0
> 


