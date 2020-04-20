Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5497E1B18D7
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgDTVwv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 17:52:51 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:35484 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTVwv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 17:52:51 -0400
Received: by mail-oo1-f65.google.com with SMTP id t12so2100425oot.2;
        Mon, 20 Apr 2020 14:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Co1cYmNyWmTzHzgxsSFAcduEN2SDR57H6MmIshko7Lk=;
        b=HVoO5iIzlJPb8znTk8Dvd3b8X9LuVIaL4rKRiFnr3V4v1Dru9Eri/o5l224jrZv/Xu
         pv2g3Y779WLSXgxpK5DHKZl01urKeeWqmgkTvH1LsH7UvwI0Wwxm6pdFwUlF9dMT8XmY
         5xMyl2R93lXw5kALf9K9hYpPzE18t00jy9JPSm1L+BYi6ZQlYR33MioxnhQgMfwGIfhd
         82jFMMNJigfRVIl53TF3kmBY1lx/EpNzCHDu3+hNhBi1XHUdmzAdP0bFA7QWZiGigBGx
         XMo+nLxZDa5mvsXRZWpJsQAtIjx6UUszM2y4LynfbW4r8MOjyi5FzHADPT+ColnLzABQ
         nEzQ==
X-Gm-Message-State: AGi0PuaIRvaAuL3qhPtnJ526PnMp7xROcITXpc9sogSIhAs9/fwpM3rO
        3gYM5hxQmEdRlGLgDAbjMA==
X-Google-Smtp-Source: APiQypKSI24KGC+Qmm1XwTPCDSuY0GG18ywAMyBMW7x3poTOLSXS061QvnH629ajhE5cTf8nGcNrBA==
X-Received: by 2002:a4a:7504:: with SMTP id j4mr14628604ooc.10.1587419569965;
        Mon, 20 Apr 2020 14:52:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 204sm184174oid.18.2020.04.20.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:52:49 -0700 (PDT)
Received: (nullmailer pid 28065 invoked by uid 1000);
        Mon, 20 Apr 2020 21:52:48 -0000
Date:   Mon, 20 Apr 2020 16:52:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: add document bindings for
 wsen-itds accel sensor
Message-ID: <20200420215248.GA26239@bogus>
References: <20200415065535.7753-1-saravanan@linumiz.com>
 <20200415065535.7753-3-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415065535.7753-3-saravanan@linumiz.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 08:55:33AM +0200, Saravanan Sekar wrote:
> Add device tree binding information for wsen-itds accel sensor driver.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/iio/accel/we,wsen-itds.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml b/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> new file mode 100644
> index 000000000000..165cdf71966d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/we,wsen-itds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Würth Elektronik WSEN-ITDS triaxial acceleration sensor
> +
> +maintainers:
> +  - Saravanan Sekar <saravanan@linumiz.com>
> +
> +description: |
> +  Acceleration and temperature iio sensors with an i2c interface.
> +  The sensor provies additional application specific features like
> +  tap detection, 6D Orinetation, Free-fall, Motion and Activity.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - we,wsen-itds
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: phandle to the regulator that provides power to the accelerometer
> +
> +  vddio-supply:
> +    description: phandle to the regulator that provides power to the sensor's IO
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      accelerometer@18 {
> +        compatible = "we,wsen-itds";
> +        reg = <0x18>;
> +        vdd-supply = <&vdd>;
> +        vddio-supply = <&vddio>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> -- 
> 2.17.1
> 
