Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8526AD5C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIOTTV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:19:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46029 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgIOTRj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:17:39 -0400
Received: by mail-io1-f68.google.com with SMTP id y74so5322674iof.12;
        Tue, 15 Sep 2020 12:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QE36zNLRX22VIj1K82uy1D0BVbbLROwx7qt6Mkuiix4=;
        b=GbssekQa+bDd3bDFCOJWnmYUs2EZL4Cd1WTJqTl0i2iRAHL4C1DkeBqLhRVezwVhwi
         kMj9H3JdZ3ynMEZI8ruCEKL3uDOo9sebZgBegp5Rb0NNelbDX3eiPfG1CZdtdtHPVKyB
         JcAg8xK1z/iKjoqDZCB9Wj97VO0vttP7ltFQAPFEY2mlvtOEuDmLOOqdXYcH9jib0/HB
         9aWszyD3ON25xYxhXJsM9kaIud8ou3FOkPtLVjVx7qO+16XFebt8sRRITTC+ELqHnFKC
         jS1mhV5Y6rqpAwtNlAbR28jbceSZJHARLcWchbvf0SeDP+L+M78NgmQUI80g4OaRXqOR
         Na/Q==
X-Gm-Message-State: AOAM533CGpGeJ+sLcCkpTYjXCK+RPgZgwMKmskBHD+rvCNA2+RSGCXAL
        4NgRy6SSGFCpkpF/Nj7Elw==
X-Google-Smtp-Source: ABdhPJzlyIGmIPA8IXdC9HyTtsqjdpGXVnNpq2opwSerWKo71GJzRPjbzbqaNFw77wLa41jy7ktXig==
X-Received: by 2002:a6b:8d57:: with SMTP id p84mr16366836iod.206.1600197420930;
        Tue, 15 Sep 2020 12:17:00 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y10sm1938511ilq.39.2020.09.15.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:17:00 -0700 (PDT)
Received: (nullmailer pid 2339801 invoked by uid 1000);
        Tue, 15 Sep 2020 19:16:58 -0000
Date:   Tue, 15 Sep 2020 13:16:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Dirk Eibach <eibach@gdsys.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 16/20] dt-bindings:iio:adc:ti,ads1015 yaml conversion
Message-ID: <20200915191658.GA2339714@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-17-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-17-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:42 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding was moved over from hwmon some time ago so is a bit
> unusual in terms of IIO bindings.  However, conversion was fairly
> straight forwards.
> 
> I've listed both Dirk (who think wrote original binding) and Daniel
> who added the IIO driver for this device.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dirk Eibach <eibach@gdsys.de>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/iio/adc/ads1015.txt   |  73 -----------
>  .../bindings/iio/adc/ti,ads1015.yaml          | 113 ++++++++++++++++++
>  2 files changed, 113 insertions(+), 73 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
