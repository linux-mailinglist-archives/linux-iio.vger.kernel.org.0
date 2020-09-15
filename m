Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA64C26AD46
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgIOTOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:14:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39678 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgIOTNy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:13:54 -0400
Received: by mail-il1-f195.google.com with SMTP id s88so4094000ilb.6;
        Tue, 15 Sep 2020 12:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKyJ7xw7qKL5pA1FwuRtzJ0NNDkgskNvGzm/1t0z87o=;
        b=WzueKbeUFBFNQPwIAuJifvLfECuQlIExMRYFTMALGNAHkE1ruATeLMuuTMd38H1Svc
         Mwivac1sSqXHQY4ml9xxy4E2MR5CLuNRt6UTZ0Qw/rVeks/dacMYyLJBy39PtXQu3ylk
         wIh6SHGQrXtoO1IBRNADOuv17Eyu9SmHurD71NYxubTLg3/XsdbJshGigKV50TKRwFHi
         MvxKdBSPDJcmgXDL+iCW12lovq/xmyD9WHNVKLVOLc4kLXQHjwnQSrfP8g+FrvtuW3iQ
         9VqB88HgM9ya0Y0z12PtKkk1DpGy2iBsOSqh5VLrbeQ768b8SOkZgRMZl9yTwxDrCdj6
         bYLg==
X-Gm-Message-State: AOAM5336E9wCGTRSXGUaX56CVjl6y6G+PmRLMj0EfNV/V5qQnGBDafJa
        0/rpGmFIGyoCGnSnuMzwBw==
X-Google-Smtp-Source: ABdhPJw/IxoeHnbvmeGrqNcboHPxI7gzqLDjtlCKh+YQYRqhfrJOx6WxY/M/4Hlr0LagYKa9MbvFew==
X-Received: by 2002:a92:999c:: with SMTP id t28mr17277617ilk.230.1600197233192;
        Tue, 15 Sep 2020 12:13:53 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p86sm1791796ilb.5.2020.09.15.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:13:52 -0700 (PDT)
Received: (nullmailer pid 2334617 invoked by uid 1000);
        Tue, 15 Sep 2020 19:13:50 -0000
Date:   Tue, 15 Sep 2020 13:13:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 14/20] dt-bindings:iio:adc:adi,ad7949 yaml conversion
Message-ID: <20200915191350.GA2334565@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-15-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-15-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:40 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple SPI driver. I've added the #io-channel-cells
> as an optional parameter to allow use of this device as a provider
> of ADC capabilities to other devices.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> ---
>  .../devicetree/bindings/iio/adc/ad7949.txt    | 16 ------
>  .../bindings/iio/adc/adi,ad7949.yaml          | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
