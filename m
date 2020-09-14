Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4C2694B0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgINSVY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 14:21:24 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43458 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINSVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 14:21:03 -0400
Received: by mail-il1-f195.google.com with SMTP id a19so460618ilq.10;
        Mon, 14 Sep 2020 11:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yt4aF338+IDlGkz9vTAwOM31QoGXEFuohSDhrPmbMY0=;
        b=FxpyB1u0+Lo2RWMrna9+f5JwEUoVa9s1ng9tGMO1JnRUI2xB2vlxJxLGZMbFTG0/pd
         xkczgoNyFLfbw0izRZ6l0GreGkb+5Hh+4efdnCx9zV37WlCxXFGVl0WfsvPN3Xco9oqV
         iMrorR0RYk2z249G9AYjT6J/rjTN0w8yTy0i2IgEeRaym90XAfNw1QIRORVSOR9EhaEp
         UxxNvsjaVWBRj9y2eRpTVaIj/0/RQTkxMVHYwt+aOWx4pKRtSZgfHfJVbaNTh5PFkMrb
         V65D9NjzN3u9UlrOq8o7OQ5cQ1vhazVK5mRwkZRbM6LR7pAjjjG9QL/jP5ECIfDhDmLh
         a7Tg==
X-Gm-Message-State: AOAM531xf2qSVIKgANQX3egNCAyxUSy2hnsvQ+8MCuSFWuLeTwJFstWs
        iok4uFxQotInA5Ds/5wnsQ==
X-Google-Smtp-Source: ABdhPJyH7Ff61SRSI6v3UfZyX6KkxY3sv/sS5tPqHBDB56p5GyDPXNrAef7Lr78XWqgPaqg2IfCKvg==
X-Received: by 2002:a92:1e0d:: with SMTP id e13mr12855265ile.66.1600107662197;
        Mon, 14 Sep 2020 11:21:02 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k1sm7300846ilq.59.2020.09.14.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:21:01 -0700 (PDT)
Received: (nullmailer pid 4179623 invoked by uid 1000);
        Mon, 14 Sep 2020 18:20:59 -0000
Date:   Mon, 14 Sep 2020 12:20:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,adc12138 yaml
 conversion.
Message-ID: <20200914182059.GA4179593@bogus>
References: <20200830161154.3201-1-jic23@kernel.org>
 <20200830161154.3201-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830161154.3201-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Aug 2020 17:11:53 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding conversion from txt to yaml.
> Only addition was #io-channel-cells to allow for potential consumers
> of the channels on this device.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> 
> Changes:
> * Fix missing include.
> * Fix typo in one of the supplies.
> * Fix spacing wrt to brackets.
> 
>  .../bindings/iio/adc/ti,adc12138.yaml         | 86 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
>  2 files changed, 86 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
