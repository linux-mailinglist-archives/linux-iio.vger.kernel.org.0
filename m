Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F119A7219
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfICSAk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 14:00:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50191 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbfICSAj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 14:00:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id c10so476360wmc.0;
        Tue, 03 Sep 2019 11:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=34Xcq7thsxhEYgF6NhsqQGQ1Vrog+b37R3Zc1f/8Qhk=;
        b=X3bWWPO+u3QPOqwAM+hjVlgL3YQRjgWTB78NeB/Ssnw6T6LduJ6pVVdqJ0GH1evOVX
         l4qsTP/voqKLJbDQBPcOJFyIsIfhDDSeRVheMOyfAC5cOSuN31jTqbrDMyQeFxfv6st1
         rnPPw0p8on5usSMQb8o8H1bRj6n3QmzSfVg7zz/UiztaPOh7CPc/c9n85QXqmIMsuJPV
         pFVHuB2QMtaVE+U/Igvk41fJN9E1tJ5d4+dFJfTf6f9hLAf5rH4PUv0RIF2VGuPuO89F
         uTKZ7167peLawMt3d5H0o+nhi9OsxNFulKDPe+R5nYhLjXf70WuBlFys7uymh8eYonC2
         4jxg==
X-Gm-Message-State: APjAAAWviQ3doY3Ye/vfLA1YdErYFwcQGTbAc8outSKxdKEV4SfiiGyN
        v9XKS2mdZ5cYwHJwwOLFzA==
X-Google-Smtp-Source: APXvYqw7VYPZePKNY1HbeRCZaXNu5r0VZkMO0MvHuCpUl6v9gVhDq6OOhA5CRy1D32J8fvPktkIHbg==
X-Received: by 2002:a1c:2546:: with SMTP id l67mr730944wml.10.1567533636754;
        Tue, 03 Sep 2019 11:00:36 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id i73sm515711wmg.33.2019.09.03.11.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:00:36 -0700 (PDT)
Date:   Tue, 3 Sep 2019 19:00:34 +0100
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7 v3] mfd: ab8500: augment DT bindings
Message-ID: <20190903180034.GA20595@bogus>
References: <20190903150612.12246-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903150612.12246-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 03, 2019 at 05:06:12PM +0200, Linus Walleij wrote:
> As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> the bindings to account for defining the ADC channels in the device
> tree.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Change "adc-channel@" to "channel@" as per preferred notation.
> - Add some full stops to the end of sentences.
> - Reference the new ADC-specific documentation for channel specifier
>   etc.
> - Collect Lee's ACK.
> ChangeLog v1->v2:
> - Rebased on v5.3-rc5

Must have missed the DT list...

> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
> index cd9e90c5d171..ff517e5d7ee0 100644
> --- a/Documentation/devicetree/bindings/mfd/ab8500.txt
> +++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
> @@ -69,6 +69,18 @@ Required child device properties:
>  - compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
>                                                 pwm|regulator|rtc|sysctrl|usb]";
>  
> +  A few child devices require ADC channels from the GPADC node. Those follow the
> +  standard bindings from iio/iio-bindings.txt and iio/adc/adc.txt
> +
> +  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
> +			   temperatures.
> +  ab8500_fg		 : io-channel "main_bat_v" for measuring main battery voltage,
> +  ab8500_btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
> +			   battery voltage.
> +  ab8500_charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
> +			   "usb_charger_c" for measuring voltage and current of the
> +			   different charging supplies.

s/_/-/ for node names.

> +
>  Optional child device properties:
>  - interrupts             : contains the device IRQ(s) using the 2-cell format (see above)
>  - interrupt-names        : contains names of IRQ resource in the order in which they were
> @@ -102,8 +114,115 @@ ab8500 {
>                                39 0x4>;
>                  interrupt-names = "HW_CONV_END", "SW_CONV_END";
>                  vddadc-supply = <&ab8500_ldo_tvout_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#io-channel-cells = <1>;
> +
> +		/* GPADC channels */
> +		bat_ctrl: channel@01 {

Drop leading 0s. dtc should give you warnings for this.

> +			reg = <0x01>;
> +		};

I guess these nodes aren't new, but why do you need them other than 
defining how many ADC channels.

> +		btemp_ball: channel@02 {
> +			reg = <0x02>;
> +		};
> +		main_charger_v: channel@03 {
> +			reg = <0x03>;
> +		};
> +		acc_detect1: channel@04 {
> +			reg = <0x04>;
> +		};
> +		acc_detect2: channel@05 {
> +			reg = <0x05>;
> +		};
> +		adc_aux1: channel@06 {
> +			reg = <0x06>;
> +		};
> +		adc_aux2: channel@07 {
> +			reg = <0x07>;
> +		};
> +		main_batt_v: channel@08 {
> +			reg = <0x08>;
> +		};
> +		vbus_v: channel@09 {
> +			reg = <0x09>;
> +		};
> +		main_charger_c: channel@0a {
> +			reg = <0x0a>;
> +		};
> +		usb_charger_c: channel@0b {
> +			reg = <0x0b>;
> +		};
> +		bk_bat_v: channel@0c {
> +			reg = <0x0c>;
> +		};
> +		die_temp: channel@0d {
> +			reg = <0x0d>;
> +		};
> +		usb_id: channel@0e {
> +			reg = <0x0e>;
> +		};
> +		xtal_temp: channel@12 {
> +			reg = <0x12>;
> +		};
> +		vbat_true_meas: channel@13 {
> +			reg = <0x13>;
> +		};
> +		bat_ctrl_and_ibat: channel@1c {
> +			reg = <0x1c>;
> +		};
> +		vbat_meas_and_ibat: channel@1d {
> +			reg = <0x1d>;
> +		};
> +		vbat_true_meas_and_ibat: channel@1e {
> +			reg = <0x1e>;
> +		};
> +		bat_temp_and_ibat: channel@1f {
> +			reg = <0x1f>;
> +		};
>          };
>  
> +	ab8500_temp {
> +		compatible = "stericsson,abx500-temp";
> +		io-channels = <&gpadc 0x06>,
> +			      <&gpadc 0x07>;
> +		io-channel-name = "aux1", "aux2";
> +	};
> +
> +	ab8500_battery: ab8500_battery {
> +		stericsson,battery-type = "LIPO";
> +		thermistor-on-batctrl;
> +	};
> +
> +	ab8500_fg {
> +		compatible = "stericsson,ab8500-fg";
> +		battery	   = <&ab8500_battery>;
> +		io-channels = <&gpadc 0x08>;
> +		io-channel-name = "main_bat_v";
> +	};
> +
> +	ab8500_btemp {
> +		compatible = "stericsson,ab8500-btemp";
> +		battery	   = <&ab8500_battery>;
> +		io-channels = <&gpadc 0x02>,
> +			      <&gpadc 0x01>;
> +		io-channel-name = "btemp_ball",
> +				"bat_ctrl";
> +	};
> +
> +	ab8500_charger {
> +		compatible	= "stericsson,ab8500-charger";
> +		battery		= <&ab8500_battery>;
> +		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
> +		io-channels = <&gpadc 0x03>,
> +			      <&gpadc 0x0a>,
> +			      <&gpadc 0x09>,
> +			      <&gpadc 0x0b>;
> +		io-channel-name = "main_charger_v",
> +				"main_charger_c",
> +				"vbus_v",
> +				"usb_charger_c";
> +	};
> +
>          ab8500-usb {
>                  compatible = "stericsson,ab8500-usb";
>                  interrupts = < 90 0x4
> -- 
> 2.21.0
> 
