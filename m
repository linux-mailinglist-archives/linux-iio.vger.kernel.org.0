Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAA22B891
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgGWVWe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 17:22:34 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41437 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWVWd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 17:22:33 -0400
Received: by mail-il1-f196.google.com with SMTP id q3so5574967ilt.8;
        Thu, 23 Jul 2020 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJ57T581vc5PeC3dDJScbWKVMa1D4jQ/zhnzNifzw9Q=;
        b=tArhQ5AASqcaPSf9cNlS6hytKA6mI7u3XpOn0pKi8Rtl+xhToGBd/W6eFcZeYM8u84
         Ofg6h1LNvQEdUg/n9Oqwar1JQTxotBoIJ7tsBYK9Cpok6AfZndRpAl6wqoOm3I9AyTP0
         FPCmFLWXhOKzzz+o//unVPv0oqviQInVu5FfDUhhMn21dSAowqMNx47vwDnzYwzjI2ka
         HUFGJC1isZg0YxW1j5Ev9Zj0T0Ij9R9Ib3huHfWloqn4J65E6MJeIBgcT6otY/qgdMKR
         CERhxHbv/cREhDFCr5eRKvC8E5b2WUGQitNgDRJMPUVEjRM7rn8YCc1DArbo40srqkvF
         O+PA==
X-Gm-Message-State: AOAM531oYqFJRUiKmaPzfyrVBiFoDOMSKiRWHIMRGsRhZiwUKd+kiraN
        +m7NyCOqKgXdxv0+kBraqw==
X-Google-Smtp-Source: ABdhPJwzC8OH3Mz3FyBavKzPCckG/RRrF9p2NAjnBrtkJ8Q8NBT2pnlr1Ur1wfpwZpiNTnMEhHHaAw==
X-Received: by 2002:a92:da51:: with SMTP id p17mr7030616ilq.44.1595539353289;
        Thu, 23 Jul 2020 14:22:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f2sm2082536ioc.52.2020.07.23.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:22:32 -0700 (PDT)
Received: (nullmailer pid 881539 invoked by uid 1000);
        Thu, 23 Jul 2020 21:22:31 -0000
Date:   Thu, 23 Jul 2020 15:22:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: maxim,max9611 yaml conversions
Message-ID: <20200723212231.GA881485@bogus>
References: <20200722171224.989138-1-jic23@kernel.org>
 <20200722171224.989138-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722171224.989138-4-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 18:12:24 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight forward conversion of this binding for this
> current sense amplifier and ADC.
> 
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/adc/max9611.txt   | 27 ----------
>  .../bindings/iio/adc/maxim,max9611.yaml       | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 27 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
