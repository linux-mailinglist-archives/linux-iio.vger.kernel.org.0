Return-Path: <linux-iio+bounces-24987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3501ABD0859
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96643B2905
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9E2EC097;
	Sun, 12 Oct 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU+8x89S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8191CEAA3;
	Sun, 12 Oct 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760289350; cv=none; b=Hjk/cVws0RK3kVvxr3j2BTqYrH5yVPc13sQRGljKcDj7pe13mJ8EbHeHHnXTeTDW2o3XAHc+H8oMe4F0MRE9lMyv6BE5xvyepvnkt3db18CGEtHhDQ5JKQOQiW0ZT0XavqYcD7W2VjeT6sid+W/1zP25ef5MhcaVDJutAkyo2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760289350; c=relaxed/simple;
	bh=wtS+qAeKr0CCO+Mhq6PZSEwGQeMzWeyVS/24iTfdb2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCW+Q+oTGt1smXdxFKq7za4Tmwz/5pIVY98ZJmtZVBtosh0whiZpkQhuzSGgSog5xcqtPFsxY/tKljr/RXRtWOkFNjPEbXKBIHgJcYX0yh731SXUnUm0Pr2i2zACSkj1y7HprKAoFJEWbbOaPZxakx9CjP+kuMqSZBvJSVG4RCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU+8x89S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72871C4CEE7;
	Sun, 12 Oct 2025 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760289350;
	bh=wtS+qAeKr0CCO+Mhq6PZSEwGQeMzWeyVS/24iTfdb2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YU+8x89S/34gVqEOIO7AB/9pVI6iVqXApr9fs1f2O7qWCPZkGFozvbBW/E+9qjZsp
	 q3i1IVjyPrhngQOdfoLeOwCnl8oX2Bw126GSN/7nDgLMnic9XE6xPrC/Jm4DIHcua6
	 INySSw17YL7GCbnG1WzCUS9iphm10lI63yC0iOv8oPFekogN0GzEiOjsY2wv/3Avau
	 Xo/8Cpqj1I2Z5M4FejKgyFiI3cPsgcgQTtA2wTvxuTDPZ41GUFecFf5jW1QaHB4Pwi
	 JU0ezrYa/A9RXsIB0UtSY3sgo3zosW7H62PMOZScBfD3oS0PefV8C6FmgjndWia5S8
	 JU4pmgA9d2ewQ==
Date: Sun, 12 Oct 2025 18:15:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lakshay Piplani <lakshay.piplani@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
 "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "peterz@infradead.org"
 <peterz@infradead.org>, "jstephan@baylibre.com" <jstephan@baylibre.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, Vikash Bansal
 <vikash.bansal@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Shashank
 Rebbapragada <shashank.rebbapragada@nxp.com>
Subject: Re: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
 P3T175x temperature sensors
Message-ID: <20251012181537.6600e6b8@jic23-huawei>
In-Reply-To: <b4fd595a-8507-43b7-9390-d819867d7cef@roeck-us.net>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
	<96f5443f-5b40-4d05-b350-78d55a1d841d@roeck-us.net>
	<AS4PR04MB9362FDA1FE35AD06C99B85E3FBEEA@AS4PR04MB9362.eurprd04.prod.outlook.com>
	<b4fd595a-8507-43b7-9390-d819867d7cef@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 15:37:42 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 10/8/25 22:56, Lakshay Piplani wrote:
> >   
> >> -----Original Message-----
> >> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> >> Sent: Wednesday, October 8, 2025 7:41 PM
> >> To: Lakshay Piplani <lakshay.piplani@nxp.com>; linux-kernel@vger.kernel.org;
> >> linux-iio@vger.kernel.org; jic23@kernel.org; dlechner@baylibre.com;
> >> nuno.sa@analog.com; andy@kernel.org; marcelo.schmitt1@gmail.com;
> >> gregkh@linuxfoundation.org; viro@zeniv.linux.org.uk; peterz@infradead.org;
> >> jstephan@baylibre.com; robh@kernel.org; krzk+dt@kernel.org;
> >> conor+dt@kernel.org; devicetree@vger.kernel.org
> >> Cc: jdelvare@suse.com; Vikash Bansal <vikash.bansal@nxp.com>; Priyanka
> >> Jain <priyanka.jain@nxp.com>; Shashank Rebbapragada
> >> <shashank.rebbapragada@nxp.com>
> >> Subject: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
> >> P3T175x temperature sensors
> >>
> >> [You don't often get email from linux@roeck-us.net. Learn why this is
> >> important at https://aka.ms/LearnAboutSenderIdentification ]
> >>
> >> Caution: This is an external email. Please take care when clicking links or
> >> opening attachments. When in doubt, report the message using the 'Report
> >> this email' button
> >>
> >>
> >> On 10/8/25 03:07, Lakshay Piplani wrote:  
> >>> This patch adds support for the P3T1750/P3T1755 temperature sensors  
> >> under the IIO subsystem.  
> >>>
> >>> P3T1750/P3T1755 support two operational modes:
> >>> 1. Comparator Mode
> >>> 2. Interrupt (Latched) Mode
> >>>
> >>> The HWMON subsystem is more suitable for implementing drivers for  
> >> comparator mode operations.  
> >>> Reason:
> >>>     - Temperature thresholds can be polled and exposed via sysfs.
> >>>     - Register reads do not clear status, allowing safe alarm state derivation.
> >>>     - Matches existing drivers under hwmon.
> >>>
> >>> The IIO subsystem is more suitable for implementing drivers for interrupt  
> >> (latched) mode operations.  
> >>> Reason:
> >>>     - Interrupt mode uses edge-triggered ALERT/IBI signal interrupts, which  
> >> can be pushed to user space using iio_push_event.  
> >>>     - IIO's event API (IIO_EV_TYPE_THRESH) supports timestamped  
> >> rising/falling edge events.  
> >>>     - I3C IBI integration maps naturally to IIO's event push model.
> >>>     - No persistent alarm bits are available; so polling in HWMON may result in  
> >> missing events.  
> >>>  
> >>
> >> This is just wrong. Interrupt support can just as well be implemented in a
> >> hwmon driver.
> >>
> >> Guenter  
> > 
> > Hi Guenter,
> > 
> > Thanks - agreed, hwmon drivers can support interrupts.
> > The distinction I meant to highlight is about semantic alignment.
> > Both P3T1750 and P3T1755 does not provide alarm/status bits. In TM=1 (interrupt mode), the alert is latched
> > but cleared on register read, with no way to query alarm state afterward.
> > 
> > HWMON typically polls alarm flags via IRQs, expecting them to remain asserted during threshold violations.
> > Without persistent bits, supporting interrupts in hwmon would require emulating state in software, which diverges  
> 
> So ? Various drivers already do that. It is not even necessary to "emulate
> the state in software". Just store the state in the interrupt handler, and
> report (and clear) the state when the alarm file(s) are read.
> 
> > from its ABI and could mislead userspace expecting stable *_alarm files.  
> 
> This is just incorrect.
> 
> > IIO's event API, being edge-triggered and timestamped, aligns more naturally with
> > this transient behavior and with I3C IBI signaling.
> > 
> > I'll reword the cover letter to clarify that this is a design choice based on ABI semantics, not a limitation of hwmon.  
> 
> Again, that design choice is not a reason to have two drivers for the same chip.
> 
> Guenter

+1.  I'm not seeing anything yet that rules out a straight forward hwmon driver for this
and as it is a simple temperature sensor hwmon is preferred home.

Jonathan


