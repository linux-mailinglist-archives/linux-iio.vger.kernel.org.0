Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D43435E6
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 01:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCVAP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 20:15:57 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:33378 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVAPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Mar 2021 20:15:40 -0400
Received: by mail-io1-f50.google.com with SMTP id n198so12143427iod.0;
        Sun, 21 Mar 2021 17:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FxUp2jEO0KRbEY12V6xZa1U/LzshQlRJK7fSuCExngA=;
        b=fheG02dhmMZXlmPj8qzRmbWK4HMxVYc7MHAMIkfBN6KGUxrXvpwcjWuYo/20MJMWUf
         gG5YIle7HNM7xW9+fSLfrzuU0X9JvgLuqWC0hvvb2FCwLAyysYdJScPe4V7mAW87paT+
         s7wpsMcQUlYiDjuRfYkCgHvxlsm/Rby85oiDH7m7JONtoqzGAV6kiLp5bjR1RGTw6WiJ
         hdpWlxyPdUQ165mRwfAwhj0iYyLbC0zboylW2cowbPGEQieVxpO4tYv5W7dh+MsizVa0
         feBVIQ/kc5CGXB6rHFA21SKdJA+cwjmdXiQWaxDWngG69J8eUCj7vb6+goOfNloBltU4
         5RZg==
X-Gm-Message-State: AOAM533ccorU8rpzVsOlQ8oqb3OcnSo1NVcuujSY7WRNO6fJ/jJQk677
        rmRI5aLTl+nNXDJA2/2SIOkHeeL2XQ==
X-Google-Smtp-Source: ABdhPJzwJ39k6DbRD/IcaVPrMClRm6JaxHcOm5Jlrno6VNA8zJ3eagAFcjnEmh1243i7QLSQIehXrQ==
X-Received: by 2002:a5e:8902:: with SMTP id k2mr1479306ioj.48.1616372139615;
        Sun, 21 Mar 2021 17:15:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j14sm6726036ilu.3.2021.03.21.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 17:15:39 -0700 (PDT)
Received: (nullmailer pid 1475026 invoked by uid 1000);
        Mon, 22 Mar 2021 00:15:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        alexandru.ardelean@analog.com, devicetree@vger.kernel.org
In-Reply-To: <20210320064509.119878-2-puranjay12@gmail.com>
References: <20210320064509.119878-1-puranjay12@gmail.com> <20210320064509.119878-2-puranjay12@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Sun, 21 Mar 2021 18:15:37 -0600
Message-Id: <1616372137.235777.1475025.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 12:15:08 +0530, Puranjay Mohan wrote:
> Add devicetree binding document for TMP117, a digital temperature sensor.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml: examples: 'tmp117@48 {\n    compatible = "ti,tmp117";\n    reg = <0x48>;\n};\n' is not of type 'array'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml: examples: 'tmp117@48 {\n    compatible = "ti,tmp117";\n    reg = <0x48>;\n};\n' is not of type 'array'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml: ignoring, error in schema: examples
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
Error: Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dts:20.5-6 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1456094

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

