Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBC26ADCF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgIOTmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:42:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44038 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIOTPN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:15:13 -0400
Received: by mail-io1-f66.google.com with SMTP id g128so5328773iof.11;
        Tue, 15 Sep 2020 12:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FM7LE2LHDCWNqLopHxLuvP6gQ42SfuuOFqZuFdFeXVs=;
        b=ED+KbHWimWrxtpP1+AM8zIlR3kxUG70S61+6FYWKqlNJ64IjJfq2f2PAVsphvenXgD
         Wd1/RJFyrPCYtiauqqqdb4ycPS64XyR5ulvvbUgPGFWJwTEEZJaFibkgRu1CueKkHti7
         VoArknTEM5Gzv/PVqQQ8aM+9uMdf0ZMng6RWbd3PnsAySLg09tl13ZrO5nhWFqLk9Fm6
         iMz9+niK2lT72dg8C7COmnlXWW4Vtzcv0x5eIo4vEG0i/2971PwRO0XSnHelMYmyfI49
         ylHAsvjBVbveqe/pivPQMwpZ5gXsm6WKVZ176doxedzPKPyyWCdgZDvUm5fP/jaB6DRY
         dFcQ==
X-Gm-Message-State: AOAM533LoJyvUGmAuk15+rKOrTAlZpaHxiZGp2rYmSyXGKZOmffBgLzU
        /Jhi5L9VnvgXoaaFx6p84w==
X-Google-Smtp-Source: ABdhPJze/kcs/GY/BYUtiDkcANofAMuoSLAHTsVQH7CMGqpM6NHD3caIkMw+iZzx9pK0U9hRcPUJRQ==
X-Received: by 2002:a5d:8e12:: with SMTP id e18mr15043269iod.99.1600197308482;
        Tue, 15 Sep 2020 12:15:08 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u18sm9454759iln.78.2020.09.15.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:15:07 -0700 (PDT)
Received: (nullmailer pid 2336730 invoked by uid 1000);
        Tue, 15 Sep 2020 19:15:05 -0000
Date:   Tue, 15 Sep 2020 13:15:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 15/20] dt-bindings:iio:adc:ad7768-1 yaml conversion
Message-ID: <20200915191505.GA2336645@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-16-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-16-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:41 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fairly straight conversion.  The one oddity in the original binding
> is that spi-cpha and spi-cpol were not marked as required, but were
> in the example.  Looking at the datasheet, there isn't any documented
> flexibility in the possible SPI modes, so I have moved these to requires.
> For spi-max-frequency I have gone the other way.  I absolutely agree
> that it is good to specify this in the dt-binding, but it's not
> strictly required.
> 
> As Stefan's email is bouncing I have gone with Michael as maintainer
> of this one as it falls under the ADI catch all entry in MAINTAINERS.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7768-1.txt         | 41 ---------
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 41 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
