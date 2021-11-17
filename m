Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B60453E7B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 03:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhKQCaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 21:30:14 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34502 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhKQCaO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 21:30:14 -0500
Received: by mail-oi1-f176.google.com with SMTP id t19so2984420oij.1;
        Tue, 16 Nov 2021 18:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/rart4BznLTgp+5QgTKxLDy9zh72t7U0cB9dGv2y30E=;
        b=mw8ETxVT3ciwnrQF0bd6GR1JsJnd3X8DDXKnvUHoGQICHMnxc+e/efVjFnPhS+M9gp
         AWwGOr9X2Qr/1jm3AauqWlJnQMCyUTdjDeLwOUVxU9tcYCHObXR4qKaZov0w/X90KvUs
         VeW3UrcATddFxNRhXpB1W91l30Qa2dp/pyVcfNjDIq4MS2IuH6roq6bLGnlP+9TomDGH
         JT9kVNWa3jC73h/70XT+g/c6J2AU+cyfH5D0OauGzMHYzNjqq/jIVQc5maENPRTUisXW
         MusYdshO6JML6SdSksuDoj+7UXAhTb2kEA2+trM3Gwie6pXH6HIT1PhnBfiDReFKCl5o
         xLEg==
X-Gm-Message-State: AOAM533ISU6fv4o8OiXHr3rg0Z1U4tl9ED7qW5uugL+hUbHm11NpbJJf
        Ugjid+CzYi+cNOoRg0IWKQmVGEbkcw==
X-Google-Smtp-Source: ABdhPJyEGt6gNqiofKP2GdyaFo30VM6OCh/c6FkbUlTbt900tC790jErIISvrBp3/6snwpxK+9wZGg==
X-Received: by 2002:a54:4584:: with SMTP id z4mr57334546oib.158.1637116035971;
        Tue, 16 Nov 2021 18:27:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 16sm4303322oix.46.2021.11.16.18.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:27:15 -0800 (PST)
Received: (nullmailer pid 1207282 invoked by uid 1000);
        Wed, 17 Nov 2021 02:27:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iain@hunterembedded.co.uk, linux-iio@vger.kernel.org
In-Reply-To: <20211116155917.304294-1-drhunter95@gmail.com>
References: <20211116155917.304294-1-drhunter95@gmail.com>
Subject: Re: [PATCH v2 1/2] Add binding for IIO ADS1018
Date:   Tue, 16 Nov 2021 20:27:10 -0600
Message-Id: <1637116030.343220.1207281.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Nov 2021 15:58:58 +0000, Iain Hunter wrote:
> v2 has me as suggested maintainer per Daniel's feedback.
> 
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1018.yaml          | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml: duplicate '$id' value 'http://devicetree.org/schemas/iio/adc/ti,ads1015.yaml#'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1555907

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

