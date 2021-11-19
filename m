Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994364574D5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Nov 2021 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhKSRB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Nov 2021 12:01:27 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46899 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhKSRB1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2021 12:01:27 -0500
Received: by mail-ot1-f42.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so17673659otk.13;
        Fri, 19 Nov 2021 08:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7Eb6Mn0pwWUrKYAbEyduuHfEo+brQAeE2/L1JK8aNSs=;
        b=w7yv4OujgfSnPC2UM05Q4eQAXeBFJ0a6ISfzYZCv3tActgTgFNWvPI6vEV5d1yCiLJ
         IQ+XJx/YVQ0AEKB6HgJDA+N3Jt++tGXYN4vKpN6ZOI2Gf8eG919WzKLkbrtVBKoTU/G5
         WMrGMCRwPxOWJbMN892af/RK4Jh7fweY6pHYZonY941qOpSz+H+LSHseXLLVWd4xIwji
         96Hi62h6Ojs0ekyd8FmUmLVV99vbfqRSEOGUrVOuIudTprF6J+kdbO3d2xW0mI+Mwyt2
         kyr2M9n4PuYBO8GMpRKq6skqb8f21IxUCnDtLI9sskrBrUdEiz/UL9gL78TUwc+SoNsA
         UQyw==
X-Gm-Message-State: AOAM533k/7nnnOxYjoD8NxNZq/71XOVLWawYCx0tdkCo0CXKf9KSThx1
        Lbeu1s1zHDmQw99/hA/xsQ==
X-Google-Smtp-Source: ABdhPJwN3jtor6NEoltXzhIUIfA1WYX4ocwXyZZ6LTiehDvPLKluF7rfbfLtUMRFZO67pgI3avCyPA==
X-Received: by 2002:a05:6830:1bc3:: with SMTP id v3mr5872612ota.276.1637341105175;
        Fri, 19 Nov 2021 08:58:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm63781oij.54.2021.11.19.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:58:23 -0800 (PST)
Received: (nullmailer pid 4078687 invoked by uid 1000);
        Fri, 19 Nov 2021 16:58:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
In-Reply-To: <20211119114011.75406-1-cristian.pop@analog.com>
References: <20211119114011.75406-1-cristian.pop@analog.com>
Subject: Re: [PATCH v1 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Date:   Fri, 19 Nov 2021 10:58:22 -0600
Message-Id: <1637341102.257587.4078686.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Nov 2021 13:40:10 +0200, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml:10:1: [warning] wrong indentation: expected 2 but found 0 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.example.dt.yaml: admv4420@0: adi,ref_single_ended: [[0]] is not of type 'boolean'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1557045

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

