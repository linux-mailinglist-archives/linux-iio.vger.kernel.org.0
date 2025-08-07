Return-Path: <linux-iio+bounces-22376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DAB1D366
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BB7A3EE7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD12234963;
	Thu,  7 Aug 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay4onxIC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250832AD32;
	Thu,  7 Aug 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552074; cv=none; b=CbBRM4hbhNq/ZMGWA1RnDgpBvojcwdZon1QP6uacG5M7yvOuYeqveI0dHGx+pJzePfHvaP9peSq+cmjfbVu2xst4+RzsWtn+qNtXfBtx4Sbo/opgP+HOHs7RTkyJKNgDgjGDn9FEMnu/Z0mNdb5nLXKLoqJiQqlwfmAC3sIQRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552074; c=relaxed/simple;
	bh=B/UtvXcFOeY5envt9lydHp3nNSJG8mqKsutu+u1GSlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnEdRyaHefo/U2tEZoLxW/AWJ+5Swn5KIHxGbTy/p2K94NDVG+cAE9zCzFriNbBwIiKkz0nEad7GeCrlPtiLI8gcWy34KznQuy1jG5xNaUIDcw/oude2GnajIWwfPncp8xC0sDwZHbFSU2yomr0UbP4V9ai7trpQvoxmvczBKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay4onxIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A47DC4CEF6;
	Thu,  7 Aug 2025 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754552073;
	bh=B/UtvXcFOeY5envt9lydHp3nNSJG8mqKsutu+u1GSlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay4onxIC/SboKhYrSARaX2TQi08DvUcGSD38g2FgUS4F7NrNSwtp+QB+I76QJbt/e
	 yMSEFMunwFuOpwpaZbJkwxX6UCu1oiL+RCnLlkt+txXr5ynZCKlVrXjwR3OF6voCRz
	 tJm2H7hNbmb0pS0CuD0LaJSo+lbzc1vIrAzz8GJoqpPRaqZET0o7mE8Bkgs9OeBNb3
	 7MT4zW2A0dA3exY8Azhh234KQlzBjo4Z6Nm1fqmCPvrvwA54xvcBmFSDyAA5nA6RQH
	 8L3q+50tSK5DaYfsXCkeyo0a30e9rsQNjJcxA8YctfY6Ya3dblMT60F3/Nf4CRbF2/
	 Fgns0S43ZsSww==
Date: Thu, 7 Aug 2025 09:34:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <20250807-offbeat-vehement-starfish-d4cee9@kuoka>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
 <20250807-tlv493d-sensor-v6_16-rc5-v3-2-b80d2cb41232@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-tlv493d-sensor-v6_16-rc5-v3-2-b80d2cb41232@gmail.com>

On Thu, Aug 07, 2025 at 08:26:36AM +0530, Dixit Parmar wrote:
> Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> controlled by I2C interface. Main applications includes joysticks, control
> elements (white goods, multifunction knops), or electric meters (anti-
> tampering).
> Drop duplicate entry for infineon,tlv493d from trivial-devices.yaml as
> its documented in this seperate dt-binding file now.

Typo, separate

> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


