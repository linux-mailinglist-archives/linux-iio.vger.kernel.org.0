Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69BD3EDE6C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhHPUHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 16:07:40 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40487 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhHPUHj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 16:07:39 -0400
Received: by mail-oi1-f169.google.com with SMTP id r5so28421226oiw.7;
        Mon, 16 Aug 2021 13:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=uHtjUONg6FCY3pnZJevLSPNM0uWf/2eId9QZ5tVSivw=;
        b=hd5K7p0b1Y0HgHqNBQKlQe6cANf6svvTe38gBbbOIPmlFYPqdomMJJl1a0Em3vYuLr
         qO27l/yCJNwfsWYcG0I/UjiRDeEY+n1NFnntCRQSBxvksflXOq/3RctUfsmEgvdessDs
         xBNLgeSyC+OCQ0uWXZK0+CUhBCepADXdYXbuetYiost2liR6np1TjHZeHTJrqBIbfQMw
         mE4bkfvbPBvFoeEqCvQTNlhoh5RchZE3IcQDXD9spsuaF3scHgSanyKQnA8102iwgd95
         tiOyKuW/ZkXIhRySTiFqFDPm02uayk6KdfcrEqc20jxdXUiHb44szEhvibp0nMdaDNE4
         3xFQ==
X-Gm-Message-State: AOAM531cz/26MFUSsVHQPsmpfHFMgsOHbTxOU7C9PMUbj9gtQMVSfHsA
        mUPvOqUVzpHXARYQVP2uPl12D7FMFw==
X-Google-Smtp-Source: ABdhPJwPoLDRQz/e37Bg6ivbukWiCoD/59uOvrNG7ZaBLascqxFx2/JD5NsoIT8X2Em6vbYg4dR/Pw==
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr383200oiw.31.1629144427275;
        Mon, 16 Aug 2021 13:07:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm4019ooa.35.2021.08.16.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:07:06 -0700 (PDT)
Received: (nullmailer pid 2563335 invoked by uid 1000);
        Mon, 16 Aug 2021 20:07:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de, andrew@aj.id.au,
        BMC-SW@aspeedtech.com, joel@jms.id.au, robh+dt@kernel.org,
        p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        linux-aspeed@lists.ozlabs.org, pmeerw@pmeerw.net, jic23@kernel.org
In-Reply-To: <20210816104846.13155-2-billy_tsai@aspeedtech.com>
References: <20210816104846.13155-1-billy_tsai@aspeedtech.com> <20210816104846.13155-2-billy_tsai@aspeedtech.com>
Subject: Re: [v3 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Date:   Mon, 16 Aug 2021 15:07:03 -0500
Message-Id: <1629144423.392245.2563334.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Aug 2021 18:48:32 +0800, Billy Tsai wrote:
> Add device tree bindings document for the aspeed ast2600 adc device
> driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml: properties:aspeed,int_vref_mv: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('enum' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml: properties:aspeed,int_vref_mv: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	1200 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2500 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml: ignoring, error in schema: properties: aspeed,int_vref_mv
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.example.dt.yaml:0:0: /example-0/adc@1e6e9000: failed to match any schema with compatible: ['aspeed,ast2600-adc0']
Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.example.dt.yaml:0:0: /example-0/adc@1e6e9100: failed to match any schema with compatible: ['aspeed,ast2600-adc1']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1517123

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

