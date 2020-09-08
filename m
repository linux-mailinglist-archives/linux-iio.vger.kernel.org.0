Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30DE260B4F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 08:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIHGzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 02:55:08 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43690 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgIHGzF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 02:55:05 -0400
Received: by mail-ej1-f66.google.com with SMTP id o8so7724897ejb.10;
        Mon, 07 Sep 2020 23:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z8F+J0dpPaiXwn0OwzuDM1BFUxGBJiTwV0EOyF8yDGs=;
        b=XVeM8rqWwz4lWbvONRX7NrXSwWogaWtzDZYoOEdikHQOBKYS2bHDFGshhlmHHR/1//
         kGalxlQfWRB5nrjZXEZ8PCwq6uuzlsKDEw0FhMNVRFTA9GRJUDZBuOEO5b5MqPmxEIrp
         I6qD17yECB229Dz98CV7zsqcy5F8j9Oo5l+atqXLAS4WG9FxbkGwVUpE58VVhU/Adr0B
         wJKfYZKkAbQu1RM7Kayi4tal0wt+2qO2gZKKvu7NDdgPxRskTBkbakgVLmPa8+sA4pU8
         X0EQiFlsoSQlrFVFe1DyZ2ErzjrmAPHY1rYeavaf5IRPufkTEWUhuAObCTmKJAjdI+uw
         i1DQ==
X-Gm-Message-State: AOAM533b/hqmuXUgJShWcz3A/wVf9lBYBTuY1TuIdFfHKbqES6tTPLHY
        dvmXNCfiyFiKF+Ak4ZekLEl57QNBCgI=
X-Google-Smtp-Source: ABdhPJwqcrsoBbvXyOtx/zQlu89AL3rfhHav4wMeQ17ElFc0uWvFvkR65vNYNv3eRpa34TVxqpdFcA==
X-Received: by 2002:a17:906:faec:: with SMTP id lu44mr23959522ejb.527.1599548102559;
        Mon, 07 Sep 2020 23:55:02 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id 16sm3865463edx.72.2020.09.07.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:55:01 -0700 (PDT)
Date:   Tue, 8 Sep 2020 08:54:59 +0200
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
Subject: Re: [PATCH 11/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Aries
 family
Message-ID: <20200908065459.GC24227@pi3>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-12-krzk@kernel.org>
 <BN6PR04MB0660939E010C3175CD0DF9D6CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660939E010C3175CD0DF9D6CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 04:57:53PM -0700, Jonathan Bakker wrote:
> Hi Krzysztof,
> 
> On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> > The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
> > However there is no such clock provider but rather a regulator driver
> > which registers the clock as a regulator.  This is an old driver which
> > will not be updated so add a workaround - a fixed-clock to fill missing
> > clock phandle reference in S3C RTC.
> > 
> > This fixes dtbs_check warnings:
> > 
> >   rtc@e2800000: clocks: [[2, 145]] is too short
> >   rtc@e2800000: clock-names: ['rtc'] is too short
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/boot/dts/s5pv210-aries.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> > index 6ba23562da46..86c3b26fd21e 100644
> > --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> > +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> > @@ -47,6 +47,13 @@
> >  		};
> >  	};
> >  
> > +	pmic_ap_clk: clock-0 {
> > +		/* Workaround for missing clock on PMIC */
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <32768>;
> > +	};
> > +
> >  	bt_codec: bt_sco {
> >  		compatible = "linux,bt-sco";
> >  		#sound-dai-cells = <0>;
> > @@ -825,6 +832,11 @@
> >  	samsung,pwm-outputs = <1>;
> >  };
> >  
> > +&rtc {
> > +	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
> > +	clock-names = "rtc", "rtc_src";
> 
> Missing a
> 
> status = "okay";
> 
> here, but with that it works fine for me.  Looks like it's also
> missing in the patches for the other devices as well.

It wasn't there on purpose - I did not want to enable the RTC, just fix
the DTS with the dtschema. However a separate patch could be to actually
enable it.

I'll add your tested-by to this patch.

Best regards,
Krzysztof
