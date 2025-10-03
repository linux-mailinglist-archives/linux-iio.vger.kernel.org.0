Return-Path: <linux-iio+bounces-24687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01477BB719F
	for <lists+linux-iio@lfdr.de>; Fri, 03 Oct 2025 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3FB3BC5FB
	for <lists+linux-iio@lfdr.de>; Fri,  3 Oct 2025 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76C1EA7CB;
	Fri,  3 Oct 2025 14:01:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B656134BD;
	Fri,  3 Oct 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500070; cv=none; b=oU83JaZrgCbTMoo4ojOe58I9EMUjdOGbzLG/ipRlP/7rj07RrN/sEjRLY7knJ7NuWEfYb1N+R4NDJc7L0VtuWLQL8T4dqiBDRbAuACY38dmpAibf6miohezbZNdVk3r/jXs/oPQ1YMFNJmyvFOiqlihrVlavDja98itH5012VWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500070; c=relaxed/simple;
	bh=RNm8+bIzCty7wKMJsfmMxSNvFNgStXeHIk3/eWA2BCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9yMfphFH8pOdvHk5PDBvtZPvZ/+AU2n3p3IcnXWVB+zMlvWjmyULhKx4D2On/KB972aNkzyo0fzfrIMIS3CNWAXE+mdqgWuZ3gLD+vFpTZ3SLHCUyBLw2j4bcNntiku2rAzgU19ZeGqr+Ww6gUc8evVcmMagYeHcRN0mR+dU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdVgF2bRxz6L4tn;
	Fri,  3 Oct 2025 22:00:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AF2114044F;
	Fri,  3 Oct 2025 22:01:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 15:01:03 +0100
Date: Fri, 3 Oct 2025 15:01:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Eddie James <eajames@linux.ibm.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <andrew@codeconstruct.com.au>, <joel@jms.id.au>,
	<linux@roeck-us.net>, <chanh@os.amperecomputing.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: Re: [PATCH v7 RESEND 3/7] dt-bindings: iio: Add Infineon DPS310
 sensor documentation
Message-ID: <20251003150102.00007dae@huawei.com>
In-Reply-To: <20251001144441.310950-4-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
	<20251001144441.310950-4-eajames@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  1 Oct 2025 09:44:37 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> The DPS310 is a barometric pressure and temperature sensor with
> an I2C interface. Remove it from trivial-devices.yaml and add its
> own documentation.

Hi Eddie,

Why?  I guess you need the #io-channel-cells which trivial devices
doesn't allow because you have a consumer driver?

Obviously the binding patch shouldn't mention that, but it could call
out that there can be such consumers.

I'd also expect to see some supplies even if the driver doesn't yet
explicitly handle them.

Jonathan

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  MAINTAINERS                                   |  1 +
>  3 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> new file mode 100644
> index 0000000000000..7c0782e2a821b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon DPS310 barometric pressure and temperature sensor
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  The DPS310 is a barometric pressure and temperature sensor with an I2C
> +  interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,dps310
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure-sensor@76 {
> +          compatible = "infineon,dps310";
> +          reg = <0x76>;
> +          #io-channel-cells = <0>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 7609acaa752d5..a72b7fabc7034 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -127,8 +127,6 @@ properties:
>            - ibm,cffps2
>              # IBM On-Chip Controller hwmon device
>            - ibm,p8-occ-hwmon
> -            # Infineon barometric pressure and temperature sensor
> -          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IRPS5401 Voltage Regulator (PMIC)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c8281ea4cc64..92b9854a0e07d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12191,6 +12191,7 @@ INFINEON DPS310 Driver
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>  F:	drivers/iio/pressure/dps310.c
>  
>  INFINEON PEB2466 ASoC CODEC


