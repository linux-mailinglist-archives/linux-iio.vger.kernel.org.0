Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D622601BD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgIGRMR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 13:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbgIGRMM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 13:12:12 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA43217A0;
        Mon,  7 Sep 2020 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599498731;
        bh=DPat3ZlRzIlx3pGvdlS9ov4+JwXoTqRT6aH65lpZpUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDIxuj2XhhhEEqVgjAA3HcCmq5ToR/R66AcQtmotmjrIDZak1xnhMwZhFXqG9mJVl
         7gx4HAq0nxoE/XiAVFScPLr9HnUwWyEzmXGrGcVisKN4f76KZkCiy8vk4j7HSLwCIM
         zLC88dGIlGzNeTM4sDs8L5lj74Oyn5DD+fXSDc78=
Received: by mail-ed1-f46.google.com with SMTP id c10so13404467edk.6;
        Mon, 07 Sep 2020 10:12:11 -0700 (PDT)
X-Gm-Message-State: AOAM5305R91HP1SniJPOH1bTem9grAExEjciNUjX+7V/6HqighDmuHdT
        PdUIZMn73wB0QGOc2EIEL6LBB88HMaZwNRGeh9Y=
X-Google-Smtp-Source: ABdhPJzMyTdkAJy73PxNoZs+gNdlcqSGeh07/2bjshW3rB0M3t0yIQeyrq5QnkZWdasM4Y6BXvKIZqTmLZdf4IZC5FI=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr23231660eds.132.1599498730074;
 Mon, 07 Sep 2020 10:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200907161141.31034-1-krzk@kernel.org> <20200907161141.31034-3-krzk@kernel.org>
 <20200907173819.00005a48@Huawei.com>
In-Reply-To: <20200907173819.00005a48@Huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 7 Sep 2020 19:11:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe0W_+hN=pk9F5O61w7riYuBhmK3=JvrYzDY8LU7xvH4A@mail.gmail.com>
Message-ID: <CAJKOXPe0W_+hN=pk9F5O61w7riYuBhmK3=JvrYzDY8LU7xvH4A@mail.gmail.com>
Subject: Re: [PATCH 02/25] dt-bindings: iio: adc: exynos-adc: require second
 interrupt with touch screen
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Sep 2020 at 18:39, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon,  7 Sep 2020 18:11:18 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> > screen.  In such case the second interrupt is required.  This second
> > interrupt can be anyway provided, even without touch screens.  This
> > fixes dtbs_check warnings like:
> >
> >   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
>
> Or I can pick this up through the IIO tree if that makes sense.
> I doubt anything else will touch this binding this cycle, so either
> way works for me.

Let's wait for Rob's review and then if you could, please pick it up.

Best regards,
Krzysztof
