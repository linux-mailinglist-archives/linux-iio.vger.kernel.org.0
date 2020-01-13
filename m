Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15A139C36
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 23:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAMWMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 17:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAMWMP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 17:12:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30952072B;
        Mon, 13 Jan 2020 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578953535;
        bh=gzCnpKeyHQpfnaGrhe7olX+cuDanMLkgwrM2ErTWP/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2HD80UsjhR5lX4DA0eV2BqvGI3Vso0QfFg9LtK46aJPc8Jfb0afdrlB0w436NOgry
         O9Tp2PsT9vC5TYlA3FVWh/0iybJrAMXxF3LzSqFiQMCCvwMp9FsPtCQCB6aNc8HcyV
         NZQgBA0q9wvWFAT+J3ipC9+d798IBo08gzW6guCg=
Date:   Mon, 13 Jan 2020 22:12:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20200113221211.27afee1d@archlinux>
In-Reply-To: <20191215172342.1e2ab5c4@archlinux>
References: <20191209170541.198206-1-stephan@gerhold.net>
        <20191215172342.1e2ab5c4@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Dec 2019 17:23:42 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon,  9 Dec 2019 18:05:41 +0100
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > At the moment, attempting to probe a device with ST_LSM6DS3_ID
> > (e.g. using the st,lsm6ds3 compatible) fails with:
> > 
> >     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
> > 
> > ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
> > 
> > This happens because st_lsm6dsx_check_whoami() also attempts
> > to match unspecified (zero-initialized) entries in the "id" array.
> > ST_LSM6DS3_ID = 0 will therefore match any entry in
> > st_lsm6dsx_sensor_settings (here: the first), because none of them
> > actually have all 12 entries listed in the "id" array.
> > 
> > Avoid this by additionally checking if "name" is set,
> > which is only set for valid entries in the "id" array.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>  
> Definitely sounds like this wants backporting. 
> 
> If you can figure out a fixes tag that would be great!
I've taken a stab at working out when this got introduced and
came up with:

81956a93b522 "iio: imu: st_lsm6dsx: get device name from st_lsm6dsx_sensor_settings"

If that's wrong please let me know asap.

Applied to the togreg branch of iio.git as we are near the merge
window opening and marked for stable.

Thanks,

Jonathan
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index a7d40c02ce6b..b921dd9e108f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> >  
> >  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> >  		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > -			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > +			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> > +			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> >  				break;
> >  		}
> >  		if (j < ST_LSM6DSX_MAX_ID)  
> 

