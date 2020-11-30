Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C342C8B51
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgK3RhU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 12:37:20 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41774 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbgK3RhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 12:37:19 -0500
Received: by mail-il1-f193.google.com with SMTP id p5so12089431iln.8;
        Mon, 30 Nov 2020 09:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsp1blWR1sEPQhmBclKQNeakz0wx8DgrPZF+YSlf8PE=;
        b=P/DwguoO8p/OuWF4ZnDju9y8l+uwsiTS+9s6LCvDQYi9AC7+yodR0fevdse1KHIzag
         ao61r+09bAOwJBZFFoBTgNj2F5AAWi5Wnm5LnTPbip3qrI3unFwRUICprdkFmTcngamC
         WvsHMOcWphP74eNMbvupi/20PPmwuogmBdJZCf8Wz7AkbOkqvE2Boa0T+3uT3/cd8CT/
         h9Y8WNYCT7JlDAM9+d4qtD6vJ7ifE9grwwEgDPys6+rJ2ZGGvDOdnOQHzTCKC5/xsNsa
         aHazL03JfvH5ISIO9PO5thumzmwx58WvRMJPp1kxTqEeq4MScaBqXqpuPDh3s+Pl4blh
         WTJw==
X-Gm-Message-State: AOAM530loeN/xLdFzsckxDpevME8qR6USuK9UXDlvU00MFkIJPertL89
        5jgwHZp5oZ4BvvsLnDnmWA==
X-Google-Smtp-Source: ABdhPJyd53GgrWq2rCHuy4ycE05CbnIyKRy6oXyUGYnljoiHnpBLlcUSgkG9E9NzQtPg7PzsjLLLZw==
X-Received: by 2002:a92:cc03:: with SMTP id s3mr19936624ilp.146.1606757798763;
        Mon, 30 Nov 2020 09:36:38 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p89sm11835225ili.29.2020.11.30.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:36:37 -0800 (PST)
Received: (nullmailer pid 2683783 invoked by uid 1000);
        Mon, 30 Nov 2020 17:36:36 -0000
Date:   Mon, 30 Nov 2020 10:36:36 -0700
From:   Rob Herring <robh@kernel.org>
To:     tomislav.denis@avl.com
Cc:     devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131E0x
 ADC driver
Message-ID: <20201130173636.GA2683425@robh.at.kernel.org>
References: <20201127194240.15060-1-tomislav.denis@avl.com>
 <20201127194240.15060-3-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127194240.15060-3-tomislav.denis@avl.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Nov 2020 20:42:40 +0100, tomislav.denis@avl.com wrote:
> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> Add a device tree binding documentation for Texas Instruments
> ADS131E0x ADC family driver.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 145 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dts:23.11-21: Warning (reg_format): /example-0/spidev@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dt.yaml: example-0: spidev@0:reg:0: [0] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1407724

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

