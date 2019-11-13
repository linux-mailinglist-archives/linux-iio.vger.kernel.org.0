Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D80FB255
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKMOQI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 09:16:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34268 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMOQI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 09:16:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so1915231oig.1;
        Wed, 13 Nov 2019 06:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtkqzX7muuVDGVKAN2CmPtSgt/yN3k3Yp3enuKd2d+k=;
        b=Oolx2Whyka6nsmR4M6YWPLAhArJ2dyncr3QjWxOUpe5V+3dVxjVDwh1CkuyXdow0UJ
         FUk1u2dLOSbJbhoKHBLKsM4FHsqRxmYz+Lafg6Nk7UIoEmK6slYOr3ri6T8gOz47CeVh
         iG8ER8qsgWlSB1p1WPe7e8y7uUAMt11zJQw93kfQP3iFiomFhPjmZkjw6A+2hLxO9drs
         aARzZCfcYKYKEbNs4nEA47sQ3OH1Pd8dhcDKIVEK+jP/NrUwSctFtPn7j6kK4a02yq53
         Ok/lHfxbKZa5lA/Bc2EUXJzdvVH8k6Fu+uBh9wxRhT8cKIzXmjQBkdoen1WwtYkUmG1/
         +8UQ==
X-Gm-Message-State: APjAAAXlJ2KjwYFVK0KoT4a49Y5avSEpIPtvH5XG+bc+41NlFQ4Dmu0e
        8Cw1Stg2mdtKYXMrQS94aw==
X-Google-Smtp-Source: APXvYqyiQMqNrnO8wb9soSqf1bY9Zgyqzt2FFtOzmgqXt9VMuZjTQJl/mNIgLFrlXuZ5TtgyBZROcQ==
X-Received: by 2002:a05:6808:84:: with SMTP id s4mr3849197oic.107.1573654566870;
        Wed, 13 Nov 2019 06:16:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s25sm667149oic.13.2019.11.13.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:16:05 -0800 (PST)
Date:   Wed, 13 Nov 2019 08:16:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: add parallax ping sensors
Message-ID: <20191113141604.GA5040@bogus>
References: <20191107130027.k2uo547xrfiuxgb7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107130027.k2uo547xrfiuxgb7@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 07, 2019 at 02:00:29PM +0100, Andreas Klinger wrote:
> Add dt-bindings for parallax PING))) and LaserPING iio sensors, which
> are used for measuring distances.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/parallax-ping.yaml      | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> new file mode 100644
> index 000000000000..ab8dbdf4f04a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/parallax-ping.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Parallax PING))) and LaserPING range finder
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Bit-banging driver using one GPIO:
> +  - ping-gpio is raised by the driver to start measurement

ping-gpios or "Ping GPIO"

> +  - direction of ping-gpio is then switched into input with an interrupt
> +    for receiving distance value as PWM signal
> +
> +  Specifications about the devices can be found at:
> +  http://parallax.com/sites/default/files/downloads/28041-LaserPING-2m-Rangefinder-Guide.pdf
> +  http://parallax.com/sites/default/files/downloads/28015-PING-Documentation-v1.6.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - parallax,ping
> +      - parallax,laserping
> +
> +  ping-gpios:
> +    description:
> +      Definition of the GPIO for the triggering and echo (output and input)
> +      This GPIO is set for about 5 us by the driver to tell the device it
> +      should initiate the measurement cycle. Afterwards the GPIO is switched
> +      to input direction with an interrupt. The device sets it and the
> +      length of the input signal corresponds to the measured distance.
> +      It needs to be an GPIO which is able to deliver an interrupt because
> +      the time between two interrupts is measured in the driver.
> +      See Documentation/devicetree/bindings/gpio/gpio.txt for information
> +      on how to specify a consumer gpio.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - ping-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    proximity {
> +        compatible = "parallax,laserping";
> +        ping-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +    };
> -- 
> 2.11.0
