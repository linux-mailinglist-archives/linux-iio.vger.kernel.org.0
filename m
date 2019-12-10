Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B3118226
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 09:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLJIXE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 03:23:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:18266 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfLJIXE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 03:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575966182;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=HN81M6UBL5MsjSt1ilW1R6bUnFBMuag+sAL05ArT9lw=;
        b=UiDoJPChxIWpGHuj7yXedgLdIqpGl4rkORkLgJA4y2hMpUH42qKrUe/icPuVJ+g1av
        ihBOzK/DIE7U2nK5rCjaM2m30J0OJu83zzaFJX5NpyFTnrXkWh5wwg8310P1BoLjOv8M
        3+6TJZWMlk75WHVgm7bjK0yKfNwNyKRQWTXnrdoswWfo7e4+f8fyoZmuh7Fo7KHpAtg+
        uRRYz36T9riKpx4s5S7N3FW2o4WBToe5RuIqwW+bYtzgN69qsThYkZFpL0JY+C6xPStZ
        P1RELGOKC0h2t3yW/Z/e0oEbgnDBCoiKT0+YcGCCnbTJlPNUCoCbQ4+JZThDdsuYdd0d
        WSNg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJGV8vHxv6O"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id R01a59vBA8N1dEd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 10 Dec 2019 09:23:01 +0100 (CET)
Date:   Tue, 10 Dec 2019 09:22:53 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20191210082253.GA867@gerhold.net>
References: <20191209170541.198206-1-stephan@gerhold.net>
 <20191209214852.GA2485@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209214852.GA2485@localhost.localdomain>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 09, 2019 at 10:48:52PM +0100, Lorenzo Bianconi wrote:
> > At the moment, attempting to probe a device with ST_LSM6DS3_ID
> > (e.g. using the st,lsm6ds3 compatible) fails with:
> > 
> >     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
> > 
> > ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
> > 
> 
> Hi Stephan,
> 
> thx for working on this. I guess we can skip 'void' iterations defining the
> array real size, do you agree?
> 

I'm not sure I understand you correctly.
Do you mean having something like:

struct st_lsm6dsx_settings {
	u8 wai;
	/* ... */
	struct {
		enum st_lsm6dsx_hw_id hw_id;
		const char *name;
	} id[ST_LSM6DSX_MAX_ID];
	int id_num; /* Add this field */
	/* ... */
};

And then change the loop to use .id_num instead?

I think it is pretty easy to forget to update "id_num"
when adding new entries. Right now there is no need to worry about that.

Thanks,
Stephan

> Regards,
> Lorenzo
> 
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
> > -- 
> > 2.24.0
> > 


