Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD6AC5D2
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfIGJWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 05:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbfIGJWR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 05:22:17 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C8421BE5;
        Sat,  7 Sep 2019 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848137;
        bh=fBxqwyXRgG0wRFfx6cCxY4NmxXwIILcA5XjIypH7uu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zlt5xhpjzApIWNI0gaW5dXnJE36f4x6ZxAlNBjEMz8N0zlqPrJsWJNfiU3dVG7nzu
         9SfXcDgvJMKWRPH5MJCJQGIakV8asCCscRsV7JOKfUpMlTXiIel38w92mwwilaeagH
         WA17Qenz/0v1sTheTNRpTvsItNdVbT5GsnEeSsV8=
Received: by mail-lf1-f48.google.com with SMTP id u29so6928258lfk.7;
        Sat, 07 Sep 2019 02:22:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWpij9d2Nastt7bu93WMRRO4PUrdsYQzpXYOdyCLmztJfpxTVT0
        uegrLfZUueoAav5Y4+IGw4MpHZ3ZwJ+G0+dx4Zs=
X-Google-Smtp-Source: APXvYqzmcslfK41HV4+HPxQdPrd5x829CWIRSwqYXaJYvVNobPvFr0tb37FSkJUy6tzZ75dlNx+LflPaZcO8QXTsVY4=
X-Received: by 2002:a19:7d55:: with SMTP id y82mr9373225lfc.106.1567848134943;
 Sat, 07 Sep 2019 02:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190823145356.6341-1-krzk@kernel.org> <20190823145356.6341-5-krzk@kernel.org>
 <CAL_JsqJybT41cEqiTriLMywUQj1BtAG_9muJ4=84OkF23y53CA@mail.gmail.com>
 <CAJKOXPc0SY_8BHMsWLN=1M3VQh41+bdBiH21L4KQPA+iLPYy+A@mail.gmail.com>
 <CAL_JsqKdsABWK9Og_f38T9zf3SCFFdhU8WOJ4uJjREantoYvYQ@mail.gmail.com>
 <CAJKOXPfnvu=c5f6AcOSiQ_9E-C2fMf9qbEpy1Tr3QvH8LgAtpQ@mail.gmail.com> <CAL_JsqKyj3s-Mn3q_Lna0w38K3DJzvKN5d72WHzqt4CUVf5X4Q@mail.gmail.com>
In-Reply-To: <CAL_JsqKyj3s-Mn3q_Lna0w38K3DJzvKN5d72WHzqt4CUVf5X4Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 7 Sep 2019 11:22:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfg4p1CAbXeF1++b7+OaR99RdeJGrkbusisNKNywoNHHg@mail.gmail.com>
Message-ID: <CAJKOXPfg4p1CAbXeF1++b7+OaR99RdeJGrkbusisNKNywoNHHg@mail.gmail.com>
Subject: Re: [RFC 5/9] dt-bindings: arm: samsung: Convert Exynos PMU bindings
 to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, notify@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Sep 2019 at 17:49, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > The bindings never required any specific ordering. Also the driver
> > just go through all indices and parses them.
> >
> > Your second syntax fails:
> > Documentation/devicetree/bindings/arm/samsung/pmu.yaml:
> > properties:clock-names:items: {'enum': ['clkout0', 'clkout1',
> > 'clkout2', 'clkout3', 'clkout4', 'clkout5', 'clkout6', 'clkout7',
> > 'clkout8', 'clkout9', 'clkout10', 'clkout11', 'clkout12', 'clkout13',
> > 'clkout14', 'clkout15', 'clkout16']} is not of type 'array'
>
> Update dt-schema and try again. It should be allowed now. You'll also
> need to define minItems and maxItems though.

Thanks, works!

Best regards,
Krzysztof
