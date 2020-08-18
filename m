Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE6247C38
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRCct (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:32:49 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34545 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRCcr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:32:47 -0400
Received: by mail-il1-f194.google.com with SMTP id t4so16350173iln.1;
        Mon, 17 Aug 2020 19:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QvpHeI0WHZgPpWWWnEcIF4iG2n5WGQmzx2y7VZKLvTU=;
        b=qPx+07UB9Lcnn8cMwqHhrIK2gimOkeinfDoaunYkvqT4D6MGsCXmp99hDocKlAI2sG
         UXjto9t163emBUACYs6zBBeLNV4Z4ePVQkqc+DkWxCNYsbF7QS21k74sfTDcyMvB9ZaF
         Xog8V0GkksU0fGcC0fHjaaIpbAj61U3m0yAzjybj3SBrYXW1EtAsHSkKOCvp6eizxzrP
         d1BDJKaXh5n5bM99xR5PFFcdEZNRuUEWU0yOVfPtBULu6kaKV8EKJEqBgsTeZgoUFfFx
         g2v+b3ShLiYVO+bspk/Ei2JZivpa9+M+FSlHz276xKBBsfxmBXnyqoWEceZOpNYtrcfu
         Xnhw==
X-Gm-Message-State: AOAM531v0HwBU51lFRSPl0K/AIUv1clrillz/75otEbTNtDucc3A9r45
        gPD/CWzvXydmZXUg+KaPOl77IaRrWQ==
X-Google-Smtp-Source: ABdhPJw2iRX+NCj5otrYdEvehO5LBWinPR96UcoEICBXqiF3MoDoBbe96tFN8kkMdYiY+px8EED6aQ==
X-Received: by 2002:a05:6e02:c71:: with SMTP id f17mr15431977ilj.98.1597717966095;
        Mon, 17 Aug 2020 19:32:46 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id n5sm1086243ilj.43.2020.08.17.19.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:32:45 -0700 (PDT)
Received: (nullmailer pid 2176277 invoked by uid 1000);
        Tue, 18 Aug 2020 02:32:43 -0000
Date:   Mon, 17 Aug 2020 20:32:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Phil Reid <preid@electromag.com.au>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/13] dt-bindings: iio: adc: ti,tlc4541 binding
 conversion
Message-ID: <20200818023243.GA2176224@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-14-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-14-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:53 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding so easy to convert.
> Dropped the stated value of maximum spi bus frequency as it does
> not seem to correspond to the datasheet.  The value of 200kHz
> is the max sampling frequency of the ADC, not the clock frequency of
> the SPI bus.
> 
> Added #io-channel-cells to allow use as a provider of channels to
> other devices via the consumer binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phil Reid <preid@electromag.com.au>
> ---
>  .../bindings/iio/adc/ti,tlc4541.yaml          | 52 +++++++++++++++++++
>  .../bindings/iio/adc/ti-tlc4541.txt           | 17 ------
>  2 files changed, 52 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
