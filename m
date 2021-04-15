Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD435360EF1
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhDOP0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:26:16 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39704 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhDOP0Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:26:16 -0400
Received: by mail-ot1-f45.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso18165571otv.6;
        Thu, 15 Apr 2021 08:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=B2sYkxahpCNkv1JbphK+OPkP2mwkf/VDQDlDmyO/jzw=;
        b=Jsqy3y8FcWG6JOWAu6b1z2VaLbq/Zo2Hbv1kqZd4q4PKmwQGn2SxzLkiQ7muuOMlEk
         I/bgKAZfIC+JP3lzEq+5nwzdLTc1jHNIshIL6VoF7bsj4QnSHEbbdpvwoDT1SMML6pfU
         wz7rald91D/Idl7/n3zDH+KtdmM9lPYouvnZGjhnA5CuZU/pgceWKK96JCVr5wHx7ILD
         TeJCaiRf02k1E53U49CW79oj3LeZLEBscCp9wes6ZvQk5LF8RGGQTOkN/C9HlbEDFftt
         SmET/1II1pdCkIdIOkK7m34NofWZMEOD81zLfP05M0Gwi216DKRjmoxxLIZWn4VbbLbQ
         8UZQ==
X-Gm-Message-State: AOAM530S9Cnv7G1/mNX5ivZKScqY7tWrfpJGpF/FBwC00fE+bhbWnGio
        ee2HmTW1fkwn1eyd2wFjsg==
X-Google-Smtp-Source: ABdhPJzXTvy21qYh+2dGc+mmE2oZ+lSK/4pBkZqvrEgQBel1C/0u02vw4aijHu3GKoqyQQhvaRzMaQ==
X-Received: by 2002:a9d:6c2:: with SMTP id 60mr3188771otx.89.1618500353106;
        Thu, 15 Apr 2021 08:25:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h8sm679328oib.55.2021.04.15.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:25:51 -0700 (PDT)
Received: (nullmailer pid 1432988 invoked by uid 1000);
        Thu, 15 Apr 2021 15:25:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
In-Reply-To: <20210415114614.1071928-2-sean@geanix.com>
References: <20210415114614.1071928-1-sean@geanix.com> <20210415114614.1071928-2-sean@geanix.com>
Subject: Re: [RFC PATCH 2/2] dt-bindings: iio: accel: fxls8962af: add bindings
Date:   Thu, 15 Apr 2021 10:25:50 -0500
Message-Id: <1618500350.743985.1432987.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Apr 2021 13:46:14 +0200, Sean Nyekjaer wrote:
> Add devicetree binding for the NXP FXLS8962AF/FXLS8962AF
> accelerometer sensor.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  .../bindings/iio/accel/nxp,fxls8962af.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.example.dts:25.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1466588

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

