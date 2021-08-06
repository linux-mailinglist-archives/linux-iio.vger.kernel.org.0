Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAA03E2EBB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhHFRHm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 13:07:42 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:42661 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhHFRHl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 13:07:41 -0400
Received: by mail-io1-f42.google.com with SMTP id h1so12486012iol.9;
        Fri, 06 Aug 2021 10:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LJWMUp8Sjeu1pu7rDiCez6vwWxz1Wf2LthgTkCA7VgI=;
        b=nwxdkzBg15lgH9BPl3/0LvegwcfJAGbDUwrlvQcI7y/pxa+1Kfw9DdhHrjqqyKnt+3
         J2bQc6LrzLSIu1tXy3B/yYXWf2UM22a8h3SaHm62Of0Gyl4Et5Sq5xXJrlGLluMXupW8
         e11WwUVXlvXG6NcUD0uphBpn2kv+0e7/I8bx5ZMdbpbXCaVhcM5PDtNR6QnWV3gnVRs6
         U41Dne5dJON3dWGPfntHrvJ6H8MIuPSdbRyoFQIPVX/dei9j5TDPpprXB24E+pugY5Tz
         kxHwptp/G/qmvZT1NsWA1rbHfpYfkITukq92mYQWI2CvBsF3GCD5Y1bAcTSY4kJQijaa
         bhsw==
X-Gm-Message-State: AOAM530YGGqCjedRnRUbh36nh6Ce6iflH4bg8CVzZQ7d74weNUpbxOvt
        vw1NWJKnCB/5/1HkQSXGCQ==
X-Google-Smtp-Source: ABdhPJyKQmErQitL7sFeN4Q8+2A+XTj6mUFXEOGDgxix6pRob33Strko9MQChcerbRNQcjAU7QVF5A==
X-Received: by 2002:a02:90d0:: with SMTP id c16mr10662905jag.106.1628269644318;
        Fri, 06 Aug 2021 10:07:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a2sm4836361ili.40.2021.08.06.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 10:07:23 -0700 (PDT)
Received: (nullmailer pid 1430714 invoked by uid 1000);
        Fri, 06 Aug 2021 17:07:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Michael.Hennerich@analog.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Dragos.Bogdan@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org, Darius.Berghe@analog.com
In-Reply-To: <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
References: <cover.1628143857.git.lucas.p.stankus@gmail.com> <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: Add binding documentation for ADXL313
Date:   Fri, 06 Aug 2021 11:07:21 -0600
Message-Id: <1628269641.621456.1430713.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 05 Aug 2021 03:29:37 -0300, Lucas Stankus wrote:
> Add device tree binding documentation for ADXL313 3-axis accelerometer.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl313.yaml       | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml: properties:interrupt-names:items: {'enum': ['INT1', 'INT2']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml: ignoring, error in schema: properties: interrupt-names: items
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
Documentation/devicetree/bindings/iio/accel/adi,adxl313.example.dt.yaml:0:0: /example-0/i2c0/accelerometer@53: failed to match any schema with compatible: ['adi,adxl313']
Documentation/devicetree/bindings/iio/accel/adi,adxl313.example.dt.yaml:0:0: /example-1/spi/accelerometer@0: failed to match any schema with compatible: ['adi,adxl313']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1513753

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

