Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8803004BA
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 15:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAVOBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 09:01:48 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35495 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbhAVOB2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 09:01:28 -0500
Received: by mail-ot1-f44.google.com with SMTP id 36so5141665otp.2;
        Fri, 22 Jan 2021 06:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=U4xsstxbQBaXybAiqcrHmLZ69QV9B6F9pTaooq4dehY=;
        b=Cj3hLhttEAovwb31auhPnOvZWuX3Hzf+4qZgARhdulb2D0nVbZPl5Itq14BKqfyzxs
         k2Rn3t9vBtjHfHXvswdJUk9x3DQopR3PxyG7EPD29vB74sapz3C5+SStgrKkm9jnVINC
         L/xN5dUElMpm+qzFST4IpYaw66h2iY+qLRame2mTmqW/RwjA5KkNgljeeGhLQp9dtj7h
         y3Iv42bL7YmTQ4dJu56NU9TVYF+IcsTADa2vr4RQA29a2ZuQfDkne28V8kutHHj/ahNl
         coVZRV/V2Mgq7ZP2e7+SZmVMyg9d//qjUzIKt656Zi5kj5U2j7nfyQvrEXQxZTj/sEm4
         C/og==
X-Gm-Message-State: AOAM532BXHz+MYCP0e9Mduqg5eg/ZJdAfbvqK4QCwZ4KYtUv9HscdHY2
        nFS6bVA0hm3BdYucTjJ3Xg==
X-Google-Smtp-Source: ABdhPJyBiSU5QQVkbT3Q/aWxpWwAj9m4LW2qvNwe02K1nfHI9+W0Pb3NSq/1AhIdgdEaN2SaTT2R6A==
X-Received: by 2002:a9d:3ef6:: with SMTP id b109mr3441742otc.288.1611324047313;
        Fri, 22 Jan 2021 06:00:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm218544oov.13.2021.01.22.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:00:46 -0800 (PST)
Received: (nullmailer pid 674368 invoked by uid 1000);
        Fri, 22 Jan 2021 14:00:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org
In-Reply-To: <20210121155700.9267-1-mike.looijmans@topic.nl>
References: <20210121155700.9267-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Fri, 22 Jan 2021 08:00:45 -0600
Message-Id: <1611324045.669047.674367.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 16:56:58 +0100, Mike Looijmans wrote:
> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v7:
> Add additionalProperties
> Change bmi088_accel to bmi088-accel
> Add interrupt-names and adjust description
> 
> Changes in v6:
> I't been almost a year since the last commit, sorry...
> Fixed the yaml errors
> Add interrupt, vdd and vddio properties
> 
> Changes in v5:
> submit together with driver code as patch series
> 
> Changes in v2:
> convert to yaml format
> 
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.example.dt.yaml: bmi088-accel@1: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

See https://patchwork.ozlabs.org/patch/1429940

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

