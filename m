Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBFD41A507
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhI1CDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 22:03:25 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37414 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbhI1CDZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 22:03:25 -0400
Received: by mail-oi1-f181.google.com with SMTP id w206so28182175oiw.4;
        Mon, 27 Sep 2021 19:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z7LkJ54STHoZgT24nai7QroD7JpjVvJEeE869Va8hFE=;
        b=DelPhj74/Gjo+RLUJ/s0QqZ9bkvl2jZQAPxC7TSGVca3R5uwFgNb3w/ROPAA3s/pXA
         eOTLgyGjo8YtqOjDp1kwAfJGcPdaiHbdx+w8SDWwdu1PJZqR0n1Q8SIakz4h0NPbEeb5
         2frm5kzBb8pF2h1zmzqF35KI6ZPPbyl0h893ULl+tMOjwgcMPVNYN4Bpvu2qfE+JZbkf
         6/8YQ0vOu0eUvkRv3ru/qq9Heit7APnZajcx/IeMZf24M9VOChow2sfuAYNyZm6I9TJI
         RdBLw8NhTKI/8vskmbmy1cOCYItgsBjElXbpUqc45KuKO0vXiVWMFA9yQ1x9YVUDTx31
         reWQ==
X-Gm-Message-State: AOAM530COwAyWnpiroghevsUyD/pHWUOK8QnovQEfr/R7g/JT66msfWI
        9KDqtCnudx+BNou3G7ZG4g==
X-Google-Smtp-Source: ABdhPJyCMWGDbvqiS9nwWzfhWA5a57/txmRASQZ2f4MCmLjXY7b1HMd8PZIgZ0PzLbyprVdf5An5Rw==
X-Received: by 2002:a54:4f12:: with SMTP id e18mr1688421oiy.77.1632794504095;
        Mon, 27 Sep 2021 19:01:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l19sm4352815otj.77.2021.09.27.19.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:01:43 -0700 (PDT)
Received: (nullmailer pid 83974 invoked by uid 1000);
        Tue, 28 Sep 2021 02:01:42 -0000
Date:   Mon, 27 Sep 2021 21:01:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: ad779x: Add binding document
Message-ID: <YVJ3hqCrw0I3spGo@robh.at.kernel.org>
References: <20210927104841.2256295-1-florian.boor@kernelconcepts.de>
 <20210927104841.2256295-2-florian.boor@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927104841.2256295-2-florian.boor@kernelconcepts.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Sep 2021 12:48:41 +0200, Florian Boor wrote:
> New binding documentation for AD799x series of I²C ADC ICs.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
> ---
>  .../bindings/iio/adc/adi,ad799x.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml: title: 'Analog Devices AD7991, AD7992, AD7993, AD7994, AD7995, AD7997, AD7998, AD7999 and similar analog to digital converters' is too long
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml: ignoring, error in schema: title
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dts:20.17-30: Warning (reg_format): /example-0/ad7991@28:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml: example-0: ad7991@28:reg:0: [40] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad799x.example.dt.yaml:0:0: /example-0/ad7991@28: failed to match any schema with compatible: ['adi,ad7991']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1533263

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
