Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8480B35A13D
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhDIOh3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:37:29 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34566 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIOh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:37:29 -0400
Received: by mail-oi1-f179.google.com with SMTP id k18so1065695oik.1;
        Fri, 09 Apr 2021 07:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ks4Ks6gtPzqkxui8NxmdiZQeRSOGRF5OfHX/GCB9fAo=;
        b=Yi6QGx6JnqHZbpbiHfogtKwRny/taIUkEz1zhzsNOdzs6GC8mFj4ggVn9uxhzNLB0Y
         iW8gDql/1r5bDTK9pDXtcuTZgnVqEux5Bb5by+Bm90GfZzq7crKk84RWMWtqHW/XE2t4
         g8hZmslkiZVEAHQI2pD8TN3422X0iTkh9sIWMurhyV2y/BfvUJkSAg4bo4BeJHxrfsD9
         2yiYOwEWGrdLSDogopQcu4dnMdV7R4CjVLhISv9Zc9MSZXPxsK7oP52Ba/tejuGKAaJl
         /p/R1KgdfFxWLR0hzaJjdSCF80nMKyN6TwdC9iTCgM24zvOWAAWeCdH0KZ/Baet7y+ho
         3J/A==
X-Gm-Message-State: AOAM531kKgy2hepVqoyjaEHqeB924bOrBUiS1bLiF6S06jSxUxxmboAY
        iUVTjRIjODSaLAEx2/OTFA==
X-Google-Smtp-Source: ABdhPJwFW47ONTuUTpNDcOSa6Udlx0pmTKeQuowG8cK24l2GxrSGa4hbMUYZugi0/HtuFKQOEa/CHw==
X-Received: by 2002:aca:1218:: with SMTP id 24mr10472146ois.75.1617979034507;
        Fri, 09 Apr 2021 07:37:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t203sm553174oig.2.2021.04.09.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:37:13 -0700 (PDT)
Received: (nullmailer pid 3614445 invoked by uid 1000);
        Fri, 09 Apr 2021 14:37:12 -0000
Date:   Fri, 9 Apr 2021 09:37:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings:iio:adc:adi,ad7298 document bindings
Message-ID: <20210409143712.GA3614371@robh.at.kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
 <20210401174112.320497-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174112.320497-7-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 18:41:12 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The device has a tsens-busy pin, but it's both fiddly and currently
> ignored by the Linux driver.  Given it's not clear whether the binding
> should be an interrupt, or a GPIO I have left that out for now.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7298.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
