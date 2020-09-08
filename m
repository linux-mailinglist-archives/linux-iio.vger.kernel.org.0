Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B14260B48
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgIHGxb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 02:53:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35848 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgIHGx3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 02:53:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id w1so14877586edr.3;
        Mon, 07 Sep 2020 23:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4p/H0CiiSp9E1p70DbzLGLjDnVkXgbyRRzE1jCB1PFQ=;
        b=S7WxUvUTdnLU7LePTuZl4k7VJNW+ONr/Umyfb4+4BPV8IeFeTdoFpZFGwZv0U5xAAf
         l0qsn30xsfPj7e5YbH2UvWlcW0N6QjK9hZcbT5XJUV0a2egd2n6VDSbQ9Gh8GDtZPgmG
         zBIs6I6SquQBlgajjA6aICEwAQM3QI54uaSFZfnOJC3g9KGmmi+Y6WyUF+lhdFS6gLA5
         kiJ+WspAS3byVVfbm28bkTCdVloKsyLMkey1ZWxnO0amizs8iU4ymVY/LkOvp2X2V/SF
         8RUBUnh321IN0IQAbp938uoXOWjRoexzrEuPg3h2dGu9Fcgu8e7NAASJvSkdUeaCLCp+
         z6JQ==
X-Gm-Message-State: AOAM532O3/18clLyfddv1pLXQagcSVx4DmV98nMPkehJqaaF2HRHb0m6
        G7ZWA4F8aad2pPWmAp03jnU=
X-Google-Smtp-Source: ABdhPJw5ezQoF+AB+ms88qmJv+sqAXN2TYB1n/eHFI3sUP193yhAz8pVhfX4GcC87mq6+y/gYFPPXw==
X-Received: by 2002:a05:6402:180a:: with SMTP id g10mr24930880edy.18.1599548004828;
        Mon, 07 Sep 2020 23:53:24 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id c5sm9290071ejk.37.2020.09.07.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:53:23 -0700 (PDT)
Date:   Tue, 8 Sep 2020 08:53:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFT 09/25] ARM: dts: s5pv210: fix number of I2S DAI cells
Message-ID: <20200908065321.GB24227@pi3>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-10-krzk@kernel.org>
 <BN6PR04MB0660D9B0D0B5FB4F40CF2769CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660D9B0D0B5FB4F40CF2769CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 04:55:26PM -0700, Jonathan Bakker wrote:
> Sadly, this is causing issues for me.  The machine driver is no longer probing correctly
> on the Galaxy S.
> 
> The failing call in sound/soc/samsung/aries_wm8994.c is
> 
> 	/* Set CPU of_node for BT DAI */
> 	aries_dai[2].cpus->of_node = of_parse_phandle(cpu,
> 			"sound-dai", 1);
> 
> where cpus->of_node is not set properly.  Which is definitely weird because it doesn't
> look like this should affect that.
> 
> Let me know if there's any specific test that you want me to do.

Thanks for the tests. I wonder now if this was working before because
really my change should not break it... I'll think more about it.

Best regards,
Krzysztof

> 
> Thanks,
> Jonathan
> 
> 
> On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> > The bindings describe I2S DAI has 1 cells.  This makes especially sense
> > for i2s0 which registers two DAIs.  Adjust the cells to fix dtbs_check
> > warnings like:
> > 
> >   i2s@e2100000: #sound-dai-cells:0:0: 1 was expected
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 2 +-
> >  arch/arm/boot/dts/s5pv210-galaxys.dts     | 2 +-
> >  arch/arm/boot/dts/s5pv210.dtsi            | 6 +++---
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> > index ca064359dd30..a6dc8a173af1 100644
> > --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> > +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> > @@ -102,7 +102,7 @@
> >  		pinctrl-0 = <&headset_det &earpath_sel>;
> >  
> >  		cpu {
> > -			sound-dai = <&i2s0>, <&bt_codec>;
> > +			sound-dai = <&i2s0 0>, <&bt_codec>;
> >  		};
> >  
> >  		codec {
> > diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
> > index 560f830b6f6b..0eba06f56ac7 100644
> > --- a/arch/arm/boot/dts/s5pv210-galaxys.dts
> > +++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
> > @@ -132,7 +132,7 @@
> >  		pinctrl-0 = <&headset_det &earpath_sel>;
> >  
> >  		cpu {
> > -			sound-dai = <&i2s0>, <&bt_codec>;
> > +			sound-dai = <&i2s0 0>, <&bt_codec>;
> >  		};
> >  
> >  		codec {
> > diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> > index 2871351ab907..96e667ba1c3f 100644
> > --- a/arch/arm/boot/dts/s5pv210.dtsi
> > +++ b/arch/arm/boot/dts/s5pv210.dtsi
> > @@ -251,7 +251,7 @@
> >  			samsung,idma-addr = <0xc0010000>;
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&i2s0_bus>;
> > -			#sound-dai-cells = <0>;
> > +			#sound-dai-cells = <1>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -266,7 +266,7 @@
> >  			clocks = <&clocks CLK_I2S1>, <&clocks SCLK_AUDIO1>;
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&i2s1_bus>;
> > -			#sound-dai-cells = <0>;
> > +			#sound-dai-cells = <1>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -281,7 +281,7 @@
> >  			clocks = <&clocks CLK_I2S2>, <&clocks SCLK_AUDIO2>;
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&i2s2_bus>;
> > -			#sound-dai-cells = <0>;
> > +			#sound-dai-cells = <1>;
> >  			status = "disabled";
> >  		};
> >  
> > 
