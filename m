Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1417CE8A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGNx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 7 Mar 2020 08:53:26 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34594 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCGNx0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 08:53:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id D59179E7689;
        Sat,  7 Mar 2020 13:53:23 +0000 (GMT)
Date:   Sat, 7 Mar 2020 13:53:21 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     519965df20014e135acc9cc9c4674bbba8d76f1a.camel@analog.com,
        linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com
Subject: Re: [PATCH v2] iio: adc: max1363: replace mlock with own lock
Message-ID: <20200307135321.23215052@archlinux>
In-Reply-To: <20200307135050.425ebda7@archlinux>
References: <5e595c91.1c69fb81.6beb1.f7b0@mx.google.com>
        <20200307135050.425ebda7@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 7 Mar 2020 13:50:50 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 29 Feb 2020 00:01:37 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > This change replaces indio_dev's mlock with the drivers own lock. In
> > each case the lock is needed to protect the driver's own state.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>  
> So this deals with the simpler cases where we want to change the lock.
> Makes sense to separate the two.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to have a poke at it. I'll do a pull request in the
> next few days and when that gets taken by Greg KH these will then show
> up in next and be queued up by him for the merge window that will open
> in perhaps 3 weeks time.
> 
I spoke too soon.  Local build tests hadn't finished.  Please make
sure you build test all patches before sending them.

make C=1 
which enables sparse as well as gcc errors gives.

Reverted the patch.  Please fix up and send me a v3.

  CHECK   drivers/iio/adc/max1363.c
drivers/iio/adc/max1363.c:709:23: error: no member 'mlock' in struct max1363_state
drivers/iio/adc/max1363.c:711:25: error: no member 'mlock' in struct max1363_state
drivers/iio/adc/max1363.c:814:23: error: no member 'mlock' in struct max1363_state
drivers/iio/adc/max1363.c:819:25: error: no member 'mlock' in struct max1363_state
  CC [M]  drivers/iio/adc/max1363.o
drivers/iio/adc/max1363.c: In function ‘max1363_monitor_store_freq’:
drivers/iio/adc/max1363.c:709:18: error: ‘struct max1363_state’ has no member named ‘mlock’; did you mean ‘lock’?
  709 |  mutex_lock(&st->mlock);
      |                  ^~~~~
      |                  lock
drivers/iio/adc/max1363.c:711:20: error: ‘struct max1363_state’ has no member named ‘mlock’; did you mean ‘lock’?
  711 |  mutex_unlock(&st->mlock);
      |                    ^~~~~
      |                    lock
drivers/iio/adc/max1363.c: In function ‘max1363_read_event_config’:
drivers/iio/adc/max1363.c:814:18: error: ‘struct max1363_state’ has no member named ‘mlock’; did you mean ‘lock’?
  814 |  mutex_lock(&st->mlock);
      |                  ^~~~~
      |                  lock
drivers/iio/adc/max1363.c:819:20: error: ‘struct max1363_state’ has no member named ‘mlock’; did you mean ‘lock’?
  819 |  mutex_unlock(&st->mlock);
      |                    ^~~~~
      |                    lock
make[3]: *** [scripts/Makefile.build:268: drivers/iio/adc/max1363.o] Error 1
make[2]: *** [scripts/Makefile.build:505: drivers/iio/adc] Error 2
make[1]: *** [scripts/Makefile.build:505: drivers/iio] Error 2

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/max1363.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> > index 5c2cc61b666e..198094ad79a1 100644
> > --- a/drivers/iio/adc/max1363.c
> > +++ b/drivers/iio/adc/max1363.c
> > @@ -169,6 +169,7 @@ struct max1363_state {
> >  	const struct max1363_mode	*current_mode;
> >  	u32				requestedmask;
> >  	struct regulator		*reg;
> > +	struct mutex			lock;
> >  
> >  	/* Using monitor modes and buffer at the same time is
> >  	   currently not supported */
> > @@ -364,7 +365,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> >  	struct max1363_state *st = iio_priv(indio_dev);
> >  	struct i2c_client *client = st->client;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	/*
> >  	 * If monitor mode is enabled, the method for reading a single
> >  	 * channel will have to be rather different and has not yet
> > @@ -405,7 +406,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> >  	}
> >  	*val = data;
> >  error_ret:
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  	return ret;
> >  
> >  }
> > @@ -705,9 +706,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
> >  	if (!found)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->mlock);
> >  	st->monitor_speed = i;
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->mlock);
> >  
> >  	return 0;
> >  }
> > @@ -810,12 +811,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
> >  	int val;
> >  	int number = chan->channel;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->mlock);
> >  	if (dir == IIO_EV_DIR_FALLING)
> >  		val = (1 << number) & st->mask_low;
> >  	else
> >  		val = (1 << number) & st->mask_high;
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->mlock);
> >  
> >  	return val;
> >  }
> > @@ -1587,6 +1588,7 @@ static int max1363_probe(struct i2c_client *client,
> >  
> >  	st = iio_priv(indio_dev);
> >  
> > +	mutex_init(&st->lock);
> >  	st->reg = devm_regulator_get(&client->dev, "vcc");
> >  	if (IS_ERR(st->reg)) {
> >  		ret = PTR_ERR(st->reg);  
> 

