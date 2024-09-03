Return-Path: <linux-iio+bounces-9096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C027396A78B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34153B21979
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063F1922E0;
	Tue,  3 Sep 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rism4ooS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08291D7E2B;
	Tue,  3 Sep 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392439; cv=none; b=RSUtq7z8tJo415z9KGu2g5UugySF3csEWEZ0SeaCb/ICPBXfeh001/ueJL6F7yIukdCP2yv5kPX8IUj0eEAUegXwgV13X60696JbIXXlhZcCYTRzfpoiFaWKxeWvnhEbF12bc6+tKJlmjaOE61tSoMGg2Ys5jkHOS350rcawKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392439; c=relaxed/simple;
	bh=7YUsp2sSGpccyYlbWGKOUrCSuBjr2Eoe65NIdAll4zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsqFHEc1orbDkrt6LGEzVMrodIhEtuiM6E7J6pIt3nBtfksh0GkEYuBEG7djFdNXI9zBwl35ZX5Rr0WhGH0jSJIzoi97OE9kPnuqHTJcyYys+ZFJP0bS3RpVYIeDcRDX6tO/r7cFAqpjmaz/YRfSqiu7k4NATaS85L1OS0FuK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rism4ooS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94156C4CEC4;
	Tue,  3 Sep 2024 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725392438;
	bh=7YUsp2sSGpccyYlbWGKOUrCSuBjr2Eoe65NIdAll4zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rism4ooSvjr+D1jsqZWle8stW18mdRgw01hSx4fFZasqrUyAwDemdxO+BDOFNUlP5
	 TeGj/8olIPLl0+HEXNPNUgRytntQzwSEU2Rgihsj1Ho33Ow15tMDtEMBpRRcydHqY9
	 QmxzMVxGH97Meka8R2B0Qxttl/BeJKhtVjYbuIBcw77wWdK3riw4uXYx7zjY9STdYi
	 3i6Yx1L9Er38/y7sLIyDRTGo2vATknrM20MbpGzLiJyqOBfDlqhOF9x/5n/XPrWPvn
	 55UfsmdvWhcKhYkGczkebwB2lm6/+KMDuqH/KNdrS4b+F/j6ulfE5HJL8yFpUTCaQf
	 i26sfULaptvhQ==
Date: Tue, 3 Sep 2024 20:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Message-ID: <20240903204027.72ae7e4d@jic23-huawei>
In-Reply-To: <BE1P281MB2420EBD112C4F7A96598AE05EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20240830-chaos-unrivaled-04c5c4c6add9@spud>
	<766b9892-ef54-4f0a-96dd-19e8a1b3279c@roeck-us.net>
	<20240831131824.03141d4a@jic23-huawei>
	<BE1P281MB2420EBD112C4F7A96598AE05EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 13:04:55 +0000
"Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:

> > On Fri, 30 Aug 2024 07:30:16 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> > > On 8/30/24 06:14, Conor Dooley wrote:  
> > > > Hey Tobias, Guenter, Jonathan,
> > > >
> > > > On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:  
> > > >>  From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00  
> > 2001  
> > > >> From: Tobias Sperling <tobias.sperling@softing.com>
> > > >> Date: Fri, 23 Aug 2024 12:08:33 +0200
> > > >> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
> > > >>
> > > >> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> > > >> analog-to-digital converters. These ADCs have a wide operating range and
> > > >> a wide feature set. Communication is based on an I2C interface.
> > > >> The driver provides the functionality of manually reading single channels
> > > >> or sequentially reading all channels automatically.
> > > >>
> > > >> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> > > >> ---
> > > >>   .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++  
> > > >
> > > > If this is a "generic" adc, why is it going into hwmon?
> > > > I would have expected this to be in iio/adc, and use more typical adc
> > > > bindings, even if the driver is in hwmon.
> > > >
> > > > Guenter/Jonathan wdyt?
> > > >  
> > >
> > > Same thought here. While the chip supports limits, making it suitable for
> > > hardware monitoring, its primary use seems to be as ADC, not as hardware
> > > monitoring device. The hardware monitoring API isn't well suited for the
> > > fast sample rate supported by this chip.  
> > 
> > Agreed, looks like a typical IIO ADC.
> > 
> > If the particular board needs it for hardware monitoring we have
> > the bridge that should work for that (iio-hwmon).  
> 
> Just some addition. In theory the chip also provides the possibility to use some
> channels as GPIO making it not only work as ADC.
> But yes, driver mainly implements reading of the ADC. Will try to make it an
> IIO ADC device then.
That's fairly common.  If you want to support it then provide the gpio_chip
etc and +CC the relevant maintainers and mailing lists.

Jonathan

> 
> > Jonathan
> >   
> > >
> > > Guenter
> > >  
> 
> Regards
> Tobias


