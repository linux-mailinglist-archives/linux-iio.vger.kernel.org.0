Return-Path: <linux-iio+bounces-24831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956FBC200E
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2344C4EC710
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EAD2E54A7;
	Tue,  7 Oct 2025 15:58:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680042AA3;
	Tue,  7 Oct 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852681; cv=none; b=NMtzYNrB7QsNq5hKmClwyuHj/OdBWd0k0f4fPAouiumHRT6hh1WG9ePzTcU6czOO7lyPlRBcJfcD9FAeB9J50lGr0OO0wSwkax6s5t74FticH8wjoaZcCZ6aomAjksg6HKQorEPV2XLRxlrw/3i1ptO4QgyQ3plP+jHjQO8ymV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852681; c=relaxed/simple;
	bh=EGCnRPxktw5M3mQTb2qivVH9GYbxPtl2jq87ALU+giA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+nkbymsEeg9DO7fvjl/UHBqBuZWADxXDnNaduAlfz28C492NRb3+yv/43/C91S4rN4cHMdkjdEFCWFnarYbNruUI+U0Beknb2tY4lG4ZgI4D+ISxfeUFPghkyPxOH9/s80/w81pWCcc5s3nCJsSHNB173NbbI1ACioZrcGsbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ch11p3Mgbz6L51c;
	Tue,  7 Oct 2025 23:55:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C5A5D1402F5;
	Tue,  7 Oct 2025 23:57:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 16:57:56 +0100
Date: Tue, 7 Oct 2025 16:57:54 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Eddie James <eajames@linux.ibm.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <andy@kernel.org>, <nuno.sa@analog.com>,
	<dlechner@baylibre.com>, <jic23@kernel.org>
Subject: Re: [PATCH v8] dt-bindings: iio: Add Infineon DPS310 sensor
 documentation
Message-ID: <20251007165754.00001e8e@huawei.com>
In-Reply-To: <20251006181040.25845-1-eajames@linux.ibm.com>
References: <20251006181040.25845-1-eajames@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon,  6 Oct 2025 13:10:40 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> The DPS310 is a barometric pressure and temperature sensor with
> an I2C interface. Remove it from trivial-devices.yaml and add its
> own documentation, with a hwmon iio channel consumer example.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Changes since v7:
>  - Add consumer example and update commit message slightly
Ah. Sorry I was unclear on my feedback wrt to this. I was just
looking for a statement in the commit message to say that you were
doing this to allow for consumers such as the iio/hwmon bridge.
I wasn't expecting any change to the example.

+ the supplies as per reply on previous version I just sent.


> 
>  .../iio/pressure/infineon,dps310.yaml         | 48 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  MAINTAINERS                                   |  1 +
>  3 files changed, 49 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> new file mode 100644
> index 0000000000000..f35ef2ce74d6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> @@ -0,0 +1,48 @@
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
> +    iio-hwmon {
> +      compatible = "iio-hwmon";
> +      io-channels = <&dps 0>;
> +    };
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dps: pressure-sensor@76 {
> +          compatible = "infineon,dps310";
> +          reg = <0x76>;
> +          #io-channel-cells = <0>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 58ff948d93c96..a76c58f3b1de4 100644
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
> index 3773c74b31d6d..bde80ddb99e9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12217,6 +12217,7 @@ INFINEON DPS310 Driver
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>  F:	drivers/iio/pressure/dps310.c
>  
>  INFINEON PEB2466 ASoC CODEC


