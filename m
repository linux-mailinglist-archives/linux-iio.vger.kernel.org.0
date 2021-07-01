Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4F3B92C4
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhGAOG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 10:06:26 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:34785 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhGAOG0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 10:06:26 -0400
Received: by mail-io1-f50.google.com with SMTP id g22so7687615iom.1;
        Thu, 01 Jul 2021 07:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=SmBXJ9fHetqXtaZ7gjDn9p2NACbKWCG+T7Pvmo1erz4=;
        b=F/h4brM93Q4dSudqe92SP9u69hxlK7LKggMGYPHLb1aX/nmrQcJFR/5+FmQtZi3on0
         z6yZXtROQ0WNeglefA7ooBWzzaqMWUXzqcIQb3e1ESK4tbKeiYaATuWApD0DE5DQUX0L
         CJJd/XuPwxILW7+40EpeXdDMfYz+AMBrfo0AK9V42BQWInklTpzgWEN8sjjpfpwaYamD
         BtjQTGEL8pHDj/CTweJaNeXWMnMNfIx06tVcrOKTZsc2ZYJJ8Qp3cV2h1Y0d8UidTGbK
         DT9DIpw7+bWClNxr/l3g70k0kXU/jvzPAjsSq543D075ZkgBPMUfiFuyoVx6CahOg8BQ
         hg2g==
X-Gm-Message-State: AOAM531w+emcarDSYlOu7e+XI8dmAFCkAB5JnySHUDHws7qSWhUr6AOb
        jf7EQ0U9H9uSnmN8YsC36g==
X-Google-Smtp-Source: ABdhPJwfnI6olZAZZ6EN1RITBI2pL6d1o7qQWw48ciG943n3gVDOQnGTinSKHtu1eq3BGagIUsOS+A==
X-Received: by 2002:a5d:8154:: with SMTP id f20mr12736753ioo.89.1625148235459;
        Thu, 01 Jul 2021 07:03:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a15sm43559ilq.18.2021.07.01.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:03:54 -0700 (PDT)
Received: (nullmailer pid 2278698 invoked by uid 1000);
        Thu, 01 Jul 2021 14:02:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
In-Reply-To: <20210627163244.1090296-6-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org> <20210627163244.1090296-6-jic23@kernel.org>
Subject: Re: [PATCH 05/15] dt-bindings: iio: dac: ad5446: Add missing binding document
Date:   Thu, 01 Jul 2021 08:02:43 -0600
Message-Id: <1625148163.528787.2278697.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:34 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Binding is a little stricter than the Linux driver.
> 
> It requires vcc-supply to be present for devices that don't have
> an internal reference, whereas the driver just prints a message and
> carries on.  Given this means that it is impossible to establish
> a scaling of the output channel, let us make it required in the binding
> schema.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5446.yaml          | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/ti,dac7512.example.dt.yaml: dac@0: 'vcc-supply' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1497723

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

