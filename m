Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF13C8828
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhGNQBE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 12:01:04 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38591 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhGNQBD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 12:01:03 -0400
Received: by mail-io1-f45.google.com with SMTP id k11so2725015ioa.5;
        Wed, 14 Jul 2021 08:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uKmN76PQcI0vviifsJlq1bWL88BKyZ8ByDVhBKGFh+s=;
        b=KbjJi5e3tT95qojOO+1woR5bQCXQkZjXHtoYb9nSxZ6UAV8zgzaYv+9F8vOPgqQrrY
         KVIRaMXbifL0JxSlCCZpb7u9zE2tFuLXRvgX+cu3zjFLBidsjC8p+XIXrIQHgQlYRpLq
         L1im2V9HaeSiub/Mig+xesepKtdDuX1BJ1ARWWJ67IdloekD7DfgS/bSgfxGHzG048pw
         5yHVkj/9gGMYYYy0bm/Gr2dZ+ILBzwKZQNQu+IYUZwcPae1U6JfMh6DwN9OcQ1X43RRi
         YeSDzMiwP+CazzbDkoLrbwKT03M3SKb+/KeuIZXDj79I8hI5X0Xm0F9CuC0fN6v9ZqJ5
         yRCw==
X-Gm-Message-State: AOAM533SjX1aPKtbJcrmGOvKV/3uuh2gRNI/mrspgW9mkEI5IWFAKrwX
        JGtlCFTtOYSVWuFsOdd0lQ==
X-Google-Smtp-Source: ABdhPJwPzVqTVZzKC9guNcbITCAzgaQNzWJaN1KCojajFukW97Wjw5AkcuT0uDZCden2vCh3/sJc3Q==
X-Received: by 2002:a05:6602:3315:: with SMTP id b21mr7708599ioz.13.1626278292066;
        Wed, 14 Jul 2021 08:58:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c19sm1366728iod.46.2021.07.14.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:58:11 -0700 (PDT)
Received: (nullmailer pid 2653513 invoked by uid 1000);
        Wed, 14 Jul 2021 15:58:09 -0000
Date:   Wed, 14 Jul 2021 09:58:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Ricardo Ribalda <ribalda@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 11/15] dt-bindings: iio: dac: ad5761: Add missing binding
 doc.
Message-ID: <20210714155809.GA2653479@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-12-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:40 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight forward binding with vref optional for those part with internal
> regulators, but required for those without.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> ---
>  .../bindings/iio/dac/adi,ad5761.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
