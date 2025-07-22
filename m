Return-Path: <linux-iio+bounces-21884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F28B0E54D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 23:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604D35430B8
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A8285066;
	Tue, 22 Jul 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dR/h70qX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C06F06B
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218960; cv=none; b=dMdVGX0VWqyoURQng/4o7Zca/KnKKaxoG8kImK7xMQdgM6xfGbmig/8QRF3QpPezF8aPa4dK6yRAQQevv3vJZ4q7d7bh77v29HgF93cguz53bBJZ4giDBJZ5x9P5XLbeLo3sCGverAy9T87I472mscvyGSW3PmnL/emdDU14GOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218960; c=relaxed/simple;
	bh=ZE/TOpGowbJekPnqxX6irREBLFL8rXFZ6e7QbrxGlDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLGJgrmOknGo12wUCQZ1I/Foum5th6EzfGZTyKs6YpzZxjV+2IiyvHyz1w5hljcW6ahhfHCHcPPwFdcUX8WNDBm+aqBLh9mqMPXexoJ+MHug4jwYfv+w1by1Cz5lrSEwH2B+Ex7O/5RtOBGepgga1nQccdS60+grQL0vY0o0k+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dR/h70qX; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-401c43671ecso152908b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753218958; x=1753823758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tgutpM3+ecON5U1EZ4+3DOjCX70RNyAOS0oE4ZvgFA=;
        b=dR/h70qX7TRr9M3x9YPz7vh0fSeYSeZlFtseFjkIoB5CdYME/qXI59iNzVcTubSQf8
         y4sFus+kr0Ez5vuX+0MApU29KsS0kXTmobo3xC8wml2BXzPbEox6h8UksqX8LHg1lnFp
         bqo71t9x8DeNfD91jns0DAwftYvTM+xmmajX+wgQJW2OtnyEAPSVdz+MiA3rbxHG+Qlo
         G8LDtteVjHoUhyfvxSEClQevDcHY9lHR7TxdPmn5R+VGIE0pbJU7W2YASuswqqVRm6VT
         XkRHNAd1CDhcK5BSkyY/By48zcP3AVOoXzFE3+cgDycuz/OzNoXqaIA73GaOBFstrnmo
         jIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218958; x=1753823758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tgutpM3+ecON5U1EZ4+3DOjCX70RNyAOS0oE4ZvgFA=;
        b=oy7KpZ2K1tMXKjvN7WxXM65FzqU77viiZVsmUE70Txb2LHZhh+CNE2ClJh81ED3hFI
         s2KicG1AyZbpemDnPbCHQv4P8Tax5t1T6O1K+olUWdeANw0k2uVBBusC7gzkHoDFoWfT
         LCuiBu+16ijKrpKoQNSbjwXmjURo6blpp7qf+fI2wc6IATf0q+FtS2HIoSz++4dlo9KQ
         26zPBPioOCFhNIk25kPfyHZFK5cw7koDUS6ecR6kpDioqRGLBYz3G2j5xkTPUkeO7WZM
         OR6JrsJpG8/oc7c/8c1EPZMiqOcA/x/NSjYgfaUATqAcI70Q5N1RDJ8yy6cPbW4NhozQ
         OLig==
X-Forwarded-Encrypted: i=1; AJvYcCWFa0c0Fc47s3XC0nJ1i7rnuqyLlyn/8VTIAWfRossnU8ZmBbau/bJ5nH7ArS+c7IrYuwMuCODc3J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaDMuW13rlqJDNSMVTcKxisEFHTFk7ZLoEct4xncixsAXTaFY
	+CNAjGtdKIRtFg/FOs/oXB8rw7HtsNmeQDSwjBsM+o+w/EwjsbIf3bIi5TghYGXovIs=
