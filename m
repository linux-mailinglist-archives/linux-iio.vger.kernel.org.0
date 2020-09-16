Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB93526CB41
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgIPUYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 16:24:41 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51234 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgIPR1m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:27:42 -0400
Received: by mail-wm1-f46.google.com with SMTP id w2so3550457wmi.1;
        Wed, 16 Sep 2020 10:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2G9Vre6ygYWYscEDxjFrH06674QIzY1lSU789kkd58Q=;
        b=stql/mUNEE+pobtSmmmcGBiKg7G7oducRkGVK6PGSfKf7gct5o7svteHK0vfYc+TmL
         rA8lONDAKCvQgnZHXeRVdY1cu60zH8/yZ1BmOpMm9kb9zb35lMEzlZR5dGpmarDrt3D/
         FMf7QdCDo6cUcEp8ByYcZ3tVkIieXfjVqDRc87Q7AzS/fIr1g0KAFkplwU4F9vVL4F/R
         vOvGvxaMTeXlTjQuFKKQoUKEoCHADeJb/QveGP/pzmjfOILoTFbRTXUKjQeFuWf5Cfn6
         2LIGYbbojiDFz/2Bs+Mw1J1ApUAROk5pWrVELOagLOQvtSrdke24MyYkKaBslHuMUKqP
         ptsw==
X-Gm-Message-State: AOAM5332t3tNEY0S1yLZ3mjSqweLwT+utkIfrY7dGtDUdhQCbT4kJ78v
        lbMU990kTzzoah3tPUAl0MX0E9d2H0uYVSTh
X-Google-Smtp-Source: ABdhPJxDTK8p4ApdB9MFWXHtAf+xwxeBYv+4T8CavWRUosM979T0uxFvHh1F2ljVlnTpTAvLzldZ4g==
X-Received: by 2002:a05:600c:2cc1:: with SMTP id l1mr5691891wmc.78.1600276598136;
        Wed, 16 Sep 2020 10:16:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id 63sm7061260wrc.63.2020.09.16.10.16.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 10:16:37 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:16:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFT 20/25] ARM: dts: s5pv210: move fixed regulators under root
 node in Aquila
Message-ID: <20200916171635.GE19427@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-21-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-21-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:36PM +0200, Krzysztof Kozlowski wrote:
> The fixed regulators are kept under dedicated "regulators" node but this
> causes multiple dtschema warnings:
> 
>   regulators: $nodename:0: 'regulators' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>   regulators: #size-cells:0:0: 0 is not one of [1, 2]
>   regulators: fixed-regulator@0:reg:0: [0] is too short
>   regulators: fixed-regulator@1:reg:0: [1] is too short
>   regulators: fixed-regulator@2:reg:0: [2] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aquila.dts | 47 +++++++++++-----------------

Applied.

Best regards,
Krzysztof

