Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6DF196831
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1Rpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1Rpj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 13:45:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBF920714;
        Sat, 28 Mar 2020 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585417538;
        bh=4/8LQolKu8so+6XDSEG5uJlSl9nM13HcF/vq2+oIHWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2bjGQxo9mlXE9D3DGo4/rulDrFofQ+KoAww6tvgNtpbtLnNBifhG07biYFLrWZu+G
         ABxZOtNXNxI5R77jk3VF1t3m7QPqE9Wa1rI5PBYKvjFEvDyibxRaXi+6Ng2HAvSazR
         X9sioDYR52VC9XCWbpa8hwqaheYFYW53Xx1e1WmU=
Date:   Sat, 28 Mar 2020 17:45:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Message-ID: <20200328174534.6851a9c0@archlinux>
In-Reply-To: <20200327131901.GW1922688@smile.fi.intel.com>
References: <5e7dfb41.1c69fb81.cc4bb.042f@mx.google.com>
        <20200327131901.GW1922688@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 15:19:01 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 27, 2020 at 06:40:23PM +0530, Rohit Sarkar wrote:
> > The debugfs interface provides direct access to read and write device
> > registers if debugfs is enabled.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> > Changelog v1->v2
> > * grab a lock to protect driver state
> > * add a comma at the end of structure member initialisation
> > 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 7cb9ff3d3e94..381a3fb09858 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -1248,12 +1248,31 @@ static const struct attribute_group inv_attribute_group = {
> >  	.attrs = inv_attributes
> >  };
> >  
> > +static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
> > +				  unsigned int reg,
> > +				  unsigned int writeval,
> > +				  unsigned int *readval)
> > +{
> > +	struct inv_mpu6050_state *st = iio_priv(indio_dev);  
> 
> > +	int ret = 0;  
> 
> Assignment is redundant, but I think maintainers may update this when applying.

Fixed up and applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Jonathan

> 
> > +
> > +	mutex_lock(&st->lock);
> > +	if (readval)
> > +		ret = regmap_read(st->map, reg, readval);
> > +	else
> > +		ret = regmap_write(st->map, reg, writeval);
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct iio_info mpu_info = {
> >  	.read_raw = &inv_mpu6050_read_raw,
> >  	.write_raw = &inv_mpu6050_write_raw,
> >  	.write_raw_get_fmt = &inv_write_raw_get_fmt,
> >  	.attrs = &inv_attribute_group,
> >  	.validate_trigger = inv_mpu6050_validate_trigger,
> > +	.debugfs_reg_access = &inv_mpu6050_reg_access,
> >  };
> >  
> >  /**
> > -- 
> > 2.23.0.385.gbc12974a89
> >   
> 

