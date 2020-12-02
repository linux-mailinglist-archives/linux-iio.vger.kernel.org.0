Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA22CBF2D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 15:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLBOKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 09:10:49 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:33128 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgLBOKt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 09:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606918077;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Q2NLxqTA1+ywheFhNlMBN+OBsRrcqR0PdEBfDF1ET8Q=;
        b=VGVVaVmQ4E0MMHKezzRkgIJSVDqRbGPwiLSyF6pjX4Eq5+rWKSn5icE+SajiZ9UlAF
        IjIgRP3Ha4GS9UdEz7YVJhqUt0kq/+yFUVjz95n9rjef+/yyUIy0nOEpxsoXcrPqzL61
        wiWAF2fSN7cwQpdkTiD9snesxsXA3gecRl/hLuV/GE5gteIHy9n6bXT6kdu1jv+84Lwj
        h7KT6PGA+TG+SKUUw4LlDlasds0U7GKSaMii0nDOKN+d+PJktUS5kZ0vGXjQScxTIPK7
        Ys6D11x2Er6y5fnZmmCKmMfGBqzGZXIG75cSOKTauj5oLXk7EOywSrZQbuqu8tv/Z/Ty
        k1JA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8jxIc/Daoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB2E7ua6m
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 15:07:56 +0100 (CET)
Date:   Wed, 2 Dec 2020 15:07:51 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055
 compatible
Message-ID: <X8eft05jIxD382Mt@gerhold.net>
References: <20201202083551.7753-1-stephan@gerhold.net>
 <CACRpkdYu77Tcv9bk8q_BfKmien0S2sRg3Kicd_AeSrzrKD+Ywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYu77Tcv9bk8q_BfKmien0S2sRg3Kicd_AeSrzrKD+Ywg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 02, 2020 at 01:08:57PM +0100, Linus Walleij wrote:
> On Wed, Dec 2, 2020 at 9:36 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > The bmc150-accel-i2c.c driver has an "_accel" suffix for the
> > compatibles of BMC150 and BMI055. This is necessary because BMC150
> > contains both accelerometer (bosch,bmc150_accel) and magnetometer
> > (bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.
> >
> > However, the binding documentation suggests using "bosch,bmc150".
> > Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
> > match what is expected by the driver.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> I see this pattern elsewhere so by tradition:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I suppose this is one of those situations where the two parts of the
> component are on the same physical I2C bus, and phsycially inside
> the same package, but accessed at two different I2C addresses?
> 

Yep, it looks like this (from
arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi):

&blsp_i2c2 {
	status = "okay";

	accelerometer@10 {
		compatible = "bosch,bmc150_accel";
		reg = <0x10>;
		interrupt-parent = <&msmgpio>;
		interrupts = <115 IRQ_TYPE_EDGE_RISING>;
	};

	magnetometer@12 {
		compatible = "bosch,bmc150_magn";
		reg = <0x12>;
	};
};

They look pretty much like separate components in the device tree.

> These components are kind of ambiguous by nature. Technically
> both devices could have the same compatible (by the label on the
> package) but then we would need some other property on the node
> to say which compatible is for which part of the component,
> so tagging on "_function" like bmc150_accel and bmc150_magn
> is one way to solve this, and I don't know anything better.
> 

The _accel and _magn compatibles are also actively used already, so
unless there is a significantly better option I think it's better to
keep existing uses working.

Thanks!
Stephan
