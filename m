Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19D913B1C9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANSPR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 13:15:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40698 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgANSPR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 13:15:17 -0500
Received: by mail-oi1-f195.google.com with SMTP id c77so12717879oib.7
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2020 10:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LSZFhjvkBvH4Jm+XH1uoBzxnQKONQoyfsFilqe6/1E=;
        b=PmTOVrJk2/D1HvZdsQaw6zwjcUMjlHBeDzPDrzT57IvKQJrO2aRz+rdmrzCEaAJC2S
         3l09tNqXSZ7qH6TwHt5hgKZW70PXt171C5/8d/xezN3oZ9b5DJAkSHkV5AuWGAfBvT9F
         9O9pWwK9ij1vUkO+LfHgxhNgJOmJhPjoOehKzjL9n03O/954GBDQFhCeW4FfWDQvO4xO
         iVN1CrK6UZ7b5y7UWUWingkS1YSuH4xM0Y0xIHse33AUa6Dk/FsG5+558HOXHuJtBa65
         GG2cKQPqwntL2wuqfsJH7IETRV3HqDdEwhAjvFUKyLdtyQpObQEmxIwUwqmPO4/Gghjn
         NZhw==
X-Gm-Message-State: APjAAAXGM4HTGfs1eJ4zairYoW/RmRHvZ7yrHZPZiL0pDWrv1ux/8y47
        gU4LE9H279dVJycYdPqXhI1xrKs=
X-Google-Smtp-Source: APXvYqyMOatEXIofQKtG/iIcofTc6U/qtbtVZm7a+1irsq0YWuXs1IFI4/9DjHhcss6hjFBZnfw1Tw==
X-Received: by 2002:aca:5fc1:: with SMTP id t184mr18665463oib.20.1579025716367;
        Tue, 14 Jan 2020 10:15:16 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm5608433oty.48.2020.01.14.10.15.15
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:15:15 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22090b
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 12:15:14 -0600
Date:   Tue, 14 Jan 2020 12:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        biabeniamin@outlook.com, knaack.h@gmx.de, lars@metafoo.de,
        robh@kernel.org, Jonathan.Cameron@huawei.com,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7606: Fix wrong maxItems value
Message-ID: <20200114181514.GA4529@bogus>
References: <20200114132401.14117-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114132401.14117-1-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jan 2020 15:24:01 +0200, Beniamin Bia wrote:
> This patch set the correct value for oversampling maxItems. In the
> original example, appears 3 items for oversampling while the maxItems
> is set to 1, this patch fixes those issues.
> 
> Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentation to yaml")
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
