Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484461D97A2
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 15:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgESN0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESN0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 09:26:02 -0400
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5302::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032FC08C5C0;
        Tue, 19 May 2020 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1589894759;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3rxAhv18/WejXE93bIdCZJH8H6kxcCvtozk9gOCeUBs=;
        b=C/LEmzzTMaQ2tlU84rM5xerIxcJThwnprU0v6tStrvo2/tvjo/YBwIuiN1o02C0Hki
        IoDplxK5mGwZ+S/dkg2/zbo+qLt4eVRWVA1oqmESxTqhXuowm3nEjcxyojh5JItWoR4a
        RqrwTNzcyyfr3HMhFqxqRbGqRSplnJ3ip5GBrytbC9SPh/pDOy6O1VIoYGX6LB9z6EQh
        bEFgCfO+dHIOqba/+JfSDFUhrJrJmKQLf+5SpZ8pSLx5N2Ss1O16e04BiuKc3dWbTY3S
        NQPpwmIpB/5YIXNNoQY6Fc8LUbuJEyA057bTPEk4rYlB7eguf+gsYwEUs725fn0Z8w9/
        YcVQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9IczFaoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.6.2 DYNA|AUTH)
        with ESMTPSA id 60b02dw4JDNul1I
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 19 May 2020 15:23:56 +0200 (CEST)
Date:   Tue, 19 May 2020 15:23:54 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
Message-ID: <20200519132354.GB4623@gerhold.net>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-3-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519124402.26076-3-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 02:43:52PM +0200, Jonathan Albrieux wrote:
> Add reset-gpio support.
> 
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheed says that, if not used, reset pin should be connected

datasheed -> datasheet

> to VID. This patch emulates this situation.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../devicetree/bindings/iio/magnetometer/ak8975.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> index 86e3efa693a8..a82c0ff5d098 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> @@ -37,6 +37,9 @@ properties:
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix
>  
> +  reset-gpio:
> +    description: an optional pin needed for AK09911 to set the reset state

Maybe add a comment that this should be "usually active low".

> +
>  required:
>    - compatible
>    - reg
> @@ -53,6 +56,7 @@ examples:
>              reg = <0x0c>;
>              gpios = <&gpj0 7 0>;
>              vdd-supply = <&ldo_3v3_gnss>;
> +            reset-gpio = <&msmgpio 111 1>;

Same here, reset-gpio = <&msmgpio 111 GPIO_ACTIVE_LOW>,
would be more clear.

>              mount-matrix = "-0.984807753012208",  /* x0 */
>                             "0",                   /* y0 */
>                             "-0.173648177666930",  /* z0 */
> -- 
> 2.17.1
