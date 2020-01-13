Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8862139BD8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAMVtw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 16:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAMVtw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 16:49:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C7F20CC7;
        Mon, 13 Jan 2020 21:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578952192;
        bh=Pz3ZeECDo8TI3Krdrc/8ti1AK+4Bz3dxKgIuWQ2/Pho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dw5cKsfjGS3VbCrt6C09XQtfZJu6fJ+ythgthZwLQNHH857WhLTqcJyLeveG3ApG6
         kfg3odpANbnZqnIL3wOOgPMBZedTJvbr9LGCj0V+WiZj8XQXYr6e26sIKLZaQ7eqzG
         h5t07ITW5muRnjoBs3rLnUUwypDpR5u+k1lm/Ntc=
Date:   Mon, 13 Jan 2020 21:49:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v1] iio: st_gyro: Correct data for LSM9DS0 gyro
Message-ID: <20200113214947.7126ad34@archlinux>
In-Reply-To: <20200113135739.GN32742@smile.fi.intel.com>
References: <20191217171038.17004-1-andriy.shevchenko@linux.intel.com>
        <20191223124534.1ed2d23b@archlinux>
        <20200113135739.GN32742@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 15:57:39 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Dec 23, 2019 at 12:45:34PM +0000, Jonathan Cameron wrote:
> > On Tue, 17 Dec 2019 19:10:38 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > The commit 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
> > > assumes that gyro in LSM9DS0 is the same as others with 0xd4 WAI ID,
> > > but datasheet tells slight different story, i.e. the first scale factor
> > > for the chip is 245 dps, and not 250 dps.
> > > 
> > > Correct this by introducing a separate settings for LSM9DS0.
> > > 
> > > Fixes: 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
> > > Depends-on: 45a4e4220bf4 ("iio: gyro: st_gyro: fix L3GD20H support")
> > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Looks good to me.  Will just leave it a bit longer to give others
> > time to check it.
> > 
> > Give me a shout if I seem to have missed this by about a week into the new
> > year (to let people get back from holidays etc).  
> 
> Gentle ping.
> 
Thanks.  Given timing and the fact the bug is old, I'll pull this into
the togreg branch and hopefully get it lined up for the coming merge window.

Thanks and sorry for the delay.

Jonathan

