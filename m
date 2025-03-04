Return-Path: <linux-iio+bounces-16344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7946A4E048
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40B7179C3E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591E20551F;
	Tue,  4 Mar 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE6wWxEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50710204F61;
	Tue,  4 Mar 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097254; cv=none; b=c6oN83NcOUbLIMdPxiD+OUQBGvYFUYBLRCB2xcTmQs4vuJ9/oLPH6gLlnUdMmwAmF8OpDpwLSLRD2Yxpq/AOYpMjt6/qK5N7OpaLzc0CQWvvE4AXj049PVGG18e2nV00Fehd789jkYaVJpQ0iDh1cTsQAbMk/C9dLBnykAkU5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097254; c=relaxed/simple;
	bh=C/gGfqeWg7bokpKzfH+pvbxBpqr4L7FKhkYPIdnr6ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjes63A94gInNlKE18xZH4XECHDchGCJNmPS79Sdw1oAQWdIJUIbL2CROgB0o6Ij3LLHdosIdPE7IM9h5OZDwGJhIQQhsyiKrzr9G/AykPCyXt9xbJN7H1S1RMpqw0PjScSwX8+44AafT4fuynfVIdIshEoL814kv2o2sNJNQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE6wWxEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51371C4CEE5;
	Tue,  4 Mar 2025 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097253;
	bh=C/gGfqeWg7bokpKzfH+pvbxBpqr4L7FKhkYPIdnr6ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cE6wWxEK4So0MmlpUJuWcqvZQkORsedvwONsszBYBeAJwsk8NmapWskpyPC8+kw4K
	 +fjedgtuUN9TZx5J6iVzy9Eva3ZytBy/SqP+T8WKCKgPwhucMQy0sPyS+FCrDUm8L2
	 lYrVowOr8tZLBuxRovZogephCb7fRadxrTJKVxNRpA1CYqfMLrYSGmy+6ZpiQ2g40w
	 AQugGX7leNDinoEwNd7F4li26heKrV6pez17MfnwlZ72lZCoYXt5eVdorH28ycydrq
	 0qFhcrFB3wkNWWwT8qZKk6ZBIZsujQGb54Y+2uES9DfW21gypY+fVjWL9CtTcjH70s
	 fvr4sDy/GS3sg==
Date: Tue, 4 Mar 2025 14:07:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 15/15] docs: iio: add documentation for adxl345
 driver
Message-ID: <20250304140723.78e17fb3@jic23-huawei>
In-Reply-To: <20250220104234.40958-16-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-16-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 10:42:34 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The documentation describes the ADXL345 driver, IIO interface,
> interface usage and configuration.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/iio/adxl345.rst | 406 ++++++++++++++++++++++++++++++++++
>  1 file changed, 406 insertions(+)
>  create mode 100644 Documentation/iio/adxl345.rst
>=20
> diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
> new file mode 100644
> index 000000000000..b77c97ef52e5
> --- /dev/null
> +++ b/Documentation/iio/adxl345.rst
> @@ -0,0 +1,406 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ADXL345 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
> +
> +1. Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `ADXL345 <https://www.analog.com/ADXL345>`_
> +* `ADXL375 <https://www.analog.com/ADXL375>`_
> +
> +The ADXL345 is a generic purpose low power, 3-axis accelerometer with se=
lectable
> +measurement ranges. The ADXL345 supports the =C2=B12 g, =C2=B14 g, =C2=
=B18 g, and =C2=B116 g ranges.
> +
> +2. Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Accelerometer measurements are always provided.

I'm not sure what this sentence is telling us. I'd drop it.

...


> +When activity and inactivity events are both enabled, the driver automat=
ically
> +will implement its hysteresis solution by setting link bit and autosleep=
 bit.
> +The link bit serially links the activity and inactivity functions. On th=
e other
> +side, the autosleep function switches the sensor to sleep mode if the
> +inactivity function is enabled. This will reduce current consumption to =
the
> +sub-12.5Hz rate.
This makes me a little nervous as it's not particularly standard.
However I can't immediately think of a better way to handle it so maybe the
currently assumption of when to enable it is fine.


> +A double tap event can be invalidated in three ways: If the suppress bit=
 is set,
> +any acceleration spike above the threshold already during the latency ti=
me
> +invalidates the double tap detection immediately, i.e. during latence mu=
st not
latency in the i.e bit?=20
> +occur spikes for double tap detection with suppress bit set.

I'm finding the previous sentence hard to understand. Perhaps consider
rewording?

> +A double tap event is invalidated if acceleration lies above the thresho=
ld at
> +the start of the window time for the double tap detection.


Thanks,

Jonathan

