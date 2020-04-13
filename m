Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63011A68D8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgDMP2x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731088AbgDMP2w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:28:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E1D2072C;
        Mon, 13 Apr 2020 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586791731;
        bh=KCA2HCHAYO5dqONO4+N3Mqs5xVip9JX18a4/gij1IY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XHRwwCpUGn6uAErLUC8vYaaNndKYYAjw1GGaBQoYn81gxGSQrndR1flnK3JvXI/Hl
         5Mzt8yn65YdEZTM3HTe6RLr0YKU8Kt3s8ceISK5HwOWa+G7bcZGLMPxoAqUprmPDmn
         X61DfToS9T7zZZMdDaM0o2rpgjKOcKdSvMKBWGP8=
Date:   Mon, 13 Apr 2020 16:28:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: RFC: Present Screen rotation as counter
Message-ID: <20200413162847.6b1fd7ef@archlinux>
In-Reply-To: <20200408180256.GB25871@icarus>
References: <CAPUE2uuL8AU8ps=aLGgkqDR3FVxeWCOoMhj+OruZ6YT5Jn+m0Q@mail.gmail.com>
        <20200408180256.GB25871@icarus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Apr 2020 14:02:56 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Apr 08, 2020 at 12:22:10AM -0700, Gwendal Grignou wrote:
> > Today, on chromebook, to detect screen orientation (portrait,
> > landscape, inverted portrait, inverted landscape), chrome is polling
> > lid accelerometer data and calculating the orientation.
> > To save power, I want the embedded controller (EC) to forward an event
> > when the lid acceleration detects an orientation change.
> > To convey that information, I would like to define a rotary encoder
> > with 4 regions, the counter increases when the screen is rotated
> > clockwise, (decreases when rotated counter-clockwise) and would
> > increment by 4 on a full rotation.
> > The EC knows the accelerometer placement relative to the screen, so we
> > can define landscape as count % 4 equals to 0.
> > Would such a counter fit into the counter subsystem?
> > 
> > Regards,
> > Gwendal.  
> 
> The Counter subsystem is capable of representing this using a design
> that looks something like this:
> 
>         Count                Synapse        Signal
>         -----                -------        ------
> +---------------------+
> | Data: Orientation   |     EC Event       _______________
> | Function: Rotate    |  <-------------   / Accelerometer \
> |                     |                  ___________________
> +---------------------+
> 
> Note: I'm calling the function "Rotate" here just to represent the
> increase/decrease behavior of a rotary device, but perhaps a more
> generic name for this function would be better here for other devices as
> well.
> 
> Essentially, within the Generic Counter paradigm, the Signal in this
> case is the accelerometer data. The Synapse is the EC event
> (clockwise/counter-clockwise movement detected) that fires when the EC
> notices the accelerometer placement changed relative to the screen.
> Finally, the Count is the orientation of the screen.
> 
> We can have the Count value be an unsigned integer (0-4) to represent
> each orientation, or an angle (90 degrees, 180 degrees, etc.) if you
> want it to be more abstract -- it's up to you.
> 
> By the way, although I'm labeling the Signal and Synapses here as
> Accelerometer and EC Event respectively, the counter driver you write
> does not need to actually present these raw data values to the user --
> I'm just including it here in the drawing to exemplify the paradigm; the
> user of this counter driver will likely only care about the Count: the
> current orientation value of the screen.

Seems like a practical solution to me.

Brainstorming... Feel free to ignore :)

One possible alternative if staying in IIO would have been to do this
in a similar fashion to activity classification.   In that we defined
a set of activities as taking a 'probability' value/percentage so
we had a set of activity channels that would report 0 if not true and 100
if definitely true. Which was which was indicated by a modifier (running,
walking etc).

So the equivalent here would be to define states as
'portrait' 'landscape', 'inverted portrait' and 'inverted landscape'
each of which is a modifier of some base channel type - not sure what we'd call
that (pose perhaps?)

Then you can use the events from the embedded controller to both update
the value that would be read from the four resulting channels and also to
trigger an iio event (it's a simple rising value with a threshold of 50%)

The reason we went this way for activities is that the reality is the controller
is making some determination of a state being 'likely'.  The same is true
for orientation, particularly if the device is flat on a table.  So
if you wanted to be cleverer in future you could report say 60% chance
of portrait and 20% landscape for example allowing userspace to decide
what thresholds to set dependant on what the application is doing...

Anyhow, this is just brainstorming.  There is some logic to the counter
option - but I do see one issue.  If you want to also distinguish
'flat on table' or 'face down on table' I'm not sure how you do it?

Jonathan

> 
> William Breathitt Gray

