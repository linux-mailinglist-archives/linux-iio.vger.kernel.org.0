Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79D2CFCA9
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgLESTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgLERjj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 12:39:39 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A051D22EBD;
        Sat,  5 Dec 2020 15:23:47 +0000 (UTC)
Date:   Sat, 5 Dec 2020 15:23:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] iio: core: Copy iio_info.attrs->is_visible into
 iio_dev_opaque.chan_attr_group.is_visible
Message-ID: <20201205152344.173e5b96@archlinux>
In-Reply-To: <2a20cf21-d483-d41e-6ff8-95ae23d230c2@redhat.com>
References: <20201125084606.11404-1-hdegoede@redhat.com>
        <2a20cf21-d483-d41e-6ff8-95ae23d230c2@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Dec 2020 13:28:47 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/25/20 9:46 AM, Hans de Goede wrote:
> > Hi All,
> > 
> > I wrote this because I was planning on using is_visible in a driver's
> > attribute group myself (1). But in the end it looks like I'm going to
> > do things differently.
> > 
> > This is still useful to have though, both for possible future use of
> > is_visible in driver's attribute groups as well as to make the current
> > usage of is_visible in adi-axi-adc.c actually work.  
> 
> Jonathan, any opinion / remarks on this one?
> 
> FWIW since I no longer have plans to use is_visible in an iio-driver
> myself I'm fine with dropping this one, but:
> 
> 1. Being able to use is_visible in the attr group of iio-drivers
> seems like a nice thing to have.
> 
> 2. There is an existing use of is_visible in adi-axi-adc.c which currently is broken.

I was giving time for Alex, or others to sanity check the need for a fix
(well more specifically wether this one was the right one as clearly
a need!).

Anyhow, all sounds good.  Giving timing I'll mark it as one I'll pick up
to go in after rc1 + stable. 

I'm not totally sure on the fixes tag.  Current patch will have to go on top
of 207c2d27a010 ("iio: core: move channel list & group to private iio device object")
but I don't think it worked before that either as we were still copying attributes
around, just to a different location.

Jonathan



> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> > 1) I was planning to add an (optional) in_accel_location attribute which
> > would contain "lid" or "base" on 360 degree hinges (yoga) style 2-in-1s
> > with 2 accelerometers and where the kernel knows the location. But given
> > the recent discussion to use label-s for this for proximity sensors,
> > I believe that using label-s here makes more sense too. I will write
> > a patch-set for this when I can find / make some time for this.
> >   
> 

