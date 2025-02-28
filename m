Return-Path: <linux-iio+bounces-16197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF545A49CC7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E943B1A5E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0F91EF393;
	Fri, 28 Feb 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="UTOThQgm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F01EF36D
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755204; cv=none; b=r3ZnGglUWOTlrGYM60pj/gvmB96TAtIdRrvWwYqtX+uy+Qs3JHWDrl8QXyRpv2AHPDZjp0g5k5PasDtoPf6Vvc4QppElVQF/CmWiYiow0KODHIhVHY7/88C3iJLpddyJbNgeOsLxdb72tSw4uiACsUeeSokqwn7q97Z6iuyiYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755204; c=relaxed/simple;
	bh=/EnYDBM43aGOMy0gb/gP024p3K1H5Tcoj+xs0GY9U0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YemsHwXI+Hw1j/3vVvnlYA7wow/8/LMsBLpj/HlhZvCOZVTb7zBz/kTj5mXFyfRDqZI8Y4fveuXB3nn+/IGk3JTC3mu+9g91y+tz1gC8irWuoOl3u80jEEmHcAj8q+3KyTD3MCLinYfiyzKOu3upRomQRvVv41fmgCQOhn1c1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=UTOThQgm; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=amr6wHzMs21hH/h1n2S3SIc2uEDDyL/a/R2Sg8zENXQ=;
	b=UTOThQgmeCgfDhFa1zO58gVsXxXm2SDJv0G1oLfx2xPrMSclq6mQU7A4lfRFK4zYdQvpLrbrypsi/
	 8aZ52/O+qiZDrvNCOLOBDYuIJUB0Xuu5KhyQDuVFEZKsDZzw1aK4q/pUllWC1eaxnvsXCKvWX7cJ35
	 xPpJLAhbWPa2WrwgACmtNcN00xipj57p76QH9+2yJqwVOrXOKK2gKFvPDVSQKuBKkMG0mem5qDhPrI
	 71MtRsW6zmqYx3h7m3ASOSxxNdjaH+BH+zZobTmrpaPIYZhKvP8qy5rICeJYR7+mgBgbzdtbi0v9Zx
	 nAktYIvbs7Yydl31kq+Lujcb1JA3xxQ==
X-MSG-ID: 9c1ba14f-f5e5-11ef-8b43-005056817704
Date: Fri, 28 Feb 2025 16:06:38 +0100
From: David Jander <david@protonic.nl>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 4/7] Documentation: Add Linux Motion Control
 documentation
Message-ID: <20250228160638.1a35944c@erd003.prtnl>
In-Reply-To: <87o6ymnna8.fsf@trenco.lwn.net>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-5-david@protonic.nl>
	<87y0xrpcnn.fsf@trenco.lwn.net>
	<20250228140212.346c4ef5@erd003.prtnl>
	<87o6ymnna8.fsf@trenco.lwn.net>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 07:42:39 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> David Jander <david@protonic.nl> writes:
> 
> > What I am unsure of is the rest of the documentation (which arguably still
> > needs to be written). I initially selected this place because of
> > Documentation/subsystem-apis.rst. LMC being a new "subsystem", made me think it
> > was the right thing to follow the structure of the contents there.
> > What I mean to put there is documentation of the driver API for motion
> > control drivers. I understand that while it doesn't really exist yet, I should
> > leave it out of this patch set, but when I am going to write it, should it
> > still go there, or is there now a better place?  
> 
> I've really been pushing to organize our documentation by the audience
> it is addressing, rather than by the developers who write it.  So
> driver-api documentation is best put into ... the driver-api book,
> Documentation/driver-api.

Sounds reasonable. I will put the driver api docs there once I come around to
writing them (I have the code commented already so that could be a start).

> My plan, that I haven't yet acted on, is to create Documentation/devices
> for device-specific docs that don't go anywhere else, then move a lot of
> stuff into it.  Much like what was done with Documentation/arch.  But
> anything that can go into the existing audience-focused manuals should
> go there.

Ok, I'll keep that in mind. Thanks.

Best regards,

-- 
David Jander

