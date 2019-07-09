Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1B633A1
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2019 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfGIJnd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jul 2019 05:43:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfGIJnd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2019 05:43:33 -0400
Received: from laptop-1.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0681E28B1DA;
        Tue,  9 Jul 2019 10:43:30 +0100 (BST)
Message-ID: <5c3e6d57e83839c278f3ae8be16c39c50be2dee4.camel@collabora.com>
Subject: Re: [PATCH v3 8/8] docs: iio: add precision about
 sampling_frequency_available
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jul 2019 11:43:28 +0200
In-Reply-To: <20190622112114.78a58440@archlinux>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
         <0c5b7e1f7996e8c1c5f6787cbb9fb58986be1f17.1560848479.git.fabien.lahoudere@collabora.com>
         <20190622112114.78a58440@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le samedi 22 juin 2019 à 11:21 +0100, Jonathan Cameron a écrit :
> On Tue, 18 Jun 2019 11:06:39 +0200
> Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> 
> > The documentation give some exemple on what format can be expected
> > from sampling_frequency_available sysfs attribute
> > 
> > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> It seems I already applied this one, though probably haven't sent
> a pull request for it to Greg yet.
> 
> Please drop it from your v4 posting as otherwise I'll get confused
> (again).
> 

Sorry, it will be dropped next time.

> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > b/Documentation/ABI/testing/sysfs-bus-iio
> > index 6aef7dbbde44..680451695422 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -61,8 +61,11 @@ What:		/sys/bus/iio/devices/triggerX/s
> > ampling_frequency_available
> >  KernelVersion:	2.6.35
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > -		When the internal sampling clock can only take a small
> > -		discrete set of values, this file lists those
> > available.
> > +		When the internal sampling clock can only take a
> > specific set of
> > +		frequencies, we can specify the available values with:
> > +		- a small discrete set of values like "0 2 4 6 8"
> > +		- a range with minimum, step and maximum frequencies
> > like
> > +		  "[min step max]"
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/oversampling_r
> > atio
> >  KernelVersion:	2.6.38

