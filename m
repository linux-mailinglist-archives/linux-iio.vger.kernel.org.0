Return-Path: <linux-iio+bounces-3540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A095187C8B1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 06:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5575F282E7B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB012E74;
	Fri, 15 Mar 2024 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ZJcHtxeH";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="LUqGr1Wz"
X-Original-To: linux-iio@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569578BFB
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482274; cv=none; b=tS8IykJLalT7vOQmiU4OdYSjPRWoY8AHxoXCrBK1u2CF/Goh7mXDOiHy2GnBF6E4YWmL19bZUROqoDxHzMFTQN7/XpofRzAFyiKRXKdIEGQjg7IzyaGcAmwlVXLzn2ogF5QQ0q5c3yana2/Ylp/+u1d3q1msSzoMS0V3cwjK5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482274; c=relaxed/simple;
	bh=689CVoU4hSkkdi+xckfkMtotCp/WIXunG9G7U95p51Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp1QfPvZYvuZLWle6eKVc8w1ZPCXA4ZFXR0W5FswYlDaBhabV1xODhh9yHvsMt3I2dofMNt3QbhUK9QfZM0XrqWsdCOuwIpxp9yl90EmFUn8hDaIo/jf5onnSxxVFmdwFjukQyrNZy6ToaKo4+GOzNUEyNFitGHlUGnVTURMbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ZJcHtxeH; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=LUqGr1Wz; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1710481673;
	bh=689CVoU4hSkkdi+xckfkMtotCp/WIXunG9G7U95p51Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJcHtxeHYquE6WIV8k927gOu21f2DOZPiugLeOnWdLAiwGTCI58XS1EUBhYk8sDJY
	 i8WahKViHF2cxu7MjATZAFrErpGxtV7LF0gVM39W0KfZrG9sU6yXgcwtLtVOIa/I7N
	 BPf3DxnAbQW4Cnuuxq3Vbx8TytBJ+g/POi9Upij36oVKtw9GFFPzK/L2gFnQwVVM46
	 r5xRMRIs00wdoua/eN+Ncyqs5lHPJZgQ+j+T3yC9vI+VrE3+LeNhErEtWXIAKHFeWb
	 ScgryDSEzKDyQpt0aNOtJCvrFFUrPo7t4i5aPB8MN/G9ifuZlD9KACdZ/LjTNWkzT1
	 jdxYI7Af8ycWQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id D2F6BA09
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 14:47:53 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=LUqGr1Wz;
	dkim-atps=neutral
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 6FF9A6E2
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 14:47:52 +0900 (JST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so1703357b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1710481671; x=1711086471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYMS5/DXfaIpI+pTTahoABUn10+eXSS/XEewvoMgNdw=;
        b=LUqGr1WzOm+02rv+c8Ap/x7k2syQ0pqh/poh5vY1pWyas4RZflTBomX4kIx9N2rWBX
         wL4PajSDOLWQKlLMQkJ/G4rsnagF1fOejFuL+dpnsMDKr4tjWD6/0+uZl8ftUtcyZWB/
         hyIeF2HwkBv6NeuRWZFCM7vJAxgYbdaEsUO65YzHPXtw1l4SvCTnswlCS6KUZaS/Aw1D
         YMi1vWIHzlujqA4U4MaTg2novA/ZNcNUVC8TpyhAPCB0PFaWUJrgSFknrRJFI/n0bNwp
         bt3QwOIX/W4M+rBCP0hu/wi+MdSzVFoEtMVVLzoZcmqxXUGPmwb+ZDeuvH9HAkqoRxDj
         XxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481671; x=1711086471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYMS5/DXfaIpI+pTTahoABUn10+eXSS/XEewvoMgNdw=;
        b=lK3bHb+3dFQschlOK7dGJt48TzlmuaLL2TAz9udOePZao8uwc/c1aROjqSsVXADt1Q
         SySfE5o7fadWm02gbXGGStLeoAhg0UMEpNeKIHPhKdAp4aGtTZhnaPxLeIvrE0s09X24
         X8db1L8Q0mMWwyIJfGelNVSPP9Mff4PPyJeni3mIM0WXWwijsI355DZ1pjer5Mm7Zlol
         E5SZr+cQ5ygxIv79FsOTOG8XNQXxuHcdk4JxsjSJtyf4E7+Jl82vWC/XLzELY0s0ZcPZ
         pR6tgYm0orpQvYlk6LSYad0ZOBQCqpG6mg91qKqUlifXrfBWfmOiUeEAcbtDFH1RQi+S
         Le7w==
X-Forwarded-Encrypted: i=1; AJvYcCVtJ8LATIXHCwyvs+aYUqo2UEh/oYVPMoMoXB/KT06wJQ9qH/YJg72KpqAHEhZKjDQ/Djca5jVGbc7W/K+UT52elYhuyAjxBgrF
X-Gm-Message-State: AOJu0YxX8oV/NdrvzUBB4PfDTWd1BooFKpe0ASBhHxxdtonh7/VTrT7m
	prYapLNMyJJqPdu7U9VdtUCzNo/dFI8Du+2Pr5BSkFW8SzAUzxFi7L1rAxkVhD6eOr83dbKhQEC
	FFP/rviht9h3l+0+Yc5gc98ZqfjAi3GjQ1zsv7ICNxtm6U4pZ+hSQAeRhde8=
X-Received: by 2002:a05:6a20:6f03:b0:1a3:4438:be20 with SMTP id gt3-20020a056a206f0300b001a34438be20mr4088613pzb.48.1710481671420;
        Thu, 14 Mar 2024 22:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCUH0IHN6AHGei3jkhHFFHGzGL76YbEw4+7QRI/GsRpKTjLzKIfiwMSllJzEGapNdawt2QAw==
X-Received: by 2002:a05:6a20:6f03:b0:1a3:4438:be20 with SMTP id gt3-20020a056a206f0300b001a34438be20mr4088593pzb.48.1710481670857;
        Thu, 14 Mar 2024 22:47:50 -0700 (PDT)
Received: from pc-0182.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id o197-20020a62cdce000000b006e68b422850sm2635895pfg.81.2024.03.14.22.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 22:47:49 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rl0Q0-002zK0-2A;
	Fri, 15 Mar 2024 14:47:48 +0900
Date: Fri, 15 Mar 2024 14:47:38 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <ZfPg-nMANUtBlr6S@atmark-techno.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
 <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
 <Zd7hSOw3_zosyrn3@atmark-techno.com>
 <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
 <Zd7qz1Qte8HWieF_@atmark-techno.com>
 <20240228142441.00002a79@Huawei.com>
 <Zd_zB_ymxkx0HB3q@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd_zB_ymxkx0HB3q@atmark-techno.com>

Hi Jonathan,

Dominique Martinet wrote on Thu, Feb 29, 2024 at 11:59:19AM +0900:
> Jonathan Cameron wrote on Wed, Feb 28, 2024 at 02:24:41PM +0000:
> > A given IIO device driver may create multiple sysfs directories (registers
> > device + one or more triggers), so I'm not sure how this would work.
> 
> Thanks for pointing this out, the driver I'm using doesn't seem to
> create extra triggers (iio_trigger_alloc doesn't seem to be called), but
> the current patch would only affect iio_device_register, so presumably
> would have no impact for these extra directories.

So my device doesn't have any "built-in" trigger if that's a thing (let
alone multiple), but I've played with iio-trig-sysfs and also had a look
at what's in the tree's dts, and as far as I can see the 'name'
(/sys/bus/iio/devices/trigger*/name, also used when registering a
trigger for a device) seems to be fixed by the driver with parameters of
the dts (e.g. 'reg'), so if there are multiple triggers and one wants
something in the triggerX directory they're supposed to check all the
names?


So as far as I can see, I keep thinking it's orthogonal:
- devices get a link as /sys/bus/iio/devices/iio:deviceX ; which contains:
 * 'name', set by driver (some have an index but many are constant), and
   does not have to be unique,
 * 'label' contains whatever was set as label if set
 * 'of_node', a symlink to the device tree node which is what we
   currently use to differentiate devices in our code
- triggers get /sys/bus/iio/devices/triggerX, which has a 'name' file
that probably must be unique (as it's can be written in device's
trigger/current_trigger to select it)

> I'm sure we can make something work out while preserving compatibility,
> the patch I sent might not be great but it wouldn't bother anyone not
> using said aliases.
> 
> aliases are apparently not appropriate for this (still not sure why?),
> but if for example labels are better we could keep the current
> iio:deviceX path (/sys/bus/iio/devices/iio:device0) with a label file in
> it as current software expect, but add a brand new directory with a link
> named as per the label itself (for example /sys/class/iio/<label>;
> my understanding is that /sys/class is meant for "easier" links and we
> don't have anything iio-related there yet)

I've looked at this /sys/class/iio idea (could use the label or fallback
to iio:deviceX for devices, and name for triggers), but /sys/class seems
to be entierly managed by the linux core driver framework so that
doesn't leave much room for compromise...
The links there use the device name (so iio:deviceX for devices), and if
creating such a link fails it'll also fail the whole device creation
(cdev_device_add() -> device_add() -> device_add_class_symlinks()), so
my evil plan is foiled. (/sys/bus/iio/devices links are also
automatically created by device_add() -> bus_add_device() from the
device name)


I guess we could manage another new directory somewhere or haphazardly
create extra redundant links in the current bus directory, but that's
not exactly something I'd consider workable given there is no possible
deprecation path down the road, so ultimately I still think the aliases
patch I sent is amongst the least bad options we have here:
- there's currently no alias for iio so it won't break anything;
- even if one adds some on a device with multiple iio devices all that
can happen is some indices will be shuffled, but paths will still be
compatible with all current applications.


Did you have time to think about this or another possible way forward?

Thanks,
-- 
Dominique



