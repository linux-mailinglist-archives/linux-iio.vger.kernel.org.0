Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61A61E327D
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 00:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbgEZW32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 18:29:28 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36300 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389638AbgEZW31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 18:29:27 -0400
Received: by mail-il1-f193.google.com with SMTP id 17so22166641ilj.3;
        Tue, 26 May 2020 15:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbT3ScDzCNYAABtOVikLEAX2UZzl2ocd0JdfNC4PAf4=;
        b=Nge8vjCsPZgXrNtZ7GW7HNrRwslUQfJV2UKZ6ocMiEDpvHqVC1QtMSG/sjAdxLsa9D
         k0h4vEmdWVvNs3PvP/rJpjRaKm8v8A7f1u16mTJrBSNwrI0/R98F+1nU9GM+ad0+Th1u
         4Sl6Yj+DAeLSkmwPJu7eCGAGDLxzWazRiBzE50IEor8SaQZxNHjs/vDz8y5NsmQ+6seq
         JQBH3H2FtQBVP12o/+sI9Gkdb/inqSKkFqinRKy/Z4J4dhmwYBCM3RbgkmA+VA/PvVbO
         Wd9pHUTYZmxXNaXyOFpkmskEViy3N328a3acvZfF/HT5bjnmwdeYsyrSk6taR3sZ0DY9
         +vUQ==
X-Gm-Message-State: AOAM530L5593GryveJfLnoO2rkWgMmO+a4HHat6ODoSx/qH8hZnDkWpE
        ggP85C7je4redlC1DKAoaw==
X-Google-Smtp-Source: ABdhPJxbJBYMTPujWSrd9WkU1HS+aI+DKsGyYjvo8BHOroiHv7F6z1GiS2D/YnAZd53VHzDlzxztOA==
X-Received: by 2002:a92:8c4c:: with SMTP id o73mr3210366ild.172.1590532166547;
        Tue, 26 May 2020 15:29:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g6sm651047ile.38.2020.05.26.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:29:25 -0700 (PDT)
Received: (nullmailer pid 500386 invoked by uid 1000);
        Tue, 26 May 2020 22:29:24 -0000
Date:   Tue, 26 May 2020 16:29:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
Message-ID: <20200526222924.GA500332@bogus>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
 <20200525151117.32540-4-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525151117.32540-4-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 17:10:37 +0200, Jonathan Albrieux wrote:
> Add reset-gpio support.
> 
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheet says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
