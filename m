Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588802C47E7
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgKYSsb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 13:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgKYSsb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Nov 2020 13:48:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EED20679;
        Wed, 25 Nov 2020 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606330110;
        bh=IHHrIRxTnPy8mqSxLM9QUGCWhPn9taIjfzjITFbS3os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1O5ki6oqAV7FGs8ppIACAUW2rpFTYX2BGpwHIIX7gvB1xpRR2B9IoNflD1lrZ1l0L
         9BqU7k8wEYTIJoDoor09COeBcjKTQkXbPHQ4D+sYe6PnAy+yT5b0sNErHn2oC1Xsxw
         QYRTHs+TafRH67iU83pTuIJB1BGE1zfnHSdSIYuU=
Date:   Wed, 25 Nov 2020 18:48:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add tablet_mode sysfs file for
 exercising the KIOX010A ACPI DSM
Message-ID: <20201125184824.2052d6aa@archlinux>
In-Reply-To: <94522440-5842-4527-f14e-e02462272611@redhat.com>
References: <20201125085444.11593-1-hdegoede@redhat.com>
        <20201125085444.11593-2-hdegoede@redhat.com>
        <CAHp75VfMxzO2Qx_t7mSv+Y_DEN8Y2KYw02No=y=VuBNACtj4zg@mail.gmail.com>
        <94522440-5842-4527-f14e-e02462272611@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Nov 2020 11:55:45 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/25/20 11:34 AM, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 10:56 AM Hans de Goede <hdegoede@redhat.com> wrote:  
> >>
> >> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
> >> to allow the OS to determine the angle between the display and the base
> >> of the device, so that the OS can determine if the 2-in-1 is in laptop
> >> or in tablet-mode.
> >>
> >> On Windows both accelerometers are read by a special HingeAngleService
> >> process; and this process calls a DSM (Device Specific Method) on the
> >> ACPI KIOX010A device node for the sensor in the display, to let the
> >> embedded-controller (EC) know about the mode so that it can disable the
> >> kbd and touchpad to avoid spurious input while folded into tablet-mode.
> >>
> >> Currently the kxcjk1013 driver calls the DSM for this once at probe time
> >> to ensure that the builtin kbd and touchpad work.
> >>
> >> But some users have expressed interest in using this functionality to
> >> disable the kbd and touchpad when folded into tablet-mode as done under
> >> Windows.
> >>
> >> Add a tablet_mode sysfs file so that users can control the kbd/touchpad
> >> enable/disable functionality from user-space.  

Biggest thing missing here is documentation.

Documentation/ABI/testing/sysfs-bus-iio-kxcjk1013

Unless this is documented somewhere else?  I've no idea if there is any
precedence for this/

> > 
> > ...
> >   
> >> +       err = kiox010a_dsm(&data->client->dev,
> >> +                          tablet_mode ? KIOX010A_SET_TABLET_MODE :
> >> +                                        KIOX010A_SET_LAPTOP_MODE);  
> > 
> > A nit. With temporary variable it may be slightly better to read, like:
> > 
> >   int value;
> >   ...
> >   value = tablet_mode ? KIOX010A_SET_TABLET_MODE : KIOX010A_SET_LAPTOP_MODE);
> >   err = kiox010a_dsm(&data->client->dev, value);  
> 
> I'm fine with either solution, Jonathan let me know if you want a v2 with
> Andy's suggestion implemented (assuming you are willing to take this at all).

Prefer Andy's suggestion slightly seeing as you are going around again to
include some docs :)

Thanks,

Jonathan

