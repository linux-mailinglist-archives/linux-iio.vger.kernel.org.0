Return-Path: <linux-iio+bounces-16146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB8A48551
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2927A3AC027
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA541B4241;
	Thu, 27 Feb 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="apCUKdjI"
X-Original-To: linux-iio@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90CE1CAA67;
	Thu, 27 Feb 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674230; cv=none; b=U+O5DevncJo3U+8DwL4Fkyrrs5zYsKof5g4kgA3JiR28xrbQcJPtIaH/MiUklyHF/mApn6aNzyy8AbC/zHwNZTZNlmr+GqlOOp8oIv2laTvxDn1q22Wf7oFwbMtLk1Lj7xNsdnkHXPfNrrnwNA2pgQk2XkUxMHD8vzq8m8cHiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674230; c=relaxed/simple;
	bh=mGXlY8Y4+2ktLSM48BY/ejBNuYKNdXAC/jN5iHT7UpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QfVmxsDD440yHqbBgGjCYNu3ZDyoViIFcRdtGvLIntvHtZkTBkjIfhDvt819WyDySd/0bbCYRh3dXgYUiTitIeGAJx0+joGOZ/9UNulrKKVdLGcCgxBiiEPSXsA3ZpkxY6EHIVhzHvUehxa4BoUu6q3O2YBoQQGCGIRVJXcyC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=apCUKdjI; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B65B448EC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740674221; bh=NGDGB8ov4zHVTiTCdNIsPZK64Vkv7UhrWBdFCn8zWPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=apCUKdjIAR4wg+LFY5B0idwA8u29aq2ZEhLWCusptlUAnNmZ/W7vsdaoK3/qk5j6I
	 3enxR1pdJNz6NyNV67/G7w4APlDitOEkp10/ITvPsa0eWidcTQ45TrMQIRsRZJiEka
	 ZXswgUUkJPcRXbTWwjvY1k843xR2Oc0jzU8t9U3wOsRv7xm83x0vRpe6blP8e20ric
	 SfbXER+cew+sGv0vfuOQxanN0yTsq8Sa7BlF71lZwWpGb9m7WEu5cThqhddjzwS7kZ
	 lEum8QEwjmu7ZR5BcIem5eajHb14hOmJGuGSLBj+Zq0owYEuSsY4W2YEBKQLMCoqQC
	 LjhO0JZnsGHkQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B65B448EC3;
	Thu, 27 Feb 2025 16:37:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH 4/7] Documentation: Add Linux Motion Control
 documentation
In-Reply-To: <20250227162823.3585810-5-david@protonic.nl>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-5-david@protonic.nl>
Date: Thu, 27 Feb 2025 09:37:00 -0700
Message-ID: <87y0xrpcnn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Jander <david@protonic.nl> writes:

> Add general- and UAPI documentation for the Linux Motion Control
> subsystem.
>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  Documentation/motion/index.rst       |  18 +
>  Documentation/motion/motion-uapi.rst | 555 +++++++++++++++++++++++++++
>  Documentation/subsystem-apis.rst     |   1 +
>  3 files changed, 574 insertions(+)
>  create mode 100644 Documentation/motion/index.rst
>  create mode 100644 Documentation/motion/motion-uapi.rst

I am glad to see this feature coming with documentation!  Please,
though, do not create a top-level "motion" directory for it - that is
just the kind of organization I've been trying to get us away from for a
while.  This document is clearly aimed at user-space developers, and
thus should be part of the userspace-api book ... please?

Thanks,

jon

