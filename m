Return-Path: <linux-iio+bounces-13398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E179F9EF613
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7235340109
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA46222D4A;
	Thu, 12 Dec 2024 16:59:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF32165F0;
	Thu, 12 Dec 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022793; cv=none; b=o7DbO3EULuVU+sUeHIZmEakH/+kgu53EAiRalutdyqbb+5wTmlCJZ0dihJuhZIkaxIG4cneKql4k/qxmsOQbvpMOwkpMNcqjGL1EtAKesdaPQckWGM4M+S8fTo/IYW1bkFuQey9qkzn5hLcJVIKgpq1I030CVEo8l+FE1YDvrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022793; c=relaxed/simple;
	bh=nhnzrn97bO1y8U7MCI+hPywmftsYsXEZoi/h/wiACHU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj5/TC/Ktn3zehdhRCbI+JWeEbCWgT2jqz5C1lYwXv624fG/EDZvqRdzDLEi/pWDuGfIGo/KV7Zd37u5sGGP8yXjO0qL/Wc9RpcH05J0rVCFmlxwOQoT4wPIGcVvMSACLIUiO6fDPXLzUPHbgVifKdLdSFx7COK50z+1HX6Q7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8JXD1grnz6K99D;
	Fri, 13 Dec 2024 00:56:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DAF7F140109;
	Fri, 13 Dec 2024 00:59:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 17:59:47 +0100
Date: Thu, 12 Dec 2024 16:59:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Hermes Zhang <Hermes.Zhang@axis.com>, <jdelvare@suse.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: Add support for D3-323-AA Pyroelectric IR
 sensor
Message-ID: <20241212165945.0000584b@huawei.com>
In-Reply-To: <5b53cffd-ae7f-45e5-b265-8e700d753275@roeck-us.net>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
	<20241212042412.702044-3-Hermes.Zhang@axis.com>
	<5b53cffd-ae7f-45e5-b265-8e700d753275@roeck-us.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 22:17:49 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> On 12/11/24 20:24, Hermes Zhang wrote:
> > Add support for Nicera D3-323-AA Pyroelectric IR sensor. The sensor
> > support to config the threshold/filter_type/filter_step and return the
> > detect result in sysfs attribute.
> > 
> > Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> > ---
> >  
> ...
> 
> > +
> > +static DEVICE_ATTR_WO(pir_threshold);
> > +static DEVICE_ATTR_WO(pir_filter_step);
> > +static DEVICE_ATTR_WO(pir_filter_type);
> > +static DEVICE_ATTR_RO(pir_detector);
> > +
> > +static struct attribute *d3323aa_attrs[] = {
> > +	&dev_attr_pir_threshold.attr,
> > +	&dev_attr_pir_filter_step.attr,
> > +	&dev_attr_pir_filter_type.attr,
> > +	&dev_attr_pir_detector.attr,
> > +	NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(d3323aa);
> > +  
> 
> I don't know what this is, but it is most definitely not a hardware
> monitoring device. I don't see a definition of those attributes,
> so I have no idea what they represent.
> 
> Maybe this is an iio device, but given the unusual attributes
> I am not even sure about that. Jonathan, any thoughts ?

New type of sensor, but sure could be in IIO. 

Seems mostly a human presence sensor. Not that different from some
types of proximity sensor and indeed that might be the path to take
here.

Taking a quick look at the driver suggests there is lots more information
needed to understand the ABI.  At very least needs ABI docs so we can
discuss how that is generalized. So if submitting an IIO driver
I want to see
Documenation/ABI/testing/sysfs-bus-iio-xxxx
with significant detail. The datasheet provides no where near enough
info.

Jonathan


> 
> Guenter
> 
> 


