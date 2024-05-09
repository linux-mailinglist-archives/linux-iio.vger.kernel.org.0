Return-Path: <linux-iio+bounces-4913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D98C1578
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 21:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB262839AC
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970D7F7F0;
	Thu,  9 May 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S13pG9CJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C097F7CC;
	Thu,  9 May 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283091; cv=none; b=dYjVjvgUI2zOk1OznODw7sdNQ7gRjWS7qFqkqJ7jFtReFCpUvCnvLy8lT+wwSYw8tuCFm32fBnhhWy2jbs7c6G5lU0TZ8SEL6bKnShv5wI5KjeR9+gH70ZMR8KhTTVnuf/jZXRTTWRNfJuF/m+9vkH7VwWELtPUqOnYRd82uPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283091; c=relaxed/simple;
	bh=NwF2z0HerUINZhURYJLwCxkjZNCsGGAC/I9PUJX0+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agjMQCK+wJOUI9dmFWOuIZ/1FyEDMBwqPJcafKvD6u3jRqG7JuygAsoVrI6xUg231t2w48aZhLdLz8sYnYgvjvTHvsXOlvivob9behi+fL83VCSftx0wwUwa7aJaK8uAgWJ1watZH34iAtASODXcD/ad0KvdPxNfqtZzacgoELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S13pG9CJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso12332295e9.3;
        Thu, 09 May 2024 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715283088; x=1715887888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56mx3iVk3ZkgiIYiIXja8c48p4L+pI2KSnmXxgGkPJA=;
        b=S13pG9CJLNa5M4/bP1KqE1zYyDkh95f14dSG1hHhzXfefaU1YbET8mkrWJH0G8bWcB
         b/xx8rhJW9hYQaPUat4+wwT141zwJKFnS8PbrzlOO3Gxzz59qqeKgL5B0+plnn947dH5
         EzMtJp7Eshl7x4pIBpU8EGX4I0R3QqHt58m0rZerze/2ux0rvvDnD4OuhDZdvd3NQBjz
         6O/R5OQI91JOGXaWs1RkTdJvO62LQFXie4NVesWOyljHN1aGWHk5WofjsbGwa7+yb8rk
         NDTTstkMX6yf+lEOI1NdOA4WEltPXD9ni00Fblqk6S/O0arD87/cRJU/hrcvE4EZRywM
         UOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715283088; x=1715887888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56mx3iVk3ZkgiIYiIXja8c48p4L+pI2KSnmXxgGkPJA=;
        b=XmjeYLwXJ611rAl9lNmtb1KrbRS2jc7FmNhk6Cfbk4I4VtWXd0TV0b1Ja0aSEvIwTZ
         +e15pwlCiWDpAl9kiEeGVEvtrYEM28PcrxXFRS5nYj+n4preP5D+pnrrpreOEnlH864w
         WWJd4CcWwFNhOiL/NQSif75KElF2xfa2qgDQtFYiA9fRfdeArjyPlqvVgrHi1H6uvpUk
         fnP2XHKgZTBeXTSLopgf+M56G96PzvasM81XjWC3ny/ulcsGmpVVc4nyorogpTCQWISa
         ElwKTM6lwT9jokW+79WixUi5XyDisO52mWrbeEnjYnEwRCuHAvMoOn/femuPDK/ll5+E
         tDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkkcIGwM/c/bNRMSBjUVKhfpaNbV6DR6KxuDr0///3j1VuTsuCmf+OwboGr5Go6Greaj7Vm7pAz5zurXP7fTT8ptze0UhI3jsEskVo/EXabfQrA/AD1I77N4qG4Qw7xyYRS4Xsl9Z+
X-Gm-Message-State: AOJu0YzTAh6bTVb/LX2Allmka54BGmgESrIWCZm+RpgHZLaoxKj3LjZ9
	W9h6WJ8Bz/JFtwZPU4U0j8wn26YFkl1amlGRmfGK2E7R9+DeqhoR
X-Google-Smtp-Source: AGHT+IHFrH1JCYTDOucAAM2aqybfB92h4Z+HBzrK4cuxjEHwoNI23gOmVBRCOPb4KN51U9jN0nYdYg==
X-Received: by 2002:a5d:6741:0:b0:34d:74cb:b048 with SMTP id ffacd0b85a97d-3504a73de83mr484479f8f.34.1715283087545;
        Thu, 09 May 2024 12:31:27 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbca98sm2451960f8f.112.2024.05.09.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:31:27 -0700 (PDT)
