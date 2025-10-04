Return-Path: <linux-iio+bounces-24709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADEBB8DFD
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52CE94E60D5
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005740855;
	Sat,  4 Oct 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnB62fHz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA3A932;
	Sat,  4 Oct 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584640; cv=none; b=HJZCvaUN65hh/ctYgPdhgEuHzFfkhmo0x32xnOOxhpwvh8T4X5xFII63KNhyk+i5dFzQ7aGs0w6GpbSsEwdQpFgA9JT1zOyagC9IBaOufglbRrmQ17W4B4q2ZiKGrHqiJi80Q5rwHa0xZ5Fxr7MmYu4JbuX98UohXwf4mfrN7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584640; c=relaxed/simple;
	bh=CArLsWXqcWM2/vGAYix/smoQl6kT2P4qKZXNV+IgUSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3O4matsbPQUBaLgPhmGtS9oibHHAY4f/VQWEkwrKE28VN/uLLd+h2zgH7M+apVn87liXZM8B1NrDtOyrt9bX8sOlf0iYf5u4GKmInS64mDkclMg58uKUwotY5QWUl2EnRTzfW9P8nN61sCubwnrmLiK937IiZmEhB9ggeQGh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnB62fHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B39C4CEF1;
	Sat,  4 Oct 2025 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759584639;
	bh=CArLsWXqcWM2/vGAYix/smoQl6kT2P4qKZXNV+IgUSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qnB62fHz3IROPsk8TypNaVCfhXdzCGSafFbRT3MWgiB8OrEqrPZYKAO42NvcJoj9G
	 wTF/oWTgc36C0R04ks9G+ZiIp2dmka8H1DZXmyMt4Ctc4jJ7MiW8gG8Pr7nCBVoAz0
	 i+8DsdR9Llta3cvDWwXYTZbGBGkQyJbPczGBhi/7DWmpzgdjgX6xtsD2i4vTM2lm/3
	 1WZOkTiLK0PqJSLRytc2ABZ5QqOOL8YGEQL6J7pacYyiKxTedJEDBE99WH3DclC/x+
	 KGWhXgC72ApYjupWhy5TsfBHyFlMZtackczAMjW9gMlFAlB9b73WZ+Rf4xYGSOTrUS
	 p6ILY87PgSyjQ==
Date: Sat, 4 Oct 2025 14:30:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Message-ID: <20251004143029.02f026a2@jic23-huawei>
In-Reply-To: <CAMuHMdXPEZJ11sfLDk=O1oZq_OKz22G9wz3Sw5acMr1QVYG_Qg@mail.gmail.com>
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
	<CAMuHMdXPEZJ11sfLDk=O1oZq_OKz22G9wz3Sw5acMr1QVYG_Qg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > --- /dev/null
> > +++ b/drivers/iio/adc/rzt2h_adc.c
> > @@ -0,0 +1,309 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/adc-helpers.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +
> > +#define RZT2H_NAME                     "rzt2h-adc"
> > +
> > +#define RZT2H_ADCSR_REG                        0x00  
> 
> I would drop the "_REG"-suffix from register definitions...
> 
> > +#define RZT2H_ADCSR_ADIE_MASK          BIT(12)  
> 
> ... and the "_MASK"-suffix from single-bit definitions.  But this is
> my personal preference/taste.  Perhaps IIO uses a different convention?

Problem with dropping _REG is we regularly see registers with complex
multi part names and it can be come confusing at point of use wrt to
whether a given define is a register address, or field.  

I don't mind dropping MASK for single bits though as there inherently can't
be confusion between those and field values as the 'mask' defines the value
as well.

Jonathan

> 
> > +#define RZT2H_ADCSR_ADCS_MASK          GENMASK(14, 13)
> > +#define RZT2H_ADCSR_ADCS_SINGLE                0b00
> > +#define RZT2H_ADCSR_ADST_MASK          BIT(15)  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


