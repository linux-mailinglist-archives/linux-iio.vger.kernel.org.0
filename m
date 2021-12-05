Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857404688CF
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 02:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhLEBGR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 20:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhLEBGR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 20:06:17 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC4C0613F8
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:02:50 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r26so13949873oiw.5
        for <linux-iio@vger.kernel.org>; Sat, 04 Dec 2021 17:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LvhQcy+FYe5J3oaGjHRqFXctehdOYam1zdymsCNBpc=;
        b=GpQxAjXjEnLsarnH8PQBJ4SvWwN5dVkZMG/Xt4X+60ZQ6UswxtW9bIDlLT3H0XDFbQ
         1ZTQLzsrf5FsikRTKiUF20Q4/zNi+Hwo3dvvGonipelvLB43gP7Kjeo6puGh1eDDH+lI
         CKfVFBGAnLygmH9xLyt1VNmLlv01k7m23rXPspOR5yEDG2nGJIkzVNCXF4b0I3DHDlV2
         m5k95ciB6APw9BoAC6x+hpEDx+4BigHSaPmzv1GmLjJmV6pP4jWE/APkr0TLqoBYfFqD
         gkW5qdeq0NoIwUASvxoCigYwXAkbVW/Nn9uFJZ5gCIOVgegqhora4OKtMyYSCj17cWKs
         KwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LvhQcy+FYe5J3oaGjHRqFXctehdOYam1zdymsCNBpc=;
        b=i5mi97adOMaLVkINiSSRscTw1Rjp3Js6JXmARvM4uOxZK8N2vN7DFwdjosBl0PDZ+q
         HYyMJ/JljjXzXML2etxa+ZxF7rg/jFHKkKdalWb/vglaCAcupnPbHHU1LrCc1IsGfu7T
         RIo2i6/Vq3I869r5pAjaeGH3GjV0cqatWRULR312hJieIcNAeAj2oDhb+MCID1zexlWX
         9Ed6bUQ5q6hM7hBNRN5mfYObRqe9tWaO1SIR8y4x2z+Avw+jmSACVPluGGUZeKi3EHdP
         9CQrx6WWt9kteQYJTjDhBk3+y5UyHEBzbI62xZxu0PLVi4KtC70WDkJBXK0RxukYXLiB
         4dsw==
X-Gm-Message-State: AOAM531r/DRikvBvqAbNF9Sabt9Nsh/jS4gfOFPtXUwvUYHcMaCJocPb
        2l2jlN+qIyD8JpE9g965GJIJB0Ou/WhSfJPExQNqug==
X-Google-Smtp-Source: ABdhPJx37JmDCF4udWikxvyYR+A61VK5ZTA+rE98rwMCchDdOGah0Qhuu36oWF7iNmYFmk4fu077FerEd5zWBBPkkng=
X-Received: by 2002:aca:120f:: with SMTP id 15mr16756308ois.132.1638666170322;
 Sat, 04 Dec 2021 17:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20211118141233.247907-1-boger@wirenboard.com> <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour> <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
 <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org> <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
 <20211201110241.kts5caycdmzqtp3i@fiqs> <4fd167ed-d5dc-358a-00f5-6590f4c20a68@wirenboard.com>
 <20211203204754.2ucaiiwyrvbtwgbz@earth.universe> <20211204152621.4f15b3d0@jic23-huawei>
In-Reply-To: <20211204152621.4f15b3d0@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Dec 2021 02:02:38 +0100
Message-ID: <CACRpkdZ+WWz7JoyE3a1Ra8dx27YcHH6zRNcTmNJyX_vfcu0n7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP PMICs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 4, 2021 at 4:21 PM Jonathan Cameron <jic23@kernel.org> wrote:

> If we were going to do something like this, I'd see the battery as a
> consumer of the the temperature measurement from the NTC (might also consume other
> things from axp directly).  So it should be
>
> Temperature / events flow.
>
> battery <---temperature----- NTC driver <--Voltage----   axp

That's the idea.

I think the battery will get a handle on a thermal zone and then
you get the temperature from that.

> Threshold configuration flow
>
> battery --temp thresh-----> NTC driver ---volt thres--> axp

I don't understand this so not commenting.

> > > Personally, I think better approach with NTCs is to place the
> > > resistance-temperature tables for bunch of models to .dtsi
> > > files, describe the thermistor node in DT and then make all drivers (hwmon
> > > NTC, iio-afe, this one) to use this data in the same way
> > > it's done with monitored-battery node.

The DT maintainers are not happy about the device tree being used
as a general data container. The rule of thumb is that things that are
configurable should be in the device tree, things which are hard data
from a datasheet should be in a struct in the driver, and the compatible
string tells you which data to use.

For an NTC the resistance-to-temperature is a clear case of data from
a datasheet and should not be in the device tree but in a table in
the kernel.

> Agreed those tables would be needed whatever the solution.  We might
> stick to 'standard' tables for simple cases but someone will always wire
> a circuit up that does something we haven't thought of.

What we usually do is model the wiring in the device tree like we (I) have
already done with much pain in:
Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml

> > Linus W. recently sent a series for NTC support in power-supply
> > core, please synchronize with him (added to Cc):
> >
> > https://lore.kernel.org/linux-pm/20211122234141.3356340-1-linus.walleij@linaro.org/

For the type of battery described in
Documentation/devicetree/bindings/power/supply/battery.yaml
a thermistor node inside the battery will be needed and then code
added to the power management core to spawn a OF-based
platform device from that.

battery: battery {
        compatible = "simple-battery";

        ntc-resistor {
                ...
        };
};

For the Samsung batteries my plan is to spawn a platform device from inside the
Samsung battery driver and add pull-down resistor value and
compatible using software nodes from within the kernel.

Since I already have the compatible of the battery itself, I know
which thermistor this is and how it is mounted with an ID resistor
as pull-down and Samsung batteries can just hardcode that from the
kernel without
modeling the resistor in the device tree at all.

Yours,
Linus Walleij
