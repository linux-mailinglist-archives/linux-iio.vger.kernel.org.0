Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E195ECF33
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2019 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKBOkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Nov 2019 10:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfKBOkq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Nov 2019 10:40:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56AFE20862;
        Sat,  2 Nov 2019 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572705645;
        bh=pkm9tdn2nbnZk9K6vYRlSU4X9Ut4KEpxn0BjOdLIpYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yOcBL8AI0u6vxlRIaoqOu8P9AkF9C90A5LmK/uMz8Q8YUr3Yh36eK/sDh9ZvMmEK4
         vCg3MYJVC9nuAUwR/OiuvVzNg7DmREunI33ncXY9CAgC2WB5WP0jiA6t9HaEzeEufQ
         MiPG7JuMGJpV2mHFVeHzdMnsLHy+LoTurYZwOpK4=
Date:   Sat, 2 Nov 2019 14:40:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: hdc100x: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20191102144041.2c8bc85d@archlinux>
In-Reply-To: <46d418bd0546c98e22a0d331741c053274c2170f.camel@analog.com>
References: <20191023082714.18681-1-alexandru.ardelean@analog.com>
        <20191027165813.5a5b0519@archlinux>
        <CAJCx=gnCaqKHuZkRoCyHXR4ewwmqFCsRTiUty=CH0KB8PS+YCQ@mail.gmail.com>
        <46d418bd0546c98e22a0d331741c053274c2170f.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Oct 2019 07:11:51 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-27 at 20:37 +0200, Matt Ranostay wrote:
> > [External]
> > 
> > On Sun, Oct 27, 2019 at 6:58 PM Jonathan Cameron <jic23@kernel.org>
> > wrote:  
> > > On Wed, 23 Oct 2019 11:27:14 +0300
> > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > >   
> > > > The iio_triggered_buffer_postenable() hook should be called first to
> > > > attach the poll function and the iio_triggered_buffer_predisable()
> > > > hook
> > > > should be called last in the predisable hook.
> > > > 
> > > > This change updates the driver to attach/detach the poll func in the
> > > > correct order.
> > > > 
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > > Seems fine, but should have cc'd Matt and I'd like to give him time
> > > to take a quick look.
> > >   
> > 
> > Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Apologies for not CC-ing Matt.
> I guess I wasn't paying [close enough] attention to the output of
> get_maintainers.pl
> 
> Thanks
> Alex
> 
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> >   
> > > +CC Matt.
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > >   
> > > > ---
> > > >  drivers/iio/humidity/hdc100x.c | 19 +++++++++++--------
> > > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/humidity/hdc100x.c
> > > > b/drivers/iio/humidity/hdc100x.c
> > > > index bfe1cdb16846..963ff043eecf 100644
> > > > --- a/drivers/iio/humidity/hdc100x.c
> > > > +++ b/drivers/iio/humidity/hdc100x.c
> > > > @@ -278,31 +278,34 @@ static int hdc100x_buffer_postenable(struct
> > > > iio_dev *indio_dev)
> > > >       struct hdc100x_data *data = iio_priv(indio_dev);
> > > >       int ret;
> > > > 
> > > > +     ret = iio_triggered_buffer_postenable(indio_dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > >       /* Buffer is enabled. First set ACQ Mode, then attach poll func
> > > > */
> > > >       mutex_lock(&data->lock);
> > > >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
> > > >                                   HDC100X_REG_CONFIG_ACQ_MODE);
> > > >       mutex_unlock(&data->lock);
> > > >       if (ret)
> > > > -             return ret;
> > > > +             iio_triggered_buffer_predisable(indio_dev);
> > > > 
> > > > -     return iio_triggered_buffer_postenable(indio_dev);
> > > > +     return ret;
> > > >  }
> > > > 
> > > >  static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
> > > >  {
> > > >       struct hdc100x_data *data = iio_priv(indio_dev);
> > > > -     int ret;
> > > > -
> > > > -     /* First detach poll func, then reset ACQ mode. OK to disable
> > > > buffer */
> > > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > > -     if (ret)
> > > > -             return ret;
> > > > +     int ret, ret2;
> > > > 
> > > >       mutex_lock(&data->lock);
> > > >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
> > > > 0);
> > > >       mutex_unlock(&data->lock);
> > > > 
> > > > +     ret2 = iio_triggered_buffer_predisable(indio_dev);
> > > > +     if (ret == 0)
> > > > +             ret = ret2;
> > > > +
> > > >       return ret;
> > > >  }
> > > >   

