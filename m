Return-Path: <linux-iio+bounces-24658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB848BB3E38
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FF916A1C3
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3331064A;
	Thu,  2 Oct 2025 12:28:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB323101D1
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408121; cv=none; b=Yek46R4U+ugO2eEup4Ohd4bDfxb5OZsgvObp0odl9qqK/sbLg+pnAMBxKeaI6/czXVfmO0wqOzWyU8X4D7JBJGZ1hanhogRHb/a37aQJTXJ+p3bLN2NBeR/yTeZAJGFLD4VhChh1c9JVH/Pmg8u0fONcVGzm5vQFG2U+5v4BSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408121; c=relaxed/simple;
	bh=crq8yfuHaLUS3p5H/zdDJJGaYFs9968BkE02+nGHfFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6MES9tlxPBW+G074VD+OqAaQhnEL4lOOeY5JeW88892XvjwXEQIvnlWG4OPGnW9gKZn5PJsbN+bfWPu/lK1c+CKHb21diC0LLxK54chhJqaM2d6vi7BPoYn7iRqtWYyqC0XFV1PkNaTR9utJulJI4nXpmZVRWpqE9owigeHWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so2111628a12.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408117; x=1760012917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJO2rpeSfonOqfgPMdFd9YnOjY8waVVypT7pLmPKhlg=;
        b=jwrMo7tqYfFdIUfnH39Ei3rX4OH2a4vRMV8P4q2e7k3G494YQioZf6/nSOCA6VVTu2
         IanjuzQxs5CbztQt0C5z16jd+9n4/ZCLAByv5bL6txNVX3PJdX3hDIYPMF3x0zbYirHc
         sxKYj4j/cbjnrvQ8fpNC40QedViE6VN48nA89OMbuB54zYpWAhNThybHOOiDxx4UM6qL
         /Fb5+rDII533Bkr4n90nihNuJIPuTRlNlTO1C7kRg2ctC8fhWQY991aP92a8k72XuQjQ
         0bSndVJCvwIA/gfLP0q05ymadWTKgE3D7EisKPt7UjIfNCk+ONn4JP2sUzKQJwipTTlk
         DQJA==
X-Forwarded-Encrypted: i=1; AJvYcCUKLvyQfUbeW8HFnULhY1dTzrJixv2RnUYglmPfJQdx9J9W6wTXa4YbaS0ZFXQ0cjO2ZdG+MhlzxNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqDh2xFDzM3bjADgzXSMsZ58sMnPqAkEFYxbHlnp1i6SYMdoL
	6lHVMr6T5aOBnEMj/jprYWLQyUX8BFmhx3scymb1Lsl07BNusbvT7pjmknbLSeYW3Bw=
X-Gm-Gg: ASbGncvpQI6dDuwpJMeG8tb4z1Kh8I8x9MbCWjqBSSgK+qBOFcpOSt9ZkuHAh/Q7lMN
	jIBs4igUn9ZUAKI9t3Af3ikzrh2iGXguIbQTqTt/UjWrsZIMgpJbvEgTlphap0kEtJDNKis2YXa
	fkDV4I1ig0xM/gx6cUoVrhFVBqMl+g3mfXZ/TiD6z/NyK/GzSEuuKRVZ2XmzW9WhZBV8iFlUE31
	NCB+bUcKxaot6OP7mX42uWqTXFuSUksE3d+MWOGQtys4EtHKQ2M2mduWzMC3ZKMxOCqi/zq1aVs
	+bAOR+O4MFRiw8Memt5E8UxJnmzC6hWX4+jMDpNIgaPPDyyu1ibJcXFrOOTwNsdDHkoIKYvUjj4
	PpjsBLoEjLTmElL14FyXuj58DkyXnwpzV9OmctjnwnwU7Y3B0f/hM5gQcUBOK5qB5PFUUynDDl3
	rsXZd/d58oBAl7x+2OUzU=
X-Google-Smtp-Source: AGHT+IEf0FLvns+qHruJrvdbFc8UldNVJ77QFlXsvf0IlcgSjvfbabZ7llu4EOBVmIuqWuJLyYdRQQ==
X-Received: by 2002:a17:907:6ea5:b0:b41:873d:e218 with SMTP id a640c23a62f3a-b46e2ff48damr835821866b.14.1759408117338;
        Thu, 02 Oct 2025 05:28:37 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a26e66csm190310366b.100.2025.10.02.05.28.33
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:28:33 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1919299a12.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYzE378iL+cUfmGCysHb9QgHz/0gb5Mfq+FjH8pPhXsTxrCIqXtKM73dSB2X+ufKAmW87jv08dLWc=@vger.kernel.org
X-Received: by 2002:a05:6402:1d53:b0:634:b5b5:9fb5 with SMTP id
 4fb4d7f45d1cf-63678bb704emr8111645a12.10.1759408113266; Thu, 02 Oct 2025
 05:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:28:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPEZJ11sfLDk=O1oZq_OKz22G9wz3Sw5acMr1QVYG_Qg@mail.gmail.com>
X-Gm-Features: AS18NWC-_9Ox7ciqPoYRQmMsFw1knBxTffAhjo8400Hfa4uqpwmBsatJ-il-O0c
Message-ID: <CAMuHMdXPEZJ11sfLDk=O1oZq_OKz22G9wz3Sw5acMr1QVYG_Qg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cosmin,

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Add support for the A/D 12-Bit successive approximation converters found
> in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Conversions can be performed in single or continuous mode. Result of the
> conversion is stored in a 16-bit data register corresponding to each
> channel.
>
> The conversions can be started by a software trigger, a synchronous
> trigger (from MTU or from ELC) or an asynchronous external trigger (from
> ADTRGn# pin).
>
> Only single mode with software trigger is supported for now.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Thanks for your patch!

> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1403,6 +1403,16 @@ config RZG2L_ADC
>           To compile this driver as a module, choose M here: the
>           module will be called rzg2l_adc.
>
> +config RZT2H_ADC
> +       tristate "Renesas RZ/T2H / RZ/N2H ADC driver"

depends on ARCH_RENESAS || COMPILE_TEST

> +       select IIO_ADC_HELPER
> +       help
> +         Say yes here to build support for the ADC found in Renesas
> +         RZ/T2H / RZ/N2H SoCs.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called rzt2h_adc.
> +
>  config SC27XX_ADC
>         tristate "Spreadtrum SC27xx series PMICs ADC"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST

> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc-helpers.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +
> +#define RZT2H_NAME                     "rzt2h-adc"
> +
> +#define RZT2H_ADCSR_REG                        0x00

I would drop the "_REG"-suffix from register definitions...

> +#define RZT2H_ADCSR_ADIE_MASK          BIT(12)

... and the "_MASK"-suffix from single-bit definitions.  But this is
my personal preference/taste.  Perhaps IIO uses a different convention?

> +#define RZT2H_ADCSR_ADCS_MASK          GENMASK(14, 13)
> +#define RZT2H_ADCSR_ADCS_SINGLE                0b00
> +#define RZT2H_ADCSR_ADST_MASK          BIT(15)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

