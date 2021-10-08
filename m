Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B67427184
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhJHTu6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 15:50:58 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:47043 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhJHTuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 15:50:54 -0400
Received: by mail-oi1-f173.google.com with SMTP id o204so6952129oih.13;
        Fri, 08 Oct 2021 12:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vQlwE9ycn9wLh/6pag8Ne3NJKLGdbIkxyQ1wTi2MfwE=;
        b=3OWP8dDHGetaQHKmbnAv8Xh0tFmQnfPb2hV/JU62HYa/9pl5Xmx1s/ka0P3XtfFPpJ
         OZLZYwrU8E/5pdU+EDDpqFGEebpM5CMA7gs7HhUOM5jlOcFHfqIfZMss/Czn91B5HaBS
         5mhK5DLWPOBBrHwQZuDXMTjvCd5kGEwtD6O+3YYSREWCgBqJL2IcYzP1adTl8fmDGXUt
         hkkskrMQtFJGBPL1ut6yN3NQ6IzacZb73bIp07QnJXUYCzBfkUl31uHyf0Ji75tNgcbF
         5dL15T4HCezIsd1sDy9rqyE3oNXnvjLIJUo0SG/fDory2VL1PpDEcOBfGFATOq1ntrk6
         desw==
X-Gm-Message-State: AOAM531hfxMqCsPC2+noIND35dVG0U0YwkB95EIs+17JP4XrPZ73972W
        o0zg6b7pOiIINLbF2eXfFuWJTTaAVw==
X-Google-Smtp-Source: ABdhPJykVd0pO8jMCYkraX/blrSwyBjg5xWKqQLyCfun6KEtBi0dqxVIC5Wxa2tF9WgIpDDv5LjRjg==
X-Received: by 2002:aca:5886:: with SMTP id m128mr17803586oib.63.1633722538467;
        Fri, 08 Oct 2021 12:48:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n18sm84569oig.16.2021.10.08.12.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:48:57 -0700 (PDT)
Received: (nullmailer pid 3211950 invoked by uid 1000);
        Fri, 08 Oct 2021 19:48:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     andrei.drimbarean@analog.com
Cc:     linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
        devicetree@vger.kernel.org, fazilyildiran@gmail.com,
        lars@metafoo.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org
In-Reply-To: <20211008112747.79969-2-andrei.drimbarean@analog.com>
References: <20211008112747.79969-1-andrei.drimbarean@analog.com> <20211008112747.79969-2-andrei.drimbarean@analog.com>
Subject: Re: [PATCH 1/2] dt-bindings: add adpd188 schema
Date:   Fri, 08 Oct 2021 14:48:56 -0500
Message-Id: <1633722536.852421.3211949.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 08 Oct 2021 14:27:46 +0300, andrei.drimbarean@analog.com wrote:
> From: Andrei Drimbarean <andrei.drimbarean@analog.com>
> 
> Signed-off-by: Andrei Drimbarean <andrei.drimbarean@analog.com>
> ---
>  .../bindings/iio/light/adi,adpd188.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/adi,adpd188.example.dt.yaml: adpd188@64: adi,no-of-devices: missing size tag in [[8]]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1538303

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

