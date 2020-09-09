Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1B2636C6
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIITol (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 15:44:41 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:43921 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIIToj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 15:44:39 -0400
Received: by mail-ej1-f46.google.com with SMTP id o8so5264568ejb.10;
        Wed, 09 Sep 2020 12:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rWZU3unCj9fu1p22kF6MLzALPkoa763qB+YvDpsCgmo=;
        b=CnjWCFYIVtuJ0YiUZfyi42HiFydXEFlyKWBDqF+Jcfq33yNY+qF6bjnaR2X8qcFjfm
         L+F7hL6L/YiAwSwKBgu/55y92dapL9sG9OaowdNpAg+Dq6fVNLG3kMhH5BuyZesPe2jK
         2Hvai8ZFREM+ir+eyLLRofpxCKdpiHbs/Hhv0ZyMtkN/TrDeaeMTb/llloU8w59+e7NY
         ivvBmD3STCufrIJQkilIHh+/EWWdOcJD/q/384NRPXeTF3rCXTPmOKI3+BO59/5mqyPv
         VqXrBogQCCrYRDjltIoZOZyUgPz1l5kJisSj8f57UFbvBkYZSuL+swvRqRnDmZW5RCyV
         VBNQ==
X-Gm-Message-State: AOAM5326DcfNjHMX9M0DHW2OSv09/rHCaAh2MXfWPhI9Nf4BIvihlLOE
        3klZBEy4a+EV3tBpFpArOTY=
X-Google-Smtp-Source: ABdhPJyoIVF6Kb8LIjY5/OZ5vuY2/SXqKdvpYPhrn2U0y2XVc9KbqJ0z8AQAQd7yR9KeYvl2A6A+NQ==
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr5107934ejx.215.1599680676715;
        Wed, 09 Sep 2020 12:44:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id g20sm3460946ejx.12.2020.09.09.12.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 12:44:35 -0700 (PDT)
Date:   Wed, 9 Sep 2020 21:44:33 +0200
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
Subject: Re: [RFT 24/25] ARM: dts: s5pv210: align SPI GPIO node name with
 dtschema in Aries
Message-ID: <20200909194433.GD21431@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-25-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-25-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:40PM +0200, Krzysztof Kozlowski wrote:
> The device tree schema expects SPI controller to be named "spi",
> otherwise dtbs_check complain with a warning like:
> 
>   spi-gpio-0: $nodename:0: 'spi-gpio-0' does not match '^spi(@.*|-[0-9a-f])*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Best regards,
Krzysztof

