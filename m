Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74941247C2A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRC3D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:29:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44330 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRC3B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:29:01 -0400
Received: by mail-io1-f66.google.com with SMTP id v6so19611686iow.11;
        Mon, 17 Aug 2020 19:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOPGCZNMbLcnvdYWcfK6GCF8gWrkDTrkpCZJdkRcfKc=;
        b=mhX5qrLgeM1gOFW0sJuKlbOUonpxmPj5wBzgd+pnHuvEn+q/H11qxhOWkDWSUxwTAL
         YGzmC3BLLJAzYKUAZobWVE3OM+g9DyQ3zqNZ54RHg8oSBdiq6CtRwILS3ThdRVDHCTz6
         EXiMAl6i3eYPCjhZICH6jmj/i3+0Y8/RSRPdijA1hIRsBAqS9nP7fiAsMBWMhgwrt3KP
         kHm/g6ntRAKdgLxhp+EWyliiVRPVLTrRK8OnGSKfrKnsqMFckn6JaouxO2FgabfxUyOp
         rW8FSsnAzwBuC7UeKudpc6jwQaI1nQjGH/1uxUfYqx7CTYh0O4oBE+JMGWvm/DrpaCCS
         717g==
X-Gm-Message-State: AOAM531Tk3LsuLl+7jJ/vvaHfOhELwkqxRMUQu77Lb51IR10U4/QMKnz
        fZ9rhZ5TEluCiBwFG9UCLA==
X-Google-Smtp-Source: ABdhPJwrNg5vAaqjlbFMABScdEtrRIR1qvk+8bQOHKwfa4SLCAMhJ3NQx56SJ/nNy4YbROZJjRtJhw==
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr14973585iom.27.1597717740341;
        Mon, 17 Aug 2020 19:29:00 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q200sm10333700iod.5.2020.08.17.19.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:28:59 -0700 (PDT)
Received: (nullmailer pid 2169650 invoked by uid 1000);
        Tue, 18 Aug 2020 02:28:57 -0000
Date:   Mon, 17 Aug 2020 20:28:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH 05/13] dt-bindings: iio: adc: ti,adc161s626 yaml
 conversion.
Message-ID: <20200818022857.GA2169563@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-6-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:45 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion for this ADC driver.  Note that I haven't put
> limits on the spi-max-sampling-frequency because the adc161s626
> doesn't state one clearly defined value.
> 
> Added the #io-channel-cells property to allow for consumers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../bindings/iio/adc/ti,adc161s626.yaml       | 51 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc161s626.txt        | 18 -------
>  2 files changed, 51 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
