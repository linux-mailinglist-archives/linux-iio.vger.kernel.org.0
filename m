Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E512D16BD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgLGQqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 11:46:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35654 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgLGQqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Dec 2020 11:46:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so6961350otr.2;
        Mon, 07 Dec 2020 08:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtZn9unR1Aesg9LN62b7/esOYjlkqxHM9rLlMSFk1PQ=;
        b=k1twg7MEtna91G6QwLRtIGIkwBO++9q1ldZmcge6PXxPrJlHVoEr6jM+6ku2rlb5Yt
         CAs3PTtpYz8MdZPsquwk0a+qMf/Vfr0Af6P/1RbKx1dFd32LGCkrIBH6uG9vKpRETRMb
         rGUMN7UazS2RoHd3gS9T6XdGgEjF7GQJqmrgJxg431vEO9apyqal/veTPP/qpUhy9YLa
         cvHFAme4Ddy6yY/ulCBWeedeZF/k/3+lDfiQ74zF4SI9NJSfRk9MlviCiL7jqSFk2r/T
         eVhbE99evIbueFmkhg91aPifLqdje0Nwut8THMREafhVTnprf1Oc0utMurM9arHHZy5G
         QALw==
X-Gm-Message-State: AOAM532GTpFSdFuZJyL55SEHJf1s03/2Tdpv3++a0tVWp0jaDTMx+SBG
        hAvoqZQPCBTR11xheu5iBQ==
X-Google-Smtp-Source: ABdhPJxrwqdRTTy1CWV3yLzwBy1fqbC8Q75rgqlnKNrFMe8vqC3G6MLHj1RB5fV+LabtW1xQt1OOGw==
X-Received: by 2002:a9d:3b06:: with SMTP id z6mr13397574otb.170.1607359555489;
        Mon, 07 Dec 2020 08:45:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm3005345oif.42.2020.12.07.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:45:54 -0800 (PST)
Received: (nullmailer pid 415547 invoked by uid 1000);
        Mon, 07 Dec 2020 16:45:53 -0000
Date:   Mon, 7 Dec 2020 10:45:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201207164553.GA414767@robh.at.kernel.org>
References: <20201204182043.86899-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204182043.86899-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 04 Dec 2020 20:20:42 +0200, Cristian Pop wrote:
> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  Changes in v2:
> 	- Add "additionalProperties: false" property
> 	- Remove blank line
>  .../bindings/iio/dac/adi,ad5766.yaml          | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dts:21.13-23: Warning (reg_format): /example-0/ad5766@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dt.yaml: example-0: ad5766@0:reg:0: [0] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1411214

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

