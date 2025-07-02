Return-Path: <linux-iio+bounces-21226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB2AF0D54
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 09:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B661622B9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B56230BDF;
	Wed,  2 Jul 2025 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLt3gF7i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C1211F;
	Wed,  2 Jul 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443076; cv=none; b=rWMT8gbV+VEgmgjKdVn2k9h1hnPfV/DHF0rCEW94Y2Slw/5vyjzfzBEpqJVX8Jwk7aVjOWFozPSYPGxSuKeeUOO4lm/Y4zlSU0EgzEWFdN8+7Q7GH3MS470aM8rD8ddUs/I6hGgbmc/YhkaATRmasWPgtTWJRqE4ZR2lpPm5fHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443076; c=relaxed/simple;
	bh=oferJm658YK0OfXJHRN4ok4UIvbf/DHykHZIPcj8Jb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jy6IsatrhdujIPH4x0x1BcUneUsQcPVQeixL4ujFtOrYIHBGffdyVX/d7igSJcIrukTwZ1IIgRePKWtFMEDMpKM3pg4rEJkTOqG5DgG0BQC+Ytb7LYrDkqlfo9bto8qpwmI2ojw5Yn4ABDMw8gTvtyN7NTjx8YiZVcFlsYfWARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLt3gF7i; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3748181f8f.1;
        Wed, 02 Jul 2025 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751443072; x=1752047872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oferJm658YK0OfXJHRN4ok4UIvbf/DHykHZIPcj8Jb0=;
        b=FLt3gF7i2D0kyjFtH6nVcFEZVc8pn3GnqPuKDXneZGpPAp2WADoy+dwslYqMKxuxMC
         xWIDBY8Iln5Qu2BQNBgYzcG/dGEH3ZWEsf6p9q50ijrrar9ZUj/qsjIyFN9bC08u1hjo
         D+jYOgvyjt8OZ88YAWQyfpnSSrpjQU+cNAt8IEIqtQdXRlSzSe5nfcOcxNE3rqrfHcbq
         Ji0Xj4bYRgyRnPnyQyUV1lal9ZBHo7Q218C5kUK5K3VoKPkmzvK2UfVTkV63Okeg3IU5
         ECcWqhhzn6vtpPXhc7E3OjJpXdtLm4Ri27X3ouXPR8SBvFVukiIvlF8Z1gFxVjVljPEe
         jMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443072; x=1752047872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oferJm658YK0OfXJHRN4ok4UIvbf/DHykHZIPcj8Jb0=;
        b=KBxiEDMoKI5TGt4Is2+Kuqgd+TKwDHCIXEzOdMyNYJesbCTG8/l8GSRyyQEam2xNxM
         HrvBDHbYJ3ck7KRDI6l8yO+lrKfpFhMiFqURmKqPwmlUD2ZP2n4+93teNx096efwI/Hf
         nPVkAjrpplOhIzBA02ACBGbktcOz8uYEIvXdJ4WZGL9vArAfDVbEi1XPWFjpI5nBVo4S
         wCzAPpmFHnOZ9xUgT7RBnPltq5eTcsQ5F5bgD0hh5o2XfxztRKxsWK914HTLaKd5W8kp
         5yXSrEgoiDxFvOw7KMuY84Z6KkSolmJlq/btI6bpz44uIRKHXMExcM4AEPPqvrkf54S1
         ONYA==
X-Forwarded-Encrypted: i=1; AJvYcCVHrfC3nrhyWRerJkK0VmsolINbFTxtHPiz1BndUJsu5N+92MIQegbUOp9FY/6rZhkLYxn7IDS98cuV@vger.kernel.org, AJvYcCWdYDbzipiTgstV8YDPuyHjtpR1Up2y/yq4yTZwAZ69OD1aoPbTyEgg37cIR+AFUbVWH73JAKDbL3Ur@vger.kernel.org, AJvYcCX570jr7fOZiBBhPdXvMJbjEOP7Rek3WNPeizD9F2SB8kXToK2EeCg5ubnwV/jppWE5RmJZuuI1sSmSnsrf@vger.kernel.org
X-Gm-Message-State: AOJu0YwsW4ToS5HyWna1vZnDwdIN1mtW60fSTv27AE2FqWLizDAg2sIW
	sYVIPiqdY2wxRHDJfD3oUtXefZqkoF0CNWVgvaZ3J6yU4b1XYOPs60eMt4FbFkiD
