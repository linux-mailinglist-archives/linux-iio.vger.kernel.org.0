Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE339D12
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFHLMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:12:15 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:58948 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfFHLMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 07:12:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id ABE929E852A;
        Sat,  8 Jun 2019 12:12:13 +0100 (BST)
Date:   Sat, 8 Jun 2019 12:12:09 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Enrico Granata <egranata@google.com>
Cc:     linux-iio@vger.kernel.org,
        chromeos-sensors <chromeos-sensors@google.com>
Subject: Re: Question about having multiple timestamp channels
Message-ID: <20190608121209.5edb307a@archlinux>
In-Reply-To: <CAPR809tZ1neoJoigs=YxT6tB6zMpkox_G67=xeXtVOusDfkfRw@mail.gmail.com>
References: <CAPR809vPoRgL+zd1juQ3u=couoF=Ef=dUi90hx-t=a31Vs6v_Q@mail.gmail.com>
        <20190526162918.23c0d8b1@archlinux>
        <CAPR809tZ1neoJoigs=YxT6tB6zMpkox_G67=xeXtVOusDfkfRw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 May 2019 10:32:50 -0700
Enrico Granata <egranata@google.com> wrote:

> On Sun, May 26, 2019 at 8:29 AM Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> > On Thu, 23 May 2019 10:40:48 -0700
> > Enrico Granata <egranata@google.com> wrote:
> >  
> > > Hi,
> > > on Chrome OS devices, the architecture for sensors (such as
> > > accelerometer and gyroscope) involves the sensors being connected to
> > > an embedded controller, which receives interrupts from the IMU,
> > > collects samples, and then sends an interrupt to the main CPU running
> > > Linux.
> > >
> > > On the CPU, there currently is an IIO device called sensor_ring, which
> > > handles the interrupt by collecting the samples from the EC, and
> > > pushes them to an IIO buffer.
> > >
> > > As part of the EC --> AP communication mechanism, we collect:
> > > - the time (in EC clock) when the sensor notified the EC;
> > > - the time (in EC clock) when the embedded controller sent the interrupt;
> > > - the time (in Linux clock) when the CPU received the interrupt.
> > >
> > > We use these values (which we call respectively "a" "b" and "c"), as
> > > input to a median filter in order to both convert EC clock to Linux
> > > clock, and to smooth out jitter.  
> >
> > I'm a little confused on what useful information b gives you.
> > The first gives you the 'data ready' signal from the sensor, which is
> > as close as we can possibly get to the 'real time' at which a reading
> > was taken.
> >  
> 
> We use b and c pairs to feed a median filter that gives us the skew
> between the clock on the EC and the AP.
> This offset is - unfortunately - not even close to a constant (changes
> by up to 1ms/sec in either direction..).
> We then use the median to both convert "a" from EC to AP time units,
> as well as to smooth jitter.

Ah, now I understand. Thanks.

> 
> > >
> > > We have since come to realize that a median is not the best filter for
> > > this task, and - as part of a larger redesign - would like to move
> > > this filtering in userspace and use a different filter (most likely
> > > either a least squares or a Kalman filter).  
> >
> > This is sounds like something very much non standard.  It's going to be
> > hard for any general purpose code to know which timestamp is the
> > 'right' one.
> >  
> 
> One option here is to provide "c" as the main timestamp (so as
> IIO_MOD_HOST_TIME or some such) out of IIO, and add the two other
> values "a" and "b" as additional channels.
> Our own userspace would know the specific semantics, and be able to
> provide filtered output, but any generic code could use "c" as-is as a
> valid timestamp.

Sounds good.  I wonder if you could do something slightly nicer still
by adding yet another default time channel (d), which is best you
can cheaply do in kernel to estimate the timing of the original
event.  That would be the one that 'non aware' code would use, leaving
the a, b and c for your userspace algorithm.

> 
> > >
> > > However, doing the filtering in userland requires us to be able to
> > > send the a, b and c points from the IIO device on the kernel to
> > > userspace.
> > >
> > > My initial investigation led me to using indexing as the most viable
> > > option to have multiple IIO_TIMESTAMP channels defined for the same
> > > device. However, I spot a few places in the IIO framework where
> > > channels of kind TIMESTAMP seem to have special meaning.  
> >
> > Hmm. This is true for the main timestamp, but mainly because it
> > is convenient to be able to do things like define available_scan_masks
> > without having to care about having to always provide twice as many
> > entries in order to cover the option of having the timestamp turned
> > off and turned on.
> >  
> > >
> > > Is defining multiple timestamp channels via indexing a supported
> > > operation? If not, is there any way to define such channels? Or a
> > > better way to support our use case of providing 3 "timestamp" values
> > > to userspace.  
> >
> > I don't think we actually prevent it in any way (just took a fairly
> > superficial look) and there certainly isn't any particular intention
> > to prevent it.
> >
> > My only real worry is how to define this interface in a fashion that
> > is generic.  We might want to use a modified channel with appropriate
> > IIO_MOD_* to define something like 'sensor time' vs 'host time'.
> >
> > We can't break the existing ABI however, so we may need the slightly
> > ugly option of 'no modifier' is the same as 'host time'.
> >  
> 
> I see. So we'd add IIO_MOD_HOST_TIME and IIO_MOD_SENSOR_TIME, with the
> implicit understanding that IIO_TIMESTAMP with no modifier ==
> HOST_TIME.
Yes.

> For ChromeOS sensors, we'd have the IIO_MOD_SENSOR_TIME as "a" and
> "b", and "c" as IIO_MOD_HOST_TIME. Generic code would continue to work
> as-is, and on our userspace end, we'd receive the additional data
> points. Makes a lot of sense.
> 
> > >
> > > Any input is appreciated.  
> >
> > Whilst I don't really like the complexity this introduces I can see
> > you might need the more sophisticated timestamps to let you refine
> > the relative clock offsets and multipliers as you get more data.
> >
> > Jonathan  
> 
> Understood, yes. Thanks for your suggestions, they are indeed much appreciated.

You are welcome. Always fun dealing with hardware that seems to
do it's best to provide you data in really unhelpful formats ;)

Jonathan

