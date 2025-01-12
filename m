Return-Path: <linux-iio+bounces-14185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C3A0A902
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F7C165FC9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F91B041B;
	Sun, 12 Jan 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOyCsoxi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B82A1B2;
	Sun, 12 Jan 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684189; cv=none; b=T+MAld/GoOd2m96zHKhEkqPmRRyaIv/fyKAp0EYzNtee2iUfvD771ade3AHzf3zMciAC79ddLuSMVgzp3ZmSifU1SuovhAL3MyHYL8jA0OfWprNv7D41TdXq2iiClGhaJxgxKZ4ID4E1Vgxnt5c/M4xkfHoEXDc17Y/0nuh6XeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684189; c=relaxed/simple;
	bh=A42SAXRmwcnKE4TLCOokFqjpUhC46Ujvsoz7qnnqVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJtV4WmSHbGn081GUNH447P8evwCJKFAHNdQ57XN9KJHzXk52HlOFbzTlq3OBK3xTIEJUK4kiPOWvHJYicNDmmR9R/em2h0Mo9BwJrw+sQ0WKtq+zb8Nle+C+FzncrbI0QJBcFlskt+wVnzVCnSLdwmxdWoIE4NzJHjMfKIro6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOyCsoxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC99FC4CEDF;
	Sun, 12 Jan 2025 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684187;
	bh=A42SAXRmwcnKE4TLCOokFqjpUhC46Ujvsoz7qnnqVSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOyCsoxiSIXBdwBNGiSub6ad0FKjP6c55CmuUW80BmENKsk+E0HLV6IMR+JQILk+M
	 obb1lMG1M2wYHpWhFPERgeVwSGncP5A9bWNasE6P19LlLZJrF0nWxNHKz6rqeRBhZl
	 N7jfL75afNTO38+xHfk39ZzRPV4WtftUw8dUU09GxZhnj8VzxTQk/KHNHqwMG2S4C7
	 GFn3OPm4FpYDVN65Fq5sFssqR0DLGHZB1IB85B3kk5fJDX9sfUeBm9tA1Tp3BwIZ7N
	 Ezwre43/nuP1S+CbdbNiG/1ZZ5bAnh/vK+R6xu3T8vOgzUmAeTF7DRTPyJVJ/ZVkoL
	 VU439h9rE5SSQ==
Date: Sun, 12 Jan 2025 12:16:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com, David Lechner
 <dlechner@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 02/15] Documentation: ABI: add wideband filter type
 to sysfs-bus-iio
Message-ID: <20250112121617.668f90c2@jic23-huawei>
In-Reply-To: <Z4L1qrqHBUE5JGdX@JSANTO12-L01.ad.analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
	<8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com>
	<Z4L1qrqHBUE5JGdX@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 19:50:18 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 01/07, David Lechner wrote:
> > On 1/7/25 9:24 AM, Jonathan Santos wrote:  
> > > The Wideband Low Ripple FIR filter is used for AD7768-1 Driver.
> > > Document wideband filter option into filter_type_avaialable  
> > 
> > s/avaialable/available/
> >   
> > > attribute.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index f83bd6829285..c4c21a7bfba1 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -2291,6 +2291,8 @@ Description:
> > >  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
> > >  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
> > >  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> > > +		* "wideband" - FIR filter with wideband low ripple passband  
> > 
> > I think "fir" would be a more specific filter type name than "wideband". (i.e.
> > there are wikipedia pages for sinc and FIR filters, but not one for "wideband"
> > filters)
> >   
> 
> Isn't "fir" a bit too generic for this case? Since Wideband here is a class of a FIR filter.
> Maybe something like "wideband-fir" or "fir-wideband" would work better?


Not sure FIR is even useful. That's just a particular filter architecture, not
related directly to the characteristics userspace cares about.
You can sometimes at least build a very similar response from an IIR filter.
The sinc ones describe the pattern they let through, FIR isn't that specific.
So I'd not mention FIR anywhere.

> 
> > > +		  and sharp transition band.
> > >  
> > >  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
> > >  KernelVersion:	6.6  
> >   


