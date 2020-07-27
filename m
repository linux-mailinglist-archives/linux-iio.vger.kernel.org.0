Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4C22F787
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgG0SPD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 14:15:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36487 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgG0SPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 14:15:03 -0400
Received: by mail-io1-f66.google.com with SMTP id t15so9045455iob.3;
        Mon, 27 Jul 2020 11:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYtw9YpjryNj+P7sa7ru3omMiZtT2NKQkuKuKcuEOlo=;
        b=XvtbHvt7eq4TVhAVk/grZjhQZbiqfFnZgi+1gGPndNhRoCz/Y9bXSZETHr5GoK9Jpt
         BTF7/+RSBkF+YCCNfUaFxBN3lkcuYzNNpZ03T3G1m2sNMkzrxQJrSF8Ei9F28nEJQBu5
         MOUvXardMIMjmJrw5t/n2Io8qwqCkWdrgzDUMNDq/ycnxZixLILo6VW1abxNeq0GQcmj
         qrx56xx0Ra8G1KOqRzzxwrh19WABumDTvdId9LgGQhQ+iGyR8Lox2UaeoGfw5mpARhHX
         za84boVdhKnJB8Cbp2x6XiByky+V5Rrqgrs3QbXZFEDWlxaMGyaYZmCnUIH84QAVCtpT
         /S0Q==
X-Gm-Message-State: AOAM533E3D/XTtWhk3oGdwcyoGaIz9GO5ye8vT9HIyi0wgJORFFxV1Zm
        wHQESouOMimyZ2HIcS0Ixf6DmaMN4g==
X-Google-Smtp-Source: ABdhPJxw3k8fI2bDsS359EwMlDuaaKCNDuNufmiHEEdYDjipxMFi7lqPsgIdQi6mLZJlEs4bF4ND4g==
X-Received: by 2002:a5d:9347:: with SMTP id i7mr25043985ioo.40.1595873702435;
        Mon, 27 Jul 2020 11:15:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i9sm8913885ile.48.2020.07.27.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:15:02 -0700 (PDT)
Received: (nullmailer pid 640299 invoked by uid 1000);
        Mon, 27 Jul 2020 18:15:01 -0000
Date:   Mon, 27 Jul 2020 12:15:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Darius Berghe <darius.berghe@analog.com>
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ltc2471 driver yaml
Message-ID: <20200727181501.GA639934@bogus>
References: <20200727135834.84093-1-darius.berghe@analog.com>
 <20200727135834.84093-4-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727135834.84093-4-darius.berghe@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 16:58:34 +0300, Darius Berghe wrote:
> Add dt binding documentation for ltc2471 driver. This covers all supported
> devices.
> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>
> ---
>  .../bindings/iio/adc/adi,ltc2471.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/adc/adi,ltc2471.yaml#
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dts:22.13-26: Warning (reg_format): /example-0/i2c0/adc@14:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dts:20.18-23.13: Warning (avoid_default_addr_size): /example-0/i2c0/adc@14: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dts:20.18-23.13: Warning (avoid_default_addr_size): /example-0/i2c0/adc@14: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/adc/adi,ltc2471.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'


See https://patchwork.ozlabs.org/patch/1336970

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