Date: Thu, 9 May 2024 21:31:25 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: temperature: mcp9600: set channel2 member
Message-ID: <20240509193125.GA3614@debian>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
 <20240430120535.46097-2-dima.fedrau@gmail.com>
 <20240430131102.00005e58@Huawei.com>
 <20240430122157.GA46332@debian>
 <20240505111541.13b94920@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505111541.13b94920@jic23-huawei>

Am Sun, May 05, 2024 at 11:15:41AM +0100 schrieb Jonathan Cameron:
> On Tue, 30 Apr 2024 14:21:57 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Am Tue, Apr 30, 2024 at 01:11:02PM +0100 schrieb Jonathan Cameron:
> > > On Tue, 30 Apr 2024 14:05:31 +0200
> > > Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> > >   
> > > > Set channel2 member of channel 0 to IIO_MOD_TEMP_OBJECT and set modified
> > > > member to 1.  
> > > This an ABI change, so needs a strong argument + must be a fix 
> > > rather than an improvement.  So why does this need to change?
> > >  
> > Hi Jonathan,
> > 
> > I don't know if it is an valid argument but when using tool "iio_info"
> > the temp_object wasn't displayed at all. After adding these two lines
> > the temp_object is displayed. Don't know if it is a problem with the
> > userspace tools.
> 
> Just to check, it displayed not temperature channel for this?
>
It did it correctly when reading from /sys/bus/iio/devices/iio\:device0
but when using "iio_info" it didn't. See below.

> If you could send the file listing of the appropriate
> /sys/bus/iio/devices/iio\:deviceX/ directory that would be great.
> 

root@raspberrypi3-64:~# ls -al /sys/bus/iio/devices/iio\:device0/
drwxr-xr-x    3 root     root             0 May  4 20:11 .
drwxr-xr-x    4 root     root             0 May  4 20:11 ..
-rw-r--r--    1 root     root          4096 May  4 20:11 in_temp_ambient_raw
-rw-r--r--    1 root     root          4096 May  4 20:11 in_temp_ambient_scale
-rw-r--r--    1 root     root          4096 May  4 20:11 in_temp_raw
-rw-r--r--    1 root     root          4096 May  4 20:11 in_temp_scale
-r--r--r--    1 root     root          4096 May  4 20:11 name
lrwxrwxrwx    1 root     root             0 May  4 20:11 of_node -> ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/temperature-sensor@67
drwxr-xr-x    2 root     root             0 May  4 20:11 power
lrwxrwxrwx    1 root     root             0 May  4 20:11 subsystem -> ../../../../../../../bus/iio
-rw-r--r--    1 root     root          4096 May  4 20:11 uevent
-r--r--r--    1 root     root          4096 May  4 20:11 waiting_for_supplier

> It is possible the tools don't cope with a mixture of modified and unmodified
> channels (without index).  Whilst the ABI docs don't say you can't do this
> it is a rather obscure corner case.
> 

I think you are right, below are my findings. When doing a cat from
in_temp_ambient_raw or in_temp_raw the results are correct, when using
iio_info there is only a single channel displayed with four attributes.

root@raspberrypi3-64:~# cat /sys/bus/iio/devices/iio\:device0/in_temp_ambient_raw; cat /sys/bus/iio/devices/iio\:device0/in_temp_raw; iio_info
314
540
iio_info version: 0.25 (git tag:b6028fde)
Libiio version: 0.25 (git tag: b6028fd) backends: local xml ip usb serial
IIO context created with local backend.
Backend version: 0.25 (git tag: b6028fd)
Backend description string: Linux raspberrypi3-64 6.9.0-rc1-g7584c270afae-dirty #239 SMP PREEMPT Thu May  9 20:11:36 CEST 2024 aarch64
IIO context has 2 attributes:
        local,kernel: 6.9.0-rc1-g7584c270afae-dirty
        uri: local:
