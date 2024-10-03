Return-Path: <linux-iio+bounces-10034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986098EECE
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C691C21D48
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1016BE1C;
	Thu,  3 Oct 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Yl2V5Et3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77414D708;
	Thu,  3 Oct 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957459; cv=none; b=BlU0pVPNgdYcStDXr8k8hyngSLGFz2vnYcTrDH3G+3SbCOyJbMl2ghdw6jXlMlzUzHxMb71viTS6njSVwQMMwwcQyGiqRod3W7xvwhYOV/ZKacZzIY0EVvhXVEN1o576y5JPquNQf1gJN8BOVxTYsTWkObc/7gSTBDcJcEBEaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957459; c=relaxed/simple;
	bh=zcY13KIWIrUY8UFQ1kMAw23M2r5Ji5YpIDTzQZHJiww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKk/20oO7hiNO+Huu4C1MpQxPMjcL4Qt3jCUwIf8xl8wVmjretHL2ojC6t/pKRvChByZWumEJ6YxwLAzfQCAcJE4xin0H/rHMPZ9tNlwixY8TfadXQ3AfL63NE54ybKCf4dw+e6JZUhm7GBbNjqHxcHxybfWl5/fxDoiHrfjx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=Yl2V5Et3; arc=none smtp.client-ip=67.231.157.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
	by m0048300.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 493BTQn9018585;
	Thu, 3 Oct 2024 07:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=outbound; bh=S
	HlQdxbYpL9AvU3/VUMxJirlhY+RYkPiFenF7jPzuo4=; b=Yl2V5Et3py9dIRqMc
	51n9c6v/FPhURwvGKbK0iy8J5/mXGF4yPHbuKjZfyN/6QHiAlYkkDYxrUXXVJqwr
	SdZqa5p8hPfDNV7uhvIGnrh/PaQyb/0ITVJqo4ApA+dV9jlwnjNS6ksnsVNZ4LYE
	09qL38GtlcXCNyvKTTgLbg/Sp6R7l2qAT7QJtNVr8b0XbkvvuakE/U1amizU1Tvd
	leiciL5ECYKfdW50873lf2lZk0Q7VKl4MECod9j4uNqnV0nTiX/7SXk3wDP603AN
	/TsrV+aDyoCjnqqlm6POdyi2V482OB+6IcuuJKFgmrrNhBPG10//fxIuk4Ej7ZdE
	UUtJg==
Date: Thu, 3 Oct 2024 14:56:03 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC
 ADC
Message-ID: <Zv6GU3QuyJjgt0o1@852ed68de471>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
 <20241003114641.672086-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003114641.672086-3-herve.codina@bootlin.com>
X-Proofpoint-GUID: vlS15X4uHUT6nIMba0xM37AcmKNocuXX
X-Proofpoint-ORIG-GUID: vlS15X4uHUT6nIMba0xM37AcmKNocuXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030087

On Thu, Oct 03, 2024 at 01:46:39PM +0200, Herve Codina wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> (voltage and current), 16-Bit ADC with an I2C Interface.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Tested-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  .../bindings/iio/adc/gehc,pmc-adc.yaml        | 86 +++++++++++++++++++
>  include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
>  create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
> new file mode 100644
> index 000000000000..2cea7c104a26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fiio%2Fadc%2Fgehc%2Cpmc-adc.yaml%23&data=05%7C02%7Cian.ray%40gehealthcare.com%7C29c6b87aecab477476ef08dce3a11117%7C9a309606d6ec4188a28a298812b4bbbf%7C0%7C0%7C638635528128598570%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=SDlnZF05zDF5iYE2X%2BsDV9BKN73B2rc5cAaPOJVY%2BrA%3D&reserved=0
> +$schema: https://nam10.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=05%7C02%7Cian.ray%40gehealthcare.com%7C29c6b87aecab477476ef08dce3a11117%7C9a309606d6ec4188a28a298812b4bbbf%7C0%7C0%7C638635528128610679%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=FbLudkkL4uUu2oTjkGLe7SFCI%2B5kXRCNhBPRcess0hc%3D&reserved=0
> +
> +title: GE HealthCare PMC Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The GE HealthCare PMC ADC is a 16-Channel (voltage and current), 16-Bit ADC
> +  with an I2C Interface.
> +
> +properties:
> +  compatible:
> +    const: gehc,pmc-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD power supply.
> +
> +  vdda-supply:
> +    description:
> +      Regulator for the VDD analog (VDDA) power supply.
> +
> +  vddio-supply:
> +    description:
> +      Regulator for the VDD IO (VDDIO) power supply.
> +
> +  vref-supply:
> +    description:
> +      Regulator for the voltage reference power supply.
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The component uses an external oscillator (osc) if an external oscillator
> +      is connected to its clock pins. Otherwise, it uses an internal reference
> +      clock.
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +
> +  "#io-channel-cells":
> +    const: 2
> +    description: |
> +      The first cell is the channel type (dt-bindings/iio/adc/gehc,pmc-adc.h
> +      defines these values):
> +       - 0: voltage
> +       - 1: current
> +      The second cell is the channel number from 0 to 15.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vdda-supply
> +  - vddio-supply
> +  - vref-supply
> +  - '#io-channel-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@14 {
> +            compatible = "gehc,pmc-adc";
> +            reg = <0x14>;
> +            vdd-supply = <&reg_vdd>;
> +            vdda-supply = <&reg_vdda>;
> +            vddio-supply = <&reg_vddio>;
> +            vref-supply = <&reg_vref>;
> +            #io-channel-cells = <2>;
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/iio/adc/gehc,pmc-adc.h b/include/dt-bindings/iio/adc/gehc,pmc-adc.h
> new file mode 100644
> index 000000000000..2f291e3c76ae
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/gehc,pmc-adc.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +
> +#ifndef _DT_BINDINGS_IIO_ADC_GEHC_PMC_ADC_H
> +#define _DT_BINDINGS_IIO_ADC_GEHC_PMC_ADC_H
> +
> +/* ADC channel type */
> +#define GEHC_PMC_ADC_VOLTAGE   0
> +#define GEHC_PMC_ADC_CURRENT   1
> +
> +#endif
> --
> 2.46.1
> 
> 

