Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ECA35A116
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDIOcy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:32:54 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40884 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIOcy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:32:54 -0400
Received: by mail-oi1-f177.google.com with SMTP id i3so5955363oik.7;
        Fri, 09 Apr 2021 07:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+7uYWfvTjGRuU3XRHJOTRCAUynSxs0+bPmSi06l94qY=;
        b=IrtZadRJXiCL/Fc8ncSmpud2xd29Oueo8YibMoSi5HJVsCio23YILYWPrHQo4vsTPf
         ZQRCIrl5GboB1Ul3sNZaZbYzI8SGGXk1XS6q/6YxcwLudqielhpGd/AHMK+lH0CST5hX
         xFq/qlskTUWe51yJnjMPOxLRYfCyVfKhP7q54+dlhKtmbCg5NHEX81cDnVHRbFHNb2uk
         kKFxgdcE0aGMlrZ7KvgZhrHP9GEw76RelzimTeU4/ADCQz/Ts7TOtReGdfljmxcGLqof
         W1WTvdaH1hOmR6C67q27oYQ0FtxtmtVbNfPwR8qt68qEOskNP9bFGIyy7NR20IMAF6sG
         /GFg==
X-Gm-Message-State: AOAM5333rNP0cZUrkwI3T3+aUqFqnO69ahZidZpK7XtbBUGPbMUh3uwc
        ndMooys60TVOoyQ8TR87qrZwmY3EEQ==
X-Google-Smtp-Source: ABdhPJyxghQ9HWVEW+W5FAHmXZctq5Wg7OEByoIGcRut/8rn0KY7ehQA9ChlWAB/EeIDa6t6zWxXNQ==
X-Received: by 2002:aca:c087:: with SMTP id q129mr10144535oif.32.1617978761045;
        Fri, 09 Apr 2021 07:32:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f2sm548723oos.16.2021.04.09.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:32:40 -0700 (PDT)
Received: (nullmailer pid 3607939 invoked by uid 1000);
        Fri, 09 Apr 2021 14:32:39 -0000
Date:   Fri, 9 Apr 2021 09:32:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/6] dt-bindings:iio:accel:adis16201 and adis16209
 bindings
Message-ID: <20210409143239.GA3606176@robh.at.kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
 <20210401174112.320497-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174112.320497-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 01, 2021 at 06:41:07PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These two devices have different internal characterstics, but their

typo: characteristics

> external connectivity and as a result device tree descriptions are
> identical.
> 
> Note that neither driver in Linux currently has an of_match_table
> but instead rely on matching via name alone.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/accel/adi,adis16201.yaml     | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
