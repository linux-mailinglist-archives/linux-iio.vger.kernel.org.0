Return-Path: <linux-iio+bounces-16165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6886A491E0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 08:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABFB3AECFF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545111C5F05;
	Fri, 28 Feb 2025 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppqQfBTR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C1748F;
	Fri, 28 Feb 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726372; cv=none; b=uC5zNisSpLroWCJIUv+CftslHX3ux+ajZCLqe4rnZvKilazdrGub9ndibHYnXHfgPjBBAVvJ7UM8kxbSoiB+tEGRNS1rGxWphj3+WGOYAjhwv+DVefOBBEvw1IOoQVeZqr1WHAdidL6aEbqEvirGsm3vSXBu+qTlDHuxcTrV5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726372; c=relaxed/simple;
	bh=D9wj05ja4SlATslubM34glg0Z06kvmqZGlHnEMns0u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKMB7Tuz3bDK96M09uAXt8aHA79aIXs/uwLarOwJCGMh3016y4viq3P+wpkADppc8Tj+TNwrPuPn/m5FvfK+pxfpM0Z/r1ojfu16KMbGeQHSoTPdKYiAJjzK5dj2l/Sj4UzOMbS5UgZfMzdNjtKOCWlfkATu/clLBrvm/P94t40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppqQfBTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C9AC4CED6;
	Fri, 28 Feb 2025 07:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740726371;
	bh=D9wj05ja4SlATslubM34glg0Z06kvmqZGlHnEMns0u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppqQfBTRPAea3NVDBmPmOAkx1JQxV9d9ZBddDcQrwpIZip1BQIDe91vU2/O5AuEGH
	 TlcrcZ0efaCM1UgefqjzD5UmDmN/EuoTTtlch10mxn9/z8z/jELYt4n4F0CYkQRnXx
	 Z3ORfrC8vCsvDONwA2bskfoEGhpn1Q7uUGtxt4JebthTAVLLevZXSf7rEvL85G4EEP
	 ieVAnaw/h5N3AfHLbMCyL9GV6BDLkxjWBexr9PskvHVt4R7ZFVjzqkwyLdhma81HZH
	 2HhNuI15dqJJcnoV0VhmnRyoGAvd+LjUL5zj/mYe1M1j8Q00YvukuMY0oDWGWT9UZ0
	 npI/JsFelXg4w==
Date: Fri, 28 Feb 2025 08:06:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 5/7] dt-bindings: motion: Add common motion device
 properties
Message-ID: <20250228-statuesque-meerkat-of-novelty-b918f3@krzk-bin>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-6-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227162823.3585810-6-david@protonic.nl>

On Thu, Feb 27, 2025 at 05:28:21PM +0100, David Jander wrote:
> +title: Common properties for motion control devices
> +
> +maintainers:
> +  - David Jander <david@protonic.nl>
> +
> +description: |
> +  This document defines device tree properties common to several motion control
> +  devices. It doesn't constitute a device tree binding specification by itself but

Wrap at coding style, so at 80.

> +  is meant to be referenced by device tree bindings.
> +
> +  When referenced from motion device tree bindings the properties defined in this
> +  document are defined as follows. The motion device tree bindings are responsible
> +  for defining whether each property is required or optional.
> +
> +properties:
> +  motion,speed-conv-mul:

Drop incorrect motion prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 1
> +    description: |

Do not need '|' unless you need to preserve formatting.

Best regards,
Krzysztof


