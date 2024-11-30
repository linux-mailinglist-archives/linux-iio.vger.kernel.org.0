Return-Path: <linux-iio+bounces-12860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417D9DF15A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65E0162C99
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E41A01D8;
	Sat, 30 Nov 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NES5W6+Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AA19DF4D;
	Sat, 30 Nov 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978444; cv=none; b=G02fRpNQbDmhVob2i2m7KWRoMBOKDS53VXP/M/DTWMMFT8LbkBgSWs0mJuqnjlSKc7LUEHeEEy2mEsnFhmgO792TL5cHsxDvyaWPxHrv+xAZBA6txT0wj9fh5K8eUJxgJ4WUZ288BvbGrdmOjKtLch8zk89mNQZiVl01mcUBp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978444; c=relaxed/simple;
	bh=92PhFQce9FtDEUc92I3nyICR45LQNMich6Qadn7I7rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=at2F70l3amjrcq0BjwiVXtW3kII6+Mbwjb49oPI0mJc7wlYh9/pbPCa26lauajijviLzwrxSxv15FR5jQlH7wMRYDe944Uq1LgF8qfjr+Eiw2GQ6Hyyl2tV/f7b4i/fDVab04MhvpN9mVem0dr7ZOfdVUCjCIPriGtc3vrMsYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NES5W6+Z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so23067791fa.2;
        Sat, 30 Nov 2024 06:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732978441; x=1733583241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auyeQ/WJf0LlFGEUDmM1nqoy+rzADdBnKGFsMbkyEUw=;
        b=NES5W6+Z88sOYkmMD/ITVVSxyWi2VFEqxYfT6jmpCAdFPCiz+uqpe0PuFCC9llHL3c
         L0+HegVdp1u6tccdFuVVcZJpxp9cS7lrSv8Jh2zn11L8pi0XXAmYlrd7xkyVBdQRLdEZ
         2ySpmqYQ5RrdfvUKX1f7z7WSSoCfe5eJo5Siw+Et06N9+yz50kC8unIsrLJe/5pfm7Bq
         Q74Ws5Am1chVs44l9j5NnytyWUy3bsOzpX73fY4rQeHU2EYwrqB7biByBF8hfKH9WJUu
         WH2FrOzZu3w6h4LOjLZpRgyJjz/gScCVuOUaw3DJzCGULqdSYPFEq0ISW8LF/dqtcwwr
         Ey9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978441; x=1733583241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auyeQ/WJf0LlFGEUDmM1nqoy+rzADdBnKGFsMbkyEUw=;
        b=i+X0JQC7SVZeFcvTOttVCI5SkPU893PdmeVcmAD2RkvOGEaz2arRCh3pKQazEakhGo
         dHQgKr5fc2gWPnGCkYK/UR3vShkxVqn6WnlVZ5GrkfoXm/ckdVfXUjLON7/bkONfD+nW
         uvG7Hxj21QgvjTR/bnybI+XDM4iYdkpsgba9SnIjckdLR4z8K2eLKiY4ojBa/4FamHrm
         dWuzFrAwxi66teFO3EWIu6Qnsk3O7/Un3ggTQ698Uu5RaTAQNqFZ5wE75/EHEtxjHh1V
         maK7jNLZA6twahB3/NN4VvA/dA3jppok3M9C2bf6rzQ3fN40VF14Uh8aoPMaFOGw9Mag
         snYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUlunysLOloJ4OE35Ksd0vH56ocbBkmC3owV4+VbnLQWe05NMr1pv9MctfzPwpF7HdZ9NVr3w5pt+H@vger.kernel.org, AJvYcCUejfLPXhNRIJ0cuWupsIbknR+Km6WiDtdhLtggIDT/4rpxSIZfqZ2gjfabKWJTBKW1UWmVHIpqvBPb@vger.kernel.org, AJvYcCXTajAoMVsIQPRzC/X3L+L3ZPx6SHRB1HvJhZXzHJJEiVRUlJYP4a1XbXZM353wsxUjiy/7hIJtupuEKCrB@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZ9wzm6wp9pE7Nw/XvX4+gsLrMb5RQWlQOzOkOmZ6vN63IP7X
	4yV4hcZ8jINS17isQJVoWbDhfaAHeMJk/QKln2LxPErVPgcIZbHT
