Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E636F767
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhD3Izp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3Izp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 04:55:45 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE2C06174A;
        Fri, 30 Apr 2021 01:54:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j6so8637906pfh.5;
        Fri, 30 Apr 2021 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amPt7GENecI5RZIuIegdl9lEK8dib9aTLCmx2zlJxqc=;
        b=Pj9PtB+mOxG5qnAs2g84MDbWlrI3JxpSGfEnVjm3jKxNPTwScLjgubZREBWewJPNPC
         +o6txmu05Gm0BOFz2/2tyU73eKWtMaAi3vor3auwbU8NZBDhdcHnjQ1AZEFwvEwtayEL
         HThSkIUSa/2ixPlxDChzHcp71b42vGMWIqs2xAHm8Ml3EwwNI9IrI2Oc3rLx39IyEy5H
         +OPTKWnjPorjLy3NbVw8XuW+ah+dl+wX1ZYb8D0/8eKRTEoA9sNV68YZUIpxvU6f3x6O
         /ncNYyZAyqK4yMxcd5N+NnkRvts1DpsLTgLTdhwOs7ynVgkOReGa9XrL5ArHIsgrodiF
         B0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amPt7GENecI5RZIuIegdl9lEK8dib9aTLCmx2zlJxqc=;
        b=VCupngHPfEKUxUvI+wqZv8adYsGZKXMKJoduUZkE27m3jNzK6fxBp85RZHzRBbFWA8
         +E3dpl9bBUf9VZJu6vtPGscDsbeXZ+6WozuAKtP6QUaPPkqL2hH/We+RiGediYvBgsf4
         JFppngZ5QFekB68SMxv/tfnsS+XT+J+kez824jShOImwy47FpMuHlchdwPVWhHPz5gea
         orW/0kMIs4Yc8qIaLHKldQQhtLnSaxiPI6p6rkzyoQrmr+uAJ1lxiNe8tHSY0+TEyLRq
         i82zsjMa4mlo4Ge9eo+pTnM/0x0DtYZ4hEGLC4+eYIRO8G5tiyEQNIYIBrECnyGDlm7v
         UYXA==
X-Gm-Message-State: AOAM533xzyxxPyvRlLFLheLmEdF3JUmZR1781QDy0Kb2Ema3RmSTjKhM
        WabgTfQSFT3eh59elOCfurB/sRsZ3b6R1zTPQHRR2g3YqOPwrA==
X-Google-Smtp-Source: ABdhPJw4FZ/DlItoOrzKjOiieaLEOQz40U4pteDPNNLHlAEydjA8bAEApTSsRokhPBg36wiB9KrsgcXOFxGFGb3JTSg=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr4159308pfb.7.1619772897114; Fri, 30
 Apr 2021 01:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210428082203.3587022-1-sean@geanix.com> <20210428082203.3587022-2-sean@geanix.com>
 <28f1e2a4-b2fa-5e4a-954f-92d90966eaf7@metafoo.de> <CAHp75Vd1j=rqmzEuo9fQMYDc+Y1=8kfyVJq6VR4Oip-O918Xow@mail.gmail.com>
 <2cc54acd-1de2-b462-0f77-145244580999@metafoo.de> <CAHp75VdptykxXy3dOR4sAZfzezt+7Fdk9yeWczFa1tGCZfzF+Q@mail.gmail.com>
 <1abf8476-e1e3-5c0e-e480-daa7c291b4c8@metafoo.de>
In-Reply-To: <1abf8476-e1e3-5c0e-e480-daa7c291b4c8@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 11:54:40 +0300
Message-ID: <CAHp75VdBxVbPnxk1uh_DaCw56x0qCn9CgcrLt0uvJp-hFUyiRQ@mail.gmail.com>
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

On Thu, Apr 29, 2021 at 10:19 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 4/29/21 1:35 PM, Andy Shevchenko wrote:
> > On Thu, Apr 29, 2021 at 12:37 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >> On 4/29/21 11:35 AM, Andy Shevchenko wrote:
> >>> On Thu, Apr 29, 2021 at 11:58 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>>> On 4/28/21 10:22 AM, Sean Nyekjaer wrote:
> >>>>> Preparation commit for the next that adds hw buffered sampling
> >>> ...
> >>>
> >>>>> +     irq = of_irq_get_byname(of_node, "INT2");
> >>>> For this I'd use device_property_match_string(dev, "interrupt-names",
> >>>> "INT2"). Means it won't try to map the interrupt again, and also this is
> >>>> the only place where the driver directly depends on OF, everything else
> >>>> already uses the device_ API.
> >>> Why not platform_get_irq_byname_optional() ?
> >> Because it is not a platform device :)
> > Then device_property reading like this isn't really needed.
> Why?

Because it doesn't bring any value in this case and actually makes
readers confused. ACPI doesn't have properties started with # (they
are special for OF and hiding it behind device property API is not
correct).

So, either leave it OF, or introduce the above API (or use existing
fwnode_get_irq() by index).

-- 
With Best Regards,
Andy Shevchenko
