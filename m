Return-Path: <linux-iio+bounces-18255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8EA938FC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603807B4E67
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65701DE4FB;
	Fri, 18 Apr 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq3bCdwZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E11D618E;
	Fri, 18 Apr 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988139; cv=none; b=tS9H/ysWhQA97WdacEO6FLlSjqEgZvvAQClZ52CpGf0fNt1XmKfY9EWDfa8uajv1L9n9QtKXf8Hr9KBtFxYN2uwdK6qPiwq3qijJ5q+1jdWJBn2WVNlpG0/V/1se0FvsDQJWAuxlLoqyjHWfwt9x8/m2S2TBPKH0NilWNP+6/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988139; c=relaxed/simple;
	bh=xxlkDC+ptsSipdaVzvxKfGZrXkHdinbpI+m0wsLD/9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd0TPbOGcyZK9e6SeICdDXAwCHiIpNU/HGn9iTQKjTk6vpf33ByNB1ZRCAJzEormMkRgylQ24BOoDUWrmdHCi5bNIPXVSC1XWNBLsPtL2DUOob9b/qszCSZEoX1RFs4i43naUOpnkL/wGjOj4P5vc6NXu7Vta6J9Cs3qA6Hhgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq3bCdwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365D2C4CEE2;
	Fri, 18 Apr 2025 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988139;
	bh=xxlkDC+ptsSipdaVzvxKfGZrXkHdinbpI+m0wsLD/9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iq3bCdwZz4DOlIjIszgQ8EVTtbNWOo5QHdeE4MppyoHFRYIXug+s6DZYQCbpHl7Xz
	 feszW9ykNafiBxRYRF/pLBwq24IzeUpwmhX3mpYrOorJaiEAJElQsonF29adeRMK7K
	 ZkgonCBfr/VPoxN8h4hYwwZyptv545Vris7VYhO8y1Eb+4bK9zokjPWhA623y2880b
	 dMbiQ6WBGgFRRcJEc58TYsmioxDQ/UzY/YiyDG+oWv2NoQMt6y3zN8Moe7K0tkbVSP
	 qkYo37OR0fyH7S67mHM052BKI20ZoFRcLPcm8DYZX/eNXrhygUYOg2EvY9882WxRTN
	 7K7XcC0ThDZYQ==
Date: Fri, 18 Apr 2025 15:55:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/8] iio: imu: adis16550: align buffers for timestamp
Message-ID: <20250418155530.088e398d@jic23-huawei>
In-Reply-To: <651b1f91-fd5e-4d59-b78b-fdd7f89247e4@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
	<aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
	<f4db1a95-106f-4fa4-9318-3ee172e29cdb@baylibre.com>
	<20250417184429.00002403@huawei.com>
	<651b1f91-fd5e-4d59-b78b-fdd7f89247e4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 15:48:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/17/25 12:44 PM, Jonathan Cameron wrote:
> > On Thu, 17 Apr 2025 12:07:37 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 4/17/25 11:59 AM, Andy Shevchenko wrote:  
> >>> On Thu, Apr 17, 2025 at 11:52:38AM -0500, David Lechner wrote:    
> >>>> Align the buffers used with iio_push_to_buffers_with_timestamp() to
> >>>> ensure the s64 timestamp is aligned to 8 bytes.
> >>>>
> >>>>  drivers/iio/accel/bmc150-accel.h | 2 +-
> >>>>  drivers/iio/imu/adis16550.c      | 2 +-    
> >>>
> >>> Looks like a stray squash of the two independent commits.    
> >>
> >> Oops, sure enough.
> >>  
> >>>
> >>> ...
> >>>     
> >>>>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> >>>>  	struct mutex mutex;
> >>>>  	u8 fifo_mode, watermark;
> >>>> -	s16 buffer[8];
> >>>> +	s16 buffer[8] __aligned(8);    
> >>>
> >>> As for the code, would it be possible to convert to actually use a sturcture
> >>> rather than an array?    
> >>
> >> I do personally prefer the struct pattern, but there are very many other drivers
> >> using this buffer pattern that I was not tempted to try to start converting them.  
> > 
> > For drivers like this one where there is no room for the timestamp
> > to sit earlier for minimal channels I think it is worth that conversion
> > if we are touching them anyway. 
> > 
> > Jonathan
> >   
> There is actually a lot more wrong in this driver, so will save that for a
> separate series.
> 
ok.  That is probably fair enough.
I'll not pick this up though given the smashing of 2 patches.

So this one will need a v2.

Jonathan



