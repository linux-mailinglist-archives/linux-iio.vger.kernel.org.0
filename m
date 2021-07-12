Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F35F3C6264
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhGLSLO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 14:11:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E9C0613DD;
        Mon, 12 Jul 2021 11:08:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso505622pjb.0;
        Mon, 12 Jul 2021 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gbTiIYDwnSRaycek8BzkWNkickJLY09hCzQewdWq06g=;
        b=nznOig5fwNxtcKpcN3/6YidTdr5sJ9YLOCQ6WboYBMI+npnzgBllgo60PysPXG0BYX
         2t2ZTwR6bexNoxnzkn519PXN1g2BlGwpC0ShfixIjUoSYq7HNXBwjMIVsbgQCRevCemj
         Ib9gEbZFA33V8M+yPFyUd1jQ8arxxiJ+RiJ7MVzdXQtbji28WGvASPo/pePFG174aK1O
         03h1TCytAz+JR9I/hajDLm2nlq7ybq6jkD5AzK8uNXhjgwGQZgiijz1Sn3CJe6DLIicy
         Fr11J3FfAiRZakNmHK9zOx8FbDjYwmr7XEWkJP51vGzbaumm19VNczACMwTh4kTPvFdt
         UpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gbTiIYDwnSRaycek8BzkWNkickJLY09hCzQewdWq06g=;
        b=bNqU84OjFq8lUH8O+801c17RLubZHp6P0YoqzM2R6oZRCXB37bJftMbuswGy57KRII
         NxL44tsCf87WO3YJPYM3XTNqrWizza6AatL+0I7SE0vskZQhUWjhxWiC/Rhhg4+zNZrc
         0bHbFbZAfVU61+xTtbJQXobtSSS240Gig5gcIO0P3Hg8Ejd2ShhxgNeSyYk6UuLMycAA
         at9Ew8+suIesOToFyGcrH257oYPe3K8K63wdKZWFS98fkFKG6uum441uEgujd2a+JN2I
         WlWjf4RKx4+WFCeFK7J5KH2d12iAzzplIyOht97Gv3IfYmW+hOOIDQx9btHjvmNbReAR
         VOtA==
X-Gm-Message-State: AOAM533ZGHVtM0BHzW7vFr0ZQ4825D1GKztOzoiRFhnZf7sJTtlmKv2y
        8LwA3iChbgJ0l0nsS2yNTTQ=
X-Google-Smtp-Source: ABdhPJy4qZUxXiKF6OSytusjkdkuB01I24Jonu7WrNPoA+9OAZ/j1HTFRSh69as7QCuYSLmWwIaX+A==
X-Received: by 2002:a17:90b:3d4:: with SMTP id go20mr15205998pjb.170.1626113304727;
        Mon, 12 Jul 2021 11:08:24 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b7d:3600:4da5:ab7e:d25a:f030])
        by smtp.gmail.com with ESMTPSA id j2sm16625902pfj.168.2021.07.12.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:08:24 -0700 (PDT)
Date:   Mon, 12 Jul 2021 15:08:19 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <YOyFE/yHrLQxKpkU@marsc.168.1.7>
References: <20210614113507.897732-1-jic23@kernel.org>
 <YNIfkaRZtWIXPbAj@marsc.168.1.7>
 <20210623093741.00007d1d@Huawei.com>
 <20210711155051.713c1207@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711155051.713c1207@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/11, Jonathan Cameron wrote:
> On Wed, 23 Jun 2021 09:37:41 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Tue, 22 Jun 2021 14:36:17 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> > 
> > > Hey Jonathan,
> > > 
> > > On 06/14, Jonathan Cameron wrote:  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > Hi All,
> > > > 
> > > > This one proved an interesting diversion.
> > > > 
> > > > Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
> > > > ad7280a devices (18 channels).  Note that the emulation isn't complete
> > > > but does do chaining, CRC, and readout of channels etc in a fashion that
> > > > worked with the original driver (up to the bug in patch 1) and continues
> > > > to work with the updated version. I've not intention to upstream the
> > > > emulation (as would need to make it more completed and flexible), but
> > > > happy to share it with anyone who is interested.    
> > > 
> > > I'm interested in seeing your device emulation with QEMU.
> > > I was looking at the ad7150 emulation you shared earlier this year but had
> > > some trouble getting the i2c slave created.  
> > 
> > Sure.  Let me do a bit of tidying up they I'll push a suitable branch out.
> > (probably will still have lots of stuff missing!)
> > 
> > Might take a little while to get to this though.
> 
> I pretended to myself for a few weeks that I'd get around to tidying this up in
> a remotely meaningful way.  That's clearly not happening so I pushed out the
> untidy version with appropriate eats babies messages:
> 
> https://github.com/jic23/qemu/commits/ad7280a-hacks

