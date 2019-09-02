Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2112A5BBD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfIBROZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 13:14:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33756 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfIBROZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 13:14:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so11025249qtd.0;
        Mon, 02 Sep 2019 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YNsJdH5ZVLz+f0cTeGEGJWLk48KOEiJLN5T05756t08=;
        b=XCZlaYBLJxRb2KPMpPlHm7+SdKmGuRYkdPGUzgWd90ZLyA0wrCT5zMlvN+lmj5b97X
         dgPBiUbMHkaYsAg12LhLt5/PYRQl+Bl5a3KpEbpKoF+pnSfdRVA+OR4ZPQ755Iqxvo69
         iO2JoTuAbtuA/8D5Fy6mu3d5na+lkoPp3iqxEIsGqPyQ9S5g2STHvxu6QaqMItJAdC/B
         xXzk+QoFVohIriEkLkQuWYiTmJRRZldzGg+ejoxbsHAjCxlJWGFSWLWs+ha7pz0/tMG6
         SdFmlikpibJrIV9Wf/v+Te8VEy/80VwzWVd6Nh6+aGwyJya6DdXCyC4BDiDCMNnoTcqq
         wwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YNsJdH5ZVLz+f0cTeGEGJWLk48KOEiJLN5T05756t08=;
        b=W9Os6w+B3x0snkDZ4aL4hhzDLqa5C/fUfK/LAr5wosNiH9wk9oytg2sb284NhK4Oyg
         SnJcAsTA7D4RP3tLfk4HNRYofnQllTi6bHaJmzODRBYb9LNeF8Bgpza0CiV9Dz0qTPji
         kknpj0WCLu0rYqXlqQIE346+82Afkt3m15+BSqdxFA/fZuyL40YWYxuoVyhukxOVh2Ch
         zsb01qYNd4ZFINNHq/T6L7/eDcJCz0xV1hIkJnCksLCjQDU6QYAGmKj+DETwhOOK/f9i
         AMON2JsYcT1w5IKanej9WC9I9Cf939mYlq4/JyF/o7SjymSAKzfR0TrNYZyQq5pZdm80
         hJNw==
X-Gm-Message-State: APjAAAXoh6fkaY2GwxOwlv3nukfY/OOv/YIsmsTY5xWBPz++vs5XD/Io
        OatcKD3oMpyXA0ExcEsL5T0rI72dWU8=
X-Google-Smtp-Source: APXvYqwVvt9fMERF1HY97g2B2SWVLwAIMrKwQqibSuPAA6WspRJ6r8Axg1IRptW90wNBKaRy/4cgag==
X-Received: by 2002:a05:6214:80b:: with SMTP id df11mr12322721qvb.45.1567444464073;
        Mon, 02 Sep 2019 10:14:24 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f20sm9160055qtf.68.2019.09.02.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:14:23 -0700 (PDT)
Date:   Mon, 2 Sep 2019 14:14:18 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20190902171417.qbj7rwi43tr77mr5@smtp.gmail.com>
References: <20190902005938.7734-1-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902005938.7734-1-rodrigorsdc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rodrigo,

This dt doc looks overal fine IMHO.
I would just add some inline comments about the cpha and cpol
properties.

On 09/01, Rodrigo Carvalho wrote:
> This patch add device tree binding documentation for ADIS16240.
> 
> Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> ---
> I have doubt about what maintainer I may to put in that documentation. I
> put Alexandru as maintainer because he reviewed my last patch on this
> driver, so I think that he is a good candidate.
>  .../bindings/iio/accel/adi,adis16240.yaml     | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> new file mode 100644
> index 000000000000..08019b51611c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADIS16240 Programmable Impact Sensor and Recorder driver
> +
> +maintainers:
> +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> +
> +description: |
> +  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> +  SPI interface.
> +    https://www.analog.com/en/products/adis16240.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16240
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
Boolean properties don't require to be explicitly set. It would also be
nice to add a description pointing to the spi-bus documentation. Like
this:

  spi-cpha:
    description: |
      See Documentation/devicetree/bindings/spi/spi-bus.txt
    maxItems: 1

  spi-cpol:
    description: |
      See Documentation/devicetree/bindings/spi/spi-bus.txt
    maxItems: 1

As far as I know, spi-cpol and spi-cpha stand for SPI chip polarity and
SPI chip phase respectively. By default, it is assumed that SPI
input/output data is available at uprising clock edges, however, some
chips may work with different configuration (taking input data and/or
push it out in falling edges). I'm not 100% sure but, from what I've
seen on IIO, cpol is set to invert the input/output logic (making IO be
taken on falling edges) while cpha is usually set when MISO valid out
data is available on SCLK falling edge. If anyone has more comments
about this please, add them here, I'm curious about it. :)

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "adi,adis16240";
> +            reg = <0>;
> +            spi-max-frequency = <2500000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> -- 
> 2.23.0.rc1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20190902005938.7734-1-rodrigorsdc%40gmail.com.
