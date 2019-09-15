Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78067B2FCE
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfIOMUo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfIOMUo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:20:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F19214AF;
        Sun, 15 Sep 2019 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568550043;
        bh=lrHAr/H+cakaanA//lFuyKshdlZzqIxKK82DkB7QZn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aMxEBPm0sxihpWLD50rrsJ4o2b87oSyXqr8XpzWShFbua+C+OgB6xTlzQIKouKEtl
         6Y5LyCGeEuQFxZQr5tQejlud8nHrCN8YiNAaWD52XcQjF3oR6fjgMwZhyv6cMM5U4X
         n1kW/rEwcaTO51zVwkd3dg56twZQHGU3lbOfQUhM=
Date:   Sun, 15 Sep 2019 13:20:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190915132038.0ed74957@archlinux>
In-Reply-To: <4167d81f-6136-f9f9-cb6b-02b423799762@geanix.com>
References: <20190909112846.55280-1-sean@geanix.com>
        <20190909112846.55280-5-sean@geanix.com>
        <4167d81f-6136-f9f9-cb6b-02b423799762@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Sep 2019 13:51:13 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 09/09/2019 13.28, Sean Nyekjaer wrote:
> > Report iio motion events to iio subsystem
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes since v4:
> >   * Updated bitmask as pr Jonathans comments
> > 
> > Changes since v5:
> >   * None
> > 
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
> >   2 files changed, 75 insertions(+)
> >   
> [...]
> >   
> > +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> > +{
> > +	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > +
> > +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > +						  0,
> > +						  IIO_MOD_Z,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_EITHER),
> > +						  timestamp);
> > +
> > +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > +						  0,
> > +						  IIO_MOD_Y,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_EITHER),
> > +						  timestamp);
> > +
> > +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > +						  0,
> > +						  IIO_MOD_X,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_EITHER),
> > +						  timestamp);
> > +}
> > +  
> 
> I was looking at this again, and if the user enables events for channel 
> x, we continue to report events for y, z.
> Is it okay or is it better to filter them out?
Better to filter them out.  It'll be a bit of a surprise for userspace
otherwise.

Thanks,

Jonathan

> 
> /Sean

