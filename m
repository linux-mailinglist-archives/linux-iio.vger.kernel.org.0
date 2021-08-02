Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E53DE112
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhHBUyo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 16:54:44 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:39885 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHBUyn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 16:54:43 -0400
Received: by mail-il1-f171.google.com with SMTP id r1so17679236iln.6;
        Mon, 02 Aug 2021 13:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gn+Cv6volHu0HcjpXLqooMmBuioV/ncfm5HA2aZI0w=;
        b=HRyWMnh1YmubqMgBtjLUaVs9UEzqxe0KqWzvBTc+CQUTLR2xFBdRW4B84kVESC88Dj
         O+kj4cgTICw/qxlr2Hp48YcWRW0h6SEg2XVnvicOyMGL7kCoJYll6J5HKGJaN9+0ynNV
         PbXlGwSjK3AQU15IfSZJJ+d3MNKRuJzYhJjwyerJhfDGvPb4UZqNACS1tfxdUrm7ZYNT
         x3K3EQQ614hb+9VZwftDmERf2KnEAO/JUaK7FD0KESxJ8beAjGR4TKAXZmGwzjUxO1Zk
         sC1LdXmMXZuIcUA4mr/F+lDTA2Tb6JWPnLSsv391Jp3UoyFWjElUMoP2IAERC2XQ6Rpl
         SuFg==
X-Gm-Message-State: AOAM532/VXZ6vxXQLT3fGstZEo7t18QfwdUpCu7NAxnVcf7C9QGp2YWM
        ln1c+0S097iG+YeioeOxSw==
X-Google-Smtp-Source: ABdhPJzkPcMfvOCRjIe3BuAlq29lTgQ6W6BdV7E1/biwkoO0mM590TnSrfs9hpscgc/As6GeYO0mLw==
X-Received: by 2002:a05:6e02:ef4:: with SMTP id j20mr225874ilk.246.1627937673016;
        Mon, 02 Aug 2021 13:54:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r16sm6231911iln.30.2021.08.02.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:54:32 -0700 (PDT)
Received: (nullmailer pid 1592385 invoked by uid 1000);
        Mon, 02 Aug 2021 20:54:30 -0000
Date:   Mon, 2 Aug 2021 14:54:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Add trivial DT binding
 for sgp40
Message-ID: <YQhbhi0WOMsKg7x/@robh.at.kernel.org>
References: <20210727163443.GA3457@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727163443.GA3457@arbad>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 18:34:45 +0200, Andreas Klinger wrote:
> Add devicetree binding for Sensirion sgp40 gas sensor to trivial
> devices.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