X-Gm-Gg: ASbGncvtlas+QwgrEVDNB9kzr7jVx3iQzaydkYgZF+53Pn1hSqQuIK/a0P93X+Z0+OP
	OOk7nufm78yW8Oa3ibV5E18N8xdzexaVF3u0tuhS1eGc9HAog50rGijmdu250I2sqrojda+s/0n
	keRcsTEJlqfkqKbWL5o8Ey6Y+4grw11DxfC+BVvTBGTZLc3VElSGUKrqjvffkeODerJ3MusvcrR
	1I5bpFYjFvyCTCRz+F/ChHUO5G/HO7bZlfij/VsP5LWuYvOF2EnWLKZYr19cVcItJZZxVxNErhR
	9wo8g+t54QMYAAMl0UStQ75jnnSlll0=
X-Google-Smtp-Source: AGHT+IH6wmJukU/nF+TIlMtoDRRBXaZ+XMVXEbGWauhGgOh3ZIbdgC6h0zDEhle0WnRHjQe1X7rU/Q==
X-Received: by 2002:a2e:88cb:0:b0:2ff:d81f:2d33 with SMTP id 38308e7fff4ca-2ffd81f7beamr86649811fa.28.1732978440425;
        Sat, 30 Nov 2024 06:54:00 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbdae77sm7176751fa.28.2024.11.30.06.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 06:53:58 -0800 (PST)
Message-ID: <66cb5639-550b-4c00-9b90-b58dcd09405d@gmail.com>
Date: Sat, 30 Nov 2024 16:53:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Drop BU27008 and BU27010
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arthur Becker <arthur.becker@sentec.com>,
 Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732819203.git.mazziesaccount@gmail.com>
 <20241130143842.34d29a51@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241130143842.34d29a51@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2024 16:38, Jonathan Cameron wrote:
> On Thu, 28 Nov 2024 21:34:54 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Drop the support for ROHM BD72008 and BD72010 RGB sensors
>>
>> I accidentally hit a BU27008 data-sheet which had a big red text saying
>> "Obsolete". After a few queries I received a word that the ROHM BU27008
>> and BU27010 RGB sensors were cancelled and never entered mass production.
>> Supporting not existing hardware makes no sense, so it's probably best
>> to drop the drivers and dt-bindings.
>>
>> There is still a RGB sensor from ROHM called BU27006.
>> https://www.rohm.com/products/sensors-mems/color-sensor-ics/bu27006muc-z-product
>> Based on a quick glance this should be very similar to the BU27010. If
>> someone wants to create a driver for this, then the bu27008.c might be
>> worth looking at.
>>
>> As writing of this I don't have the BU27006 at my hands, and when I
>> asked about creating a driver for this IC from the HQ ... I got an
>> impression that at the moment ROHM rather pays me for doing something
>> else. So, currently I have no plan to add support for the BD27006.
>> We can always dig the bu27008.c from the depths of the git, if it later
>> appears such a driver would be a good idea.
> 
> Applied.  I'm not going to rush it in because a driver for hardware
> that no one has is not really a problem as long as no one does any more
> work on it.  So queued up in my testing branch which will go upstream
> next merge cycle.

Thanks. This makes perfect sense, and I didn't expect them to go in 
sooner :)

> You have my sympathies wrt to wasted work!

It indeed hurts. You do always hope things you tinker with would be 
useful. Well, not the first cancelled product I am working with - and I 
believe not a last one either...

Yours,
	-- Matti

