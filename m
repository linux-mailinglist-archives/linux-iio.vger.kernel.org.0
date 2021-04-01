Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D87351D3D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhDAS1o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbhDASPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 14:15:50 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC5C0F26CA;
        Thu,  1 Apr 2021 07:56:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n8so2016723oie.10;
        Thu, 01 Apr 2021 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hmK4hQlTe/dm4OEhWDvI1X0E5xhesSt9X9vk7PN2+D0=;
        b=Nt3OrrBvL3S9XKUVqA54ZvBGEsaBvezPl3jRLE0I2Bi0NWtYOZ61z05xk5t0aahcS3
         iKsAk7vQVS9oV8UWzL8INOpgyzhugy7vON9xMXMREoLwQcdbduWVnLvXfkZquUmwvzbz
         sjJiRCLDSWYIsmRe+BxuRCYgU4VJ9swJKjnVKyz5TrUaAjzFeIn9Kcc7XKOc4RdpA4rM
         kR+XQ9PIs9NEbPwWMDk8Mu1UxX+NYGWpvDINS4NrOnA3yzvE+YdHi9I2d3T+iIL7hC0u
         WmJJG2Zecscg0R3l06J+8g/yLQensHlob2lkGgQr8npEQ9Mhhq7zn9bP2Qdwtf4ZRxIB
         q+7Q==
X-Gm-Message-State: AOAM533+7v6il8Nkpt37Z0U4nFlnYvXbVBUu2I7mbeUniBP6ecZQl08+
        l8rkVm+KjwyjC18vFZmDHA==
X-Google-Smtp-Source: ABdhPJzSJezFFJWfsrLlTbHO7wSon9UUy58X1LwrBJKlLXSZ7+3BsgnGryhpiYtiaivLvDP+5R1zPg==
X-Received: by 2002:a05:6808:249:: with SMTP id m9mr6434303oie.170.1617288986305;
        Thu, 01 Apr 2021 07:56:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v65sm1092368oib.42.2021.04.01.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 07:56:24 -0700 (PDT)
Received: (nullmailer pid 409162 invoked by uid 1000);
        Thu, 01 Apr 2021 14:56:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alexandru.ardelean@analog.com,
        knaack.h@gmx.de, devicetree@vger.kernel.org, lars@metafoo.de,
        jic23@kernel.org, linux-iio@vger.kernel.org
In-Reply-To: <20210401091648.87421-2-puranjay12@gmail.com>
References: <20210401091648.87421-1-puranjay12@gmail.com> <20210401091648.87421-2-puranjay12@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Thu, 01 Apr 2021 09:56:21 -0500
Message-Id: <1617288981.576340.409161.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 14:46:47 +0530, Puranjay Mohan wrote:
> Add devicetree binding document for TMP117, a digital temperature sensor.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dts:21.13-26: Warning (reg_format): /example-0/tmp117@48:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml: example-0: tmp117@48:reg:0: [72] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

See https://patchwork.ozlabs.org/patch/1460920

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

