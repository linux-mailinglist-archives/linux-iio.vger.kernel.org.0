Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4614EE54
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2020 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgAaOXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jan 2020 09:23:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39216 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgAaOXz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jan 2020 09:23:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so6709814oty.6;
        Fri, 31 Jan 2020 06:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5uwU39YyYRL3F37tHbbpfkuTD2Ge/FRXkO7F7HVJViM=;
        b=WEdrQR8AIlV1kn1OWcnHjMpjszB9gj2qHLDHCiVkbIePXSA/6tTnqUUuqNXLH09fp9
         wX6Gv+jCIJoLrhd2xkuv7VUY5pvFvdaYAdV56P5abwnCPvix7bJzH1KLI4FswBlGWyTe
         cW676wzypUZJiYpT22Yq/1dnHoHIcq7aMHXCzEKxOLak2vGQ5rKVVFebQaBKqNpROdlk
         /Ljvuf9UDDRaclYLX//numkgNttKi9uCCuGkc6xIsd7yKjLt+MKIdJLXkGKavZn86ZX1
         omqQwQ8KXc2shhUfkkX+YwuHhg1SUTwdQPSr5Dt8hOLlMgZjjaJTe4z782K/zg+ACO41
         Kbxg==
X-Gm-Message-State: APjAAAUndxNYxVG3dkbWq9WhAgmGfBwns9EJ6dFHNbJizXBlLwBRG9P0
        bn7amGEiwKJpXQF6uXZDA4KJg1I=
X-Google-Smtp-Source: APXvYqxAX9BkIBFcXo6Bjdh3cDS5uE8g2wRF8ywC1Tz4ET9W/tKUjqFL1YqVZt9pQDJ4jzKcusd0Og==
X-Received: by 2002:a9d:7593:: with SMTP id s19mr7380770otk.219.1580480633913;
        Fri, 31 Jan 2020 06:23:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm2636565oia.21.2020.01.31.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 06:23:53 -0800 (PST)
Received: (nullmailer pid 5038 invoked by uid 1000);
        Fri, 31 Jan 2020 14:23:52 -0000
Date:   Fri, 31 Jan 2020 08:23:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-iio@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
Message-ID: <20200131142352.GA4558@bogus>
References: <20200128133052.201587-1-david@ixit.cz>
 <20200128133052.201587-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133052.201587-2-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jan 2020 14:30:46 +0100, David Heidelberg wrote:
> This commit add dt-bindings support to al3320a driver and vendor-prefix
> dynaimage.
> Partly based on unmerged commit:
> "iio: Add Dyna-Image AP3223 ambient light and proximity driver"
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/iio/light/al3320a.yaml           | 40 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/iio/light/al3320a.example.dts:20.17-30: Warning (reg_format): /example-0/i2c/al3320a@1c:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/light/al3320a.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/light/al3320a.example.dts:17.5-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/iio/light/al3320a.example.dts:17.5-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/iio/light/al3320a.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/light/al3320a.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/iio/light/al3320a.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/light/al3320a.example.dts:18.24-23.15: Warning (avoid_default_addr_size): /example-0/i2c/al3320a@1c: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/light/al3320a.example.dts:18.24-23.15: Warning (avoid_default_addr_size): /example-0/i2c/al3320a@1c: Relying on default #size-cells value
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/al3320a.example.dt.yaml: al3320a@1c: 'interrupt' is a required property

See https://patchwork.ozlabs.org/patch/1230353
Please check and re-submit.
