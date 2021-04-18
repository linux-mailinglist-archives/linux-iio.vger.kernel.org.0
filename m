Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69317363801
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhDRWRe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 18:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhDRWRd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 18:17:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F973C06174A;
        Sun, 18 Apr 2021 15:17:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso5286368wmq.1;
        Sun, 18 Apr 2021 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MakLW4/ABJt5A2wbd0oookNXhTi2QU35p1hgi1JeVaQ=;
        b=RIcsx4Qj/fYUqHsay8hlOGfVyRR9i3jEw6oCGvUEWEXprIcJ3NvqfYRqeKU+q5clT4
         E8G9J3UgbBrz8cUBc0efK2kfZYH1NV9jSJyPbeDbl5kOe7Cae8HM7oTdJU3pRGksemBu
         zyMoVKbb5Ek89cIqUkp35oyCMGTjHOdbJsd/i39iXBoyacSwrB1zMdcvMrhJf+Deme4r
         6+sTnoUqxgLUQEHna2l2YG6QpZXNcfAmYRFLQXz0P/RSrNoJQ0JcXNOlIISd5IiSZyNa
         KQIUHLMVc9CmozdgWYGbFtH49NHsPAQrDfpP/736+pgSA12Ucjwbpemcpd2sYvNCFjdR
         08pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MakLW4/ABJt5A2wbd0oookNXhTi2QU35p1hgi1JeVaQ=;
        b=Q5lqST0XwSsgqxIE2Q6a4dMwme7TxLq05xBDC0tCRLvGIOHeaGhCvsjS9tYp0t7nk4
         vRH/SrmkRI0Rrh5o3xebwH/wB3kQxRx4ov0lu3zfbuHAgxew/6VBGvOOLNv3wRlC0a+I
         X5zAzWUvudWqUrHvB8/ey3ocEdj6dVA/kltltxccPSko2Q9boXxGvoYz8MTS4eka6ne0
         ZmBy+tK26+p9teU1+MynXF1/P69zNVU8CSvo6ElaMLLY+Qt1S2l4xivSLrErFEpnYJdJ
         HWkU5d7VRSRzI3PLQRvm0833Mf85/bkJXx3C0G1KO8aPR3/9GxYQchlPZpUic7dTrAlh
         YlIw==
X-Gm-Message-State: AOAM530EVzPErprt5PNmeiJdqkhzNZKa5ZvOaHTpfoft4hVNcugBJTBA
        SU/sKYT4pnZoKF7mtQCIj3VEK2g60No=
X-Google-Smtp-Source: ABdhPJwXcQQ0S/0sj9OBcptSDCVIfr5v3KiLoVygwWGT/UNTo5Qp4hhb6/3ncjo7xost7PYxIxnFoA==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr2504688wmq.147.1618784222206;
        Sun, 18 Apr 2021 15:17:02 -0700 (PDT)
Received: from pop-os.localdomain ([2a01:4b00:8534:a300:35c9:f774:7b2:b3ba])
        by smtp.gmail.com with ESMTPSA id p18sm19409239wrs.68.2021.04.18.15.17.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Apr 2021 15:17:01 -0700 (PDT)
Date:   Sun, 18 Apr 2021 23:17:00 +0100
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] Added AMS tsl2591 driver implementation
Message-ID: <20210418221659.iyzihpmgkggsb5id@pop-os.localdomain>
References: <20210416174902.9036-1-joe.g.sandom@gmail.com>
 <CAHp75VeSNDdY_jUsgy06mLpLVXnuyw3NjvxJBN6D-cxV5-VvUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeSNDdY_jUsgy06mLpLVXnuyw3NjvxJBN6D-cxV5-VvUg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 17, 2021 at 03:50:16PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 16, 2021 at 8:49 PM Joe Sandom <joe.g.sandom@gmail.com> wrote:
> >
> > Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
> >
> > This driver supports configuration via device tree and sysfs.
> > Supported channels for raw infrared light intensity,
> > raw combined light intensity and illuminance in lux.
> > The driver additionally supports iio events on lower and
> > upper thresholds.
> >
> > This is a very-high sensitivity light-to-digital converter that
> > transforms light intensity into a digital signal.
> 
> Hmm... It's v8 and the subject line is wrongly formatted.
> Please add the corresponding prefix "iio: light: ..."
> 
Thanks for pointing that out Andy. I'll be sure to correct this in v9.

> Otherwise it's in very good shape.
> 
> ...
> 
> > +/* TSL2591 enable register definitions */
> > +#define TSL2591_PWR_ON              0x01
> > +#define TSL2591_PWR_OFF             0x00
> 
> > +#define TSL2591_ENABLE_ALS          0x02
> > +#define TSL2591_ENABLE_ALS_INT      0x10
> > +#define TSL2591_ENABLE_SLEEP_INT    0x40
> > +#define TSL2591_ENABLE_NP_INT       0x80
> 
> Is it a bitfield?
> 
> ...
> 
> > +       als_lower_l = als_lower_threshold;
> 
> >> 0, but it's up to you.
> 
> > +       als_lower_h = als_lower_threshold >> 8;
> 
> ...
> 
> > +       als_upper_l = als_upper_threshold;
> > +       als_upper_h = als_upper_threshold >> 8;
> 
> Ditto.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
