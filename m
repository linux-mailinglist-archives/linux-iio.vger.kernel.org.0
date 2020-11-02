Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25F2A2F94
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKBQTt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 11:19:49 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.158]:49752 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKBQTt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 11:19:49 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.22.175
X-Interia-R-Helo: <t480s.localdomain>
Received: from t480s.localdomain (ipv4-188-121-22-175.net.internetunion.pl [188.121.22.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Mon,  2 Nov 2020 17:18:09 +0100 (CET)
Date:   Mon, 2 Nov 2020 17:18:08 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maury Anderson <maury.anderson@rockwellcollins.com>,
        Matthew Weber <matthew.weber@rockwellcollins.com>
Subject: Re: [PATCH 4/7] dt-bindings:iio:potentiometer:maxim,max5481 move to
 trivial devices
Message-ID: <20201102161808.GB524499@t480s.localdomain>
References: <20201031182922.743153-1-jic23@kernel.org>
 <20201031182922.743153-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201031182922.743153-5-jic23@kernel.org>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1604333891;
        bh=pQDavQUISnJGdnmETUCYq6TYJ5RnpdxLYYL8OttEWnA=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-Interia-Antivirus;
        b=Q/grS77S8oRJUKDsYLhpcOkql54ISB+rcUCD3EpK9TQh4nMdXMiSXNPysSTbByyrw
         WJG2SLD0NzfaMFfUw4aIq8Fj6lIVO0tvoQPQXKjXYK32H4f/Xa9TGYHsFV66kgbF7w
         5VOZ0g9UETZxeACbaAEvIsDBtWRQr0PUTRazqzKk=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On paź 31, 2020 18:29, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple SPI binding that doesn't need a separate file.
> During conversion I looked up the individual part number descriptions
> in the datasheet so that we could give slightly more detail in
> trivial-device.yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Maury Anderson <maury.anderson@rockwellcollins.com>
> Cc: Matthew Weber <matthew.weber@rockwellcollins.com>
> Cc: Slawomir Stepien <sst@poczta.fm>

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

> ---
>  .../bindings/iio/potentiometer/max5481.txt    | 23 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  8 +++++++
>  2 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt b/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> deleted file mode 100644
> index 6a91b106e076..000000000000
> --- a/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -* Maxim Linear-Taper Digital Potentiometer MAX5481-MAX5484
> -
> -The node for this driver must be a child node of a SPI controller, hence
> -all mandatory properties described in
> -
> -        Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -must be specified.
> -
> -Required properties:
> -	- compatible:  	Must be one of the following, depending on the
> -			model:
> -			"maxim,max5481"
> -			"maxim,max5482"
> -			"maxim,max5483"
> -			"maxim,max5484"
> -
> -Example:
> -max548x: max548x@0 {
> -	compatible = "maxim,max5482";
> -	spi-max-frequency = <7000000>;
> -	reg = <0>; /* chip-select */
> -};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 695b1e379238..3182d5b5a0b4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -118,6 +118,14 @@ properties:
>            - maxim,ds1803-100
>              # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>            - maxim,max1237
> +            # 10-bit 10 kOhm linear programable voltage divider
> +          - maxim,max5481
> +            # 10-bit 50 kOhm linear programable voltage divider
> +          - maxim,max5482
> +            # 10-bit 10 kOhm linear programable variable resistor
> +          - maxim,max5483
> +            # 10-bit 50 kOhm linear programable variable resistor
> +          - maxim,max5484
>              # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
>            - maxim,max6621
>              # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface

-- 
Slawomir Stepien
