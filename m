Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA32AA67
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2019 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEZP31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 May 2019 11:29:27 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57596 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEZP31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 May 2019 11:29:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 10DC29E8B38;
        Sun, 26 May 2019 16:29:24 +0100 (BST)
Date:   Sun, 26 May 2019 16:29:18 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Enrico Granata <egranata@google.com>
Cc:     linux-iio@vger.kernel.org,
        chromeos-sensors <chromeos-sensors@google.com>
Subject: Re: Question about having multiple timestamp channels
Message-ID: <20190526162918.23c0d8b1@archlinux>
In-Reply-To: <CAPR809vPoRgL+zd1juQ3u=couoF=Ef=dUi90hx-t=a31Vs6v_Q@mail.gmail.com>
References: <CAPR809vPoRgL+zd1juQ3u=couoF=Ef=dUi90hx-t=a31Vs6v_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 May 2019 10:40:48 -0700
Enrico Granata <egranata@google.com> wrote:

> Hi,
> on Chrome OS devices, the architecture for sensors (such as
> accelerometer and gyroscope) involves the sensors being connected to
> an embedded controller, which receives interrupts from the IMU,
> collects samples, and then sends an interrupt to the main CPU running
> Linux.
> 
> On the CPU, there currently is an IIO device called sensor_ring, which
> handles the interrupt by collecting the samples from the EC, and
> pushes them to an IIO buffer.
> 
> As part of the EC --> AP communication mechanism, we collect:
> - the time (in EC clock) when the sensor notified the EC;
> - the time (in EC clock) when the embedded controller sent the interrupt;
> - the time (in Linux clock) when the CPU received the interrupt.
> 
> We use these values (which we call respectively "a" "b" and "c"), as
> input to a median filter in order to both convert EC clock to Linux
> clock, and to smooth out jitter.

I'm a little confused on what useful information b gives you.
The first gives you the 'data ready' signal from the sensor, which is
as close as we can possibly get to the 'real time' at which a reading
was taken.

> 
> We have since come to realize that a median is not the best filter for
> this task, and - as part of a larger redesign - would like to move
> this filtering in userspace and use a different filter (most likely
> either a least squares or a Kalman filter).

This is sounds like something very much non standard.  It's going to be
hard for any general purpose code to know which timestamp is the
'right' one.

> 
> However, doing the filtering in userland requires us to be able to
> send the a, b and c points from the IIO device on the kernel to
> userspace.
> 
> My initial investigation led me to using indexing as the most viable
> option to have multiple IIO_TIMESTAMP channels defined for the same
> device. However, I spot a few places in the IIO framework where
> channels of kind TIMESTAMP seem to have special meaning.

Hmm. This is true for the main timestamp, but mainly because it
is convenient to be able to do things like define available_scan_masks
without having to care about having to always provide twice as many
entries in order to cover the option of having the timestamp turned
off and turned on.

> 
> Is defining multiple timestamp channels via indexing a supported
> operation? If not, is there any way to define such channels? Or a
> better way to support our use case of providing 3 "timestamp" values
> to userspace.

I don't think we actually prevent it in any way (just took a fairly
superficial look) and there certainly isn't any particular intention
to prevent it.

My only real worry is how to define this interface in a fashion that
is generic.  We might want to use a modified channel with appropriate
IIO_MOD_* to define something like 'sensor time' vs 'host time'.

We can't break the existing ABI however, so we may need the slightly
ugly option of 'no modifier' is the same as 'host time'.

> 
> Any input is appreciated.

Whilst I don't really like the complexity this introduces I can see
you might need the more sophisticated timestamps to let you refine
the relative clock offsets and multipliers as you get more data.

Jonathan
