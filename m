Return-Path: <linux-iio+bounces-27073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEA9CBBB8B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 670C93003FB2
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793221773D;
	Sun, 14 Dec 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7iourVe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6B2AD2C;
	Sun, 14 Dec 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765723178; cv=none; b=Zfj32XEmXV4eqRen3Bv1Sm2DBcN9Fig9XHdObydB7s7IA6KzH6kmPJhwF5QrmZUPPj94eC01+GnVL2KLDY4qKsoqKGj8qDRSPpJP6c1dBqO/KqcHCXFmdWHFpPgjnonyZU7ioTFAwsbbAWQnlf1szo1WLYw6D7ybJVoB/bjypdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765723178; c=relaxed/simple;
	bh=Bd+qo7bHkfqUlew5YUofuLCW5YL5aHXZu/BXbAdnosw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHj7FFywHdzB5IXXHjmKFbjmzmZAG9qCfXeKNHFtPCRqWy8T9NUAFwHiRorjttw95osYrOttesog3zgUZS/vHXCWLbS+OXKh3qq3ZGf2sAzBxDnH+c+4ov7Ofj/lSjJSokgY/kFgr6e5VTQq5fvJ5TtcKkKVOKDqMpk8X1FuxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7iourVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF5C4CEF1;
	Sun, 14 Dec 2025 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765723178;
	bh=Bd+qo7bHkfqUlew5YUofuLCW5YL5aHXZu/BXbAdnosw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7iourVefKaeCaiumBeiJ4qHejJ1iTeolnGZA+RT2uYAbOWGB+LMOFUhls+yTlMBt
	 OBxw55YFp+de26cv8w856CCDgjY+HdwObnSIvhVcFBBRbaglvK8o1CwBeGZ9YlSQKd
	 40g2zyZqRHV2trTMze4Jc22vV01U1FioVTMVfe8jdJPC3eoxrOPZ9+uYQWniNs4Zix
	 swolH+yc7R0oto+EACLOB6Xe1VhULR+wl5GcX+h5AspX+hMrkVRRiZcuJlI3xiZcsV
	 hk+rPclfIXFgD1iKUDMIjrtXdS/6OSYbfkbkpQBFuwWyFY7QUtXtUz4XAvr5h64891
	 bADWozPX2jyDg==
Date: Sun, 14 Dec 2025 14:39:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
Message-ID: <20251214143930.6ee61d75@jic23-huawei>
In-Reply-To: <98101700-35EB-4D45-AEE4-6FF1E9D55505@axentia.se>
References: <87qzt2tnlu.fsf@prevas.dk>
	<17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
	<ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
	<307296eb-e5b4-705b-6851-53cecb87a69c@axentia.se>
	<87ms3nu9m7.fsf@prevas.dk>
	<20251213165723.762035e4@jic23-huawei>
	<98101700-35EB-4D45-AEE4-6FF1E9D55505@axentia.se>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Dec 2025 05:56:14 +0100
Peter Rosin <peda@axentia.se> wrote:

> On December 13, 2025 5:57:23 PM GMT+01:00, Jonathan Cameron <jic23@kernel.org> wrote:
> > I'm a bit curious we haven't seen many reports of this one. Whilst
> > there are relatively few IIO drivers that consume other IIO driver
> > provided channels it's also not a particularly new thing.  
> 
> I suspect the reason is that plain old iio_read_channel_raw does not
> grab the info_exist_lock, so it seems that you need two levels of
> iio_read_channel_processed[_scale] (or something like that). Which
> is rarer still.

iio_read_channel_raw() does grab the lock (you had me worried
there for a moment!)  Does it with a guard() so perhaps that threw you
off.


Jonathan

> 
> Cheers,
> Peter


