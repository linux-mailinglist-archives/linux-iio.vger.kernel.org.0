Return-Path: <linux-iio+bounces-13321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1F9ECBD1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E2328405F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBB225A2A;
	Wed, 11 Dec 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exmfa/dW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B7238E34;
	Wed, 11 Dec 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919448; cv=none; b=EUXMc2hDkqbKIndMhIA9nKV8S6dIevGkDEYHY4/JIwLAKUxegFrhdEdMZPDBXjQPBGYb81L8qnSv5DLbc9iTYBeJkJ8r2Br2eXQ7HbWsRzLg7C1kkMiovyiaPyKaN2diTSz3hwrNmoKx5xvX9piBnQdSP2LXNzJrncF3WAW4W+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919448; c=relaxed/simple;
	bh=pxxMBZqrH7x/gS7Fl8JT4cHNQ825NZlShGPRQdbliHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVicywcDVY9xhQrDeoaA8k37fvPBnke4y571PdAlidtjbHJMhW88d8KJhfCXcP1B9DcJJGLqhEUr+3dE4/0DQnLTgqGR1/ww/YBBX7weTZOe7NgXtBAykanY8Mu7WwDZBiAFeW0OcEbyMazOL17oVx/93Q4QE7Cd6brX7HbgjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exmfa/dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62825C4CED2;
	Wed, 11 Dec 2024 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733919447;
	bh=pxxMBZqrH7x/gS7Fl8JT4cHNQ825NZlShGPRQdbliHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exmfa/dWUJQdqssDCvd4IXqfV2xh+VVg8htJAWrMhISPUmite/i8jN5/G6n+em1sg
	 iNzEivin+e1cVizPcwrdU0vePxvbltw5ADNWnE+ZJJqiyuj/fNq6l2P3tp9W3r4GG0
	 9E4NrB6iS5o44mDf1axfIcBfOfKT/0/iMCEqsZISd/jIJVpAGZkpqltWwuT4QtyWQh
	 tXLYnQHY4+ycSHLV4p31MClhab0cdtMhVhn8apJZ/OnUq3L/yLd6LQmW6kf+zw2cL+
	 35YrQMExjH6A385RY7HICJPPAy8GuYl2JHSiu0O018XzxC+mUvnNXWFyLYQ8BQKBoh
	 S3udlbhc36vEA==
Date: Wed, 11 Dec 2024 12:17:18 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale
 platform-data on remove
Message-ID: <20241211120844.GD7139@google.com>
References: <20241107114712.538976-1-heiko@sntech.de>
 <20241107114712.538976-2-heiko@sntech.de>
 <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm>
 <4934964.GXAFRqVoOG@diego>
 <nycvar.YFH.7.76.2411071534110.20286@cbobk.fhfr.pm>
 <20241112143732.GG8552@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112143732.GG8552@google.com>

On Tue, 12 Nov 2024, Lee Jones wrote:

> On Thu, 07 Nov 2024, Jiri Kosina wrote:
> 
> > On Thu, 7 Nov 2024, Heiko Stübner wrote:
> > 
> > > This change was more or less a surprise find, because I wanted to make
> > > the platform_data pointer in the mfd_cell struct const and this the hid
> > > sensor hub stood out as doing something strange ;-) .
> > > 
> > > So patch 2 of this series actually depends on this change to not cause
> > > build errors.
> > 
> > Ah, right.
> > 
> > > But seeing that we're after -rc6 alredy, I would assume the brunt of the 
> > > mcu series might need to wait after 6.13-rc1 anyway - but I guess that 
> > > depends on how Lee sees things ;-) .
> > 
> > OK, I am keeping my hands off it for the time being.
> 
> I can take it now with an Ack.

Looking to apply this set now.

Ack please.

-- 
Lee Jones [李琼斯]

