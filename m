Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8541D26ADE3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgIOTpN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:45:13 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37658 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgIOTor (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:44:47 -0400
Received: by mail-il1-f193.google.com with SMTP id q4so4192232ils.4;
        Tue, 15 Sep 2020 12:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ER4i4P91JA8XeWAZ4N8ZnfRej/QPtcJHPmb1yet97nE=;
        b=Rzlt7slUI+3rF6r/X0uyHdNzX4boWeO4IkzpL5Bg5sjD3ZSaMkdekgPM5hT7USoMWr
         8+bMvcpcPBks7502iXX+g+0SSiQcCYYvrArgBxrWu2fE6pmfkH6ZDWiB59PoyLhRxeA/
         duSldmnvRS3/bRQQ7MwoNRrkBGBn377h9w4AiAak/VkoD805fhzmTroUGNA8AD0S+TJ0
         kvpLm+gQmdUv/I67YjvJrJt/5whYHvVNUq8WtZYVyt/mhVS7VnvHRn7whptQV+q85UUN
         FF60usxH/08BetwFlldeRt6aE7BR5oF8p0zVKnG7JVraRVq8VEeRkV/adBKu+6iMkMa4
         eRpA==
X-Gm-Message-State: AOAM531ZtaAH9g7A7G+tOYhoHddrhoUNYFKjFfQYObWPZKtbwTVrS+HA
        Dt5MQ4AO9mkeSbLtk0yYy+jHYfPu8ifDAl0=
X-Google-Smtp-Source: ABdhPJyz1iDGc/LKq9EZm/77LVcAekloomVZDNQC7+Rkm16+Rgx6gE+pqZY0OLcy1zlIyWdkpCIrPA==
X-Received: by 2002:a05:6e02:e07:: with SMTP id a7mr16855667ilk.277.1600199086466;
        Tue, 15 Sep 2020 12:44:46 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a23sm7874806ioc.54.2020.09.15.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:44:45 -0700 (PDT)
Received: (nullmailer pid 2384233 invoked by uid 1000);
        Tue, 15 Sep 2020 19:44:44 -0000
Date:   Tue, 15 Sep 2020 13:44:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: exynos-adc: require second
 interrupt with touch screen
Message-ID: <20200915194444.GA2384148@bogus>
References: <20200910161933.9156-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910161933.9156-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 18:19:32 +0200, Krzysztof Kozlowski wrote:
> The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> screen.  In such case the second interrupt is required.  This second
> interrupt can be anyway provided, even without touch screens.  This
> fixes dtbs_check warnings like:
> 
>   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> 
> ---
> 
> Changes since v1:
> 1. Fix if:has-touchscreen, as pointed by Rob.
> 2. Add Ack.
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.yaml       | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
