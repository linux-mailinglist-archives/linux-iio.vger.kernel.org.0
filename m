Return-Path: <linux-iio+bounces-7492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C37192E08D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94FBB211C2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 07:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EBA12FB0B;
	Thu, 11 Jul 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEZ6tKvB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2812FF71;
	Thu, 11 Jul 2024 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681704; cv=none; b=NgLNv84Ts+9ifDaCLJlN+cEuihlnF6gStDGWr1QSwoBX9hf+QEFyLa7E8hAgsgQAfLmnwYbaS+DC7qExAAtGTc/EPqUUlDnIUfX4blULNWswqBjW35p558vScyOTXbEfG2PSg3JbK7pTHxLjkx4CaebLPmh4aV06h+FZXwt5llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681704; c=relaxed/simple;
	bh=tS+OusqglwII9Oh8jwE+31yUzsC3175g4YbMyRvsVrs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Fb5gWJ92Rk8877hgx9mw+8svHJf9PsDwXVPIoXo46q64LvqxQNN8yZBuHaclk1JsWR8Ye3M9uaszU+oxjo6WCe42srb4OfOL3diVnxFkGHm9v9djp1PgHuj5+XpSSWeXxwU8g3ItRiB9Sp3tZVjHitVJsP3Mu8xfdYkvWqobdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEZ6tKvB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9f863c46so624809e87.1;
        Thu, 11 Jul 2024 00:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720681701; x=1721286501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS+OusqglwII9Oh8jwE+31yUzsC3175g4YbMyRvsVrs=;
        b=HEZ6tKvBtHcoa1/Gvrv33CpmDYg6l7SH/HEbaidTDYeEfXRWgpighPcaiNG+oEc5pl
         lr1Nlkg1dIcAE4Vs52uNdh6pfDItTc7t2XzRp1grwzR5I/+lPzpxmRG/nx2AC/TvypwJ
         AeKDjnxvkiKFFXg1PTrdtxxG/h6+SLb3I1WHQb2KpVtH6WUWxS9l8QWsbKVjoRFiPRXM
         CKI+nXXFppaQutdMQWrr1sOxWXiCPdp4CgNx4HGwZCtkzhLUNsjXaFbyP47RYpItQi5l
         MXC0GYg72ArGMIhFNDv5U/E+eOyUcL+BzvzeeLga23fE0GqLHBdOwPi4uj7NeiPJuPea
         /Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681701; x=1721286501;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tS+OusqglwII9Oh8jwE+31yUzsC3175g4YbMyRvsVrs=;
        b=sr56movDL24Lxsk3g/LTIGybPvKWlFdFiN3rtOAvdQ80zT1NEW/b3XTL0aHsVEtTfL
         2bZ+o5ddV3MAL1b6aBLQim76CXTwvsyP0PrlLmIClI152L6oo8Ajx7cFAQB66EWkGySE
         pTuznilp7vROA1ojUy3tsAL64h/07Zcq2nFkTbGj0RPR/gxwmp4F8ZmGt7eKGTHfeyW9
         3YlxvDW8ma/0uvnq/tdL9LL5UFYpV0ewFS1DAQQvKjGmAGdDtN+A735EkABh9OppY75q
         owN0e6K3315RKP0wpnYkaoJp+ZtjHfgSq7X06U+Ruf2jlua1s7O83gh7VoNCO4cwFGTo
         NNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUubLSL3BAqsm7bCIaiopyzzN55ocbWES6uM7l0p/rQN+LOHIMKmzXspqSTON5BS0C+l5UHlq1Zvz4d9pt4xRUHY/s9FAWXtjZG2SSGCU67TPi9NvTpQoRk2lgscdaE4ZPCYdaGI1UEWuAzZ/oVmjgLVIfz+hb8+Wf46BCmFexogABQ3Q==
X-Gm-Message-State: AOJu0Yz5iTVawrBDmSFMTlMtBT8ifCLzJXa6NvJ9wVdmu4y1yIYusDIz
	fiwroLjo8KKpDyJrq4u24XfIfKuZe8e0OWrh93gkW6F3Vmr4O4YRIT3ebEq/
X-Google-Smtp-Source: AGHT+IF8ndhQWKLZYKZRgh0LQz+uDp0LDnnrjbssWSZHZB+zwt1PnkHq99C0weqNdu2BHIrqHiDw5g==
X-Received: by 2002:a05:6512:3b82:b0:52c:fd49:d42 with SMTP id 2adb3069b0e04-52eb9990d58mr4801546e87.14.1720681700618;
        Thu, 11 Jul 2024 00:08:20 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e097bsm107815295e9.6.2024.07.11.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:08:20 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:08:18 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Marius.Cristea@microchip.com, 
 jic23@kernel.org, 
 matteomartelli3@gmail.com
Cc: robh@kernel.org, 
 krzk+dt@kernel.org, 
 conor+dt@kernel.org, 
 devicetree@vger.kernel.org, 
 lars@metafoo.de, 
 linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <668f84e2f3e10_2b423707a@njaxe.notmuch>
