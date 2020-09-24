Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5FF276926
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIXGlp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgIXGlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 02:41:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF557C0613CE
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2020 23:41:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so1286394pfd.5
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2020 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pkb//R8oXT+t8qeHr6oiA9QSPsxt1R75OQJJCbE7QPs=;
        b=YwCnfeiyYpDJm5ShVg3KU/ajLEXqM/dVl71ywWjIhQGm92hVzANavTe1oaz+6wtvhD
         ktftYIDvLUUk4ieQ77NZCc2F34MXa0SxVImTlGiAW2aj7VAxxdXIiATk9IvK6SlQdwXi
         BEmHBXYXHXnNyzvDsuQ7rIJ436s2k4MFgwi5W6ev9+pIGl5lqKHLsZBFWlWzIEEDhdo/
         BreU0P3kO8nuKwP3+VeAKOO5LSDpeyL1CKz2FYbMRjr8yh2jYuE8mCdSctiPrpHdU4IQ
         lvaqqxn8628OjltBbGUXwVLYO2VncZUG713Du8v+zR0+K3pP+YICF+S+Nul5vIWXdxcl
         143w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pkb//R8oXT+t8qeHr6oiA9QSPsxt1R75OQJJCbE7QPs=;
        b=mGuJlctkYXJq0LK+3kTpr4AIMfFQ+RW9QKMh7st7LYKySe3fueQauwIdW804OR4q5i
         KWMyuX59O7DI97tcecIgRz/om9SckrAzXV46fbMF5nEBDEM0Ivc4v9ZwmVjzY0rlQi3/
         N3/p4I6VAKCYKzsKDGmXWSMeiJTwFfl09J3NBlGhGOcfddVRLeKgj29FmNeH1zwOffFA
         vNB7XY3NKWpmUnHDB50C1Pm8pMzHwqlGn+d+rc5/NuGP24tHegI+IM+yQh0JP5QyUZ9M
         5LkvfsXbp29nQfB2OSoIN4f362LpCbsNMmtpeHne7uW3IFpTgLqp/zHhMFwhzUmHBOMF
         5NVQ==
X-Gm-Message-State: AOAM532P5EHrFVe+/z9FFAp8fkadMRZ5qCfngKwH9j6sK+gCS6r7E4xV
        i9qJrqOSYJDNE6qAvD4FlXg=
X-Google-Smtp-Source: ABdhPJzocAjc68rNIKeQdwIgqr9GAUN+QUho4WVQM+1PvE+qN2PmASbtkkGSQr4+1EvPwf6nfunE6w==
X-Received: by 2002:a63:40e:: with SMTP id 14mr2846801pge.85.1600929701239;
        Wed, 23 Sep 2020 23:41:41 -0700 (PDT)
Received: from localhost ([122.167.81.155])
        by smtp.gmail.com with ESMTPSA id n125sm1554949pfn.185.2020.09.23.23.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 23:41:40 -0700 (PDT)
Date:   Thu, 24 Sep 2020 12:11:32 +0530
From:   Sanchayan Maity <maitysanchayan@gmail.com>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
Message-ID: <20200924064132.GA22507@core-precision>
References: <20200813075358.13310-1-lars@metafoo.de>
 <20200814113008.00002733@Huawei.com>
 <20200920191545.4ed79276@archlinux>
 <5007153.c9bsiqU2ZW@n95hx1g2>
 <20200921105703.000048b3@Huawei.com>
 <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
 <20200921143206.00006b43@Huawei.com>
 <AM8PR04MB731594F51648126A764EA066FF3B0@AM8PR04MB7315.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM8PR04MB731594F51648126A764EA066FF3B0@AM8PR04MB7315.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20-09-22 02:51:11, Andy Duan wrote:
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > On Mon, 21 Sep 2020 14:27:28 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > On 2020-09-21 10:57:03 [+0100], Jonathan Cameron wrote:
> > > > So looking at this the other way, are there any significant risks
> > > > associated with this change?  If not I'm tempted to queue them up
> > > > and we have the rcX time to fix anything we've missed (just like
> > > > every other patch!)
> > >
> > > I've been told that it only performs IRQ-thread wake-ups in hard-IRQ
> > > context. This is fine then.
> > >
> > drivers/iio/adc/vf610-adc.c
> > 
> > However, there looks to be a lot more wrong in there than just this.
> > So normally for a device with a data ready signal like this we would hook up as
> > follows.
> > 
> > Data ready #1 -> IRQ chip (trigger) ->  Read sensor #1 +
> > iio_trigger_notify_done()
> >                                     ->  Read sensor #2 +
> > iio_trigger_notify_done()
> > 
> > (note that the read etc is normally in a thread - all we do in interrupt context is
> > usually to  grab a timestamp if that makes sense for a given sensor).
> > 
> > This driver does both of.
> > Data ready -> Read data from itself and call iio_trigger_notify_done() IRQ chip
> > for a different trigger -> Take a timestamp and never call
> > iio_trigger_notify_done()
> >   or read any data for that matter.
> > 
> > Which won't do what we want at all.
> > 
> > Andy, if I have a go at fixing this are you able to test the result?
> > I think the simplest is probably to introduce a trigger to tie the two halves
> > together.
> > We can set it as the default trigger so things should keep on working for existing
> > users.
> > 
> > For more general case, we should probably have two functions.
> > 
> > iio_trigger_notify_done() which is only called from places we can sleep.
> > iio_trigger_notify_done_no_action() which only decrements the counter (or
> > given this is only called inside industrialio-trigger.c could just replace  with
> > atomic_dec(&trig->use_count)).
> > 
> 
> Sanchayan, can you help to verify the fixes that Jonathan will send out ?
> 

Sorry for the delay in reply. Unfortunately can't as I do not access to the
hardware having left Toradex.

CCed Stefan Agner who might be able to help.

@Stefan

Hello Stefan :), may be you can help here?
