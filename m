Return-Path: <linux-iio+bounces-7655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED80933E4E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6831F22942
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93968181310;
	Wed, 17 Jul 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXIUHuBz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF011CA1;
	Wed, 17 Jul 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226166; cv=none; b=JMvXWNksX5z9SbcY6YdIXyLwIJKanumSyZ0/y60ymaSd5GuMHK1BVawxw4eUFsfS60Hob/yR/6CCAye+XzRnxLvt294pgo34FGJM+Zl5XRiwWU+AFJBf0duL0vRk1p5a7GuG1dy0rjMP/d8kVxnlunB5f6Q/QdehSPca8VKNbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226166; c=relaxed/simple;
	bh=/8cn59SFKipQBi0bRTqzGyGafixibZCGtq4LcKyPTmU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TkbnPI8RPEYbRqZWHym3UPa78cDcwHAcRI8Rl/shFokvb7sRwkYg5pdSW8t4Mtwc5ojRWrc7WKiAQWp7EgwtcXM1CWNXocxFrwKbHTH0uZxhTgn5U5SGAT9Ac7W3WOLiTBNA7uXnP2hMyjiCbD+7NBi18y3EmXm3HPDOJqOc0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXIUHuBz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367975543a8so4218065f8f.3;
        Wed, 17 Jul 2024 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721226163; x=1721830963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svEMdNJrhPzf6XWkWqE1d25cErVE+thuLdJTXQmltm4=;
        b=YXIUHuBzbHnGwaDErUeEIViqwD34bvbXmpCLeS7QtGbbe/sXjg6UL757U+KJempmLH
         OKqfrjknfvi2saDtLJ2ws4jK1CTWscUR5Z/kJNx6Oq+qNQqQvBWLgr2C4Tm7cE1xlvYE
         inIC3LLXVJrwapgrT2em1+zVeEoS0ARLIksDNcGwpKgaJ1EHghYIwj23sHU+9GHjk1nk
         op92iVS9JyB+s8gBNFNDjW4Dp2ig7xc7Gu+Ns0CM48X6GjxPr7tZSAcHpZHBDLyAspt+
         Uj3n+KP0d8UszxbXESIaXmcYCAz/xoWLr78kEYdi3K51azcIdqfLlTLiKS/+7ulrSd2j
         kywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226163; x=1721830963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=svEMdNJrhPzf6XWkWqE1d25cErVE+thuLdJTXQmltm4=;
        b=l/XcgpIWutNksfgLsyowQlerFfPM80NVRtKKfGe6sG8VUkUxkS8JG5+USI8Xu5VIbD
         kSJa99p6AHC5Qil+DTgBAaUhL8a5ln+n5sF2igpiu02LL4W9IAre5J5sFAGyK77TU6Xi
         q87Lak7N7+20RwaF4w7I1846gA4Ofis4suLa9TBa16o429mz7POPoex/ayuLeH4wBpl/
         MVUG8XdAbryNyINc95fo3FEqnPTb3Tq1nlF4N8YfvdU7bEd+Ogoa9A4sUq+bdWgfj+A5
         ZaoRmm6hJujgfNbtnGJwbjKuZRMsvjHPK1U6y1UyMteOvtlI5e/xT1j0J6V3Im6QCi4V
         m6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU2d0p0KDpbjoYN9ZTHCWbeb/iZ+TIivvKqRa8aKqqjk4RLfKmlcgNa+//g8YeUFjHwHqUXmgRsJC9s33NG6S1F+z7zLqf6XvkhciXFDZaRyW+aAMA9iC81YFpAGoTW3cwEOrdlRKa+90FvJBeqQM6xYRFfOpgO/Y/wv68w/hS6hQn07A==
X-Gm-Message-State: AOJu0YwdQF62QpLvtdhUnsaYB8/M6d1n5jIZu8/fvVp3W3CBZT8xMhy7
	8cMkZCPTT+ig6Qny/2zQUgfvasrFsz2aujdmFlun7+EIhRPp/nU1
X-Google-Smtp-Source: AGHT+IEVY8HHSSKsk8wQhIZ5k22k5MKq3xOehqT14foB2HFo51VlGfrc118c3sQhigI411UVvD9Jhw==
X-Received: by 2002:a5d:4bc4:0:b0:367:f0f2:66bb with SMTP id ffacd0b85a97d-368316547d3mr1410621f8f.13.1721226162575;
        Wed, 17 Jul 2024 07:22:42 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db03bc4sm11829956f8f.93.2024.07.17.07.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:22:42 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:22:40 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Marius.Cristea@microchip.com
Cc: matteomartelli3@gmail.com, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 robh@kernel.org, 
 lars@metafoo.de, 
 linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org, 
 Jonathan.Cameron@Huawei.com, 
 conor+dt@kernel.org
