Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9753C882D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhGNQBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 12:01:30 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:42896 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhGNQBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 12:01:30 -0400
Received: by mail-il1-f176.google.com with SMTP id h3so2068963ilc.9;
        Wed, 14 Jul 2021 08:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shQMH6La5pMHGqrUtXGk6XO7MmZhjADpG0DF/0Lmo2E=;
        b=LpjX2jP4B1yzkhZUivlv0j6+tKRBph7xhEOOE7MK1jz4njM7U9aqIXfTYonoqZe4nc
         wyXisbWD6KUy/sO/vqsIQb6zZnZ0AwtW+bSDu5/lJmY9DXhhZusXcZE4oswCZurqecvI
         dvpS7FF12OueHEzQgoCPJd8HC3DdXOhzZHB9Gj7KBeDg1T+DWcAsF+4Qc75w7/wjv+WW
         O2v3KinXybgy8YnDHlShZud+3HaThQtKDQluEno3dVAzLW3ReV1aDW23q6ooFx/S/jWZ
         NiZM8R1Qn0Rl3B1AlYJpjuUglbXKlBMkwXYQ+EaY2FU+mVr222KIO+ILHG11NjlzTw6x
         UFUA==
X-Gm-Message-State: AOAM532Gte5l8fxmSiEOdThzNyzOGERKNj2BR3UM1KbB5Mc+kaJxXVe7
        q52Q15HcIjXzpy/ohGiFIQ==
X-Google-Smtp-Source: ABdhPJwmVhyTw0/hmXQUedNMRBvsuvEfMoUNeBEWh4WvVYO6Vfu6sJQ+415XfBMclTN5zitkGarJNQ==
X-Received: by 2002:a92:9502:: with SMTP id y2mr7122606ilh.1.1626278317165;
        Wed, 14 Jul 2021 08:58:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w8sm1369299ill.50.2021.07.14.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:58:36 -0700 (PDT)
Received: (nullmailer pid 2654295 invoked by uid 1000);
        Wed, 14 Jul 2021 15:58:34 -0000
Date:   Wed, 14 Jul 2021 09:58:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 12/15] dt-bindings: iio: dac: adi,ad5764: Add missing
 binding document
Message-ID: <20210714155834.GA2654239@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-13-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-13-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:41 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding covers the ad5744, ad5744r, ad5764 and ad5764r DACs.
> Note that the driver currently assumes the internal reference is used for
> the r parts. The binding as defined relaxes this constraint.
> 
> There is no support in the binding or driver for the two digital IO
> signals.  I do not propose to add that until we have a means to
> test any such binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5764.yaml          | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
