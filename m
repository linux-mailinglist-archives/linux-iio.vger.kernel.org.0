Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728BCB3081
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfIOOXp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 10:23:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37875 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIOOXp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 10:23:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so10108296pgg.4
        for <linux-iio@vger.kernel.org>; Sun, 15 Sep 2019 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UEb9kgjpzKaWz+XuhyCUxwznQIX1Kknm4eq+qplGVo=;
        b=oFVJOnGHoqaajsirjLEL+SiD5NzV9YxnPPn9WnQ9yuP2nhJOmRGtZdSkgQBL1G6dnv
         KGerVZmpZg1MxHuRhS2VlWjGF6a9KB72FYoJs0oBXDsjy/I7spxUN87psoxymQwDa5I7
         0P/jNmQ2/3OW50yO41Hu2TUFYLIYMwE7lTr1YUh+Ga2pbUUAr9SLId/G228T134Zt5pt
         AHiw58TIIHjme8zH1YGbH1uQ34GFHJVXmMXGQM4lRDveLhRQnXbBF9leclqoms2Ig5eJ
         kZcPSEz0KuDzeftvRUxGkwG21ZSXKVk+xBNRCeticGfZ+ArlHhfIrPIuxe/vud5nEB4o
         1Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UEb9kgjpzKaWz+XuhyCUxwznQIX1Kknm4eq+qplGVo=;
        b=GtLgIs8N+r+5J2YX8bpI0a9eg3EYr4nVw2gkrQZk6S9CjV6EDojK5BjsyQxu9DZAJu
         M7WweTnBa6Z2fuGULwuOgYxyoWqNJk7SvFNCBPsb6D1Vygw144ViRAy9T2eck9huHZea
         rFUnpx+TrhK240keal7TThE/xDlmNQCAe1MmmgcpD7cwsUMLs9K1oebQsgLo0S7A00sd
         jysbEVatz1YAYDhHywXA5l7f0kKbZ7d1vS3c4/thXtEF4gmTfJZMIBDskPrgtuINOJWH
         Ox2rYcdnsuwBu4dkVRiYveeNh10hw09jKNxLBX4Hg+P+pP5bUumtm+Ep0dn93UJxuEsX
         GCSg==
X-Gm-Message-State: APjAAAX3e5tQNqalVU/NtLgTrdfD8+8PZt+WVbWvPBJJUeBq41u4K70d
        q8t3POYVtpOr9H2yccjOZ6Y=
X-Google-Smtp-Source: APXvYqxDK6ntaXT/iob5GEsOICY8MkEnL16KIn88Y0zAIQL1SrwISjhggfjxs9DyndKxcTmsUo2YyQ==
X-Received: by 2002:aa7:998f:: with SMTP id k15mr68896557pfh.203.1568557423306;
        Sun, 15 Sep 2019 07:23:43 -0700 (PDT)
Received: from icarus ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id c14sm36389840pfo.64.2019.09.15.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 07:23:42 -0700 (PDT)
Date:   Sun, 15 Sep 2019 23:23:25 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH 0/1] Quadrature Encoder Support
Message-ID: <20190915142325.GA446150@icarus>
References: <20190909121605.92008-1-felipe.balbi@linux.intel.com>
 <20190915145347.42bfc393@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915145347.42bfc393@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 15, 2019 at 02:53:47PM +0100, Jonathan Cameron wrote:
> On Mon,  9 Sep 2019 15:16:04 +0300
> Felipe Balbi <felipe.balbi@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > Here's a simple RFC for Intel's Quadrature Encoder. Let me make it clear
> > that I don't mean we should the following patch as is, rather I'd like
> > to open the discussion to, perhaps, extending Industrial Automation
> > Framework with support for Quadrature Encoders.
> > 
> > Let me know if you think IIO would be correct place for such devices,
> > then I can start reworking the driver to provide an IIO-compliant
> > interface.
> > 
> > I'm thinking we would need standard sysfs files for configuring the QEP
> > into single-shot QEP mode or buffered Capture mode, configure thresholds
> > and other details.
> 
> Hi Felipe,
> 
> Fairly recently, similar concerns that IIO didn't really suite these
> devices lead William to create a specific 'counters' subsystem.
> +CC William.
> 
> It may not address all of your requirements yet, but I would imagine it
> is a better fit than IIO would ever be.  We have moved all the older
> counter drivers out of IIO and across to this new subsystem.
> 
> Thanks,
> 
> Jonathan

Felipe,

Take a look at the Generic Counter interface, it may be what you need:
https://www.kernel.org/doc/html/latest/driver-api/generic-counter.html

There are some existing quadrature encoder counter devices using this
interface already; look at the files under drivers/counter for
reference.

This interface is still relatively new, so if you have any problems just
shoot me an email and I'll be happy to help. :-)

William Breathitt Gray

> 
> 
> > 
> > Cheers
> > 
> > Felipe Balbi (1):
> >   misc: introduce intel QEP
> > 
> >  drivers/misc/Kconfig     |   7 +
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/intel-qep.c | 813 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 821 insertions(+)
> >  create mode 100644 drivers/misc/intel-qep.c
> > 
> 
