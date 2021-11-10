Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81544B9DA
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 02:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhKJBJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 20:09:55 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39554 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhKJBJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 20:09:55 -0500
Received: by mail-ot1-f49.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso1413182ots.6;
        Tue, 09 Nov 2021 17:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XVy96mJGWAltgt7UegL9Otd1SwtIvQvMyrZTa4hhou0=;
        b=Iptavy81VH3Oz99JI6L9poAiXb+yDSAIUf4HVyKpCMSVSoSB2gXt2pAKg+t+NWNHlP
         hmjCFc3vDO1VJ59SAEIE0JLet/aEjdT3biTsyt46v91xKoocZa8LpOt4B8PU7MM0JGui
         zpWZClJZt4oV+KieF4sNPEaKuMUV4qHln2njUSdEh1bCIqIg3E0Db3tBghipuM0b5I63
         q0UBGmdwBkoQPm+GAM2VQRTWhwn444vjYxLWwzp7YYCgRiq6SPLORPnxuYIV89Fl6+7O
         7v8DoaKedIDBP8CX2TDYN7fytmNo4g8jr5q1a1z8R4KFfRwjN/EWuPliQyjMocWQezUj
         d+vg==
X-Gm-Message-State: AOAM5336vjw3fvQXgOdR/gBatT88d/tTD1ZE7FWlB4s5Lw07JxAkX2+5
        52GBf+Y/mf8vDzjcDtm4qF2b+bmYjQ==
X-Google-Smtp-Source: ABdhPJx9pN6F8YVjrzduGrvQpecWUeRByej2GoCjnvs7ACsSkC/DZAwpGEuXa596mR8zK5CSZEnMUA==
X-Received: by 2002:a9d:7b51:: with SMTP id f17mr6824298oto.88.1636506427801;
        Tue, 09 Nov 2021 17:07:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm6919606ooh.40.2021.11.09.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:07:07 -0800 (PST)
Received: (nullmailer pid 3016195 invoked by uid 1000);
        Wed, 10 Nov 2021 01:07:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20211109123127.96399-4-antoniu.miclaus@analog.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com> <20211109123127.96399-4-antoniu.miclaus@analog.com>
Subject: Re: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Date:   Tue, 09 Nov 2021 19:07:06 -0600
Message-Id: <1636506426.248164.3016194.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 09 Nov 2021 14:31:26 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV8818 Filter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/filter/adi,admv8818.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml: properties:adi,bw-hz: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml: ignoring, error in schema: properties: adi,bw-hz
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
Documentation/devicetree/bindings/iio/filter/adi,admv8818.example.dt.yaml:0:0: /example-0/spi/admv8818@0: failed to match any schema with compatible: ['adi,admv8818']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1552959

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

