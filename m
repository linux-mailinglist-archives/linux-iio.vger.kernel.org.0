Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206AF36ED5B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhD2P0X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 11:26:23 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42670 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbhD2P0K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 11:26:10 -0400
Received: by mail-ot1-f42.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so25194812otq.9;
        Thu, 29 Apr 2021 08:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2mQOXVVAaC3S4BiYoLh8krZX0s9YyIobwu0IHy7jdq4=;
        b=BI4T0hzEE2gqHXQEs02tS+cbrCyRmKjoNoXSggP/Q8bXB7R8uuS3Ns0EH3EPmd3Ioc
         2NuU9KK2FytftSV3Cxj8Rh2XnX3OjAjpOSUM9CpDNQyPku4kFzndLYFEmjRvWzBtFVdT
         aBBYHsnFTbtvg4tjQGIsEuSu2grikbX8VBMl8FMl2NvYqrlIgr8WlH6kCyz4et6u0giC
         tq9ekXlSB5p1V4cM7rV+8MpCHfxfcQ/M9aGFsiBfCZZHsu3BQUYqb4T7dYsMcqJrzYiG
         RP8sJyin3A5qpAyk9d98qzL3n9qzEU3f8qwJWO9c1nDechA45cKN1C5BAP3JItF7kW+p
         hMNw==
X-Gm-Message-State: AOAM533ISS/0uUzf0UsGUo1YqK9Ir8Rlo3AFEwexHu1d8Qmyace2rPK2
        VNrsSWj9egYzHWlOF9gzTP9Xq3nmmQ==
X-Google-Smtp-Source: ABdhPJyTqmOypYCUidwE2+zru7QRvkZvnQMNYVO2yqU9gzHUdu581/FtW3I1INuWRUqO4+S2S8Ajvw==
X-Received: by 2002:a9d:61d0:: with SMTP id h16mr30175224otk.363.1619709922473;
        Thu, 29 Apr 2021 08:25:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p2sm21722ool.15.2021.04.29.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:25:21 -0700 (PDT)
Received: (nullmailer pid 1303440 invoked by uid 1000);
        Thu, 29 Apr 2021 15:25:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     devicetree@vger.kernel.org, Nuno.Sa@analog.com, jic23@kernel.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, lars@metafoo.de
In-Reply-To: <20210429122806.3814330-2-sean@geanix.com>
References: <20210429122806.3814330-1-sean@geanix.com> <20210429122806.3814330-2-sean@geanix.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: iio: accel: fxls8962af: add bindings
Date:   Thu, 29 Apr 2021 10:25:15 -0500
Message-Id: <1619709915.268133.1303439.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Apr 2021 14:28:02 +0200, Sean Nyekjaer wrote:
> Add devicetree binding for the NXP FXLS8962AF/FXLS8964AF
> accelerometer sensor.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes for v2:
>  - removed requirement for interrupt
> 
> Changes for v3:
>  - None
> 
> Changes for v4:
>  - Included the dt patch from the RFC
> 
>  .../bindings/iio/accel/nxp,fxls8962af.yaml    | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml: properties:interrupt-names:items: {'enum': ['INT1', 'INT2']} is not of type 'array'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml: ignoring, error in schema: properties: interrupt-names: items
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.example.dt.yaml:0:0: /example-0/i2c0/accelerometer@62: failed to match any schema with compatible: ['nxp,fxls8962af']
Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.example.dt.yaml:0:0: /example-1/spi0/accelerometer@0: failed to match any schema with compatible: ['nxp,fxls8962af']

See https://patchwork.ozlabs.org/patch/1471682

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

