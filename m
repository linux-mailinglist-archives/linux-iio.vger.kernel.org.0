Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D251E3956
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgE0Geg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 02:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgE0Gef (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 02:34:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B88C061A0F;
        Tue, 26 May 2020 23:34:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c75so11331974pga.3;
        Tue, 26 May 2020 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lvwr1YAKNY9WMfoJU9GdyQAGCpa27iG61RB5+DG9+HU=;
        b=ix0hzHaX0/bvm5aUekJKMV8QeyRNclPiKL4kC29OJXGd5CLBVgOCaeBJD1XAE2xE9Q
         iA2XWct7NUT9Udlx+YLrc6YwdV67LYDVTSgP9Zskh8U4ybuwHcjhZ79fkJMfIpQFu9LY
         C/r7mrd2gHilznrxGWHKuppf6Cllt5pUKICSdlW2nSgraYAf8aIyEapaJQ16hzNg7Jvl
         iPO5vHKLvYQ9j8r5K7e1jW0nODLgzjZHxHw/Y3PDy1zzy2+GsO0CmN9QJMXIqidzqRHv
         0sXSwNn8dCO4sc8sVUonenNlEvXrP/YLUBosYUIQB5S2IpScL4AwL7iFnycDTcVSAwrc
         PA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Lvwr1YAKNY9WMfoJU9GdyQAGCpa27iG61RB5+DG9+HU=;
        b=MJ7xJ66bwBTVoQhiWANH95T9p57gm9O3anY7rmuyyz5PNttufweiJbDZ1UuCy3LBQT
         Ns8OuAMbbml2D36/sS3nuqK+QBjMnN5fSYL/mXeAb7B6xgRYf776QiR2NDi+J8fpRipG
         YKlPMfQ6hzadRpk9ECaz1oQ7qxeMJJOwpeGsJ5i/KSR3pdSrZpTMbLAqDwB8KQbd3Ilx
         mcBzhWjp5R1hh0idZeBye9MISAkKx5UoBDcSSiONRuJ2nXfOHVw21sd80tezK8PK2dac
         7sLDTojcw7nGcv+Unp7lfJ7Ss2eKS/WdU3MRIv5+eJehoo+hA9vWS8mR8thc0pWerEBX
         D4lA==
X-Gm-Message-State: AOAM532YLf8w9YaJA2VehkLG9//d36ptjXzz/QMeWvw0nv7CO/whq6So
        6owIrDW+mVt8y1CTKBA7ohc=
X-Google-Smtp-Source: ABdhPJy94qGzmuj+00p3Dh9npYlo29qvv4Wbqm86SBnhevdkWrqlXMuJueFxKKQb5We+HFd9b+yjbA==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr2399377pfj.164.1590561274736;
        Tue, 26 May 2020 23:34:34 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id e21sm1190329pga.71.2020.05.26.23.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:34:34 -0700 (PDT)
Date:   Tue, 26 May 2020 23:34:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
Message-ID: <20200527063430.GJ89269@dtor-ws>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <e6030957-97dc-5b04-7855-bc14a78164c8@collabora.com>
 <6d9921fc-5c2f-beda-4dcd-66d6970a22fe@redhat.com>
 <09679de4-75d3-1f29-ec5f-8d42c84273dd@collabora.com>
 <f674ba4f-bd83-0877-c730-5dc6ea09ae4b@redhat.com>
 <2d224833-3a7e-bc7c-af15-1f803f466697@collabora.com>
 <aa2ce2ab-e5bc-9cb4-8b53-c1ef9348b646@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa2ce2ab-e5bc-9cb4-8b53-c1ef9348b646@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 11:36:34AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/19/20 11:02 AM, Andrzej Pietrasiewicz wrote:
> > Hi Hans, Hi Dmitry,
> > 
> > W dniu 18.05.2020 o 16:23, Hans de Goede pisze:
> > > Hi,
> > 
> > <snip>
> > 
> > > > > > > 
> > > > > > > So I wonder what this series actually adds for functionality for
> > > > > > > userspace which can not already be achieved this way?
> > > > > > > 
> > > > > > > I also noticed that you keep the device open (do not call the
> > > > > > > input_device's close callback) when inhibited and just throw away
> > > > > > 
> > > > > > I'm not sure if I understand you correctly, it is called:
> > > > > > 
> > > > > > +static inline void input_stop(struct input_dev *dev)
> > > > > > +{
> > > > > > +    if (dev->poller)
> > > > > > +        input_dev_poller_stop(dev->poller);
> > > > > > +    if (dev->close)
> > > > > > +        dev->close(dev);
> > > > > >                  ^^^^^^^^^^^^^^^^
> > > > > > +static int input_inhibit(struct input_dev *dev)
> > > > > > +{
> > > > > > +    int ret = 0;
> > > > > > +
> > > > > > +    mutex_lock(&dev->mutex);
> > > > > > +
> > > > > > +    if (dev->inhibited)
> > > > > > +        goto out;
> > > > > > +
> > > > > > +    if (dev->users) {
> > > > > > +        if (dev->inhibit) {
> > > > > > +            ret = dev->inhibit(dev);
> > > > > > +            if (ret)
> > > > > > +                goto out;
> > > > > > +        }
> > > > > > +        input_stop(dev);
> > > > > >                  ^^^^^^^^^^^^^^^^
> > > > > > 
> > > > > > It will not be called when dev->users is zero, but if it is zero,
> > > > > > then nobody has opened the device yet so there is nothing to close.
> > > > > 
> > > > > Ah, I missed that.
> > > > > 
> > > > > So if the device implements the inhibit call back then on
> > > > > inhibit it will get both the inhibit and close callback called?
> > > > > 
> > > > 
> > > > That's right. And conversely, upon uninhibit open() and uninhibit()
> > > > callbacks will be invoked. Please note that just as with open()/close(),
> > > > providing inhibit()/uninhibit() is optional.
> > > 
> > > Ack.
> > > 
> > > > > And what happens if the last user goes away and the device
> > > > > is not inhibited?
> > > > 
> > > > close() is called as usually.
> > > 
> > > But not inhibit, hmm, see below.
> > > 
> > > > > I'm trying to understand here what the difference between the 2
> > > > > is / what the goal of having a separate inhibit callback ?
> > > > > 
> > > > 
> > > > Drivers have very different ideas about what it means to suspend/resume
> > > > and open/close. The optional inhibit/uninhibit callbacks are meant for
> > > > the drivers to know that it is this particular action going on.
> > > 
> > > So the inhibit() callback triggers the "suspend" behavior ?
> > > But shouldn't drivers which are capable of suspending the device
> > > always do so on close() ?
> > > 
> > > Since your current proposal also calls close() on inhibit() I
> > > really see little difference between an inhibit() and the last
> > > user of the device closing it and IMHO unless there is a good
> > > reason to actually differentiate the 2 it would be better
> > > to only stick with the existing close() and in cases where
> > > that does not put the device in a low-power mode yet, fix
> > > the existing close() callback to do the low-power mode
> > > setting instead of adding a new callback.
> > > 
> > > > For inhibit() there's one more argument: close() does not return a value,
> > > > so its meaning is "do some last cleanup" and as such it is not allowed
> > > > to fail - whatever its effect is, we must deem it successful. inhibit()
> > > > does return a value and so it is allowed to fail.
> > > 
> > > Well, we could make close() return an error and at least in the inhibit()
> > > case propagate that to userspace. I wonder if userspace is going to
> > > do anything useful with that error though...

It really can't do anything. Have you ever seen userspace handling
errors from close()? And what can be done? A program is terminating, but
the kernel says "no, you closing input device failed, you have to
continue running indefinitely..."

> > > 
> > > In my experience errors during cleanup/shutdown are best logged
> > > (using dev_err) and otherwise ignored, so that we try to clean up
> > > as much possible. Unless the very first step of the shutdown process
> > > fails the device is going to be in some twilight zone state anyways
> > > at this point we might as well try to cleanup as much as possible.
> > 
> > What you say makes sense to me.
> > @Dmitry?

I will note here, that inhibit is closer to suspend() than to close(),
and we do report errors for suspend(). Therefore we could conceivably
try to handle errors if driver really wants to be fancy. But I think
majority of cases will be quite happy with using close() and simply
logging errors, as Hans said.

That said, I think the way we should handle inhibit/uninhibit, is that
if we have the callback defined, then we call it, and only call open and
close if uninhibit or inhibit are _not_ defined.

> > 
> > > 
> > > > All in all, it is up to the drivers to decide which callback they
> > > > provide. Based on my work so far I would say that there are tens
> > > > of simple cases where open() and close() are sufficient, out of total
> > > > ~400 users of input_allocate_device():
> > > > 
> > > > $ git grep "input_allocate_device(" | grep -v ^Documentation | \
> > > > cut -f1 -d: | sort | uniq | wc
> > > >      390     390   13496
> > > 
> > > So can you explain a bit more about the cases where only having
> > > open/close is not sufficient?  So far I have the feeling that
> > > those are all we need and that we really do not need separate
> > > [un]inhibit callbacks.
> > 
> > My primary concern was not being able to propagate inhibit() error
> > to userspace, and then if we have inhibit(), uninhibit() should be
> > there for completeness. If propagating the error to userspace can
> > be neglected then yes, it seems open/close should be sufficient,
> > even more because the real meaning of "open" is "prepare the device
> > for generating input events".
> > 
> > To validate the idea of not introducing inhibit()/uninhibit() callbacks
> > to implement device inhibiting/uninhibiting let's look at
> > drivers/input/mouse/elan_i2c_core.c (PATCH 7/7):
> > 
> > static int elan_inhibit(struct input_dev *input)
> > {
> > [...]
> > 
> >      ret = mutex_lock_interruptible(&data->sysfs_mutex);
> >      if (ret)
> >          return ret;
> > 
> >      disable_irq(client->irq);
> > 
> >      ret = elan_disable_power(data);
> >      if (ret)
> >          enable_irq(client->irq);
> > [...]
> > }
> > 
> > First, close() does not exist in this driver. Of course this can be
> > fixed. Then it doesn't return a value. Then, if either taking the
> > mutex or disabling the power fails, the close() is still deemed
> > successful. Is it ok?
> 
> Note I also mentioned another solution for the error propagation,
> which would require a big "flag day" commit adding "return 0"
> to all existing close callbacks, but otherwise should work for your
> purposes:

No, please, no flag days and no changing close() to return error, it
makes no sense for close().

> 
> > Well, we could make close() return an error and at least in the inhibit()
> > case propagate that to userspace. I wonder if userspace is going to
> > do anything useful with that error though...
> 
> And I guess we could log an error that close failed in the old close() path
> where we cannot propagate the error.
> 
> Also why the mutex_lock_interruptible() ?  If you change that to
> a normal mutex_lock() you loose one of the possible 2 error cases and
> I doubt anyone is going to do a CTRL-C of the process doing the
> inhibiting (or that that process starts a timer using a signal
> to ensure the inhibit does not take to long or some such).

Well, we have the dedicated callbacks in Chrome OS, so when I did the
patch I could even handle Ctrl-C, so why not? But it indeed can easily
be dropped in favor of straight mutex_lock().

Thanks.

-- 
Dmitry
