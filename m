Return-Path: <linux-iio+bounces-20706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD2ADAE0A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA613B0064
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615E129C326;
	Mon, 16 Jun 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQG1Ic0M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D81E501C;
	Mon, 16 Jun 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072220; cv=none; b=kSU3hXDiwe+fWI0YWB8KDlaqYTYxOfAOgw1bLEObThdtiuSMrd1loopSMchpABZaixRBY5V0SYoEdEAHHkpg9tgj8Dr7tHFX9WEdWljQ4xKR2zec94zKd/iPgYpJ89SgV4vyJq6q+amzD8wR3blc9Urh6aM2M9dxmmjxHBdjxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072220; c=relaxed/simple;
	bh=4fFLkI3dcSAqiA6dgdncycNhf9klmZACMiwYA9Dt0bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOFA2fIxR4Cpap/PDp933rdRXCN0O5MYf5JBogP8Doztjs+GUnamSl1kTlgJMcT/h8KWMH+4scmgZs6Vmz5j7qG2QWImrMQgpOISgj6T9BX34ZdZpXqHNj/Qe0CL12sxdl850Z4Nhrau21xs5dcsjjSOx6U+5EZVRzE4bX197lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQG1Ic0M; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so6929506a12.1;
        Mon, 16 Jun 2025 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750072217; x=1750677017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbd6uttja4lI5BY3otJRuMZI44UPQt6xv5Z5Yw1NAe4=;
        b=ZQG1Ic0MWMlI89uAbmPx2jiHLLCwlyF9nvG0901WUDdlc0pi1P7rU1IR0ndVG4yoxA
         2ZN/Kq2ppQOAhsAUBVWZs1HvVd8W4zvpcdMEF7IpoSFyKLOIl8ODZ5/sEa04ZKxmrF2G
         ThkGDEXaElKe3kPaz7g4vVsHvLL0zklVPnltQZqi0tH6XY8ynV/QBVy8o2StAvUdT6Bs
         qHALkpKIjEu50kdAwHxglFgaA6oJ/u+wxisbeXyIjlWbWyR5jsjecY9rWQnounucNZzp
         AGUf5dpHhbJp005E/i8YbK8YZiraKx/sOC77Rc0szV4fWRRI7Lnb+Jf5eBxFJubXfxN0
         44+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072217; x=1750677017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbd6uttja4lI5BY3otJRuMZI44UPQt6xv5Z5Yw1NAe4=;
        b=VzBM/zNfMKcChEnhtLZATRn2XniZhu7vEoebQpGQjuZjWWCSAAFko+87Kn4Ju8132M
         IqZhoPB0Qw4fytrFkGQ1KiCj+rYxDJq/hxYQUFKDJw1j4mDH97OYGUCpSoEPaTVwidPt
         NEPNGAaAXGWbUPADQP2NpV3omknN3r59WQrgZQLc9Tk8nOxJPXrcZJCQ6YHDnrhu0F8G
         s9kDiyCvxndmQxwCfnt7Bdaq4Kz5ulxD5p4rIGAgTkPJt5Nt/pA7jy9zAkO1RVQKt6Iq
         Ft0UsVJU9BkNqy0cG8Pn8UanODSGDk/xxoYmbTwy1JofkrDR+0VHXNCgZffttRT//Eto
         ZAYg==
X-Forwarded-Encrypted: i=1; AJvYcCULAJrlsqQfRXydQEvvc03/9vo3QuSkb+YF7O35ZvcaPy14YRMFeyvMd+4RVu/vRtEnuvIh4g797xE=@vger.kernel.org, AJvYcCUnMMVe+hdaNSe2ZfuAKTMghN1ziT4D9AWUr6RG/Oh7xxe0ybU1GdBmwqOjBiYd6vnW/uOid+yT/9345eZU@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpJXkSbmf5UEbmkerSKNWqeTWkByYPs8NgqwnUtZW7L7deldd
	Cm2B/N6GTsMLgyEMXU8wBVtPXegk3EGbgGImCb6HxdTpUHUc6YeCZ2UF8ymdTxIfqUD/T4DFbga
	9ea03lcoCUz/iL/SaQS7SMwyD+TbVTho=
X-Gm-Gg: ASbGncsnB+l+PXICeTL533hDh0ojsAufzsuUQ0TQdvVgdQeb227sRMxOBDZIOt76ge8
	PecKHS/EoodRQr/yr5ygWIoeoxOQxZsWUtkhsb77upme/ZZGnUZU0ih6bEdCr3li2/H9EvVfPAf
	hxiJYPBUv8gAi/QqCqMEDiNCmndhDfuC3fDtIV9nZBr2SMww==
