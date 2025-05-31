Return-Path: <linux-iio+bounces-20077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5BAC9BC4
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726BE3AD328
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3EC18A959;
	Sat, 31 May 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTq/D0BQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3C17A2EF;
	Sat, 31 May 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748709219; cv=none; b=m+dSHwh/1QXUXin7zj/RNque+j8yeLqbPKur5UP3jHVMBVt+jbvUWp5l5moqBONv9dJIvkF/1xQOGrgN22ZlgnIx9oqYve38N0GPQpYBKAoX8htNG8iskjn3qqVNlE7L3DmRNG8E8WSG9JRJWAd4QLlGtn6olNvWBSZV3CRPiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748709219; c=relaxed/simple;
	bh=B97QqIpCY6V/3BaPtrDVnyViN6IWZPEPLmJYDSMdDTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdVLxbfs6ZXIZjN9+hPKQKOY5cqqKYTl5MB/5OY7sjqsMcGeNIy9oE8clFA35b3cA7OM/aGPldpLgkQK8zz4DKptELJOtLgMp8a62+OWyo8pqyflbziJZWMVfjUmL0PIfD25+5rcn7XFxly92ioRP+YfCsB1yScje9+N3wVjGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTq/D0BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131FDC4CEE3;
	Sat, 31 May 2025 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748709218;
	bh=B97QqIpCY6V/3BaPtrDVnyViN6IWZPEPLmJYDSMdDTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTq/D0BQd1zlkfM6f8MqKVEPGSOk8UJ0KtaC8axY0Y2L9B18+YQaLLm9RhcKZYlOF
	 aFy46Pbg8LGickEFm9eD547wEnEqkiMUdI2fVs1ezWOtHgsRTrI6h/TqkrZGIL7LE5
	 fiInn4yMcWGpdCQmwz567NS01gKurcV+iccUgPtKzOQUjyk9sOMn0TgGujglIpPbBL
	 gTgwSC/0jWJs0zoD5gWk3Xx+9Kwj7p0Z3OIH3+MGhaPzexgHpGOqR9+iz5D498/5xL
	 JEnOEmCDL+/rrJW+vzCGtVptCdwpAtrY9G7PPD/igjEBBoCIL/faqK7bd7ho01rfap
	 LlJIGeVZWmoZA==
Date: Sat, 31 May 2025 17:33:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] iio: accel: adxl313: add basic interrupt
 handling
Message-ID: <20250531173330.4d913f65@jic23-huawei>
In-Reply-To: <CAFXKEHaM1xEk-v7rXdKoxdXKV-k=_Leu+hMBukDyKoWr3irVRQ@mail.gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-8-l.rubusch@gmail.com>
	<20250525134831.68b3c905@jic23-huawei>
	<CAFXKEHaM1xEk-v7rXdKoxdXKV-k=_Leu+hMBukDyKoWr3irVRQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 22:52:55 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
> 
> I feel here either I have some missunderstanding or it needs more
> (better?) explanation. Perhaps I'm using the wrong terminology.
> 
> One point, I forgot, do I actually need to add a Reviewed-by tag or
> something like that for Andys review? Or if so, they will let me know,
> I guess?

Only add a tag if Andy gives it.

> 
> First of all, introducing the adxl313_fifo_reset(data) here is the
> crucial part. So, the title I chose is not matching with the topic, or
> is too general. I'll answer and try to better explain down below.

I'd misunderstood somewhat what we had here which probably didn't help.
Partly this was down to patch break up and you putting something called
reset in temporarily covering the normal read path (threshold interrupt).

> >  
> > >  static const struct regmap_range adxl312_readable_reg_range[] = {
> > >       regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
> > >       regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > > @@ -62,6 +71,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
> > >       case ADXL313_REG_DATA_AXIS(4):
> > >       case ADXL313_REG_DATA_AXIS(5):
> > >       case ADXL313_REG_FIFO_STATUS:
> > > +     case ADXL313_REG_INT_SOURCE:
> > >               return true;
> > >       default:
> > >               return false;
> > > @@ -363,6 +373,118 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
> > >       }
> > >  }
> > >
> > > +static int adxl313_get_samples(struct adxl313_data *data)  
> >
> > I doubt this gets called from multiple places. I'd just put
> > the code inline and no have this helper at all.
> >  
> 
> It will be a called at least in two places. First, when reading the
> measurements and second when clearing the fifo in the reset.

Ok. Then this is fine to keep.

