Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386991E7F0E
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2Npl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 09:45:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37532 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgE2Npl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 09:45:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id e4so2686835ljn.4;
        Fri, 29 May 2020 06:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l50zvieDLS4zKDw/YL/iLEviMA7HLF9b0G8jpz91/Yo=;
        b=E3Qp9JqZLa6VcWCDr/nLMS2g0VwL6UOTMMUApYS+glsjAsuG6aMNixP1qqN+GfIORh
         76RvhIeMgxFDxsRxfY+JSvc9XZrEjwAkWhBdBUMlCucaYoOL7a2Hxg8Mo1/Z3ESssb0s
         e5Kb7mXP6Srlj8pzGkePqDzpfTxemlm4ojZDBCCfSB57W27k63bYf67B3iaifBtIf1+L
         8DC9XGBm+Mf1Sc8o2XD+sZbreEb2X8F3lZ91iOVE7TUsN1ZgtwUq1msiD1TPDJnMix/P
         hgIkMtxh6fgTDYpSxscuZrKnhK3QuOPo2dSiz5NGb0zGOWdhBgnlbxYBq4AxVC+Ymlvi
         so9Q==
X-Gm-Message-State: AOAM531/k2VQOsM0wzf/VcVfHoQBLuX1UGYAj6PEEm/8vk+94FyLpKoi
        mWM+Wa4tXoMwj4fzOiNCTbg=
X-Google-Smtp-Source: ABdhPJwwl/gV7oBpVa4coDOoCycUzZ0AhD4gCrOT5sULHYF43JsIPx3Rir1VcEeVkW0rvDRtthbbjA==
X-Received: by 2002:a2e:9805:: with SMTP id a5mr4048592ljj.384.1590759938174;
        Fri, 29 May 2020 06:45:38 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id c22sm400347lfi.79.2020.05.29.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:45:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jefKH-0005Hq-OZ; Fri, 29 May 2020 15:45:33 +0200
Date:   Fri, 29 May 2020 15:45:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent
 assignment
Message-ID: <20200529134533.GD19480@localhost>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
 <20200522082208.383631-4-alexandru.ardelean@analog.com>
 <20200529101608.GC19480@localhost>
 <05500c815f4881a6aa86c809c5ac53e8af3f3e91.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05500c815f4881a6aa86c809c5ac53e8af3f3e91.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[ Trimming CC to something more reasonable... ]

On Fri, May 29, 2020 at 11:08:38AM +0000, Ardelean, Alexandru wrote:
> On Fri, 2020-05-29 at 12:16 +0200, Johan Hovold wrote:
> > On Fri, May 22, 2020 at 11:22:07AM +0300, Alexandru Ardelean wrote:
> > > This assignment is the more peculiar of the bunch as it assigns the parent
> > > of the platform-device's device (i.e. pdev->dev.parent) as the IIO device's
> > > parent.
> > > 
> > > It's unclear whether this is intentional or not.
> > > Hence it is in it's own patch.
> > 
> > Yeah, we have a few mfd drivers whose child drivers registers their
> > class devices directly under the parent mfd device rather than the
> > corresponding child platform device.
> > 
> > Since it's done consistently I think you need to update them all if you
> > really want to change this. 
> > 
> > And it may not be worth it since at least in theory someone could now be
> > relying on this topology.
> 
> Thanks for the feedback.
> I guess, it could make sense to do here:
>       devm_iio_device_alloc(pdev->dev.parent, ...)
> 
> Currently it's:
>       devm_iio_device_alloc(&pdev->dev, ...)
> 
> That would make it slightly more consistent.  i.e. the life-time of
> the object would be attached to the parent of the platform device,
> versus the platform-device.

Not really. If you unbind the iio driver, the iio device gets
deregistered (as it should be) and there's no need to keep it around any
more.

You'd essentially just leak resources every time you rebind the driver
(e.g. during development).

And in fact, you could also introduce a use-after-free depending on if
the parent mfd driver use devres to deregister its children.

> Currently, as it is, the allocation [of the IIO device] is tied the
> platform-device, and the IIO registration to the parent (of the
> platform-device).

Not quite; the iio device still gets deregistered when the platform
device is unbound.

> I'm not super-familiar with the internals here, but does this sound a
> bit wrong?

It's not a common pattern but not necessarily wrong per se.

> Is there a chance where the IIO device could be de-allocated, while
> registered?

No, the device-managed iio device object is freed when the platform
device is unbound and specifically after the iio device has been
deregistered.

> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  drivers/iio/light/lm3533-als.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> > > index bc196c212881..0f380ec8d30c 100644
> > > --- a/drivers/iio/light/lm3533-als.c
> > > +++ b/drivers/iio/light/lm3533-als.c
> > > @@ -852,7 +852,6 @@ static int lm3533_als_probe(struct platform_device
> > > *pdev)
> > >  	indio_dev->channels = lm3533_als_channels;
> > >  	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
> > >  	indio_dev->name = dev_name(&pdev->dev);
> > > -	indio_dev->dev.parent = pdev->dev.parent;
> > >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > >  
> > >  	als = iio_priv(indio_dev);

Johan