IIO context has 3 devices:
        hwmon0: cpu_thermal
                1 channels found:
                        temp1:  (input)
                        1 channel-specific attributes found:
                                attr  0: input value: 42932
                No trigger on this device
        hwmon1: rpi_volt
                1 channels found:
                        in0:  (input)
                        1 channel-specific attributes found:
                                attr  0: lcrit_alarm value: 0
                No trigger on this device
        iio:device0: mcp9600
                1 channels found:
                        temp_ambient:  (input)
                        4 channel-specific attributes found:
                                attr  0: raw value: 314
                                attr  1: raw value: 314
                                attr  2: scale value: 62.500000
                                attr  3: scale value: 62.500000
                1 device-specific attributes found:
                                attr  0: waiting_for_supplier value: 0
                No trigger on this device




With the patch setting modified and channel2:


root@raspberrypi3-64:~# ls -al /sys/bus/iio/devices/iio\:device0/
drwxr-xr-x    3 root     root             0 May  9 18:21 .
drwxr-xr-x    4 root     root             0 May  9 18:21 ..
-rw-r--r--    1 root     root          4096 May  9 18:22 in_temp_ambient_raw
-rw-r--r--    1 root     root          4096 May  9 18:22 in_temp_ambient_scale
-rw-r--r--    1 root     root          4096 May  9 18:22 in_temp_object_raw
-rw-r--r--    1 root     root          4096 May  9 18:22 in_temp_object_scale
-r--r--r--    1 root     root          4096 May  9 18:21 name
lrwxrwxrwx    1 root     root             0 May  9 18:22 of_node -> ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/temperature-sensor@67
drwxr-xr-x    2 root     root             0 May  9 18:22 power
lrwxrwxrwx    1 root     root             0 May  9 18:22 subsystem -> ../../../../../../../bus/iio
-rw-r--r--    1 root     root          4096 May  9 18:22 uevent
-r--r--r--    1 root     root          4096 May  9 18:22 waiting_for_supplier

root@raspberrypi3-64:~# cat /sys/bus/iio/devices/iio\:device0/in_temp_ambient_raw; cat /sys/bus/iio/devices/iio\:device0/in_temp_object_raw; iio_info                                                              
318
523
iio_info version: 0.25 (git tag:b6028fde)
Libiio version: 0.25 (git tag: b6028fd) backends: local xml ip usb serial
IIO context created with local backend.
Backend version: 0.25 (git tag: b6028fd)
Backend description string: Linux raspberrypi3-64 6.9.0-rc1-g51f9ab5c4102-dirty #240 SMP PREEMPT Thu May  9 20:21:32 CEST 2024 aarch64
IIO context has 2 attributes:
        local,kernel: 6.9.0-rc1-g51f9ab5c4102-dirty
        uri: local:
IIO context has 3 devices:
        hwmon0: cpu_thermal
                1 channels found:
                        temp1:  (input)
                        1 channel-specific attributes found:
                                attr  0: input value: 45084
                No trigger on this device
        hwmon1: rpi_volt
                1 channels found:
                        in0:  (input)
                        1 channel-specific attributes found:
                                attr  0: lcrit_alarm value: 0
                No trigger on this device
        iio:device0: mcp9600
                2 channels found:
                        temp_ambient:  (input)
                        2 channel-specific attributes found:
                                attr  0: raw value: 317
                                attr  1: scale value: 62.500000
                        temp_object:  (input)
                        2 channel-specific attributes found:
                                attr  0: raw value: 532
                                attr  1: scale value: 62.500000
                1 device-specific attributes found:
                                attr  0: waiting_for_supplier value: 0
                No trigger on this device

> The maping from hotjunction to object isn't totally clear to me.
> Mind you neither is the mapping from cold junction to ambient (that one is
> a bit stronger as the datasheet tables assume
> Cold Junction Temperature == Ambient Temperature.
> 
> Example of why I don't like this is object is no obvious if the hotjunction
> is in a gas or liquid.  The object defintion was I think added for infrared
> temperature sensors where you get nothing meaningful without an object to
> emit the infrared.
> 
Thanks for the explanation, somehow I was satisfied with the mapping
from hotjunction to object. :) If the object is gas or liquid ?!

> An alternative would be to provide an index for both channels. Also an ABI
> change, but avoids the object / hot junction issue and I would assume works
> fine with iio_info.
> 
I will have a look into it and come up with a patch eventually. Don't
know if its worth changing the ABI. What do you think ?

Dimitri

...

