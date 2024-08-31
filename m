Return-Path: <linux-iio+bounces-8915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B09967180
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C2F1C21583
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E317E01C;
	Sat, 31 Aug 2024 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ2JezcI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF84193;
	Sat, 31 Aug 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106714; cv=none; b=kzgbjZImdh4X0crAkzufd3dhNeAyiXcZQ2eJ1flHUppe0QjE55mikB2R7POpspNEZphcf7J34jSHhQcs0Y3AB4/vC6sYCikW3HJkwVuP6wAoLN4GJm/GceKF4/aGpqoinPpgeQGoJBPvvC7jfQFkYz/Zg3GburvYGfx4/3/KBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106714; c=relaxed/simple;
	bh=/DcwqGi/TTJgseU69eQAMnE6ASnIXDVzUih6oz1NpNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSsnDfPiwIvo+eFR5iZSDsU1/oINV3yTPxxAfvL0BuW01Q5KMkfXa0IvQmzJl60iFQ4kL8P0pMC1hh3cdkumiuA4gMi7pC2PNoNg/f6b3E6+VT79EC20pH8J31UI5c65XYjpNVn6ylyzr8d+iho9j8Upn6ssdg2GxzsAlbs2ebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ2JezcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567CEC4CEC0;
	Sat, 31 Aug 2024 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725106713;
	bh=/DcwqGi/TTJgseU69eQAMnE6ASnIXDVzUih6oz1NpNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJ2JezcIpXcSe1NeonYL0r100OFvOuWNOT0MzKkQRdZzXDLAyYJ1JJbL+AndAvIRr
	 3DlUus60hSuaxcD927eSDfNQb6AkRNKC2AjJRL18BHbJFuCcOzTnrTZZZ8U6yVn1rH
	 CS86ErYAaIzj+qOuWqmmLrVoQZqNNd8VCfvoWIEfBYt0+e3sqekz25D+KsGL7q6QhW
	 GKEolpj6QE+8i4Ypgw7zHal+9jbV4qdoj+xpyUgBCLdOjD6ge1BaW7JcqGWG4lDfgy
	 Z70M6CTMzhLYpkkobsxeaQjB/Xp/QDCAgTogGGLf+7YiN5qcFPwYe0RTkVDoM7nklM
	 BwU0BnUV+d5ng==
Date: Sat, 31 Aug 2024 13:18:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Conor Dooley <conor@kernel.org>, "Sperling, Tobias"
 <Tobias.Sperling@softing.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
 <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Message-ID: <20240831131824.03141d4a@jic23-huawei>
In-Reply-To: <766b9892-ef54-4f0a-96dd-19e8a1b3279c@roeck-us.net>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20240830-chaos-unrivaled-04c5c4c6add9@spud>
	<766b9892-ef54-4f0a-96dd-19e8a1b3279c@roeck-us.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 07:30:16 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 8/30/24 06:14, Conor Dooley wrote:
> > Hey Tobias, Guenter, Jonathan,
> > 
> > On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:  
> >>  From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00 2001
> >> From: Tobias Sperling <tobias.sperling@softing.com>
> >> Date: Fri, 23 Aug 2024 12:08:33 +0200
> >> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
> >>
> >> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> >> analog-to-digital converters. These ADCs have a wide operating range and
> >> a wide feature set. Communication is based on an I2C interface.
> >> The driver provides the functionality of manually reading single channels
> >> or sequentially reading all channels automatically.
> >>
> >> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> >> ---
> >>   .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++  
> > 
> > If this is a "generic" adc, why is it going into hwmon?
> > I would have expected this to be in iio/adc, and use more typical adc
> > bindings, even if the driver is in hwmon.
> > 
> > Guenter/Jonathan wdyt?
> >   
> 
> Same thought here. While the chip supports limits, making it suitable for
> hardware monitoring, its primary use seems to be as ADC, not as hardware
> monitoring device. The hardware monitoring API isn't well suited for the
> fast sample rate supported by this chip.

Agreed, looks like a typical IIO ADC.

If the particular board needs it for hardware monitoring we have
the bridge that should work for that (iio-hwmon).

Jonathan

> 
> Guenter
> 


