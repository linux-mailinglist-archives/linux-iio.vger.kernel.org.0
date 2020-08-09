Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D523FE97
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHINm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 09:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHINm1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 09:42:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9E6206B6;
        Sun,  9 Aug 2020 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596980546;
        bh=z5ggloJNSGbzFqqy5FHmnwMWQ3MZ9nRoSWZRpWR9klU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2pP5p4l1UBj7LXtrfSEqaHQi1n0qTCP2tOejp5K7tgGCUl6sNPoRWR4+F2B1j36ln
         Fxh9c6u9oZyaisvh5P5Jd3KjTd7l82acjPoytbL3BDvwbNcUOWSlv/RqjfDf98xFkM
         IVcCj3Fm7boVUIEUt1TtKu+9xLkxS1x8Be74b/pM=
Date:   Sun, 9 Aug 2020 14:42:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        David.Laight@ACULAB.COM
Subject: Re: [PATCH v4 1/5] counter: Internalize sysfs interface code
Message-ID: <20200809144221.6947ea6e@archlinux>
In-Reply-To: <4061c9e4-775e-b7a6-14fa-446de4fae537@lechnology.com>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
        <e13d43849f68af8227c6aaa0ef672b459d47e9ab.1595358237.git.vilhelm.gray@gmail.com>
        <7209ac3d-d1ca-1b4c-b22c-8d98b13742e2@lechnology.com>
        <20200802210415.GA606173@shinobu>
        <4061c9e4-775e-b7a6-14fa-446de4fae537@lechnology.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Aug 2020 15:00:49 -0500
David Lechner <david@lechnology.com> wrote:

> On 8/2/20 4:04 PM, William Breathitt Gray wrote:
> > On Tue, Jul 28, 2020 at 05:45:53PM -0500, David Lechner wrote:  
> >> On 7/21/20 2:35 PM, William Breathitt Gray wrote:  
> >>> This is a reimplementation of the Generic Counter driver interface.  
> 
> ...
> 
> >>> -F:	include/linux/counter_enum.h
> >>> +F:	include/uapi/linux/counter.h  
> >>
> >> Seems odd to be introducing a uapi header here since this patch doesn't
> >> make any changes to userspace.  
> > 
> > These defines are needed by userspace for the character device
> > interface, but I see your point that at this point in the patchset they
> > don't need to be exposed yet.
> > 
> > I could create temporary include/linux/counter_types.h to house these
> > defines, and then later move them to include/uapi/linux/counter.h in the
> > character device interface introduction patch. Do you think I should do
> > so?  
> 
> Since this patch is independent of the chardev changes and probably ready
> to merge after one more round of review, I would say it probably makes
> sense to just leave them in counter.h for now and move them to uapi when
> the chardev interface is finalized. This way, we can just merge this patch
> as soon as it is ready.
> 
Agreed.

...

> >>>    /**
> >>>     * struct counter_device - Counter data structure
> >>> - * @name:		name of the device as it appears in the datasheet
> >>> + * @name:		name of the device
> >>>     * @parent:		optional parent device providing the counters
> >>> - * @device_state:	internal device state container
> >>> - * @ops:		callbacks from driver
> >>> + * @signal_read:	optional read callback for Signals. The read value of
> >>> + *			the respective Signal should be passed back via the
> >>> + *			value parameter.
> >>> + * @count_read:		optional read callback for Counts. The read value of the
> >>> + *			respective Count should be passed back via the value
> >>> + *			parameter.
> >>> + * @count_write:	optional write callback for Counts. The write value for
> >>> + *			the respective Count is passed in via the value
> >>> + *			parameter.
> >>> + * @function_read:	optional read callback the Count function modes. The
> >>> + *			read function mode of the respective Count should be
> >>> + *			passed back via the function parameter.
> >>> + * @function_write:	option write callback for Count function modes. The
> >>> + *			function mode to write for the respective Count is
> >>> + *			passed in via the function parameter.
> >>> + * @action_read:	optional read callback the Synapse action modes. The
> >>> + *			read action mode of the respective Synapse should be
> >>> + *			passed back via the action parameter.
> >>> + * @action_write:	option write callback for Synapse action modes. The
> >>> + *			action mode to write for the respective Synapse is
> >>> + *			passed in via the action parameter.
> >>>     * @signals:		array of Signals  
> >>
> >> Why not keep the ops struct?  
> > 
> > Defining static ops structures in the drivers seemed to have no
> > advantage when those callbacks are always used via the counter_device
> > structure. I decided it'd be simpler to just set them directly in the
> > counter_device structure then.
> > 
> > I could reorganize them into an ops structure again if there's enough
> > interest.  
> 
> I've been working on really constrained systems lately where every byte
> counts, so this stuck out to me since there would be a copy of all
> functions for each counter instance. But probably not that big of a deal
> in the Linux kernel. :-)
> 
In addition to that..

There are other advantages to keeping an ops structure including
easy function order randomization (for security), plus
the fact that we want to make any function pointers build time assignments
if we possibly can.  Makes them harder to attack.

So in more recent kernel code we try to use ops structures wherever possible.

Jonathan