> > > +static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
> > > +{
> > > +     size_t count;
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     count = array_size(sizeof(data->fifo_buf[0]), ADXL313_NUM_AXIS);
> > > +     for (i = 0; i < samples; i++) {
> > > +             ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
> > > +                                    data->fifo_buf + (i * count / 2), count);  
> >
> > that 2 is I'd guessed based on size of some data store element?
> > I'd guess sizeof(data->fifo_buf[0]) is appropriate.
> >  
> 
> My calculation was the following:
> * samples := number of "lines" in the FIFO e.g. by watermark
> * count := number of bytes per "line"
> * ADXL313_NUM_AXIS := 3 for the three axis here
> There's a bulk read per "line" of the FIFO. A "line" comprises
> measurement for x, y and z axis. Each measurement consists of 2 bytes,
> i.e. count has 6 bytes.
> 
> At a second look now, probably count/2 can be replaced directly by
> ADXL313_NUM_AXIS. If so, I don't need the count variable. I see,
> count/2 being already a constant expression here smells somehow. I
> guess, this might be your point? I'll change that and need verify.

I was only commenting on the 2.  But sure, using ADXL313_NUM_AXIS
resolves that and is better still.
Not sure I'd bother with array_size() here, probably simply
using sizeof(data->fifo_buf[0]) * ADXL313_NUM_AXIS for that
final parameter is fine given we know it can't over flow and it's
the size of a subset of a larger array rather than an array
(kind of anyway!)


> >  
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +/**
> > > + * adxl313_fifo_reset() - Reset the FIFO and interrupt status registers.
> > > + * @data: The device data.
> > > + *
> > > + * Reset the FIFO status registers. Reading out status registers clears the  
> >
> > I think you already read it before calling this. So how is it ever set?
> >  
> > > + * FIFO and interrupt configuration. Thus do not evaluate regmap return values.
> > > + * Ignore particular read register content. Register content is not processed
> > > + * any further. Therefore the function returns void.
> > > + */
> > > +static void adxl313_fifo_reset(struct adxl313_data *data)  
> >
> > As below.  This isn't a reset.  Fifo reset is normally the term used
> > for when we have lost tracking of what is in the fifo and drop all data,
> > not normal readback.
> >  
> > > +{
> > > +     unsigned int regval;
> > > +     int samples;
> > > +
> > > +     adxl313_set_measure_en(data, false);  
> > Disabling measurement to read a fifo is unusual -  is this really necessary
> > as it presumably puts a gap in the data, which is what we are trying
> > to avoid by using a fifo.
> >  
> > > +
> > > +     samples = adxl313_get_samples(data);
> > > +     if (samples > 0)
> > > +             adxl313_fifo_transfer(data, samples);
> > > +
> > > +     regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &regval);  
> >
> > Not processing the convents of INT_SOURCE every time you read it
> > introduces race conditions.  This logic needs a rethink so that
> > never happens.  I guess this is why you are disabling measurement
> > to stop the status changing?  Just whatever each read of INT_SOURCE
> > tells us we need to handle and all should be fine without disabling
> > measurement.  That read should only clear bits that are set, so no
> > race conditions.
> >  
> 
> When the ADXL345 triggers an interrupt for e.g. watermark, data ready,
> or overrun,... it will stop from triggerring further interrupts until
> the status registers, INT_SOURCE and FIFO_STATUS are cleared. This I
> call "reset". In consequence the FIFO will simply run full.

Hmm.  I'd not use the reset term so broadly.  Reset for a fifo typically means
dropping all data on the floor after an overflow or other error condition.

> 
> Usually when the interrupt handler reads the interrupt status
> (INT_SOURCE). In case of, say, watermark, it then reads the
> FIFO_STATUS to obtain number of entries and reads this number of
> samples by a linewise bulk read from the sensor DATA registers.
> Reading all FIFO entries from the DATA register clears FIFO_STATUS,
> and this clears INT_SOURCE.
> 
> Now, in case of error or overrun, I'd use this reset function as a
> fallback error handling. I stop measurement i.e. I set the sensor to
> standby. The sensor should not accept further measurements. Then I
> read out the fifo entries to clear FIFO_STATUS and I (already) read
> INT_SOURCE to clear interrupt status. Eventually I turn on measurement
> to bring the sensor back to operational. I ignore the read
> measurements, I'm reading here.
> 
> As alternative approaches I also saw for similar sensors (not Linux)
> to e.g. switch FIFO_STREAM mode to FIFO_BYPASS and back. This works
> here too, but only for the FIFO_STATUS not for INT_SOURCE. Another
> idea I can imagine with the ADXL313, there is a soft reset register,
> but never tried that.
> 
> In this initial patch, the reset function will resume the interrupt
> handler function. With the follow up patches, this will form rather
> the error handling. It is easy to get into this kind of overrun
> situation, if the interrupt handler is still not working correctly.
> I'm actually pretty confident, that it now works only as a fallback
> error handling, but perhaps I'm doing something wrong here?

This is where I got confused - because it wasn't just the error
paths. All made sense after later patches.  Stopping measurements when
you enter an error condition is fine.
> 

> > > +             return IRQ_NONE;
> > > +
> > > +     adxl313_fifo_reset(data);  
> >
> > Given we don't know it had anything to do with the fifo at this point
> > resetting the fifo doesn't make much sense.  I'd expect a check
> > on int_status, probably for overrun, before doing this.
> >
> > Ah. On closer inspection this isn't resetting the fifo, it's just
> > reading it.  Rename that function and make it dependent on what
> > was in int_stat.
> >  
> 
> As mentioned before, I used the term "reset" to clear the status
> registers. This can occur for typically overrun, but also would cover
> all events which are still not handled by the interrupt handler. I
> could give it a try to see if the soft reset here would be a better
> fit.

No need to change the code, just don't use the term reset if you
are not clearing all data (without using it) and any outstanding
interrupt status.  Pick a different term clear_int for example.

Soft reset is massive overkill for an overrun event.

Jonathan

> 
> Best,
> L
> 
> >  
> > > +
> > > +     return IRQ_HANDLED;
> > > +}  
> >  


