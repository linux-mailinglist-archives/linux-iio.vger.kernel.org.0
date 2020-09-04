Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582A725D365
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIDITu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 04:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgIDITt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 04:19:49 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A7C061244;
        Fri,  4 Sep 2020 01:19:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 3so5836115oih.0;
        Fri, 04 Sep 2020 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9p6cCuEJ0Kd4XEWKLM+mNWslgz5UQcFUd+4LCcx7ZxE=;
        b=tLCxElJ/l2c0CzybrIMtews6zsJbIUMM6Urb9nFwT1WjtZihS0ItcqIdKmtgj3q087
         /Q1s1+UAhDSXPuh/hVeYtM3UXmXva5bDMqzEcMTp2l3sEVfOaNvljJTDP6wq/VwpEOIa
         py/273kg/t5RlW5auBar6bx61rt6GAT0DI2SIt49SxksD9rrjofkJYdpVn/hYc0GPOrT
         XqiV0S7kUMN0I+ZWYU7z7f+Z1TzS0V9LTAlt5kjwoOMMOi5O0s/Egop6UssUK1+NanF8
         dv1Pz8gvOtWeel7wI36IpDfnPvSHj4p6+FeviLCKpHZucy7kdy9zr7T+hWLuVJLK7hg5
         Ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9p6cCuEJ0Kd4XEWKLM+mNWslgz5UQcFUd+4LCcx7ZxE=;
        b=MwJu543EjUlUopUeOsBGWbZ8gAZS4FRMDYMQxKsXlZTkjIfOwcwQpmWLyRvzlEHGO1
         x/0ymj6LGWnQT0t5bEqxu9C2BrBYeDnQYPXru8CLbRQ3vL6dtausrQgWJiZuAFJZI/Dj
         vPv9F/ucLBqWznzM+DiZyp2Pni/q3J06+Mcy8NyNkPghPXWlgn/0rNx/IHckhYwWlpOt
         IQUgLNM8nqw9JW/4D9ms4C2UfVgeJkjOA2BgSXF0PWGLCROFrG694O/iP4pR94f9h8VO
         exV7jYSYH9Ho3onG9mmhR5s4KPV+LmDqPFl5QASG0U+cixuI/NtEKmUnT9Q0hDVrQcnT
         cqHw==
X-Gm-Message-State: AOAM530QZEmrmmoVphFLBRrwneMDN2G5rAOOJh4J+fp7SNwbF7IaOVEh
        OF7PGYC5//XM+JJwC3HbjFR4PXpLqYaQP85wJ4dbu2Tw7Xw=
X-Google-Smtp-Source: ABdhPJwCyTQ9yezSUlNXMX59CupY7j4Pkjl+sHL1KwRZOkTB/yM9lvExdwRpHDVdKBRtiiJDlPygN7eUuqFaElVFzPI=
X-Received: by 2002:a05:6808:695:: with SMTP id k21mr4442094oig.124.1599207586094;
 Fri, 04 Sep 2020 01:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181926.5606-1-krzk@kernel.org> <CAHp75VeXTN5gTv2Pj33N9EB9i2U7R+uvgZ-Ad4_SMgKkrB0F3g@mail.gmail.com>
In-Reply-To: <CAHp75VeXTN5gTv2Pj33N9EB9i2U7R+uvgZ-Ad4_SMgKkrB0F3g@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 4 Sep 2020 11:19:34 +0300
Message-ID: <CA+U=DsrYUke0YNMGw8zqgL=zfAjBY703mtLTWOTaixXNVCeCaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 10:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 9:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Emails to Beniamin Bia bounce with no such address so remove him from
> > maintainers.  After this removal, many entries for Analog Devices Inc
> > IIO drivers look exactly the same so consolidate them.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio <linux-iio@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> ...
>
> >  ANALOG DEVICES INC IIO DRIVERS
> >  M:     Lars-Peter Clausen <lars@metafoo.de>
> >  M:     Michael Hennerich <Michael.Hennerich@analog.com>
> > @@ -1152,8 +1101,11 @@ W:       http://wiki.analog.com/
> >  W:     http://ez.analog.com/community/linux-device-drivers
> >  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> >  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> > +F:     Documentation/devicetree/bindings/iio/*/adi,*
> > +F:     Documentation/devicetree/bindings/iio/dac/ad5758.txt
> >  F:     drivers/iio/*/ad*
> >  F:     drivers/iio/adc/ltc249*
> > +F:     drivers/iio/amplifiers/hmc425a.c
> >  F:     drivers/staging/iio/*/ad*
> >  X:     drivers/iio/*/adjd*
>
> >  STAGING - SEPS525 LCD CONTROLLER DRIVERS
> >  M:     Michael Hennerich <michael.hennerich@analog.com>
> > -M:     Beniamin Bia <beniamin.bia@analog.com>
> >  L:     linux-fbdev@vger.kernel.org
> >  S:     Supported
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
>
> It's not related to this series, but I'm wondering why the above
> binding is attached to a staging driver...

Looks like a copy+paste error.
Good catch.

>
> --
> With Best Regards,
> Andy Shevchenko
