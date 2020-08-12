Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B4242D49
	for <lists+linux-iio@lfdr.de>; Wed, 12 Aug 2020 18:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHLQad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Aug 2020 12:30:33 -0400
Received: from vern.gendns.com ([98.142.107.122]:47632 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgHLQac (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FHX9wopVRHyoaKb8ehO3LKXTuA6JJa1bUHlwgljK24E=; b=khcFk5jWpuPdEtYEQtFDKUzAlk
        BtHqGYFPdF4nN+8rTHB1uQDfUY+jWknzFdMFheVYUXyML33eEhZZiT1RPu+0EFjzFSQMevN6l8KSk
        sTatPazqr0pfH2yeG4l0Iww+06lKhn/Ik+FIFHf7YfcEH3hHy45A+3v3eoGjo2LHGRiM8/xws1kT0
        v5B96mrvweXPC1zlZ8A+sox00wEBYEDN6O8/qXrJl5QtqZHIKVPfOXawQsR+SlTTeiJLhVIjFUBSg
        DGl9TstycwAfJjLxNzjgdPD3Ir3T0abijUv3Jhq7rIqkiDAZxwKMBfP4NgnHlyJ87ieWkwcHP8VCS
        WvP35J/A==;
Received: from [2600:1700:4830:165f::19e] (port=57330)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k5te1-0007SV-KF; Wed, 12 Aug 2020 12:30:29 -0400
Subject: Re: [PATCH 10/13] dt-bindings: iio: adc: ti,ads7950 binding
 conversion
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-11-jic23@kernel.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <5a4f6244-8840-e871-4a15-b63ad461be4a@lechnology.com>
Date:   Wed, 12 Aug 2020 11:30:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809111753.156236-11-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/9/20 6:17 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion.  This binding already had the
> that is necessary, I'm happy to leave it as previously documented.

This commit message doesn't make sense to me. It should probably
just say "this converts the device tree bindings to yml" or so.

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Lechner <david@lechnology.com>
> ---
>   .../bindings/iio/adc/ti,ads7950.yaml          | 64 +++++++++++++++++++
>   .../bindings/iio/adc/ti-ads7950.txt           | 23 -------
>   2 files changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
> new file mode 100644
> index 000000000000..a759d9064718
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7950.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7950 and similar ADCs
> +
> +maintainers:
> +  - David Lechner <david@lechnology.com>
> +
> +description: |
> +  Family of 4-16 channel, 8-12 bit ADCs with SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7950
> +      - ti,ads7951
> +      - ti,ads7952
> +      - ti,ads7953
> +      - ti,ads7954
> +      - ti,ads7955
> +      - ti,ads7956
> +      - ti,ads7957
> +      - ti,ads7958
> +      - ti,ads7959
> +      - ti,ads7960
> +      - ti,ads7961
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true

According to the datasheet, max frequency is 20MHz, so this can be:

spi-max-frequency:
   maximum: 20000000

> +
> +  vref-supply:
> +    description: Supply the 2.5V or 5V reference voltage

Should this say "Supplies ..."?

> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads7957";
> +            reg = <0>;
> +            vref-supply = <&refin_supply>;
> +            spi-max-frequency = <10000000>;
> +            #io-channel-cells = <1>;
> +        };
> +    };


