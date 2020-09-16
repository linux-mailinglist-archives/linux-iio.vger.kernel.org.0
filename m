Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266226C5DA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgIPRVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 13:21:38 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:32897 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgIPRVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:21:22 -0400
Received: by mail-wm1-f49.google.com with SMTP id e11so2680675wme.0;
        Wed, 16 Sep 2020 10:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsVNkWfU/xN6v/3RuJ+E3lKyP7RLysQnfO7peLpE7kY=;
        b=IG8QtBCPnZ04p6Fk6Cy+Egr4B891tu+pB3tWcAvT3daWhCNAinqXfUmYITarHkN6Ne
         bUfgDXFrOoJiSrBqX8VmdgECEa52ZOoNPJHAa+iwQ2QPzdRnvfMnOyRBYzYNFh24iP7b
         RhPKDJwAKJhIpERsuEKHgKLanxtNznKxbRiH7B4h7UKsyjWjUimgqrDerhAMG+GUh3SC
         xbVsGdVtGQEadl0YzpBBvnyzJDj9vsnmhZBVOWxrNF7aUwOW72z7XpEsZunMP0Uwap1w
         bMiRtxh5Jy/blNilpEQLHpOC/y0jCYMvJPgiUV6DO5Ww3ftGDLYpBfhNX0MUmdyH4v4a
         Nw4Q==
X-Gm-Message-State: AOAM533YcOq+tQ4kHGuFcSHzV+H8NM1jH/L3CYIzFfWT8zxaytwvwVFD
        ngRu8tgX3yv34SIov5bj2EolcF1slY2L57RQ
X-Google-Smtp-Source: ABdhPJwCjPvgxD4dQGPl4rSxujR29N2FIrmsHbZlFKpyM6D15ecoUifRyyZYzgPH1gpbcK+Vzu7mfQ==
X-Received: by 2002:a1c:b407:: with SMTP id d7mr6142610wmf.59.1600276640309;
        Wed, 16 Sep 2020 10:17:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id p1sm8727158wma.0.2020.09.16.10.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 10:17:19 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:17:17 +0200
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
Subject: Re: [RFT 23/25] ARM: dts: s5pv210: replace deprecated "gpios"
 i2c-gpio property in Goni
Message-ID: <20200916171717.GH19427@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-24-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-24-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:39PM +0200, Krzysztof Kozlowski wrote:
> "gpios" property is deprecated.  Update the Goni DTS to fix
> dtbs_checks warnings like:
> 
>   i2c-pmic: 'sda-gpios' is a required property
>   i2c-pmic: 'scl-gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-goni.dts | 4 ++--

Applied.

Best regards,
Krzysztof

