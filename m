Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9194F1A3CCA
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 01:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDIXLM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 19:11:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41404 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDIXLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 19:11:11 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so348848ilj.8;
        Thu, 09 Apr 2020 16:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHTHGCsgfXX19VGzpIF+rrRJOUUg2k/5itbti4Sluiw=;
        b=IzHZU48K1YiX/+21sbw6ltl0cfMlPd0AJL++uHe1cm1SPfBeZNavnNLgE6/Ik15p4Z
         ST0rof2SNOW/1KF/xia/N0ovS0yDmSlaMvtefia3gvxXiiGRoef/gEWiNYhqUhDxEiFt
         Q2EY/Zwm86nzQJNLzeZ/D/KKMMv8OrYXYPKAeYYAKdgHKrTxqAb0jK4yr0jcrmhdlOT2
         V8e4UqzdSw4wKDUPKmWoUifEq0flZzmi559PSQV4rrM6e5opxeUtgabZgcwsvdmaozbq
         TdP51W6/47WYVcNrvV43E4W55wZ8jPsaJaISuc+EsgYjKa1jmPcYI1OLlpL8RjcgNYLQ
         F+Sg==
X-Gm-Message-State: AGi0PuYfJ7sF8xy3eHVtrJnBnvhr+fXXQsvbct3FsqDJ59dWuDBSS0Nk
        ouEFZx/Vhpm1wwQJb0ypHg==
X-Google-Smtp-Source: APiQypLqo2zaWnSheojFEJB8E++9Zq1uWFEbh1m5g1x8qcvNxZ1Pn4QvM+fA/kuyDlypQvUKQCdWKQ==
X-Received: by 2002:a92:912:: with SMTP id y18mr2357154ilg.299.1586473871414;
        Thu, 09 Apr 2020 16:11:11 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h29sm157861ili.19.2020.04.09.16.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:11:10 -0700 (PDT)
Received: (nullmailer pid 26485 invoked by uid 1000);
        Thu, 09 Apr 2020 23:11:08 -0000
Date:   Thu, 9 Apr 2020 17:11:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: counter: atmel-tcb-capture counter
Message-ID: <20200409231108.GA25954@bogus>
References: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
 <20200409141401.321222-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409141401.321222-3-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Apr 2020 16:14:00 +0200, Kamel Bouhara wrote:
> Describe the devicetree binding for the ATMEL TCB counter. Each counter
> blocks exposes three independent counters.
> 
> However, when configured in quadrature decoder, both channel <0> and <1>
> are required for speed/position and rotation capture (yet only the
> position is captured).
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../bindings/counter/atmel-tcb-capture.yaml   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/counter/atmel-tcb-capture.example.dts:20.17-32: Warning (reg_format): /example-0/timer@f800c000/timer@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/counter/atmel-tcb-capture.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/counter/atmel-tcb-capture.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/counter/atmel-tcb-capture.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/counter/atmel-tcb-capture.example.dts:18.27-21.15: Warning (avoid_default_addr_size): /example-0/timer@f800c000/timer@0: Relying on default #address-cells value
Documentation/devicetree/bindings/counter/atmel-tcb-capture.example.dts:18.27-21.15: Warning (avoid_default_addr_size): /example-0/timer@f800c000/timer@0: Relying on default #size-cells value

See https://patchwork.ozlabs.org/patch/1268623

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
