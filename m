Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7F26AD23
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgIOTKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:10:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35865 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgIOTJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:09:35 -0400
Received: by mail-io1-f65.google.com with SMTP id d190so5370581iof.3;
        Tue, 15 Sep 2020 12:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARIwDW6QCJu+jC1gsduHdKyYt+r8i7o6Kx0PfeHT3II=;
        b=BGjB6fUifxdOkK0c2J3Zzd3m6/ajLb55et9r7SpMKodSlaQ7H7UI2OrDaiv8otbAHC
         rigS4p/ncvak2XmDuR82Hgg5GF/Jup+eqS2UGd2D1GVPBIkiz+pDzFlNfOi1cCqrI81E
         imLwPf7BJzBd12/9XeIAWUDrGSkm63wfCnUGdRIZwOY4glIin6ah1v3p5987bjwpqJXV
         /J5FvaCIrBoAUAb6mtbIdAap8m0Ii3iPlWDydR5ML0hgGU7K93pVWQeCzOifz3XgqtiL
         Zr2MGFKCdFIh5gLET7akPj9KyGMZuUZHa+vG4w8F+eRjOg3k2JqFG5rbQgYY+zlwbl87
         Riiw==
X-Gm-Message-State: AOAM530pvo5uP6s86Ey2lMSQsuIXq2BKIcAmOv9UV0WvjinkivPZKb+X
        xJeIjstppAzkrDQ7XTPdEt3ryYhegVQNUDw=
X-Google-Smtp-Source: ABdhPJy+aXvoDpuvC/H1c+gz71i2zc3yn1l9fNdp85Ob22ZyO+2VOTemJimIyksM+WDn7Sfc7qHplA==
X-Received: by 2002:a6b:3bd3:: with SMTP id i202mr16583083ioa.145.1600196974691;
        Tue, 15 Sep 2020 12:09:34 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x1sm9151155ilo.50.2020.09.15.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:09:34 -0700 (PDT)
Received: (nullmailer pid 2327450 invoked by uid 1000);
        Tue, 15 Sep 2020 19:09:33 -0000
Date:   Tue, 15 Sep 2020 13:09:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/20] dt-bindings:iio:adc:lpc3220-adc yaml conversion
Message-ID: <20200915190933.GA2327420@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-11-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-11-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:36 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Renamed to remove the wild cards.  These go wrong far too often so
> in general preferred to use the name of a specific part.  As this
> binding only provides one compatible, I went with that.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> ---
>  .../bindings/iio/adc/lpc32xx-adc.txt          | 21 --------
>  .../bindings/iio/adc/nxp,lpc3220-adc.yaml     | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
