Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E943094D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 15:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbhJQN0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 09:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343648AbhJQN0p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 09:26:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6181661212;
        Sun, 17 Oct 2021 13:24:33 +0000 (UTC)
Date:   Sun, 17 Oct 2021 14:28:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Teng Qi <starmiku1207184332@gmail.com>,
        lorenzo.bianconi83@gmail.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        islituo@gmail.com, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: Fix an array overflow in
 st_lsm6dsx_set_odr()
Message-ID: <20211017142847.07040537@jic23-huawei>
In-Reply-To: <YWQse08lZHMBe+LX@lore-desk>
References: <20211011114003.976221-1-starmiku1207184332@gmail.com>
        <YWQse08lZHMBe+LX@lore-desk>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Oct 2021 14:22:19 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > The length of hw->settings->odr_table is 2 and ref_sensor->id is an enum
> > variable whose value is between 0 and 5.
> > However, the value ST_LSM6DSX_ID_MAX (i.e. 5) is not catched properly in
> >  switch (sensor->id) {
> > 
> > If ref_sensor->id is ST_LSM6DSX_ID_MAX, an array overflow will ocurrs in
> > function st_lsm6dsx_check_odr():
> >   odr_table = &sensor->hw->settings->odr_table[sensor->id];
> > 
> > and in function st_lsm6dsx_set_odr():
> >   reg = &hw->settings->odr_table[ref_sensor->id].reg;
> > 
> > To fix this array overflow, handle ST_LSM6DSX_ID_GYRO explicitly and 
> > return -EINVAL for the default case.
> > 
> > Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> > Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Teng Qi,

As discussed previously this isn't technically a 'fix' as the default case can
never actually occur, so I've modified the patch description a tiny bit make
that clear.  It's a good change, but we probably don't want to back port it to
older kernels and most things that claim to be 'fixes' are back ported.

Applied to the iio-togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Always good to see a new robot finding suspicious bits of code like this :)

Thanks,

Jonathan
 
> > 
> > ---
> > v2:
> > * explicitly handle ST_LSM6DSX_ID_GYRO and return -EINVAL for the default
> > case instead of adding an if statement behind the switch statement.
> >   Thank Lars-Peter Clausen for helpful and friendly advice.
> > 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index db45f1fc0b81..8dbf744c5651 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1279,6 +1279,8 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
> >  	int err;
> >  
> >  	switch (sensor->id) {
> > +	case ST_LSM6DSX_ID_GYRO:
> > +		break;
> >  	case ST_LSM6DSX_ID_EXT0:
> >  	case ST_LSM6DSX_ID_EXT1:
> >  	case ST_LSM6DSX_ID_EXT2:
> > @@ -1304,8 +1306,8 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
> >  		}
> >  		break;
> >  	}
> > -	default:
> > -		break;
> > +	default: /* should never occur */
> > +		return -EINVAL;
> >  	}
> >  
> >  	if (req_odr > 0) {
> > -- 
> > 2.25.1
> >   

