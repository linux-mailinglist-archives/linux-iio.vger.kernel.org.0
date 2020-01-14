Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2329413A381
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 10:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgANJKB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 04:10:01 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:26615 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJKB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 04:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578992998;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1kwBok+YLpF15alNujeDCZ2WmjBCKN8elMO8GAKt6qU=;
        b=iUOz1VZy3hYgz+6iM8rzamkyojzBqAcK+b9LXTYqaBoSpP2P7XnPRjThGJGKXgH04G
        yDKZU78fhDPZYnb8oPADc6sFhLIOEGY+Oh+quSwwW05chcALeOb7DZWpmJ9KrCEAoPyI
        +XNdNiXLRQEOfemJY8qyUYTiaWVvvXaarp6QuXiKKHveYdlNy6jQOfo/2GHhTlvog9Px
        dQSjX/v9O/lmG8iz2KtiWvjTMY/yuHnwNQHHORyYta/qjT6s1jVpTZ09iwby+BjbZo4B
        ZX5Z1G5stJGeVAqkd9pNIvD5oVjMuCrxOARmECnm9wsuW76rPgRQ5J4WcANcNUAfQ71h
        oSOg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4oDWF5yUxHE="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.4 AUTH)
        with ESMTPSA id h048a6w0E96vTKO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 14 Jan 2020 10:06:57 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:06:52 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20200114090652.GA932@gerhold.net>
References: <20191209170541.198206-1-stephan@gerhold.net>
 <20191215172342.1e2ab5c4@archlinux>
 <20200113221211.27afee1d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113221211.27afee1d@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 13, 2020 at 10:12:11PM +0000, Jonathan Cameron wrote:
> On Sun, 15 Dec 2019 17:23:42 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon,  9 Dec 2019 18:05:41 +0100
> > Stephan Gerhold <stephan@gerhold.net> wrote:
> > 
> > > At the moment, attempting to probe a device with ST_LSM6DS3_ID
> > > (e.g. using the st,lsm6ds3 compatible) fails with:
> > > 
> > >     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
> > > 
> > > ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
> > > 
> > > This happens because st_lsm6dsx_check_whoami() also attempts
> > > to match unspecified (zero-initialized) entries in the "id" array.
> > > ST_LSM6DS3_ID = 0 will therefore match any entry in
> > > st_lsm6dsx_sensor_settings (here: the first), because none of them
> > > actually have all 12 entries listed in the "id" array.
> > > 
> > > Avoid this by additionally checking if "name" is set,
> > > which is only set for valid entries in the "id" array.
> > > 
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>  
> > Definitely sounds like this wants backporting. 
> > 
> > If you can figure out a fixes tag that would be great!
> I've taken a stab at working out when this got introduced and
> came up with:
> 
> 81956a93b522 "iio: imu: st_lsm6dsx: get device name from st_lsm6dsx_sensor_settings"
> 
> If that's wrong please let me know asap.
> 
> Applied to the togreg branch of iio.git as we are near the merge
> window opening and marked for stable.

You have already applied the v2 I sent with the fixes/cc stable tags :)
It's part of your "Second set of IIO fixes for the 5.5 cycle." pull request:
https://lore.kernel.org/linux-iio/20200105110051.445c9a95@archlinux/

> 
> Thanks,
> 
> Jonathan
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index a7d40c02ce6b..b921dd9e108f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > >  
> > >  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> > >  		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > > -			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > > +			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> > > +			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > >  				break;
> > >  		}
> > >  		if (j < ST_LSM6DSX_MAX_ID)  
> > 
> 