X-Gm-Gg: ASbGncvLCYn5eyKtPYoUP1vE8g7eH2PvlVBTj9vfob9Hogv4Y5lHOqy/QVr5CxJXHSJ
	GMdM8FD6qkL6PkbDIPUTue5UNq77sCsw0ZgN/Qgm761vC2zDUapyjLak4vVkEaK40sQGD/tdS/4
	8WcpVoJfDekWiVbRLTkCDc4zkGIhVH8G8jPz5JD0TR1aHGSrgEJNWo/vykR5hrGYc2FzjkzVYbV
	r+cSVA87U8FEWlUdl1/JUNoQE/AZpwgBdy9uJheejmBqVMV7Y2T/2EPIfJuP+XTBjoxuVps5zOe
	zouMkBYP6kfQuPtGcKIZGNfAZDd3ryE+kpVK7AqGt3QUScaV5+fSmmtcbTabgbivJBlpF6REem/
	pSInzN9DKmkPxPQ/IeDVCakdrKWMtwC5bANsSRfuoiU7eeNg7pXt/8biDvqdpDTCURWe6Zwl+3A
	o=
X-Google-Smtp-Source: AGHT+IErYsEQlXxI7pFpPraI6RvhcDBUJh8XyJwxt2mUeS7ZpHZNeZWE1+cTKbIWmSYhMxEmYfWCLQ==
X-Received: by 2002:a05:6808:4f21:b0:40b:1826:34c1 with SMTP id 5614622812f47-4272f778a68mr362949b6e.6.1753218957671;
        Tue, 22 Jul 2025 14:15:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7? ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd565d35csm3361010b6e.40.2025.07.22.14.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:15:57 -0700 (PDT)
Message-ID: <8f924da6-c5f6-4f88-9cb1-3e7e1aae491b@baylibre.com>
Date: Tue, 22 Jul 2025 16:15:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
 <a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
 <CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 10:55 PM, Akshay Jindal wrote:
> Thanks David for the swift and valuable feedback. Please find replies inline.
> 
> On Tue, Jul 22, 2025 at 1:55 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> For debugging, using debugfs would make more sense.
> Will it make sense if I simply give register access via debugfs?
> Something like this:
> static const struct iio_info ad7606_info_sw_mode = {
>     .read_raw = &ad7606_read_raw,
>     .write_raw = &ad7606_write_raw,
>     .debugfs_reg_access = &ad7606_reg_access,<---------
>     .validate_trigger = &ad7606_validate_trigger,
>     .update_scan_mode = &ad7606_update_scan_mode,
> };
> This way the information about data status will be available on demand,
> without exposing any special sysfs attribute.

Yes, this would be fine.

>>
>> For application level filtering, why does it matter if we have
>> read the same value before or not? The sampling_frequency is
>> available, so the application should be able to deduce when
>> fresh data should be available based on time.
> Agreed.
>>
>> I could see maybe polling this in the kernel in order to implement
>> a buffered capture mode, but not sure passing this on to userspace
>> is the best way to go about it.
> I had sent 2 patches. This was my PATCH 1 of 2. In patch 2 of 2,
> I have done something similar to what you mentioned, not exactly polling,

Here is what the IIO docs have to say about it (reading the in_light_raw
attribute is considered INDIO_DIRECT_MODE):

 * @INDIO_DIRECT_MODE: There is an access to either:
 * a) The last single value available for devices that do not provide
 *    on-demand reads.
 * b) A new value after performing an on-demand read otherwise.
 * On most devices, this is a single-shot read. On some devices with data
 * streams without an 'on-demand' function, this might also be the 'last value'
 * feature. Above all, this mode internally means that we are not in any of the
 * other modes, and sysfs reads should work.
 * Device drivers should inform the core if they support this mode.

So I don't think the current implementation is really in violation
of this.

Additionally, changes you proposed in patch 2/2 would break existing
users by returning an error when it didn't used to, so we couldn't
accept that.

If this was a new driver, we might consider having the raw read
poll for fresh data so that each read was guaranteed to be new
data, but even that change in timing could break existing users,
so probably not something we would want to do now.


I still think there is a reasonable workaround of just having userspace
wait for the sample period between reads to guarantee fresh data
without changing the driver at all.


> but reading the data status bit before reading actual data.
> Both patches are independent. Please have a look at that as well.
> 
> Thanks,
> Akshay


