Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712BF36E9A9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhD2Lgj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Lgj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 07:36:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A1C06138B;
        Thu, 29 Apr 2021 04:35:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so8610522pjz.0;
        Thu, 29 Apr 2021 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=my3TuAp3AQ/+HxcIPd/AU9V8ewfolfT6HrtnGFkYxlk=;
        b=oUtYFFWwgyCXZJp9kGWCalfR+hm+j2TPSUM9RBqksFWiPSEHAd1bYrO/Bo7awHdr0c
         x2oJ2cPRScXyRbXmoBy55YKwC+fylfC0LtGWeR8Z59heLhLXYC9JdqpGtUvbNvtrhW5h
         8pFWGL7w/zUui11EP93nmXOb3kAy89txQjQ1fouUEIJEqv3CJxPRUDTksc40YYRov8yZ
         k+8/88jEZDkSHXhT1BicFSKwTr9gs/piWETP+S85cT6wX7xq76qtzD3fhj0jM11No29T
         jb+ITQXSEH8xnN5Nd1p++za+2eel1l48y41OBhIoYeiWbVG/94W+Vsfl7HkfT2gnUZ0t
         AfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=my3TuAp3AQ/+HxcIPd/AU9V8ewfolfT6HrtnGFkYxlk=;
        b=TwWggrMUU2H5E8HXzoXzsst9HHi2IN++B0hGn+u7CyYJ7pnXvEveY9mLWb75RJhQim
         rIvMvX+64Ugfyl9jnlovNh47s5kpqInrhIYr8PO8nikDABUASffgBsQyHxL1gqwFmkhs
         LyNt3FmxRRwhlfe7nUd/KFUzB7xtjHztMaEypEm1mhzaQmO/Lx4HW8wu7Je+t3hGjvzq
         GID4zzyQ0oTWfPfpOMGGxEwfBGc0Nl5eh9JHVLwfX+Sx5Hy9hL+NWtggFyBdsWsLIf3r
         9FOBsE8N7gOyIhj4iwWoQX0N1QEc4yN//nAqOeuoITHECCw9PDoWTRlCvL9dG/+l+rTx
         YsMQ==
X-Gm-Message-State: AOAM530UG6V/zhF6xSCs/bH/8z0Ql+15nN/jQ4ak2lNCbRCx4tVMbY84
        af7vFacO1DmgcMuhj9L7t7vt5oeXYZO7xNv8AUM=
X-Google-Smtp-Source: ABdhPJyvnbw1BSoEp40AyWEfcxAIICKwgG0MwL2RvyRGA+EbrjL5QQ+MXVtWhYVIXBObI/okHuAzW1CG3ro1Gzuo2JY=
X-Received: by 2002:a17:90b:1184:: with SMTP id gk4mr9339818pjb.129.1619696150985;
 Thu, 29 Apr 2021 04:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210428082203.3587022-1-sean@geanix.com> <20210428082203.3587022-2-sean@geanix.com>
 <28f1e2a4-b2fa-5e4a-954f-92d90966eaf7@metafoo.de> <CAHp75Vd1j=rqmzEuo9fQMYDc+Y1=8kfyVJq6VR4Oip-O918Xow@mail.gmail.com>
 <2cc54acd-1de2-b462-0f77-145244580999@metafoo.de>
In-Reply-To: <2cc54acd-1de2-b462-0f77-145244580999@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Apr 2021 14:35:34 +0300
Message-ID: <CAHp75VdptykxXy3dOR4sAZfzezt+7Fdk9yeWczFa1tGCZfzF+Q@mail.gmail.com>
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

On Thu, Apr 29, 2021 at 12:37 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 4/29/21 11:35 AM, Andy Shevchenko wrote:
> > On Thu, Apr 29, 2021 at 11:58 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >> On 4/28/21 10:22 AM, Sean Nyekjaer wrote:
> >>> Preparation commit for the next that adds hw buffered sampling
> > ...
> >
> >>> +     irq = of_irq_get_byname(of_node, "INT2");
> >> For this I'd use device_property_match_string(dev, "interrupt-names",
> >> "INT2"). Means it won't try to map the interrupt again, and also this is
> >> the only place where the driver directly depends on OF, everything else
> >> already uses the device_ API.
> > Why not platform_get_irq_byname_optional() ?
> Because it is not a platform device :)

Then device_property reading like this isn't really needed.

What is missed is fwnode_irq_get_by_name() API which will do the right
things on any resource provider.

-- 
With Best Regards,
Andy Shevchenko
