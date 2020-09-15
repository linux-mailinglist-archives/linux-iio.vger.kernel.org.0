Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4E26AD06
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIOTIU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:08:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41879 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgIOTH1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:07:27 -0400
Received: by mail-io1-f68.google.com with SMTP id z13so5333405iom.8;
        Tue, 15 Sep 2020 12:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2L/ffHc0y6kCEhEO5Yd+LktqdR1hQx9aZ0mkoI5X2K4=;
        b=A1d4m5YYMM0j7gzp/ih839htCBf+qzccrAyHsdvhTzwN6I4Nsw/hmM2oC7F6QtrxhM
         x7nU93xsRoiYAbahZl7ltWGbGWp8fglQWQ0y3IQD/6kD9fGFXb3NPQUEhjqf09CZsX+8
         pvO7/oHuxzDSL7dIH62F+RcJpSEkaDrRW5Tg+6fJzy0eaga3KwmOP5JXSuFsie9wuudQ
         RL8WGc3LgFztu/73xqr0udwHZawZo/8n2DQ7zjbU1LU/WuabiC9vVSbXh5akwehW6Ddo
         H+2iUBYaEyIOy3U+cL7cq1aRpKPhuAS/fCpm+WRvK5uroi7DIzGx62ESgnkFNvGmHsT/
         70Yw==
X-Gm-Message-State: AOAM531EDpN6mcXTRKePKE2YXn9duktg0+yVns8PzUhLBUeVFbVpNKzo
        8HSEv3JHxzq7M7KJb2kMQw==
X-Google-Smtp-Source: ABdhPJzxTKdRJbyeFL4CxtpfuBBrNNcyCIKIS9bPa1g+jzJTrNAu0PWThg4dHWfvD0EXi8uiVgmjIQ==
X-Received: by 2002:a05:6602:2e0e:: with SMTP id o14mr17120619iow.111.1600196846657;
        Tue, 15 Sep 2020 12:07:26 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j62sm8073362iof.53.2020.09.15.12.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:07:25 -0700 (PDT)
Received: (nullmailer pid 2323842 invoked by uid 1000);
        Tue, 15 Sep 2020 19:07:24 -0000
Date:   Tue, 15 Sep 2020 13:07:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v2 08/20] dt-bindings:iio:adc:nuvoton,npcm750-adc yaml
 conversion
Message-ID: <20200915190724.GA2323735@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-9-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-9-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:34 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Renamed the file to reflect the only compatible.
> Added #io-channel-cells to make it easier to support consumers of the
> ADC channels this device provides.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/iio/adc/nuvoton,npcm-adc.txt     | 26 --------
>  .../bindings/iio/adc/nuvoton,npcm750-adc.yaml | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