Thanks. I don't mind if it's not exactly tidy or elegant code provided I
can understand whats going on and get it running.

> 
> Note there is loads of stuff that isn't implemented as it was developed alongside
> this patch series to verify individual patches rather than with the intent of
> actually emulating the device.
> 
OK, will be aware of that.

> It's hard coded to 2 a chain of 3 ad7280a devices because that seemed to hit most possible
> corner cases.
> 
> The top commit has the launch string I'm using.  You'll need a filesystem, but
> you can probably use one of the convenient ones debian posts as nocloud cloud
> images. 
> 
> There is some info on that on people.kernel.org/jic23 as I wrote up how to test
> CXL stuff on ARM recently and gave guidance on easy ways to get a filesystem.
> http://cdimage.debian.org/cdimage/cloud/sid/daily/20210702-691/debian-sid-nocloud-arm64-daily-20210702-691.qcow2
> will probably work and is more recent than the one linked from that blog post. 

I was using a debian imgage created from following the instructions on a
tutorial pointed by the QEMU docs.
https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/
Anyhow, I'll chance to the nocloud one if see things don't get working.

> 
> Give me a shout if you need more specific guidance than this very very rough guide!

Sure, let's see if I can get through it now. Otherwise ...

> 
> I mentioned this thread in the diversion the rust on linux thread took into
> use of QEMU to emulate devices which motivated me to stop being lazy and at least
> post this hideous version.  Probably the most useful bit is how to get a working
> spi device emulated on the arm virt machine as that is very handy for all manner
> of testing.  One day someone might implement a large set of IIO device emulation
> and bolt it into a CI...

Agree, it's hard to get IIO drivers runtime tested because we often don't
have the required hardware to do it. I think emulation would help us with
that or, at least, would give us a little bit more confidence in our
changes than just relying on sharp eyes and compile/static tests.
Puching that into a CI would also be rather nice.

> 
> Jonathan
> 
> > 
> > > 
> > > Being able to see it running, I may feel more confident to provide a review
> > > for this set :)  
> > 
> > :)
> > 
> > > 
> > > Regards,
> > > 
> > > Marcelo  
> > > > 
> > > > I briefly flirted with posting a patch to just drop the driver entirely,
> > > > but the part is still available and it looked like fun + isn't going
> > > > to greatly impact maintainability of the subsystem long term so is low
> > > > cost even if it goes obsolete sometime soonish.
> > > > 
> > > > There are lots of things we could do after this set to improved the driver
> > > > and make things more flexible, but it should basically 'just work'
> > > > 
> > > > Anyhow, as normal for staging graduations, last patch has rename detection
> > > > turned off so that people can easily see what I am proposing we move
> > > > out of staging.
> > > > 
> > > > Jonathan Cameron (17):
> > > >   staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
> > > >   staging:iio:adc:ad7280a: Register define cleanup.
> > > >   staging:iio:adc:ad7280a: rename _read() to _read_reg()
> > > >   staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
> > > >   staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
> > > >     transfers.
> > > >   staging:iio:adc:ad7280a: Switch to standard event control
> > > >   staging:iio:adc:ad7280a: Standardize extended ABI naming
> > > >   staging:iio:adc:ad7280a: Drop unused timestamp channel.
> > > >   staging:iio:adc:ad7280a: Trivial comment formatting cleanup
> > > >   staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
> > > >   staging:iio:adc:ad7280a: Cleanup includes
> > > >   staging:iio:ad7280a: Reflect optionality of irq in ABI
> > > >   staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
> > > >   staging:iio:adc:ad7280a: Use device properties to replace platform
> > > >     data.
> > > >   dt-bindings:iio:adc:ad7280a: Add binding
> > > >   iio:adc:ad7280a: Document ABI for cell balance switches
> > > >   iio:adc:ad7280a: Move out of staging
> > > > 
> > > >  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   14 +
> > > >  .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
> > > >  drivers/iio/adc/Kconfig                       |   11 +
> > > >  drivers/iio/adc/Makefile                      |    1 +
> > > >  drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
> > > >  drivers/staging/iio/adc/Kconfig               |   11 -
> > > >  drivers/staging/iio/adc/Makefile              |    1 -
> > > >  drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
> > > >  drivers/staging/iio/adc/ad7280a.h             |   37 -
> > > >  9 files changed, 1229 insertions(+), 1093 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > > >  create mode 100644 drivers/iio/adc/ad7280a.c
> > > >  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
> > > >  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> > > > 
> > > > -- 
> > > > 2.32.0
> > > >     
> > 
> 
