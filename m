Return-Path: <linux-iio+bounces-23352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0AB3B3A9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 08:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B534A581339
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099D25F98B;
	Fri, 29 Aug 2025 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRXnmf7y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1313AC1;
	Fri, 29 Aug 2025 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450337; cv=none; b=FgYZa0P7mK2mGMIRTOECrvMXncKr7pSMnHf677TJwKgacLYirjem3Mo+WYzcBAP1gEeaNjuVtARR4aiDiQySUOqVWgLu9gTwYn0KpfrNGh2BKW8oPei2+tDR83VxV8EHmVbxxdupkxo+/2KmF8YndmaFMvuqe2La/seN4asShiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450337; c=relaxed/simple;
	bh=68jkQgCx2fazd5y0OMizbVRJG8wEHR4BpUqv1dweba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP8GWYKwpjkSoOsWjgueVXWTgFsn4ZL+9Hm0VPRXRGSY7ZHeyLFewtrnUE4jO/xUZqFVl1Hmy/BrODfUzY5xL0t6FDAjB7lmnmBXMMbWOSLTBlFw/hw0gnMQBtNLI84l6tbAu7is3SwIoiGQ5e2yXtuCDTVvplBAGkuKETAQ+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRXnmf7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF0FC4CEF0;
	Fri, 29 Aug 2025 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756450336;
	bh=68jkQgCx2fazd5y0OMizbVRJG8wEHR4BpUqv1dweba0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRXnmf7yNzFdwaYBcrB8StoHt60CtdwslFoBZAIEITuOvSoPQ5f+F3lk56/PWhqJL
	 cIDznaFTCL3QI+NcKfjvswqzV8ZEmU3Ubp09Pp3OXOQ34RmZnE0iKwCtp7M7pAzOEu
	 cR+0jM5xaiuSnmGe+v4rfnxEiWUnpwmN8pUJvkDg+sm1AJ3HSi2RWpyv+VKZCZ5I2H
	 JfzwecPBV0zET2fFh41eZK5bFQ8k6fqQ8v33IO7k2wCBlYAMnDDRf7aUhIMQWe3HxB
	 55DhcQYoR/IKhTXsbw0xHnW3/2i7mYktZh1itDGWzkJwU9+CQuPe7i9bdDf0wWa9j9
	 J/2Y9oSFKPwfg==
Date: Fri, 29 Aug 2025 08:52:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250829-fluorescent-delicate-pogona-c96b5f@kuoka>
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
 <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>

On Fri, Aug 29, 2025 at 08:23:42AM +0530, Dixit Parmar wrote:
> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
> 
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
> 
> The driver supports raw value read and buffered input via external trigger
> to allow streaming values with the same sensing timestamp.
> 
> While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> But for bus configurations interrupt(INT) is not recommended, unless timing
> constraints between I2C data transfers and interrupt pulses are monitored
> and aligned.
> 
> The Sensor's I2C register map and mode information is described in product
> User Manual [1].
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf [1]
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  MAINTAINERS                        |   8 +
>  drivers/iio/magnetometer/Kconfig   |  13 +
>  drivers/iio/magnetometer/Makefile  |   2 +
>  drivers/iio/magnetometer/tlv493d.c | 533 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 556 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fad6cb025a19..cf0a00f5c4d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11843,6 +11843,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
>  F:	sound/soc/codecs/peb2466.c
>  
> +INFINEON TLV493D Driver
> +M:	Dixit Parmar <dixitparmar19@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +W:	https://www.infineon.com/part/TLV493D-A1B6
> +F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml

There is no such file here. Apply this *patch* and check by yourself.

Your patchset is still incorrectly organized. See submitting patches in
DT dir.

Best regards,
Krzysztof