Message-ID: <6697d3b0d33f6_1fc333707f@njaxe.notmuch>
In-Reply-To: <20240716180004.606006d0@jic23-huawei>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
 <20240707160442.6bab64c9@jic23-huawei>
 <668bec2a8b23a_6e037017@njaxe.notmuch>
 <20240708173439.000070b4@Huawei.com>
 <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
 <20240713112153.3576fc2a@jic23-huawei>
 <66963b764ac3c_706370bd@njaxe.notmuch>
 <483de34b3a74a2981fac89a8232e3ef2448f57ef.camel@microchip.com>
 <20240716180004.606006d0@jic23-huawei>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron wrote:
> > > =

> > > * If for instance the generalized ABI unit is going to be Ohms,
> > > should I still
> > > remove the entry from the pac1934 even though it would not be fully=

> > > compliant
> > > with the generalized ABI?
> > > =

> > > * To cover the current exposed attributes, the "What" fields would
> > > look like:
> > > from max9611:
> > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_current_shunt_resistor
> > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_power_shunt_resistor
> > > from ina2xx:
> > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_shunt_resistor
> > > from pac1934:
> > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_shunt_resistorY
> =

> This one is a bit odd in that it describes it if it were a measurable
> channel in of itself but we probably couldn't figure out a better way
> to scope it to a specific channel.
> =

> > > Does this look correct? I think that for the first two drivers the
> > > shunt_resistor can be considered as a channel info property, shared=

> > > by type for
> > > max9611 case and shared by direction for ina2xx case (maybe better =
to
> > > remove
> > > "in_" from the What field if the type is not specified?).
> =

> Keep it consistent.  It's valid to provide the in_ and in general
> over restrict channel attributes, even if not strictly necessary.
> =

> > > What seems odd to me is the pac1934 case, since it doesn't fit in t=
he
> > > format
> > > <type>[Y_]shunt_resistor referred in many other attributes (where I=

> > > assume
> > > <type> is actually [dir_][type_]?).
> > > Doesn't it look like pac1934 is exposing additional input channels,=

> > > that are
> > > also writeable? Maybe such case would more clear if the shunt
> > > resistor would be
> > > an info property of specific channels? For example:
> > > in_currentY_shunt_resistor,
> > > in_powerY_shunt_resistor and in_engergyY_shunt_resitor.
> =

> > >   =

> > =

> > I don't think it will be a good idea to duplicate the same informatio=
n
> > into multiple attributes like: in_currentY_shunt_resistor,
> > in_powerY_shunt_resistor and in_engergyY_shunt_resitor.
> > =

> > The pac1934 device could be viewed like 4 devices that have only one
> > measurement hardware. Changing the shunt for a hardware channel will
> > impact multiple software measurements for that particular channel.
> Yup. You've =


Sorry Jonathan, is there anything missing in this sentence? Looks like
unintentionally truncated: You've ...

> > =

> > For example "sampling_frequency" is only one property per device and
> > not one property per channel.
> =

> Not necessarily.  If it varies per channel it is
> in_voltageX_sampling_frequency etc
> That is rare, but we have specific text to cover it in the ABI docs.
> =

> What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
> What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
> What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
> KernelVersion:	5.20
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		Some devices have separate controls of sampling frequency for
> 		individual channels. If multiple channels are enabled in a scan,
> 		then the sampling_frequency of the scan may be computed from the
> 		per channel sampling frequencies.
> =

> > =

> > Also I'm not felling comfortable to remove the [dir_] from the name,
> > because this value is dependent of the hardware and we can't have a
> > "available" properties for it.
> Removing the dir is unnecessary.  Just leave that in place.
> Note we can't change existing ABI of drivers for this sort of thing
> that wasn't standardized (as we can't argue they break ABI) so
> they are stuck as they stand.
> =

> Unfortunately the most consistent path is probably to treat it as a
> normal attribute, even if that generates a bunch of silly duplication
> if there is more than one shunt_resistance.
> I agree it's ugly but it's not the only case of this sort of duplicatio=
n.
> It happens for that sampling_frequency case in a few corners were there=
 is
> on channel that is sampled different from all the others.
> =

> So I think
> in_powerY_shut_resistor and in_energyY_shunt_resistor is
> most consistent with existing 'standard' ABI.
> =

> This is one where I didn't do a great job in review unfortunately
> so the one with the index on the end got through.
> =

> I'm not hugely worried about this mess though as runtime shunt resistor=

> calibration is not that common.  If people want good measurements they
> tend to build their circuit with good components / PCB tracks etc.
> =


From your comments I get that in_shunt_resistorY should be added in the
generalized ABI (as in the example above) since it is already used and ca=
n't be
changed. Is this correct?

I am still not sure whether in_currentY_shunt_resistor,
in_powerY_shunt_resistor and in_energyY_shunt_resistor, should be added o=
r not
until a new driver using it comes through.

Regarding pac1921, would it be more clear to expose a single in_shunt_res=
istor
(keeping [dir_] for consistency as you suggested) as it is for ina2xx or
in_current_shunt_resistor plus in_power_shunt_resistor as it is for max96=
11? I
agree that just exposing it once would be more clear for the user, so I w=
ould
go for the first case but maybe I am missing something.

> =

> Thanks,
> =

> Jonathan
> =


Thanks,
Matteo=