X-Google-Smtp-Source: AGHT+IH5djo//PgoZzM4cW2EllofwQvtZMXpS8OuCnInkAgxOQ/0dp/YAeXJ0VTTVVZ6/f9axZ4wXunzUGycO2pjodo=
X-Received: by 2002:a17:907:a893:b0:ad2:313f:f550 with SMTP id
 a640c23a62f3a-adfad412330mr856362966b.29.1750072216601; Mon, 16 Jun 2025
 04:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <aEw_DcqpCpcsBGd0@smile.fi.intel.com> <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
 <aE_aL5dGKZeKBu50@smile.fi.intel.com> <db14331e-193a-4915-990e-7657b5ca0c5b@mailbox.org>
In-Reply-To: <db14331e-193a-4915-990e-7657b5ca0c5b@mailbox.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 14:09:39 +0300
X-Gm-Features: AX0GCFsl7HH3ZC8U1dnAudEoJCiM1kf47YKTc03cEpSDAOXzYNb7_qqbfuBMkvA
Message-ID: <CAHp75VcZ6-WFyyERg7YVXNj3-uggwyNf2fF4mnbhiUZ6xNwYvg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Marek Vasut <marek.vasut+bmc150@mailbox.org>, Hans de Goede <hansg@kernel.org>, 
	linux-iio@vger.kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>, 
	Peter Zijlstra <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:03=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
> On 6/16/25 10:47 AM, Andy Shevchenko wrote:
> > On Fri, Jun 13, 2025 at 07:02:28PM +0200, Marek Vasut wrote:
> >> On 6/13/25 5:09 PM, Andy Shevchenko wrote:
> >>> On Fri, Jun 13, 2025 at 02:45:22PM +0200, Marek Vasut wrote:

...

> >>>> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tab=
les,
> >>>> which leads to bmc150_accel_core_probe() being called with irq=3D0, =
which
> >>>> leads to bmc150_accel_interrupts_setup() never being called, which l=
eads
> >>>> to struct bmc150_accel_data *data ->interrupts[i].info being left un=
set
> >>>> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_in=
terrupt()
> >>>> which depends on struct bmc150_accel_data *data ->interrupts[i].info=
 being
> >>>> non-NULL, and which triggers NULL pointer dereference. This is trigg=
ered
> >>>> e.g. from iio-sensor-proxy.
> >>>>
> >>>> Fix this by skipping the IRQ register configuration in case there is=
 no
> >>>> IRQ connected in hardware, in a manner similar to what the driver di=
d in
> >>>> the very first commit which added the driver.
> >>>>
> >>>> ACPI table dump:
> >>>
> >>>>           Device (BMA2)
> >>>>           {
> >>>>               Name (_ADR, Zero)  // _ADR: Address
> >>>>               Name (_HID, "BOSC0200")  // _HID: Hardware ID
> >>>>               Name (_CID, "BOSC0200")  // _CID: Compatible ID
> >>>>               Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> >>>>               Name (_UID, One)  // _UID: Unique ID
> >>>>               Method (_CRS, 0, NotSerialized)  // _CRS: Current Reso=
urce Settings
> >>>>               {
> >>>>                   Name (RBUF, ResourceTemplate ()
> >>>>                   {
> >>>>                       I2cSerialBusV2 (0x0019, ControllerInitiated, 0=
x00061A80,
> >>>>                           AddressingMode7Bit, "\\_SB.PCI0.I2C0",
> >>>>                           0x00, ResourceConsumer, , Exclusive,
> >>>>                           )
> >>>>                   })
> >>>>                   Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
> >>>>               }
> >
> >>>>           }

...

> >>> As for the solution, are you sure the line is not wired at all?
> >>
> >> No . It is some cheap mini-laptop , I have no schematics or any other =
info
> >> really .
> >
> >> Note that I am not really familiar with x86 and ACPI, so there is that=
.
> >
> > Yes, I understand that.
> >
> > You can try to monitor the /sys/kernel/debug/pinctrl/*/pins files for a=
ny
> > changes that might happen on the sensor events. It might (help to) reve=
al
> > the IRQ line.
> Sooo ... if the IRQ line is not described in ACPI, it could still be
> connected ? Hum, I'll try to shake the laptop next time I power it up.

Yes, it's possible, unfortunately due to the closed / per-product
nature of the Windows drivers.

--=20
With Best Regards,
Andy Shevchenko

