Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506F2F85E8
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLBQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 20:16:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44980 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfKLBQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 20:16:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so13283937oih.11;
        Mon, 11 Nov 2019 17:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ArhZrxdgZq3h08D9ehAHSXgdG1rOFXrvThQrayyk/0=;
        b=ckZWz4ruKEHkjNnnVkxZMvy+n8b4W/NZaQzIuRrOdm6daqLU92cQASmMxLsLaRim2A
         O2T1OHz0xawbGWb3PygjiTJ54Cgwemx5lEQWnCbM2txx9Ic1W5EJQV2yQeo3oxi7ggek
         MJMN5wuDUiaANV34HDV6U9t/riri9mQed9vQc4FgF+cxaOfU5BphSJ4DhsMEpI9CaaN/
         r3j1+AjrYDZ04W8RYfW3+fCcC1CqT2kYrqYG4rfM0j5fBydF3OnxWvPizHfP8AFQDy+b
         HPRY5Ez+S47ofTG+cFFR7E48JR+tmHkDBwM/XBkHNk4FPM3m9NTWFXzG6FcWUomrEkKf
         l0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ArhZrxdgZq3h08D9ehAHSXgdG1rOFXrvThQrayyk/0=;
        b=cKNk1f/gxMV3/z7fymAGiSTeAgbxsSkROOjpWSl0Q4IXKXqWyz/fFtlwMI7Muh+J/d
         reAlP195bFn5IYv+qlwgb/G9W/6J++nlcvQZ5NBuI/AxOydZpe8jo96aLSp4D412yoFu
         1JPOc8FOYTgc1m5vlEUQIpL2HD15pEtJ2P9i6Ya6Q6XWnNVmzb9iYwjQkz5CHr17UcuQ
         LHc89r8ladOLsFy/ih7FLSFCWBi6UnS/VT+OTwGOx0M9DK72F5ODuOETiWab3/VMbfAl
         dZwQWfiN8Vy5y1cKLGWf8QvUhIYKb5fOjoQgxrVQ2hcmZi/CcA+W8uwx0TNsfAA89wUI
         wyug==
X-Gm-Message-State: APjAAAV+ZOmwL6FzdSWDN3rHp5lh+RN3CFGC9Lqd7TwFqsl3PKdTiQyG
        d+kCm0B4mhYMF8WpNeam35A=
X-Google-Smtp-Source: APXvYqzllnDD8SyX3HDZdoJn/NTh17HuRN4QUZSfp6M3OPNOjBPd0SDBOfBcXBjQ2o5/Hkl8Lnao5Q==
X-Received: by 2002:aca:2811:: with SMTP id 17mr1622747oix.46.1573521394052;
        Mon, 11 Nov 2019 17:16:34 -0800 (PST)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id w10sm4779246oif.9.2019.11.11.17.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:16:33 -0800 (PST)
Date:   Mon, 11 Nov 2019 20:16:18 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
Message-ID: <20191112011618.GA62259@icarus>
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
 <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
 <20190826095612.7455cb05@archlinux>
 <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
 <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
 <20191110151408.GB3984@icarus>
 <20191111114955.00001031@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111114955.00001031@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 11, 2019 at 11:49:55AM +0000, Jonathan Cameron wrote:
> On Sun, 10 Nov 2019 10:14:08 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > On Tue, Sep 24, 2019 at 04:20:51PM +0200, Fabien Lahoudere wrote:
> > > Hi all,
> > > 
> > > After some discussions and investigation, the timestamp is very
> > > important for that sync driver.
> > > Google team uses that timestamp to compare with gyroscope timestamp.
> > > 
> > > So the important data is timestamp and counter value is useless.
> > > Just the event of counter increment is important to get a timestamp.
> > > 
> > > In that case, my idea was to just use an IIO driver with a single
> > > channel with IIO_TIMESTAMP. We discuss this here and it seems
> > > controversial.
> > > 
> > > So my question to Jonathan is if we have a timestamp coming from the EC
> > > itself, can we consider this timestamp as a good IIO driver?
> > > 
> > > Any other idea is welcome, however Google team would like to manage
> > > only IIO drivers if possible.
> > > 
> > > Thanks  
> > 
> > Jonathan,
> > 
> > Should the the timestamp from the EC be introduced as an IIO driver
> > using IIO_TIMESTAMP?
> 
> It is is a rather odd driver but I suppose it would be fine with lots
> of clear docs on why it is how it is...
> 
> > 
> > Since there is no corresponding EC Counter driver in the baseline right
> > now we don't have a conflict yet. If the EC timestamp is introduced as
> > an IIO driver then we should make any future EC Counter driver mutually
> > exclusive with the IIO driver in order to prevent any memory space
> > conflict. At that point we may deprecate the IIO driver and move the
> > timestamp functionality to the corresponding Counter driver.
> 
> That route does become somewhat of a mess so I suspect we'd have to have
> a single driver supporting both userspace interfaces.  If you are happy
> that we'd be adding a bit of legacy to support for ever then we can go
> that way.

Generally I'd prefer all components of a device to be supported, but
if this is as Fabien suggests that due to the nature of this particular
device the counter value is of no interest, then a Counter driver is of
little practical use here. In this particular case, it seems better to
restrict the driver support to just the timestamp functionality that
will be used, rather than introduce extra code to expose values that
will likely be ignored and risk adding code to the kernel that becomes
unmaintained due to lack of exposure or interest.

William Breathitt Gray

> 
> > 
> > That's assuming someone is interested in the Count component enough to
> > implement an EC Counter driver; otherwise, the IIO driver will serve
> > just fine if timestamp is the only data desired from this device.
> > 
> > William Breathitt Gray
> 
> 
