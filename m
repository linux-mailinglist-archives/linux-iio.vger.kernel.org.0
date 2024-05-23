Return-Path: <linux-iio+bounces-5225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F58CD78A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EC9B20FCC
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DBE54C;
	Thu, 23 May 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUJ4AOym"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0212E48;
	Thu, 23 May 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479140; cv=none; b=djIxIoJvG6qrNvx5e0ARA1QQFPVHRJrnr7EjazuyTno6MbpH878tlrnnIqp9WM2zYF9FDvyPVwbpfdiHZDEJqWnLdCoJFCbs+MDAQ1IVl2L2txg1f8FZRgrJEuclnnYzcxpFPIsK1e+X6abRbGA2rsXYQ5fDEBMKqU1HTIpDyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479140; c=relaxed/simple;
	bh=mU+FNvS/AcdPTacPDvLEp1WhMI3Ky9tIAnHzccSAn9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L41HxztJqwWKei6lT5FfQOyOn3CTc39qRny85ELz2FG70cWxEC8HDGDNiPnOUNW1ffivSFI/CCR4VGmajFFgeI7jpbcMJTezFcGWj4WByiSafr5XYV2Isk6iwbjFUwp/bgm6RFPXRilrX8nj6UXXnrr67PDRdNzvQC69wNWxYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUJ4AOym; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso5319042e87.3;
        Thu, 23 May 2024 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479136; x=1717083936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTVgDid7IOYG8yxCQcsjVDpyySVUiCKA89ig1j3KlAo=;
        b=TUJ4AOymjcK0dU2sXbNuWw4/mJ83sPBbnzlm1ZxuLNv08DGenx/+1u9yYc20EcVHkv
         22XEEOqtMUSvwRhYnF4dG8g7Qj++ESRJuuIyGGXC+VS+OoTITgHz8zKR3YDQKnqv61Zm
         2BXpjvDNTpcAM/HQOkuwioykpdOX6y2qgwmANqRIOX7FHkiTyLs/pg4QdivjdQbMR1PZ
         XRt8FNK9RLWYpshmkeP8L9lMT/zjEyMEffi1BryVZMVT8tLe4FYFmKaabAbKSgiX7ARi
         Xn2VUBMcBJdOGM5h0z+S2n3OQmcJ2aQ/OneDV87rQ8FrLL/kSJ4hSi8R890V5EaNw4BO
         n7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479136; x=1717083936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTVgDid7IOYG8yxCQcsjVDpyySVUiCKA89ig1j3KlAo=;
        b=h0miXgfOVrHEN7k9EW07Ir83yys0+EXxuJcBKKSLpHRucaNdoXO6OmtfeHElLizWpP
         YG52HaoiqqfOw5uJYZ8dfyJk7sD1nA/aXqUVxQo/39z4Qp/I7P8r4fGq/p+V8HwPf+s2
         UzjS/hTwbVyOFPTk2hCz3aNZnkzSEG/kzhEYocpQZSPzpOqFNu2hl8WO6WvJeFahVIAf
         zo18D55T0g4IHz4Kpmq87RclNoK4smngMX7JcHkY/HqkTzXb1Ip/5eXfKD6tILkEfsMv
         JInrgetwpKMFIav2KnPq/PqHBLcQafwVMwNDf+uix6qxN7gZT2JLua9pHyDVBs5ZETrC
         FD6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjNe8lN3mwTyzOYWLcVMeBkNN9p5isGYiuLnGbBV4iQTyxWi+huQWGYqyQQ2ivmrb1UpGmNAyZj36ia4vJ6vWdRahCO82O1c5/iOHKPdbfBNx20+J8JzpcCY5yHNhb3KT0bRrBEfw1
X-Gm-Message-State: AOJu0Yz0DHhoenqFl8kUh11ldUWmKOas99rnhfHc/Hpo4dp+j+Eah1Ww
	9KwBr0CMD10dAJKViHp0H5yDwd5J1VBUCsGcOdntXL2ppv+HfvWQ
X-Google-Smtp-Source: AGHT+IEPgT+ia7w9g4KzcuYONIVbVvnuleepnPuPJ9aV5nLPi9AylMroBuiAtwaRIQ59hgFPcfwApw==
X-Received: by 2002:ac2:5f9a:0:b0:51f:13e8:3729 with SMTP id 2adb3069b0e04-526bee937cfmr3420868e87.20.1716479136215;
        Thu, 23 May 2024 08:45:36 -0700 (PDT)
Received: from [192.168.0.31] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad6ccsm28456445e9.32.2024.05.23.08.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:45:35 -0700 (PDT)
Message-ID: <17adc0d0-55c1-4608-a4c0-93f9911296f8@gmail.com>
Date: Thu, 23 May 2024 17:45:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: hdc3020: fix hysteresis representation
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240523114336.532428-1-dima.fedrau@gmail.com>
 <cef810ee-bb2c-4588-baec-7edfc74daeea@gmail.com>
 <20240523142849.GA558466@debian>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240523142849.GA558466@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2024 16:28, Dimitri Fedrau wrote:
> Am Thu, May 23, 2024 at 04:12:37PM +0200 schrieb Javier Carrasco:
>> Hi Dimitri, a few comments inline.
>>
>> On 23/05/2024 13:43, Dimitri Fedrau wrote:
>>> According to the ABI docs hysteresis values are represented as offsets to
>>> threshold values. Current implementation represents hysteresis values as
>>> absolute values which is wrong. Nevertheless the device stores them as
>>> absolute values and the datasheet refers to them as clear thresholds. Fix
>>> the reading and writing of hysteresis values by including thresholds into
>>> calculations.
>>>
>>> Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
>>> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
>>> ---
>>>
>>> Since absolute values are used on the device, the hysteresis values are
>>> influenced by setting thresholds. Is this behavior in line with the ABI docs ?
>>> It can be fixed by readjusting the threshold clear value whenever setting
>>> thresholds to have the same hysteresis value as before. See some example below:
>>>
>>> # echo 25 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
>>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
>>> 24.727626459
>>> # echo 5 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
>>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
>>> 5.127031357
>>> # echo 35 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
>>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
>>> 15.381094071
>>>

> Hi Javier,
> 
> thanks for reviewing so quickly. Do you think I should correct the clear
> threshold values once I changed the threshold. I have an example
> provided where I set the threshold and hysteresis. After setting the
> threshold again the hysteresis value also changes.
> 
> Dimitri

I am not sure if I got that right. Did the rising hysteresis change its
value automatically from ~5 to ~15 by just adding 10 to the threshold?
If we are treating the hysteresis as an offset, then it should not
change its value i.e. it should keep the configured value.

Best regards,
Javier Carrasco

