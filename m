Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46C7247C1E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRCYz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:24:55 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37334 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRCYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:24:54 -0400
Received: by mail-il1-f195.google.com with SMTP id p13so16324991ilh.4;
        Mon, 17 Aug 2020 19:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bc8w+auDtnGD/WQvB7JwiCS9B8ZlaMpaRSsJSr2PmIA=;
        b=s8VSBuYcEMQwAARhTrSlWJZ8qVJy7vLHiysfHQkfw1jNwu1qT1N7JLKChrd3ONfVAa
         6fc82PX/bZuT7Zxl9RJx9IwUfjrN4LM6jwWzklqq5HLJf+GUgzMm53Rewldhss4lliDs
         neSlBbdN74icyOadBW9zGpu24J+KZVuDtP3XE8gCELW6KqrR6k+O5OjIpMe5xJkwIqTn
         G/z8rNeuOfoHbV0jmuesDO+EJTst593kf8HajY/xQNCgV3mrbWbW+iJAeccfPpweOpbE
         SyRFixlaT2rjwmtNQEexKJ09pr2Ho2eczsmYCD+1dVaFJFw0lvXR0AS6DeSUYTJ7Ds1W
         ogVg==
X-Gm-Message-State: AOAM530bQOzInbRUKeKwAT8OqpI0los4eybv2RExAhxec+YAP2SfqevE
        Nc9qLo3LgNe4YxSo+C6rzg==
X-Google-Smtp-Source: ABdhPJyZj3jx2PAZHK5AtK7nB1NrMd+1OpOSli5NYFFRX9JrqYG9Ge2WKv37KxMGfAOxIdM/ygocDA==
X-Received: by 2002:a92:8418:: with SMTP id l24mr16347894ild.201.1597717493824;
        Mon, 17 Aug 2020 19:24:53 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id o11sm9999564iom.25.2020.08.17.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:24:53 -0700 (PDT)
Received: (nullmailer pid 2163039 invoked by uid 1000);
        Tue, 18 Aug 2020 02:24:51 -0000
Date:   Mon, 17 Aug 2020 20:24:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oskar Andero <oskar.andero@gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: iio: adc: microchip,mcp3201 yaml
 conversion.
Message-ID: <20200818022451.GA2158889@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 09, 2020 at 12:17:41PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Drops the deprecated compatibles without the vendor name.
> Whilst the driver continues to support these for old dt blobs,
> any dt bindings that are actuallly verified against this document should
> be fixed to add the vendor name.
> 
> Enforces rule that spi-cpol == spi-cpha.  Is there a cleaner way to
> do this?

dependencies:
  spi-cpol: [ spi-cpha ]
  spi-cpha: [ spi-cpol ]

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Added the #io-channel-cells property to allow for consumers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Oskar Andero <oskar.andero@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/mcp320x.txt   | 57 ------------
>  .../bindings/iio/adc/microchip,mcp3201.yaml   | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 57 deletions(-)