X-Gm-Gg: ASbGnculwNGjnhy5+3SNhyEEsxE6VDzCYO4HOdIuFbFu5Oj2gRJUFxuwontZhLxguW9
	WB0nSCBEE19XjnWkCZvKVuLYEL6hP29Tk3/qkpRe6eKkRK08PO/UPGkeg5abRsFB9ny8kzK2d/N
	4BA+sShdxXoOIqgELVNBTmvLGqxyiB0bVnqkoJXL0MZcFwuYUCb1i1cnEPhDMWdxjE4dAOG5m7K
	e6Vq9+Hkz/MnZz5LezGADkfMcGph7ZxRZP0gONNDmoC9Ybv2jHiuD81JrAyZfhBPpCCZt/mYZx0
	xx5rPORKFesyV8HDgst1GpcqNadzaWbu4SLGXRLwwYEHdIKI1RyFZpR9W6Lz1IBQR7RODw==
X-Google-Smtp-Source: AGHT+IFXLUR3NDT/WUsJ8mOESQBdYzix9UnmRPYXH18PTjwvmWq4ieqO4e+r6VK0WIJJv++VYUX+AQ==
X-Received: by 2002:a05:6000:4404:b0:3a5:27ba:47ba with SMTP id ffacd0b85a97d-3b200679c28mr864874f8f.44.1751443072276;
        Wed, 02 Jul 2025 00:57:52 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8e1sm15149684f8f.88.2025.07.02.00.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:57:52 -0700 (PDT)
Message-ID: <e1ed93170e820ab5e057c35048a04fcd74cdaa8a.camel@gmail.com>
Subject: Re: [PATCH v3 00/12] iio: adc: ad7173: add SPI offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Date: Wed, 02 Jul 2025 08:58:02 +0100
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
References: 
	<20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 16:37 -0500, David Lechner wrote:
> Here comes another series for adding SPI offload support to an ADC.
>=20
> The primary target is AD411x, but since this uses the ad_sigma_delta
> shared module, a lot of this series is focused on that.
>=20
> To start with, we have some cleanups to the ad_sigma_delta code, so feel
> free to pick these up as they are ready as they generally stand on their
> own.
>=20
> Then before adding proper SPI offload support, we make use of
> spi_optimize_message() to reduce CPU usage of all users of this driver
> during buffered reads.
>=20
> Also there is a new dt-binding and driver for a special SPI offload
> trigger FPGA IP core that is used in this particular setup.
>=20
> Then finally actual SPI offload support is added to the ad_sigma_delta
> module and the ad7173 driver.
>=20
> This was tested using EVAL-AD4112ARDZ on a DE10-Nano.
>=20
> ---
> Changes in v3:
> - Added extra patch to replace 8 with sizeof(s64) in ALIGN() [4/12]
> - Fixed typo in commit message. [6/12]
> - Fixed includes in spi offload trigger driver. [10/12]
> - Link to v2:
> https://lore.kernel.org/r/20250627-iio-adc-ad7173-add-spi-offload-support=
-v2-0-f49c55599113@baylibre.com
>=20
> Changes in v2:
> - New patch to fix overallocation of buffer size. [1/11]
> - Also change int64_t to s64. [3/11]
> - Fix typo in commit message. [4/11]
> - Factor out scan_type to reduce line wraps. [4/11]
> - New patch to clean up include more. [5/11]
> - Duplicate comment about odd case of 24-bit data. [7/11]
> - Fixed missing MODULE_IMPORT_NS() [10/11]
> - Link to v1:
> https://lore.kernel.org/r/20250620-iio-adc-ad7173-add-spi-offload-support=
-v1-0-0766f6297430@baylibre.com
>=20
> ---

Hi David,

Great series. Small nit on the new trigger patch but not really important:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> David Lechner (12):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: don't overalloca=
te scan buffer
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: sort includes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: use u8 instead o=
f uint8_t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: use sizeof() in =
ALIGN()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: use BITS_TO_BYTE=
S() macro
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: audit included h=
eaders
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: refactor setting=
 read address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: use spi_optimize=
_message()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: trigger-source: add ADI Util =
Sigma-Delta SPI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: offload trigger: add ADI Util Sigma-D=
elta SPI driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad_sigma_delta: add SPI offload =
support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7173: add SPI offload support
>=20
> =C2=A0.../trigger-source/adi,util-sigma-delta-spi.yaml=C2=A0=C2=A0 |=C2=
=A0 49 ++++
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0drivers/iio/adc/ad7173.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
> =C2=A0drivers/iio/adc/ad_sigma_delta.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 295 +++++++++++++-------
> -
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0.../spi/spi-offload-trigger-adi-util-sigma-delta.c |=C2=A0 62 +++++
> =C2=A0include/linux/iio/adc/ad_sigma_delta.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 +-
> =C2=A08 files changed, 345 insertions(+), 114 deletions(-)
> ---
> base-commit: d02f330b0c78bcf76643fbb7d3215a58b181f829
> change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
>=20
> Best regards,

