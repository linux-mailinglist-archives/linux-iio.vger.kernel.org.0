Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5762B129481
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLWLAP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 06:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWLAP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 06:00:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E3120709;
        Mon, 23 Dec 2019 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577098814;
        bh=1vGFLkbvKus/2D6hTriWlriq8CwJYe5ZiDjw/Yj+Ibs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rzzQgUOtZcpmHu9QFAnBpt2h+j+o8mYL/1GgXDHHxCnfAZzFGeI7PnBsWFtqS2vQc
         Bssaxd7RJNRE03xY5UVa33WlsM2kz0F/Tx5kyyBR2DDa+d+gc0FOBfOntift2LGmDt
         fPrQUKq5h1baHBo4tVN2weaLd13uBu/DMWvF8JmU=
Date:   Mon, 23 Dec 2019 11:00:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 3/3] dt-binding: iio: Add documentation for ADF4371
 channel child notes
Message-ID: <20191223110009.6fcc2951@archlinux>
In-Reply-To: <20191219133755.26109-3-beniamin.bia@analog.com>
References: <20191219133755.26109-1-beniamin.bia@analog.com>
        <20191219133755.26109-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Dec 2019 15:37:55 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> This patch documents the ADF4371 individual channel configuration.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  .../bindings/iio/frequency/adf4371.yaml       | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 7ec3ec94356b..5339c929e883 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,12 +40,48 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves lock as
>        measured by the digital lock detect circuitry.
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
>    - clocks
>    - clock-names
>  
> +  patternProperties:
> +  "^channel@[01]$":
> +    type: object
> +    description: Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 3 channels on adf4372
> +          and 4 channels on adf4371, numbered from 0 to 3.
> +        maxItems: 1
> +
> +      adi,output-enable:
> +        description: |
> +          If this property is specified, the output channel will be enabled.
> +          If left empty, the driver will initialize the defaults (RF8x, channel 0
> +          will be the only one enabled).

If I read the driver right, this is effectively 'power up channel when driver
loads'.  Why do we need that in DT?  A bit of udev magic or similar and the existing
controls can set both this and the frequency below.  Would happen a tiny
bit after the driver loads, but I assume the driver current loads with the channels
turned off so that shouldn't matter...

> +        maxItems: 1
> +
> +      adi,power-up-frequency:
> +        description: |
> +          Set the frequency after power up for the channel. If this property is
> +          specified, it has to be in sync with the power up frequency set on the
> +          other channels. This limitation is due to the fact that all the channel
> +          frequencies are derived from the VCO fundamental frequency.
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
>  examples:
>    - |
>      spi0 {
> @@ -55,9 +91,36 @@ examples:
>          frequency@0 {
>                  compatible = "adi,adf4371";
>                  reg = <0>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
>                  spi-max-frequency = <1000000>;
>                  clocks = <&adf4371_clkin>;
>                  clock-names = "clkin";
> +
> +                channel@0 {
> +                        reg = <0>;
> +                        adi,output-enable;
> +                        adi,power-up-frequency = /bits/ 64 <8000000000>;
> +                };
> +
> +                channel@1 {
> +                        reg = <1>;
> +                        adi,output-enable;
> +                };
> +
> +                channel@2 {
> +                        reg = <2>;
> +                        adi,output-enable;
> +                        adi,power-up-frequency = /bits/ 64 <16000000000>;
> +                };
> +
> +                channel@3 {
> +                        reg = <3>;
> +                        adi,output-enable;
> +                        adi,power-up-frequency = /bits/ 64 <32000000000>;
> +                };
>          };
>      };
>  ...

