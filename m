Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB73C87ED
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhGNPuq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:50:46 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:35718 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhGNPuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:50:46 -0400
Received: by mail-il1-f181.google.com with SMTP id a11so2061267ilf.2;
        Wed, 14 Jul 2021 08:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sR0t2+c6Dwhb8bFvG4vyou+fHYcdXM7gxmXBgVkYtr0=;
        b=Uxo4SZK9qnQK7L5rGSCdwDQ6ZtGSsCzJf3dpZAYnTLCzUbA07OyvT+f9FpoMPbAN3x
         qPNgDY89fC+xqRvr3vabqeGv3eYvPzUskltRiScOmtLaGjaw/7FAs+4tiTBfD4fZVS/n
         0SSAnVEtgsf3PLDD2ycyL2EJRxfRs+yaQbdKJLWpuhoDWZ+320rbNZqrhskwHQb6v8P1
         lmsEx1LyGBqH8uWxmYnQSpt7XRgJ4wXMe1a8Mcor7UxLa5p3d5e9pb/xmLVez3WlG0t9
         B66sQNgyJvTltHlFTUhFhEj+imuIQOGdnt8eaMV9+uPx+yid51zTweYfOwIC9Os4mrC7
         qY9w==
X-Gm-Message-State: AOAM533BDvQkWCJ8OabfR92yOUjJgvyHE2DVzdNx2ba6+jgrEX2xXZmz
        0L9Hgv+K2Vuyxz3ln+M8YA09HHoQ6w==
X-Google-Smtp-Source: ABdhPJy3NhGyKKGahaIaf0Q7iePgPaRsX7TBvrkcY9MyS6ZiEOuVNk5khOJi7bUZXLs2g+c8YbBaYw==
X-Received: by 2002:a92:8707:: with SMTP id m7mr7175288ild.177.1626277674594;
        Wed, 14 Jul 2021 08:47:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m184sm1399141ioa.17.2021.07.14.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:47:53 -0700 (PDT)
Received: (nullmailer pid 2636816 invoked by uid 1000);
        Wed, 14 Jul 2021 15:47:51 -0000
Date:   Wed, 14 Jul 2021 09:47:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/15] dt-bindings: iio: dac: adi,ad5421: Add missing
 binding document.
Message-ID: <20210714154751.GA2636782@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:30 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is documented what is currently the case.  There are a number
> of things that could be added, but I don't feel the binding elements
> are obvious enough to document without a driver implementation to
> verify they are good choices.
> 
> These include
> * Range
> * Regulators, both input and potentially output (if the loop being
>   driven is ever described).
> 
> I've listed Lars and myself as maintainers of the binding, but if
> anyone else wants to be added they would be most welcome!
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5421.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
