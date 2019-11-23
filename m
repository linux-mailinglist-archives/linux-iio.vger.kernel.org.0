Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD9107EDB
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfKWOfB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWOfB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:35:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013AC20714;
        Sat, 23 Nov 2019 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574519700;
        bh=tMb6Fqc9xzJcCZ2un0CHrkqxaQOzOTMvgdm/ie6o1yU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VzgnSkj7a6C6pzsJpkDNt7I2bmRSvaTSBqFlw0zZAHNTfwJVAdKgJR3BEKp/7AxRv
         llGRYC5iO6dhLOZGMcgtDooUxojOogAcNPd20Q45z7Smf3xJm8jX/GCBH0X10+v4Xv
         4I8j0W1qv0UEM1ffSgeCi0S2L1ai6E8OstTS1IbQ=
Date:   Sat, 23 Nov 2019 14:34:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: add parallax ping sensors
Message-ID: <20191123143454.68f4d4a5@archlinux>
In-Reply-To: <20191118073611.pvge47kgupu6omrf@arbad>
References: <20191118073611.pvge47kgupu6omrf@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 08:36:12 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add dt-bindings for parallax PING))) and LaserPING iio sensors, which
> are used for measuring distances.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  .../bindings/iio/proximity/parallax-ping.yaml      | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> new file mode 100644
> index 000000000000..a079c9921af6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
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
> +  - ping-gpios is raised by the driver to start measurement
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

