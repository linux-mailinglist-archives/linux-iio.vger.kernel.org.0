Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD18A3B92C7
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhGAOGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 10:06:34 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:45833 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhGAOGc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 10:06:32 -0400
Received: by mail-il1-f179.google.com with SMTP id b5so6432705ilc.12;
        Thu, 01 Jul 2021 07:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wbT8Ks1SNmRLlWkzxeU8xdlQA5u/+Yl10JWaWVZb/dQ=;
        b=XDokCOVNy1sl7UFa44Vwo4YBOQD4rG4FTAf+0i7et9/aqI9j6ayOyHtN1qw8iX+WhJ
         p5/PnAkYexrrC/nr8kb7pqyzaGxdcLPKh8pKsheO7SJDkBBlXBncfHke1NnPIYi8ubWD
         ExEgKL/gg8LuPR6vf7tDI6W+dhAUazkU+ui/UBMMr0Ti8O8jGVfSsSjk4jAajBXua5yV
         JikpNpZXy8xalFOoD+ukKcWZSa6w/DwKq1ntLxglIj/0qKriguZz2wA09LboKikmjK7f
         nl3ItbmL2h22Isf4rhjT8IGbBOM63Hezg0yST2reKOmkFwfz7cC7x0QtDfFnGhsahoty
         5j1g==
X-Gm-Message-State: AOAM533jmrPDEFseWaOO8ngPjR8mhbvHHrDQRN0gg3GWEcMnJgCriCH3
        pmd9W8eDD6UtftklaFqCh91V4eTZUg==
X-Google-Smtp-Source: ABdhPJx71za0MYqLZLGjIKph+dBsSeZJNQ43Mf4e2arjbbbCoz00zF0285z+YR4s9PRr63GczYPUfg==
X-Received: by 2002:a05:6e02:ee2:: with SMTP id j2mr23739395ilk.63.1625148240363;
        Thu, 01 Jul 2021 07:04:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g14sm14460934ioo.19.2021.07.01.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:03:58 -0700 (PDT)
Received: (nullmailer pid 2278716 invoked by uid 1000);
        Thu, 01 Jul 2021 14:02:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210701112803.75815-2-antoniu.miclaus@analog.com>
References: <20210701112803.75815-1-antoniu.miclaus@analog.com> <20210701112803.75815-2-antoniu.miclaus@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Thu, 01 Jul 2021 08:02:43 -0600
Message-Id: <1625148163.622224.2278715.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Jul 2021 14:28:03 +0300, Antoniu Miclaus wrote:
> Add device tree bindings for the ADRF6780 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> v2: remove `det-en` and `parity-en` from device tree
>  .../bindings/iio/frequency/adi,adrf6780.yaml  | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml:10:1: [warning] wrong indentation: expected 2 but found 0 (indentation)
./Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml:101:1: [warning] wrong indentation: expected 2 but found 0 (indentation)
./Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml:109:1: [warning] wrong indentation: expected 2 but found 0 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.example.dt.yaml: adrf6780@0: 'adi,parity-en' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1499502

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

