Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF445E27A
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 22:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbhKYVbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 16:31:36 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41819 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhKYV3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 16:29:35 -0500
Received: by mail-oi1-f169.google.com with SMTP id u74so14939887oie.8;
        Thu, 25 Nov 2021 13:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=B6wyCDAmUSCibSY1414flm92lyIj8FXeL6fX67zL5Jw=;
        b=F0cWaLGT3UOVMMl0DxupnHSTOlb3Q2TJvcsukldsEwOzzLhH+7+s2L0QBXacsjQzB+
         bpnHPIU48dKbmaseG04tMbJxcOOI1SvV8O8GRInknjNfH9jqkxNQ6w+lHC324LsZx6GR
         hauZJEPQ32KRIPFiGOVeLFTy3q8aEmdObFOmVCW0mLT977m0hV2JkMTKqf94RcEUWxNJ
         LAq2s4Q0qg5HTowVbK6ssOJvW2+LwkVErUC4azsI3f4QTR945Czxil4SPcBkOFwAOOka
         T75kpmht6yLzmIanl1rgkP9h5UcjCutRgbP4WYtYi5HISUObiyK2lL+Wmbaaq3emTAlr
         gGIA==
X-Gm-Message-State: AOAM531edzLSNZWXwfIRuIj5wiy9DokmZNyN9MAQ+rtnXUVmcOQz/Sdn
        eMalx8w8z4qc2s+Q4XgRKI/c6iNcuQ==
X-Google-Smtp-Source: ABdhPJy2R9t+40EAgpr2S6XGtSWSnhEPJsptRSXK8jQhEK8v2yhDQATbssIRHRP9tz+jMibWZPuxew==
X-Received: by 2002:aca:b843:: with SMTP id i64mr18863323oif.109.1637875583352;
        Thu, 25 Nov 2021 13:26:23 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id be12sm938107oib.50.2021.11.25.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:26:22 -0800 (PST)
Received: (nullmailer pid 2858317 invoked by uid 1000);
        Thu, 25 Nov 2021 21:26:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, cosmin.tanislav@analog.com,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20211125131422.50657-3-demonsingur@gmail.com>
References: <20211125131422.50657-1-demonsingur@gmail.com> <20211125131422.50657-3-demonsingur@gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: add AD74413R
Date:   Thu, 25 Nov 2021 14:26:02 -0700
Message-Id: <1637875562.336876.2858316.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Nov 2021 15:14:21 +0200, Cosmin Tanislav wrote:
> The AD74412R and AD74413R are quad-channel software configurable input/output
> solutions for building and process control applications. They contain
> functionality for analog output, analog input, digital input, resistance
> temperature detector, and thermocouple measurements integrated
> into a single chip solution with an SPI interface.
> The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
> four configurable input/output channels and a suite of diagnostic functions.
> The AD74413R differentiates itself from the AD74412R by being HART-compatible.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/addac/adi,ad74413r.yaml      | 153 ++++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dts:23.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1559714

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

