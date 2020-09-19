Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA46270DCC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgISLvO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 07:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgISLvO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 07:51:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4162100A;
        Sat, 19 Sep 2020 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600516274;
        bh=iYJvHqYl6JBo8pnhB5+j6v5A0yBVOh2+73FFjTmI4WU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GS4pux4kmkX5OFQHES3jECVwWe58mx3Nc1NtmpgMG6Ql8Wmp/ka14m7+zrjDSjXLX
         +siCobE9brCtp6B4BrA/5YMP/HV1SWMyuWmLpSj64jJt4rqwe2omyW4z0HlIqIM0YG
         8BYttD3e2LdyvWdu/324MXP8xNrxmS0wtLYn3ELw=
Date:   Sat, 19 Sep 2020 12:51:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/3] iio:core: Tidy up kernel-doc.
Message-ID: <20200919125109.7524f734@archlinux>
In-Reply-To: <CA+U=Dsq1p00bS=dr2jjPTQZ-sbubp79oeGoB8FgzYx_Ccnc2yQ@mail.gmail.com>
References: <20200913132115.800131-1-jic23@kernel.org>
        <20200913132115.800131-4-jic23@kernel.org>
        <CA+U=Dsq1p00bS=dr2jjPTQZ-sbubp79oeGoB8FgzYx_Ccnc2yQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 15:48:02 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Sep 13, 2020 at 4:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One comment isn't kernel-doc at all, but starts with /** and another
> > is simply missing a parameter that was introduced recently.
> >  
> 
> Apologies for missing this earlier.
No problem.  This one is you being nice rather than an ADI driver :)
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Thanks.  Applied with yours and Andy's tag (from the request
for review email).

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 8ddc6dfc8ed4..6e388293c828 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -170,7 +170,7 @@ static const char * const iio_chan_info_postfix[] = {
> >  };
> >
> >  #if defined(CONFIG_DEBUG_FS)
> > -/**
> > +/*
> >   * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> >   * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
> >   */
> > @@ -1525,6 +1525,7 @@ struct device_type iio_device_type = {
> >
> >  /**
> >   * iio_device_alloc() - allocate an iio_dev from a driver
> > + * @parent:            Parent device.
> >   * @sizeof_priv:       Space to allocate for private structure.
> >   **/
> >  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
> > --
> > 2.28.0
> >  

