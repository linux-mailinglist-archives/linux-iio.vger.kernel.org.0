Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305C42694B6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgINSVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 14:21:54 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39545 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgINSVf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 14:21:35 -0400
Received: by mail-il1-f193.google.com with SMTP id s88so496231ilb.6;
        Mon, 14 Sep 2020 11:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PFZG5zCl+nbcnUAIeX7otp7vp9aNzfGw9/wGWmQANFs=;
        b=STOc723urV+J4Fxt3cSOF5DyZKufoP4nEhZnakIOho9cnjzMDjsJKY37MtgXl7iTcV
         D+jcyN+EVpZogxj8jfJpVmI5vuckxaTPdfYoecFAcpncn+vrGMqavYNQe2aTy5ZwbWBL
         PxsNQzEuB0uIG3h1Po47fo2Io/YychRkSiXcBfc/aUDqYRqC83zGAkdiUz/LXD69J0eC
         DS+c1QpKmR6hDSsgxKXrq0Nzid+70AHjCR4Ol5DUUlxxt68zCn1W8jRxxLZCXtITVH1a
         4Vd71WMMvTnWsqEkXAZTu8ult3Z+lHBFTbXIi+9fIqAyc5HwVENp2MSF4W+hSBa/p5HF
         KdEQ==
X-Gm-Message-State: AOAM531STf4hQYKley6mot0hr3fNrUSd0GITw94v1rc9QQW58hpUtZpE
        2mc9fbnUwVEOS7DUwUe8uUH7FlGfItVX
X-Google-Smtp-Source: ABdhPJxAgsl+yxZ8v9ZEeOHkBWuwKDir8WZA+EQTe4Gz6NbyOfWE8LMSZDx3/fPHogQaEiDZDTjO0g==
X-Received: by 2002:a92:c847:: with SMTP id b7mr1676011ilq.35.1600107694529;
        Mon, 14 Sep 2020 11:21:34 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u18sm7446820iln.78.2020.09.14.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:21:34 -0700 (PDT)
Received: (nullmailer pid 4180574 invoked by uid 1000);
        Mon, 14 Sep 2020 18:21:31 -0000
Date:   Mon, 14 Sep 2020 12:21:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, David Lechner <david@lechnology.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ti,ads7950 binding
 conversion
Message-ID: <20200914182131.GA4180513@bogus>
References: <20200830161154.3201-1-jic23@kernel.org>
 <20200830161154.3201-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830161154.3201-3-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Aug 2020 17:11:54 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Conversion from txt to yaml.  The binding documents that
> as not all boards will make use of the ADC channels via a consumer
> driver.  It does no harm however, so we will leave it as required.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Lechner <david@lechnology.com>
> ---
> 
> Changes:
> * Fix patch description to make sense.
> * Fix a supplies instead of supply.
> * Add maximum value for spi-bus-frequency
> 
>  .../bindings/iio/adc/ti,ads7950.yaml          | 65 +++++++++++++++++++
>  .../bindings/iio/adc/ti-ads7950.txt           | 23 -------
>  2 files changed, 65 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
