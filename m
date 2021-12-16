Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8B476BFB
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 09:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhLPIcr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 03:32:47 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:59605 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhLPIcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 03:32:46 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DD635240011;
        Thu, 16 Dec 2021 08:32:44 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:32:43 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/10] iio: st_sensors: Use
 iio_device_claim/release_direct_mode() when relevant
Message-ID: <20211216093243.42fd0c88@xps13>
In-Reply-To: <CA+U=DsoVieRnfm6K-Oeva7poGBU+GbxfnS6uoRpc9=qihq6+Rw@mail.gmail.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-6-miquel.raynal@bootlin.com>
        <CA+U=DsoVieRnfm6K-Oeva7poGBU+GbxfnS6uoRpc9=qihq6+Rw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Alexandru,

ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 09:16:34 +0200:

> On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > The st_sensors_core driver hardcodes the content of the
> > iio_device_claim_direct_mode() and iio_device_release_direct_mode()
> > helpers. Let's get rid of this handcrafted implementation and use the
> > proper core helpers instead. Additionally, this lowers the tab level
> > (which is always good) and prevents the use of the ->currentmode
> > variable which is not supposed to be used like this anyway.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++++----------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> > index 1de395bda03e..e57e85c06f4b 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -549,26 +549,24 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
> >         int err;
> >         struct st_sensor_data *sdata = iio_priv(indio_dev);
> >
> > -       mutex_lock(&indio_dev->mlock);
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > -               err = -EBUSY;
> > +       err = iio_device_claim_direct_mode(indio_dev);  
> 
> I'm afraid, for this driver, we would first need a cleanup of
> indio_dev->mlock usage.
> Or at least that's how I would start it.
> i.e. remove the indio_dev->mlock and replace it with it's own
> mutex/lock in all places (except this one).
> 
> The whole story about mlock is a bit old.
> As I was told, it was initially defined in the iio_dev object, but not
> very strictly controlled during review [of drivers].
> Drivers kept using it (as a convenience lock).
> It was later defined to be an IIO framework lock.

I see, thanks for the explanation!

> Now, there's a (slow) ongoing work to move mlock inside the
> iio_dev_opaque struct, and make each driver use it's own lock, OR use
> iio_device_{claim,release}_direct_mode() where appropriate.
> 
> FWIW: this change could go in as-is.

/me breathes :-)

> But there's still the point of implementing another lock on the
> st_sensor_data type.
> I would try to split this work into another [parallel] series, because
> otherwise [if fitted into this series] it would just grow and be
> slow-to-review series.
> But ¯\_(ツ)_/¯

To be honest, my first goal was to document the modes enumeration.
Then, I realized currentmodes was also needing a bit of explanations as
well. Jonathan added that there were misuses with this variable. I then
tried to reduce it's overall use (when not particularly needed) and I
ended up doing this much bigger series, because every commit prepares
the field for the next one.

The situation in this driver is (as you truly report):
- the mlock is correctly used in the read_raw hook but everything is
  hardcoded
- the mlock is abused everywhere else

I am very sorry but I am not willing to entirely rework this driver
because it's not the point of my series, I don't have the hardware and
I know this would led to yet another series of changes, which I will
have no time to handle >.<

My goal here is to reduce the usage count of currentmodes across all
the device driver. This addresses the former point and I think it's
completely valid because a series doing exactly what you request would
definitely do this in two distinct steps as well O:-)

Thanks,
Miquèl

