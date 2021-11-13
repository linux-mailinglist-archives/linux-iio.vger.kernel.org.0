Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6D44F497
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 19:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhKMSkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 13:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhKMSkW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Nov 2021 13:40:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77010C061766;
        Sat, 13 Nov 2021 10:37:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t18so32498023edd.8;
        Sat, 13 Nov 2021 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpSvUpikRucUdX60LvI6REv2A8stOS8mXEZ/NbJdaQY=;
        b=I7P8qGurTC/ME+aFCy/kn6i/xZvrCRF66dj5R5YdhpJUVi/ebHhMRxVA44ajDrWZq9
         MmbLlhViLM8ycecxiofX3vsktk3aAhyrt66s5UIgf5hg2QwbTnJ+cS8iVCJGrJsy7PPU
         fql0C+Fqd+NxkXUWlJXCBkoCUqFeZQzlMTUUwpe952Ezi5J5mutn6j3KdVLNDd4NAdDk
         iXDUWGDdsCozTJOSRLr5kdTarsWdXasqsgz/8KBcVKIc1B8KAMy+zFyGv4BAaIr+4O/V
         5+WFQ4mUoiBO//pzSeSDink1DDz820g3+v8zbt9XJgbvW96VwdJceSMc/O+ACUQcRq5C
         W9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpSvUpikRucUdX60LvI6REv2A8stOS8mXEZ/NbJdaQY=;
        b=W4GKLbnsTASDLII5M8+QZYWFOpeKgiwmDu5riRolHCfyTW0KWXahZ3ii983ybRkpmn
         OUdZBaBphW7Rmyzlys8TIUB1yhi2M4Iz+rXpr8nCl1e9mfpiwuzXpBmnHIbHhhe42myo
         w2tgskdZnzbQYSCn9zXoFJiI4IhOhU8tNebm7arFmrxupQnoNV/FsSMeE7XootdTmSZq
         huQyo6pf3Udw6Lo8eTw9X9gWJ0QervQPfEb5gdHefQBL7GcVYc0e6qiQRmX2cIMpwLfn
         JMipDY1avrwq/daSn+vNLe14sdT7AHYprligXY7CEalg4kS899K9TQjTygFomkDj4oHN
         aRWA==
X-Gm-Message-State: AOAM5302wn+p26LPNYHBdluGAkYClclU16gEBJKW/0/LQSEBgC+6VAwJ
        r/73xG6adV3iRfCKhc2a/Iau6gwP+huOwSpFE70=
X-Google-Smtp-Source: ABdhPJwEMQ+g6yxxn09uU46RR+89QOAkCaqWTejN7PPKmBboGmC4vrDXw28kIY1TlC67wIfgmn6QSTmQQ4hoSMy7ReM=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr31270993ejb.377.1636828647958;
 Sat, 13 Nov 2021 10:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com> <20211113161724.371e4bcf@jic23-huawei>
In-Reply-To: <20211113161724.371e4bcf@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Nov 2021 20:36:51 +0200
Message-ID: <CAHp75Vfz7zPXg2E=7Q+E-QnvfdHEDv7eFin1srjVZ53PtrMz7g@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 13, 2021 at 6:12 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 8 Nov 2021 21:05:07 +0000
> Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

...

> +Cc Andy for a question on of_iomap() and whether we should add something similar
> to the generic firmware handling.  Personally I'd be happy with leaving it for
> now on basis of it being something to come back and tidy up later, but would
> like your opinion as you are more familiar with that stuff.

Thanks, let me look into it...

...

> > +static int ams_init_module(struct iio_dev *indio_dev, struct fwnode_handle *np,

np --> fwnode

> > +                        struct iio_chan_spec *channels)
> > +{
> > +     struct ams *ams = iio_priv(indio_dev);
> > +     struct device *dev = indio_dev->dev.parent;

> > +     struct device_node *node;
> > +     int num_channels = 0;
> > +     int ret;
> > +
> > +     node = to_of_node(np);
> > +     if (fwnode_property_match_string(np, "compatible",
> > +                                      "xlnx,zynqmp-ams-ps") == 0) {
> > +             ams->ps_base = of_iomap(node, 0);
> > +             if (!ams->ps_base)
> > +                     return -ENXIO;
> > +             ret = devm_add_action_or_reset(dev, ams_iounmap, ams->ps_base);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             /* add PS channels to iio device channels */
> > +             memcpy(channels + num_channels, ams_ps_channels,
> > +                    sizeof(ams_ps_channels));
> > +             num_channels += ARRAY_SIZE(ams_ps_channels);
> > +     } else if (fwnode_property_match_string(np, "compatible",
> > +                                             "xlnx,zynqmp-ams-pl") == 0) {
> > +             ams->pl_base = of_iomap(node, 0);
>
> Hmm. So of_iomap() leaves us dependent on dt specific calls. Whilst it doesn't
> exactly look hard to create a generic version covering at least dt and acpi
> I don' think there is an equivalent acpi function currently defined.
>
> Andy, do you think this is a good thing to add to the generic firmware node
> handling?  It's a bit specialist as most of the time this will be wrapped up
> in the platform device handling or similar rather than being in a child node like this.

I saw this issue previously somewhere else and we can do something about it.
But first (before going to ACPI guts) we may indeed introduce a basic
skeleton under fwnode API for this.

Something like

void __iomem *fwnode_iomap(...)
{
  if (is_of_node(fwnode))
    return of_iomap();
  return NULL;
}
EXPORT_SYMBOL_GPL(fwnode_iomap);

At least it will allow drivers to make them property provider agnostic.

Okay, I checked the current version of the ACPI specification and the
proposed DTS here. With above API and something like

Device (AMS0) {
  Name (_CRS, ...)
  ...
  Device (PLMN) {
    Name (_CRS, ...)
  }
  Device (PSMN) {
    Name (_CRS, ...)
  }
}

we may get the resource from the corresponding fwnode's _CRS object.

> > +             if (!ams->pl_base)
> > +                     return -ENXIO;

...

> > +     /* Initialize buffer for channel specification */
> > +     ams_channels = kzalloc(sizeof(ams_ps_channels) +
> > +                            sizeof(ams_pl_channels) +
> > +                            sizeof(ams_ctrl_channels), GFP_KERNEL);

Make a use of something from overflow.h.


> > +     if (!ams_channels)
> > +             return -ENOMEM;

--
With Best Regards,
Andy Shevchenko
