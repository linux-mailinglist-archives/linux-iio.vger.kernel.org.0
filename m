Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C145221629
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGOUZR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 16:25:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34780 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGOUZR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 16:25:17 -0400
Received: by mail-io1-f66.google.com with SMTP id q74so3700143iod.1;
        Wed, 15 Jul 2020 13:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pgPelXJC023gvebrydz3J6qpaoXYuRrLQ8hxrPLPGj4=;
        b=MW964hpfQri9Hv/U9iSA8WD2iEpBha/r6nk55dGQTEXkgLJGMcG4tAGex/oSoKdvaf
         aRm1d/NOcEjgRkvmPjrLYKaYDb3bfHdtMNzxfPp1EbFnzAXG7oj2W91m08YRW2IZdwjg
         IvkNYRpA3zHo/xPpf2Jg1fCg8Qs4Fsw65Wp4VHy7qvC0R547xOFUdWeAEfIvdQnGslMs
         uQRw8WB2jFpbfCkqELXSKFX5112UudqgH9jJw94ERGK+6wBo0K4q9HWZaplrDr5220el
         XfasF8njZtLaHo2ucVuDDAAundDoPH83O4Wgw8CwBcH7vxOMG8Own8JS0tEnnnflDu5b
         8EPw==
X-Gm-Message-State: AOAM530ep8QZ9VQLPKfY0QpMmU1MWKNT7p+hzat5b9E15m0wKTPCXlzX
        /n2uo9yYWtHCjx6Lmu5NRA==
X-Google-Smtp-Source: ABdhPJyLzIPEXAng/S28+/rIhjKFMOKYRIkcS5fnGhvWXLleFbk9avmueHrgkskrz/V4hyuNVo8Ozw==
X-Received: by 2002:a05:6638:2493:: with SMTP id x19mr1297511jat.53.1594844716503;
        Wed, 15 Jul 2020 13:25:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z9sm1593748ilz.45.2020.07.15.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:25:15 -0700 (PDT)
Received: (nullmailer pid 759949 invoked by uid 1000);
        Wed, 15 Jul 2020 20:25:14 -0000
Date:   Wed, 15 Jul 2020 14:25:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: kionix,kxsd9 yaml conversion.
Message-ID: <20200715202514.GA759901@bogus>
References: <20200628203205.49915-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628203205.49915-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 21:32:05 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Convert and flesh out a bit the binding docs for this simple 3 axis
> accelerometer.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> Sorry, typo in iio mailing list in first try at sending this out.
> 
> .../bindings/iio/accel/kionix,kxsd9.txt       | 22 -------
>  .../bindings/iio/accel/kionix,kxsd9.yaml      | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
