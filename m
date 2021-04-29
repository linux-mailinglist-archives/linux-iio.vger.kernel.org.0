Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4EF36E80F
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhD2JgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhD2JgF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 05:36:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E71C06138B;
        Thu, 29 Apr 2021 02:35:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so4212513pju.2;
        Thu, 29 Apr 2021 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVXRus23N5eHQoHGw2fxcpvJ9XmlGDoX0zJymGZHLoM=;
        b=lVV8ltX7YP0X93+e846PvgeCLZXF1a510XXTS74GHq+/xLZh9RToZcGPlGhY38MZVe
         VOLw51eOda1RZe4CJ5HNiFrSZAoMX9h+dw4OsJpLLtRF3PsJNdTpirPwr+ULc8wn7b8Z
         QlAiFIYPLii0mBxCyrhH0gI8dySYjgOMwJN+IogJvdlHIgMJ/iKn7M7hDHNdu3P67JAZ
         0XO2nItwOu0HT4rwnuXi+UiIwvWQT15jg0bDaRpphIBRe1ysldgHxcxWLo5RgBmf93pj
         jX2XcxjQ7Ps6/+3oJ2UKnbwWv19ZmVOJrKqJZJCDRbwIimOSMPsxdGId1ZFdg9fH1MOK
         IQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVXRus23N5eHQoHGw2fxcpvJ9XmlGDoX0zJymGZHLoM=;
        b=orT+emJtsgcY2/pHRkeKxHAc7sTHoRTd1qoeA2Eydrnoek6CnXK0KMFrdsnbo9Jhak
         ji3OCj+SYoXDXj428/6cq+y6XO1fAH+dGNtWCDxas+fEqk3zs2Ph+mve6Cjt6rERWSUV
         CHqdl/pVuIQkw3PaQGfCRoyi1HeGw0xBuMhB0vPeGouRwa231TFlOSNlQo8CXRDQRXJ/
         NoE2PAv9OUKVA3/0UPkg8GKVG7pau8W3TUv/qKupQ7x+vE+djttDVs9rBqFPLeuK89SQ
         QUx/QFq02TBXBqnWu33uaFvDGPlmEuwWeqR8Vi2UPg7inxcQVpJFrIaaVwkIKH62SFPS
         AyaQ==
X-Gm-Message-State: AOAM5321lu1wzjHhKJjcQ2SbtDiJpZGy7IP6Su/NIDRRTCFh5F80iT8K
        b8zYg59GG8+6jw9S5EtfuUhodcxU9DlJCTneyQve5IMV0ic=
X-Google-Smtp-Source: ABdhPJwdWYYxNUkfbN77K21PyuCnXmtgoZpAIoDt0Gg9Rz0gREZWB/rvdb2WnUUX4bBv0BgGJQTGv+3CRBmYhqryw44=
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr38842010pjb.228.1619688918805;
 Thu, 29 Apr 2021 02:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210428082203.3587022-1-sean@geanix.com> <20210428082203.3587022-2-sean@geanix.com>
 <28f1e2a4-b2fa-5e4a-954f-92d90966eaf7@metafoo.de>
In-Reply-To: <28f1e2a4-b2fa-5e4a-954f-92d90966eaf7@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Apr 2021 12:35:02 +0300
Message-ID: <CAHp75Vd1j=rqmzEuo9fQMYDc+Y1=8kfyVJq6VR4Oip-O918Xow@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] iio: accel: fxls8962af: add interrupt support
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 29, 2021 at 11:58 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 4/28/21 10:22 AM, Sean Nyekjaer wrote:
> > Preparation commit for the next that adds hw buffered sampling

...

> > +     irq = of_irq_get_byname(of_node, "INT2");
>
> For this I'd use device_property_match_string(dev, "interrupt-names",
> "INT2"). Means it won't try to map the interrupt again, and also this is
> the only place where the driver directly depends on OF, everything else
> already uses the device_ API.

Why not platform_get_irq_byname_optional() ?

> > +     if (irq > 0) {
> > +             *pin = FXLS8962AF_PIN_INT2;
> > +             return;
> > +     }

-- 
With Best Regards,
Andy Shevchenko
