Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF62C89BC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgK3QjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 11:39:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40489 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgK3QjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 11:39:22 -0500
Received: by mail-io1-f65.google.com with SMTP id r9so12408947ioo.7;
        Mon, 30 Nov 2020 08:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6I9VGJWSiiniPwoytIW7/IWLQ2Yesh4ZxepFqF8IfbQ=;
        b=t6n3NXnSZDQi5B1jUIYMtxDfc889f3/JBY4RvBeFNcyJPT7RjCu5zSkGEjKOCwQpM5
         fsVM2pAMjfDQ4vkT4iTBE+jm8fmR20P/HFIPx7UJzWVLJfSMd4VSnB3GTC81ri0HA/cP
         z6E+1g60OojXmbvItHDG8boJByp5y+ziRzrkhoKmn8h2uB23QDM06uKMSWuxOaBNKSqC
         pX/xf9aWjNEzLJ7K/3mIohzKsTHH/E4h0dAIO2YwBOZ6UHXKkVoUXRRaPpjxXm8rUM4m
         u4sQeGdl/pnl99FZD9sgcevE+s/bmM/FYr8nkjHvRf4IcfGmpUOiqRPy+zVVL/ZTLHIz
         EvVw==
X-Gm-Message-State: AOAM531vR0R57JsYkUpXfqlSyFKYLhXfYaE5HWXFkLvV9t3NEsTD7LqX
        +/L1MnLBk7xQvA2mN8O3Xw==
X-Google-Smtp-Source: ABdhPJz3Y8funAZBlLqf8d+aAk9THXhAiQ3D80fWbYx3siUEKY6mKSIlfIFxbQhgs8zsrdXxZhLAmg==
X-Received: by 2002:a6b:8d58:: with SMTP id p85mr16907880iod.74.1606754320872;
        Mon, 30 Nov 2020 08:38:40 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 10sm10999380ill.75.2020.11.30.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:38:40 -0800 (PST)
Received: (nullmailer pid 2592489 invoked by uid 1000);
        Mon, 30 Nov 2020 16:38:38 -0000
Date:   Mon, 30 Nov 2020 09:38:38 -0700
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201130163838.GB2590579@robh.at.kernel.org>
References: <20201123145042.18930-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123145042.18930-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Nov 2020 16:50:41 +0200, Cristian Pop wrote:
> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5766.yaml          | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml: 'additionalProperties' is a required property
./Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dts:21.13-23: Warning (reg_format): /example-0/ad5766@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: example-0: ad5766@0:reg:0: [0] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1404863

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

