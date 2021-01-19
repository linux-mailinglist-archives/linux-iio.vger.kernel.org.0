Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DED2FC4BF
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 00:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbhASXah (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 18:30:37 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34999 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbhASX3E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 18:29:04 -0500
Received: by mail-oi1-f177.google.com with SMTP id w8so1348449oie.2;
        Tue, 19 Jan 2021 15:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NgCjdpeD2ewodAEIf3EQzoU1nevKZ6HXzGccvrmfIfA=;
        b=ElA8yaxMJd6GiuFs2Jt/zCSC8F3CKWQ8crU2SkJo2Fm6Hc2ifsNdUKffZy/q6ZiA3U
         ezY8V/betxSAEdhtHYRlpJmN6X8fGA/dDc4YKdn/T2NdLlgQvHW0eKjO/HM+R1phBFzV
         UTE99Qb+3fRTzPpLxrYUSG9rZYrI/R772IiRtc5qaX/HFeXofpNpHkEjfqvQFuOc6uV3
         henhxwxZNazr376gQhUQbSgpc3VWEDo9iTTzT3EIzMk4zYL5CtyY3H+u9GrefrxeuWgE
         D6a0BhLelRGt2Z4KRAYRg0IMWA/SnUuxWF3V6jpXnMzxE27v9gnnEJ3m/QejyGliIZKe
         Vq/A==
X-Gm-Message-State: AOAM533fKORvK9gIHUxXXPvedhBDzbzRoiTs/2HX4tXJ2zp0l8o7RWn/
        zN2PtIWyeActfqAc/zmuRmZTGlXnUw==
X-Google-Smtp-Source: ABdhPJxjoKWxggjGsvdJkBiPqoPTvu9VCOzm1dtQb6Aj5ED83KtYj9XBHxaWMQSIs/Fq0OCB5taxxA==
X-Received: by 2002:aca:a915:: with SMTP id s21mr1412597oie.108.1611098903373;
        Tue, 19 Jan 2021 15:28:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e12sm31915otp.25.2021.01.19.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:28:22 -0800 (PST)
Received: (nullmailer pid 2803682 invoked by uid 1000);
        Tue, 19 Jan 2021 23:28:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
In-Reply-To: <20210119124622.9490-1-mike.looijmans@topic.nl>
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Tue, 19 Jan 2021 17:28:21 -0600
Message-Id: <1611098901.303102.2803681.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jan 2021 13:46:21 +0100, Mike Looijmans wrote:
> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
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
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

See https://patchwork.ozlabs.org/patch/1428668

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

