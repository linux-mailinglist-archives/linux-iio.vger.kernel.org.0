Return-Path: <linux-iio+bounces-13444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AAF9F1E54
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC43A167C1F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377F18E37B;
	Sat, 14 Dec 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isDfM8xF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A2154C00;
	Sat, 14 Dec 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734176772; cv=none; b=A0EjFaWRdop/U6x/0hw/t+vEmKpF718cwQJJnzxbog6ZrQf8VZAoYNBZ6uOL4uHvb2lbE3VimK7smMp7hAAKeJzXks3azUwPDF19CvP7xLLHiSWBoQE7O2SCBQ2bLtQd53I6tMmcOjvurMz2XjRLlMvBW/2KRDr4Jz91/SLw0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734176772; c=relaxed/simple;
	bh=LiDT+4Sqgdk41JHmh264e+RxJgrj5cF6Q+GLadxXmRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0c5UtVbhtfh2fwE+0NU5dXGoik8NW1sEVP2LMIygule2VKbsw4/M0c7j5YRsoEC3n7gAIxf46px9SrXDLWB/zOyNtdB7tLGZUwmySV5wxdYcDc2P9egIvFvGIS1pZEnKaHoC1hldiVE1jyFZAJzQxA7SoymyXZDjb17BMVGNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isDfM8xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE64DC4CED1;
	Sat, 14 Dec 2024 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734176772;
	bh=LiDT+4Sqgdk41JHmh264e+RxJgrj5cF6Q+GLadxXmRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isDfM8xFVwh2FdN7tQAcXFJZSTx9kCtWqn61QiOszlCRQB1YFO+CPWn4GcyFbEfZW
	 yuwlCZAQYh+OvSDa4genjEMJ8D5IkQNaRId0s9JgQZxlT2lTwGRUJ92ohRJD2Jr26c
	 +kT56j/unPeTZR0K/zT2Vof72CugqnxONTD7uzMaeMoLrEZt9w3gcSbgKQ7sDYGcyF
	 T7CW5Di1iY5KWlMG5QCdVo8C36Hm3+LuiS5ayilQj55a9+LSGGt3Sc9jGK4/TGHrQk
	 vVmzn6xRCrwVrYSrQ20Gf9bJqygNjaZwGkarKcbVJQvGQ8N1FB2dwWGC+SIO8MpsyY
	 vxa99RIcxJ1zA==
Date: Sat, 14 Dec 2024 11:46:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hermes Zhang <chenhuiz@axis.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Guenter Roeck
 <linux@roeck-us.net>, Hermes Zhang <Hermes.Zhang@axis.com>,
 jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: Add support for D3-323-AA Pyroelectric IR
 sensor
Message-ID: <20241214114603.7db6bdbc@jic23-huawei>
In-Reply-To: <3a5c0c73-0d80-bbd0-b53b-522e2f3e936e@axis.com>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
	<20241212042412.702044-3-Hermes.Zhang@axis.com>
	<5b53cffd-ae7f-45e5-b265-8e700d753275@roeck-us.net>
	<20241212165945.0000584b@huawei.com>
	<3a5c0c73-0d80-bbd0-b53b-522e2f3e936e@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 13:39:01 +0800
Hermes Zhang <chenhuiz@axis.com> wrote:

> Hi
> 
> On 2024/12/13 0:59, Jonathan Cameron wrote:
> > On Wed, 11 Dec 2024 22:17:49 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >  
> >> Hi,
> >>
> >> On 12/11/24 20:24, Hermes Zhang wrote:  
> >>> Add support for Nicera D3-323-AA Pyroelectric IR sensor. The sensor
> >>> support to config the threshold/filter_type/filter_step and return the
> >>> detect result in sysfs attribute.
> >>>
> >>> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> >>> ---
> >>>     
> >> ...
> >>  
> >>> +
> >>> +static DEVICE_ATTR_WO(pir_threshold);
> >>> +static DEVICE_ATTR_WO(pir_filter_step);
> >>> +static DEVICE_ATTR_WO(pir_filter_type);
> >>> +static DEVICE_ATTR_RO(pir_detector);
> >>> +
> >>> +static struct attribute *d3323aa_attrs[] = {
> >>> +	&dev_attr_pir_threshold.attr,
> >>> +	&dev_attr_pir_filter_step.attr,
> >>> +	&dev_attr_pir_filter_type.attr,
> >>> +	&dev_attr_pir_detector.attr,
> >>> +	NULL,
> >>> +};
> >>> +
> >>> +ATTRIBUTE_GROUPS(d3323aa);
> >>> +  
> >> I don't know what this is, but it is most definitely not a hardware
> >> monitoring device. I don't see a definition of those attributes,
> >> so I have no idea what they represent.
> >>
> >> Maybe this is an iio device, but given the unusual attributes
> >> I am not even sure about that. Jonathan, any thoughts ?  
> > New type of sensor, but sure could be in IIO.
> >
> > Seems mostly a human presence sensor. Not that different from some
> > types of proximity sensor and indeed that might be the path to take
> > here.
> >
> > Taking a quick look at the driver suggests there is lots more information
> > needed to understand the ABI.  At very least needs ABI docs so we can
> > discuss how that is generalized. So if submitting an IIO driver
> > I want to see
> > Documenation/ABI/testing/sysfs-bus-iio-xxxx
> > with significant detail. The datasheet provides no where near enough
> > info.
> >
> > Jonathan  
> 
> Thanks for your suggestions. For the new sensor, it seems require three 
> attributes, e.g. /sys/bus/iio/devices/iio:deviceX/in_threshold 
> (in_filter_step, in_filter_type), then one data to indicate if it is 
> been triggerred (bool), but I'm not sure what is sutible IIO type could 
> it used? Do you have any suggestion?

Look at the existing ABI in Documentation/ABI/testing/sysfs-bus-iio
and aim to fit within that scheme.

I'm hoping you have access to a datasheet that tells you something about the
filters that lets you map them to something standard.  Normally we aim
for something like 3DB frequency.  Filter types are harder but there tend to
only be so many types people actually build.

Channel type wise, I'm thinking this is kind of a form of proximity sensor
so IIO_PROXIMITY is probably appropriate.  That has always been a bit vague
as many proximity sensors are kind of 'there is something nearish' rather
than providing actual units etc.

It's a little different as I believe these only detect movement rather
than entirely static people, but in the case of the ones for presence detection
they work on tiny movements so more or less the same as detecting proximity.

Jonathan



> 
> Best Regards,
> Hermes
> 
> 


