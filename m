Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC02D1C26EF
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgEBQXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 12:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgEBQXk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 12:23:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF0B206EB;
        Sat,  2 May 2020 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588436620;
        bh=2xRIoNermLl3yBWwYWTIRuWu1VuPx6Z3+S4kgIWgc7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gfOV4I9O2k1ahYDFhuwT/BmwEqlf/GqT8CcWA5t2RZfmqGYt4tLigmA8OgqSKm1Rm
         wTXoJl0eXMhVUs81uDe3wTD5CQtS2Nya1wHINZEleO8Xdgf7LK7bdl/tkh8Du5pBAa
         woqSPQ4N/nHQD4iUcLeAY/Qaf3GWghgCl9iObKcs=
Date:   Sat, 2 May 2020 17:23:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] iio: chemical: atlas-sensor: add DO support
Message-ID: <20200502172336.1456e167@archlinux>
In-Reply-To: <CAJCx=gnEySbyLQA9u=nVJ3-Wk+++Ch6L9C-bYP_EFSz-7TKkhg@mail.gmail.com>
References: <20200210001058.7515-1-matt.ranostay@konsulko.com>
        <20200413181031.68e101da@archlinux>
        <CAJCx=gnEySbyLQA9u=nVJ3-Wk+++Ch6L9C-bYP_EFSz-7TKkhg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 21:30:30 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Mon, Apr 13, 2020 at 10:10 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> >
> >
> > Hi Matt,
> >
> > Found this still in my queue and to be honest I'm lost and
> > can't easily figure out what the status is (I'm too lazy to
> > read all the past threads).
> >
> > So what do you think the status of this patch set is?  
> 
> The code is merged but just noticed the documentation patch somehow got dropped.
Ah oops. I picked up v7 but missed dropping v6 from my queue.

For docs, it seems to be there..?

J
> 
> Thanks,
> 
> Matt
> 
> >
> > Thanks,
> >
> > Jonathan
> >
> > On Sun,  9 Feb 2020 16:10:55 -0800
> > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> >  
> > > Changes from v1:
> > > * combined dt binding docs
> > > * added making interrupt line is optional patchset
> > > * broke out dt changes from DO-SM module patchset
> > >
> > > Changes from v2:
> > > * switch docs to YAML format
> > >
> > > Changes from v3:
> > > * fix up issues reported with dt-schema
> > >
> > > Changes from v4:
> > > * fix logic issue in optional interrupt patchset
> > >
> > > Changes from v5:
> > > * Update license on yaml conversion to GPLv2.0+ and BSD clause
> > >
> > > Matt Ranostay (3):
> > >   iio: chemical: atlas-sensor: allow probe without interrupt line
> > >   iio: chemical: atlas-sensor: add DO-SM module support
> > >   dt-bindings: iio: chemical: consolidate atlas-sensor docs
> > >
> > >  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 -----
> > >  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 -----
> > >  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 -----
> > >  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++
> > >  drivers/iio/chemical/atlas-sensor.c           | 91 +++++++++++++++----
> > >  5 files changed, 125 insertions(+), 82 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> > >  
> >  

