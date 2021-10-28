Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073BE43E0ED
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJ1M1f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 08:27:35 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45014 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhJ1M1f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 08:27:35 -0400
Received: by mail-ot1-f45.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so2433188otj.11;
        Thu, 28 Oct 2021 05:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6NJL/epdKwPjRr+Azrw8XvMRYX/QOKMs3w7KqwedYLI=;
        b=Uo2zqrWzsw0SepZbQPFwthTExaFFee0QwnPLJjtK2PtrPceGswWvDNf5L8I8gsiSBm
         Xal60CZkQByfvGdJQAT4Ch/PbuLPjtz3HzWD5q+5qCdD09ZXuJTRQ+fpJ/njzYzPf3YP
         ukgE1cUPXH7bGCRe9PNzajcWXnIIV+4thee31uerYQoM8BMUm/ibSVcyCUInSMLws3U2
         1dbRsE8/cZaISWusKv0YTdmn1ij+oKeDOYavKaVW/h8CLy9z+h7LdZqkauwxzPfkOori
         iqDOUlApo7NYLUcOQ9eYsn9mTxe+LFJGOp3/Vh0ssFtwGj8PiYRakIedIHcxx/PU/ytc
         YTlQ==
X-Gm-Message-State: AOAM530ClHgtNk9CG4Pf+00RVZeHKN4YK0z9i0xSrasISENnoCk/sT2R
        aRTnvrmC1mXXSwHlyLB9TN1zEONMoA==
X-Google-Smtp-Source: ABdhPJwSevZxg+e9IYslJ09TcROXr7fMOjeHx07dXdyrDspyDA98bHNjgkkryT6U61ynE1oAk4Zrbw==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr3098287otj.191.1635423907966;
        Thu, 28 Oct 2021 05:25:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 16sm1043080oty.20.2021.10.28.05.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 05:25:07 -0700 (PDT)
Received: (nullmailer pid 3934876 invoked by uid 1000);
        Thu, 28 Oct 2021 12:25:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, lars@metafoo.de,
        matt.ranostay@konsulko.com, Andrea Merello <andrea.merello@iit.it>,
        devicetree@vger.kernel.org, jacopo@jmondi.org,
        mchehab+huawei@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org, ardeleanalex@gmail.com
In-Reply-To: <20211028101840.24632-9-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com> <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-9-andrea.merello@gmail.com>
Subject: Re: [v2 08/10] dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
Date:   Thu, 28 Oct 2021 07:25:06 -0500
Message-Id: <1635423906.378411.3934875.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:38 +0200, Andrea Merello wrote:
> Introduce new documentation file for the Bosch BNO055 IMU
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml:20:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
./Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml:37:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/imu/bosch,bno055.yaml#
Error: Documentation/devicetree/bindings/iio/imu/bosch,bno055.example.dts:53.13-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/iio/imu/bosch,bno055.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1547408

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

