Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD54346E128
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 04:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhLIDMb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 22:12:31 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34344 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhLIDM2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 22:12:28 -0500
Received: by mail-ot1-f49.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso4873171otj.1;
        Wed, 08 Dec 2021 19:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lupNvExpNMQ8Z9nGG3yaD8+KxUyj9IiGSOaXOmVK6Bc=;
        b=nevp/iaINYwzEk2O+HCsLsTrLSRcx+BNLeXLAvKGldnxh2C5iw6+Kij1PSjxkbdnmP
         Tsne5KTo5j7zs9dGaKD61VApSF6eY7sJ2kUfHZYJ6fB3u6ye5SD7XJR+FPpV9OhruPT5
         b955xjZtJX4rLT0sE273uHcIOvACOsY+P5GjWawbATLgeXUhe+gGqK3p9QxQ/sFYoty2
         T31lHFu8+SFAqSmSXA3ee+hh6PeUz8cU2SapeKXxKcQll7xEubVHFKbH2xuixXP2XnzZ
         7zsrgAggASyYZGKjO380PWK11llaUN070Vr3v7ahoh2DEdmxP94x6rTfFr8enDHZQJXB
         LOhA==
X-Gm-Message-State: AOAM532wWtrEo9HqfZhD632WDd/IsIhhgjnJytqOtd7sNqmcmZSU1pdY
        WApFbBbmAE94OOX1bXf5/A==
X-Google-Smtp-Source: ABdhPJxAuOKsobe/Oh4NMZZVt1E0kOkhWXWCJupfGToDEmjG9e8+zYAivkm5TLnk+zMagRguOmeDVg==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr3261989otp.45.1639019335355;
        Wed, 08 Dec 2021 19:08:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q10sm1132611oiw.17.2021.12.08.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 19:08:54 -0800 (PST)
Received: (nullmailer pid 934415 invoked by uid 1000);
        Thu, 09 Dec 2021 03:08:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org
In-Reply-To: <20211209005806.3575399-5-gwendal@chromium.org>
References: <20211209005806.3575399-1-gwendal@chromium.org> <20211209005806.3575399-5-gwendal@chromium.org>
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Wed, 08 Dec 2021 21:08:51 -0600
Message-Id: <1639019331.997945.934414.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 08 Dec 2021 16:58:05 -0800, Gwendal Grignou wrote:
> Similar to SX9310, add biddings to setup sx9324 hardware properties.
> SX9324 is a little different, introduce 4 phases to be configured in 2
> pairs over 3 antennas.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v6:
> - Fix syntax errors in device tree binding documentation.
> - Run 'make dt_binding_check' to make fix errors.
> 
> Changes in v5:
> - Use consistent field naming, prefixed with phX.
> 
> Changes in v4:
> - Use const instead of single enum
> - Specify ph0-pin better
> - Recopy type information for phX-pin
> - Fix cut and paste errors.
> 
> Changes in v3:
> - Remove duplicate information.
> - Use intervals instead of enum.
> - Fix filter description.
> 
> Changes in v2:
> - Fix interrupt documentation wording.
> 
>  .../iio/proximity/semtech,sx9324.yaml         | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.example.dt.yaml: proximity@28: semtech,ph01-resolution:0:0: 2 is not one of [8, 16, 32, 64, 128, 256, 512, 1024]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.example.dt.yaml: proximity@28: semtech,ph23-resolution:0:0: 2 is not one of [8, 16, 32, 64, 128, 256, 512, 1024]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1565557

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

