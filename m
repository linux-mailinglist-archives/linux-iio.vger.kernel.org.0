Return-Path: <linux-iio+bounces-16196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A47A49C4A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 15:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AEA174F1C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD826FDBF;
	Fri, 28 Feb 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Yya9l4ou"
X-Original-To: linux-iio@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AA26B970;
	Fri, 28 Feb 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753762; cv=none; b=FwmyqiUUDT8ySCQTN1eIx/OAEeRZ079gTc76CS5jeCUTDiaeCWaV5s/0QXjXF+H2o04FVSNJJ3t5TGYyVQQsvcjHFWz53DTuDltkI7yD/17sZxQsoXca6uzyyMnHUp217blIDRPaT7+yw3zyuO1+VApnsSoOo6KzKlw6Zx2qs44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753762; c=relaxed/simple;
	bh=3fsvnjXaM/CzbH4hRdFI5Frl6zZPizu0LaHFPeLi1PQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDlnixffmmsaIMkGopX13FtV7Vry31wwVsVNyMsBIoG6ifWH3W7183TXotp5trWH328fFZPnFbhPS9G7S0G42Ws+SFjrBnnUw29UBvom6YxEtUFVQ1V8l4CZM3VaNkx9FI5TdDtnhbFr6KeOoFcg/1GNIhXFnzPhbb8B8+wgj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Yya9l4ou; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 08422404E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740753760; bh=VuBD/Hdy0DzyuJe4EYfZHrvz2Ap2tI9MnSTHTevxMIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Yya9l4ouvsltCpyExs0Vm+yj8+3lAtgjiC/564uxQOraDn3vFydGnLtkUnrEnqEPM
	 f8kEGY278WBShvSNd+6ZUn1i3o3oS5mMxdgNBgW5p3kXuPU0yrbCSb+VnysUfiyYaL
	 V44maLEfOvHp/I5wKjfhrPVS+gYxTHJnFUdTeTWKxQIsnTovmoS33dvVLpSmG71HTL
	 dAJ1c97l2goGAeebgrMuyBytXp4UfzK7YYTQMGZ0ZhGfALHNK4qlN/yOxKchr5wY3b
	 THMPmmiH4NDnxgNjzeEbd6RMqzXhstLx26VodXjpbeF71dL24RFukiXdGPO6EW1fgj
	 0Ofu6pdz88o/w==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 08422404E4;
	Fri, 28 Feb 2025 14:42:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 4/7] Documentation: Add Linux Motion Control
 documentation
In-Reply-To: <20250228140212.346c4ef5@erd003.prtnl>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-5-david@protonic.nl>
 <87y0xrpcnn.fsf@trenco.lwn.net> <20250228140212.346c4ef5@erd003.prtnl>
Date: Fri, 28 Feb 2025 07:42:39 -0700
Message-ID: <87o6ymnna8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Jander <david@protonic.nl> writes:

> What I am unsure of is the rest of the documentation (which arguably still
> needs to be written). I initially selected this place because of
> Documentation/subsystem-apis.rst. LMC being a new "subsystem", made me think it
> was the right thing to follow the structure of the contents there.
> What I mean to put there is documentation of the driver API for motion
> control drivers. I understand that while it doesn't really exist yet, I should
> leave it out of this patch set, but when I am going to write it, should it
> still go there, or is there now a better place?

I've really been pushing to organize our documentation by the audience
it is addressing, rather than by the developers who write it.  So
driver-api documentation is best put into ... the driver-api book,
Documentation/driver-api.

My plan, that I haven't yet acted on, is to create Documentation/devices
for device-specific docs that don't go anywhere else, then move a lot of
stuff into it.  Much like what was done with Documentation/arch.  But
anything that can go into the existing audience-focused manuals should
go there.

Thanks,

jon

