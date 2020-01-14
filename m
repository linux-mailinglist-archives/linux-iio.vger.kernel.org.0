Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 723D713A387
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgANJMc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 04:12:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgANJMb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Jan 2020 04:12:31 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DED8310C4514AE4E6422;
        Tue, 14 Jan 2020 09:12:29 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Jan 2020 09:12:29 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 09:12:29 +0000
Date:   Tue, 14 Jan 2020 09:12:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephan Gerhold <stephan@gerhold.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20200114091227.00002880@Huawei.com>
In-Reply-To: <20200114090652.GA932@gerhold.net>
References: <20191209170541.198206-1-stephan@gerhold.net>
        <20191215172342.1e2ab5c4@archlinux>
        <20200113221211.27afee1d@archlinux>
        <20200114090652.GA932@gerhold.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jan 2020 10:06:52 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> On Mon, Jan 13, 2020 at 10:12:11PM +0000, Jonathan Cameron wrote:
> > On Sun, 15 Dec 2019 17:23:42 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Mon,  9 Dec 2019 18:05:41 +0100
> > > Stephan Gerhold <stephan@gerhold.net> wrote:
> > >   
> > > > At the moment, attempting to probe a device with ST_LSM6DS3_ID
> > > > (e.g. using the st,lsm6ds3 compatible) fails with:
> > > > 
> > > >     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
> > > > 
> > > > ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
> > > > 
> > > > This happens because st_lsm6dsx_check_whoami() also attempts
> > > > to match unspecified (zero-initialized) entries in the "id" array.
> > > > ST_LSM6DS3_ID = 0 will therefore match any entry in
> > > > st_lsm6dsx_sensor_settings (here: the first), because none of them
> > > > actually have all 12 entries listed in the "id" array.
> > > > 
> > > > Avoid this by additionally checking if "name" is set,
> > > > which is only set for valid entries in the "id" array.
> > > > 
> > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>    
> > > Definitely sounds like this wants backporting. 
> > > 
> > > If you can figure out a fixes tag that would be great!  
> > I've taken a stab at working out when this got introduced and
> > came up with:
> > 
> > 81956a93b522 "iio: imu: st_lsm6dsx: get device name from st_lsm6dsx_sensor_settings"
> > 
> > If that's wrong please let me know asap.
> > 
> > Applied to the togreg branch of iio.git as we are near the merge
> > window opening and marked for stable.  
> 
> You have already applied the v2 I sent with the fixes/cc stable tags :)
> It's part of your "Second set of IIO fixes for the 5.5 cycle." pull request:
> https://lore.kernel.org/linux-iio/20200105110051.445c9a95@archlinux/

Gah!  I clearly wasn't on top form last night.   Will drop this one again.

Thanks.

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan  
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > >   
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index a7d40c02ce6b..b921dd9e108f 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > > >  
> > > >  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> > > >  		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > > > -			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > > > +			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> > > > +			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > > >  				break;
> > > >  		}
> > > >  		if (j < ST_LSM6DSX_MAX_ID)    
> > >   
> >   
> 