In-Reply-To: <88a54c736e0c39ead34dbde53c813526484d767d.camel@microchip.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
 <20240707160442.6bab64c9@jic23-huawei>
 <668bec2a8b23a_6e037017@njaxe.notmuch>
 <88a54c736e0c39ead34dbde53c813526484d767d.camel@microchip.com>
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

Hi Marius,

Marius.Cristea@ wrote:
> > I think that the OUT pin might not be used at all in many use cases
> > so I would
> > leave the OUT pin setting as fixed for now and maybe extend it in the=

> > future
> > when more use cases arise. I am open to reconsider this though.
> > =

> =

> The OUT functionality could be set from the device tree.

I think this should to be controlled during runtime since it's a configur=
ation
that changes the device operation mode and so also what measurements are
exposed to the user. An additional DT property could be useful but I am n=
ot
sure it would fit in the DT scope.
Anyway I will leave this for future extensions.

...
> > > > ---
> > > > =C2=A0.../ABI/testing/sysfs-bus-iio-adc-pac1921=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 45 +
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 7 +
> > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 10 +
> > > > =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > > =C2=A0drivers/iio/adc/pac1921.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1038
> > > > ++++++++++++++++++++
> > > > =C2=A05 files changed, 1101 insertions(+)
> > > > =

> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > > > b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > > > new file mode 100644
> > > > index 000000000000..4a32e2d4207b
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > > Quite a bit of custom ABI in here.
> > > =

> > > Rule of thumb is that custom ABI is more or less pointless ABI for
> > > 99% of users
> > > because standard userspace won't use it.=C2=A0 So keep that in mind=
 when
> > > defining it.
> > > =

> > > > @@ -0,0 +1,45 @@
> > > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > > > /sys/bus/iio/devices/iio:deviceX/resolution_bits
> > > > +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0 6.10
> > > > +Contact:=C2=A0=C2=A0 linux-iio@vger.kernel.org
> > > > +Description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADC=
 measurement resolution. Can be either 11 bits or
> > > > 14 bits
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (de=
fault). The driver sets the same resolution for
> > > > both VBUS and
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VSE=
NSE measurements even if the hardware could be
> > > > configured to
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mea=
sure VBUS and VSENSE with different resolutions.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thi=
s attribute affects the integration time: with 14
> > > > bits
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
olution the integration time is increased by a
> > > > factor of
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.9=
 (the driver considers a factor of 2). See Table
> > > > 4-5 in
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev=
ice datasheet for details.
> > > =

> > > Is the integration time ever high enough that it matters?
> > > People tend not to do power measurement 'quickly'.
> > > =

> > > If we are doing it quickly then you'll probably want to be
> > > providing buffered
> > > support and that does allow you to 'read' the resolution for a part=

> > > where
> > > it changes for some other reason.=C2=A0=C2=A0 I haven't yet underst=
ood this
> > > case.
> > =

> > I will remove this control and fix the resolution bits to 14 (highest=

> > value),
> > same as the HW default.
> =

> The resolution could be set from the device tree. As default it could
> be 14 bits like into the hardware. The user could add
> "microchip,low_resolution_voltage" into the device tree in order to use=

> only 11 bits for voltage samples.

I think this should be controlled during runtime since it does not depend=
 on
the HW design but more on the user preferences about measurements precisi=
on.
As Jonathan pointed out, since custom ABIs should be avoided when possibl=
e, I
will leave it out from now until it becomes necessary and fix the resolut=
ion to
14 bits, as the HW default.

...
> > > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /sys/bus/iio/devices/iio:devices/filters_en
> > > > +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0 6.10
> > > > +Contact:=C2=A0=C2=A0 linux-iio@vger.kernel.org
> > > > +Description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Att=
ribute to enable/disable ADC post filters. Enabled
> > > > by
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def=
ault.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thi=
s attribute affects the integration time: with
> > > > filters
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ena=
bled the integration time is increased by 50%. See
> > > > Table 4-5
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in =
device datasheet for details.
> > > =

> > > Do we have any idea what this filter is? Datasheet seems very vague=

> > > indeed and from
> > > a control point of view that makes this largely useless. How does
> > > userspace know
> > > whether to turn it on?
> > > =

> > > We have an existing filter ABI but with so little information no
> > > way to fit this in.
> > > Gut feeling, leave it on all the time and drop the control
> > > interface.
> > =

> > I will remove this control and leave it on all the time as the HW
> > default.
> > =

> =

> The filters could be enabled from the device tree. As default it could
> be disabled.
> As a small detail here this is a post processing digital filter that
> could be enabled/disabled inside the PAC module.
> =


Same reasoning of the resolution_bits parameter applies here. I will fix =
the
filters to enabled, as the HW default. If there is any particular reason =
to
prefer the filters fixed as disabled I will change that.

...
> Thanks,
> Marius

Thanks,
Matteo=

