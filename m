Return-Path: <linux-iio+bounces-18892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68DAA433B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 08:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2753C3B6032
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E81E98EA;
	Wed, 30 Apr 2025 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns4X0hrI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C72DC779;
	Wed, 30 Apr 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745995241; cv=none; b=KTa2AZSxPi8KdvDXgRbP1HzEPMPSWf56+aUYZ8iUYx2/3XrsyBokf3IeIR08La9HSt+TC09QwBJVSDLvH8SDvHXl3vpfcNvhFtfRYFKoL7o/6rpkCwr2MxczSFEPlqcvIFyo+YR0lVu/8wO1+y5FVIE5clXU/d9kp5F4MSfeDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745995241; c=relaxed/simple;
	bh=HHOU7KMeX0mK5OS/F7GqN3nKb7uyLvNY78mpAgxsClk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwnIMMNPFpyUj+FS//w4koTgB0qL3Tcv4b9Zd4+H0VVAMrIDeWWN8G+b/2iCTn9XOqLmtg4aAU2dGr83Zke0u9/BK5sN2dXOGmDp69LlmMSQSmCLiD+0QcShy0j097IrS0OzfC7ocdntARPFtsiiUo+HeXqlpdvga4+SMDBQf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns4X0hrI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso48546195e9.1;
        Tue, 29 Apr 2025 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745995238; x=1746600038; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mpwBsR1+9GkLGmZAJLv8cZ37ZEluonUnS/qcsbm8IJ0=;
        b=Ns4X0hrINfw7FcCq7Cko9feGRABTR7mNsLWGQwgBHXC4+6qYmgFIUIp/kXCMXl3D8I
         eWNU9pbW5A/Di7Rr+92ksHO7Njb9Bya/NvU5cmRuIftpthlD7ysh75cWnfJPPddWv8jR
         z8LZuaBczyKikXakxbHetr2UtSYTA2X+JHhVzyyPItYGYVfTXwdWz1+l87YzZtFkG/nl
         1TnaDtEoG9gwGR229yDB78qd76vJn+r1R6VWoSJhvyCuF7jaYtUfqiPSvKJDkrr2BRSl
         LJYyjK+9flCRmKDfFy4TMqmd5HGeiGny5Ln0V74XucXQacOozJpWY1qvoEnbtOygl+0z
         fmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745995238; x=1746600038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpwBsR1+9GkLGmZAJLv8cZ37ZEluonUnS/qcsbm8IJ0=;
        b=VmeMNMMPLSqWgsiVyGuWtQ7FXRZJXlHyEM7KfV4Ryw4vINcuz/K/9ZToAkni27V/km
         O1xVWKrd9EOps19NCK5tRB5FRPqnVqabQvzDuJRafRzmvcPCbcfW/J0aqaqpMj14lnp9
         f9hY86+CZXuJL2nHL25uEv1tDGf0K20TCXDsdC+BGAdMb0ZSOxnM79OI+zLcJOB9RLvp
         5YCDCC4wT5mb51mjfeHM3hI9O9UJjI64AG1jtlbSnbemW5W3VXoctsaFLh2fZO+w7Y/L
         o+pMGtTtQVFmCALqAMYfk4ad7D043DGs7NLzVHNg33wUuwNfrhJBmBLGDNZAf4UXB79p
         6HCg==
X-Forwarded-Encrypted: i=1; AJvYcCWlvuKUc6TFEnq8oJ/GEB2OXDfT+hZngCQcwpoPyNchFlNyoELJhHhRYrL+gQ0P/Offsbrbluzp/PRJFzye@vger.kernel.org, AJvYcCXiWlPTu95M2PB/xzRwmmjuUxpnzNtmnzjx3gWiVzrX4GLsQ/+myRtT+exexCyzJHMld32QXIsSEYqx@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLDaoz9RzvHpIzlMO+TSZNHPSLvHzY6X9gfqcbss2LtFTlJq3
	A+6nR3SBL03/Fk+N7XhbI4F1A5c3hbCAyK68sc9NHjWUaEso9i5e
X-Gm-Gg: ASbGncuHCYrFMq3ED2n9S1hNWPJK1NLAyhMBcFntGSXd+eTWNwjgMqX3Wc7xIVbug64
	3QB6cZpDKEtS30thZE3Iyet36WANA/kttcwZBwJJNDCUy9rywcUCzfk6Pq1nQ5I/DkyChxSDaWb
	mKKX3QbfyCYihNiIqz0cakwp/TX45C8U8CO9c6VXCnxButDlFIIQVkK4eM8pStD+elelT05+LYV
	x3UZ38DrhpkgJJZ6F3h7WfrSqicrR0zrjHIHL9okVL1uh+tLp0cIFPfL1tu9RASJPZta46C3ZVs
	ueJvpRRaJlSSVboTkf9le5xMP2NgYonZLc5gi0z+59LCfc9XcV18le5kpP0ZxzIa53jjS2oqzDe
	jF1XZAtQ6VOpfTSY=
X-Google-Smtp-Source: AGHT+IGnOMdNScH6CkQCUlLailPHD46QOK4xU+DzjPrePOu++kDD1o1L2oLxUhMj9DaRMtnWQp70pA==
X-Received: by 2002:a05:600c:154f:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-441b2696014mr9461885e9.27.1745995237397;
        Tue, 29 Apr 2025 23:40:37 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28082sm12929205e9.34.2025.04.29.23.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:40:37 -0700 (PDT)
Message-ID: <4645ae3e0c3bb1ada9d4cadce77b64fe5e651596.camel@gmail.com>
Subject: Re: [PATCH 1/5] Documentation: ABI: IIO: add calibphase_delay
 documentation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 30 Apr 2025 06:40:59 +0100
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-1-eb4d4821b172@baylibre.com>
References: 
	<20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
	 <20250429-wip-bl-ad7606-calibration-v1-1-eb4d4821b172@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add new IIO calibphase_delay documentation.
>=20
> The delay suffix is added to specify that the phase, generally in
> radiants, is for this case (needed from ad7606) in nanoseconds.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++++++++++++
> =C2=A01 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index
> 33c09c4ac60a4feec82308461643134f5ba84b66..f233190d48a34882b7fed2d961141cc=
6bec3ddb2
> 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -559,6 +559,26 @@ Description:
> =C2=A0		- a small discrete set of values like "0 2 4 6 8"
> =C2=A0		- a range specified as "[min step max]"
> =C2=A0
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_delay

Not sure if I'm too convinced on the _delay suffix

> +KernelVersion:=C2=A0 6.16
> +Contact:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-iio@vger.kernel=
.org
> +Description:
> +		Hardware applied calbiration phase (assumed to fix errors that are
> +		introduced from external filters).
> +		For the ad7606 ADC series, this value is intended as a time delay,
> +		as an integer plus nanoseconds.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_delay_ava=
i
> lable
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available values of calibphase_delay. Maybe expressed as:
> +
> +		- a range specified as "[min step max]"
> +
> +		If shared across all channels, <type>_calibphase_delay_available
> +		is used.
> +
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
>=20


