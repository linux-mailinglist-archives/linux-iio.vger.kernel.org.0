Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F4E26AD38
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIOTKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:10:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44550 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgIOTFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:05:25 -0400
Received: by mail-io1-f67.google.com with SMTP id g128so5293433iof.11;
        Tue, 15 Sep 2020 12:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIx4NRubsQ/BmlJQ4RX8flhD3UuShW7nQqivaZd4oCE=;
        b=GdL1GGQZMmdXCofZ8XQxz3udedAa6s6oOxXkp4szo+Zl2wnisFVapJ9gCH8AJ92Fls
         yfTRflYQJhEXtkm1lJZBBbNmVgmepYi6tngrDMvuDJrlxkuq6RPO7zOpfacEW5yc5NbZ
         TyEfEJU+aLFaZTBcDqtxndoLawzzPpxsTRAccRINMZwB5PMC9qpii6b0iYnB6cRgS4KN
         3Ps1P8wuQxJicm+ycs1nXFdvecA6vPwTZKD1DX0Ra4QsTCIheM5vR4/CAKBGsQ/ArC80
         xw66CHUFDHz4isyhxWspVUueysv5G+gNG6OQKowdTGBFvfgCPNqVsL1dIVab7O6QCbfV
         vBww==
X-Gm-Message-State: AOAM533bgF//k/+oiDDUTNhE8kI0RQmGOLpW7J/SCsnvm7PH/aC7LM5v
        qG3Am3LzQvR5pMgXPq3DYg==
X-Google-Smtp-Source: ABdhPJxP7mgxgIOA6ogOazTJDP1NhUeVKBYsW+PuDG/Tg+2c3XfK2f4tqcUivAnkqawCOxK2atDxOA==
X-Received: by 2002:a5d:888b:: with SMTP id d11mr16422139ioo.188.1600196724957;
        Tue, 15 Sep 2020 12:05:24 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a20sm9414527ilq.57.2020.09.15.12.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:05:24 -0700 (PDT)
Received: (nullmailer pid 2320419 invoked by uid 1000);
        Tue, 15 Sep 2020 19:05:22 -0000
Date:   Tue, 15 Sep 2020 13:05:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/20] dt-bindings:iio:adc:sprd,sc2720-adc yaml
 conversion.
Message-ID: <20200915190522.GA2320364@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-7-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:32 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I changed the name to reflect a specific part in line with normal
> naming conventions. If there is a particularly strong reason to
> keep the wild cards let me know.
> 
> Otherwise this was a fairly simple conversion as part of converting
> all the IIO bindings to yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 72 +++++++++++++++++++
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt      | 40 -----------
>  2 files changed, 72 insertions(+), 40 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
