Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5FB2F9F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfIOK5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 06:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbfIOK5M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 06:57:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A041320830;
        Sun, 15 Sep 2019 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568545031;
        bh=zwXSUpTZg29J3q8RuKqoMHRyfVXYXBqb7yxWubVPUHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x+rfUC2LTVPO5V+10g6Ih1IrfXthNPqYYuA/RsaDbR+OgHKyLBH2izkOW63+9Qw2h
         obFMvOR+JGKtJ5k3Aw1n08wkh7pFlRgeVgiQLJWro18VGLq0myPFwr18+Adjw/nxGT
         Vr0pUje9xF/jzTouXM2p3v56P7C8oFQ+y6ULL/Wg=
Date:   Sun, 15 Sep 2019 11:57:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, mario.tesi@st.com,
        armando.visconti@st.com, denis.ciocca@st.com
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: enable LIR for sensor events
Message-ID: <20190915115706.3d1adb1e@archlinux>
In-Reply-To: <9e55d2f6-5136-f783-bec6-bae79dbc59d2@geanix.com>
References: <cover.1568184231.git.lorenzo@kernel.org>
        <376b8e64aa95f686e46aa760934cd25d9f47833f.1568184231.git.lorenzo@kernel.org>
        <9e55d2f6-5136-f783-bec6-bae79dbc59d2@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Sep 2019 14:37:23 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 11/09/2019 08.50, Lorenzo Bianconi wrote:
> > Enable Latched interrupt by default for sensor events
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> Tested-by: Sean Nyekjaer <sean@geanix.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> > ---
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 35 ++++++++++++++++++++
> >   2 files changed, 37 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index 5e3cd96b0059..3ea0dc13d101 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -215,6 +215,7 @@ struct st_lsm6dsx_ext_dev_settings {
> >    * @fs_table: Hw sensors gain table (gain + val).
> >    * @decimator: List of decimator register info (addr + mask).
> >    * @batch: List of FIFO batching register info (addr + mask).
> > + * @lir: Latched interrupt register info (addr + mask).
> >    * @fifo_ops: Sensor hw FIFO parameters.
> >    * @ts_settings: Hw timer related settings.
> >    * @shub_settings: i2c controller related settings.
> > @@ -237,6 +238,7 @@ struct st_lsm6dsx_settings {
> >   	struct st_lsm6dsx_fs_table_entry fs_table[2];
> >   	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> >   	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> > +	struct st_lsm6dsx_reg lir;
> >   	struct st_lsm6dsx_fifo_ops fifo_ops;
> >   	struct st_lsm6dsx_hw_ts_settings ts_settings;
> >   	struct st_lsm6dsx_shub_settings shub_settings;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 2d3495560136..a208da865efe 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -237,6 +237,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   				.mask = GENMASK(5, 3),
> >   			},
> >   		},
> > +		.lir = {
> > +			.addr = 0x58,
> > +			.mask = BIT(0),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_fifo,
> > @@ -349,6 +353,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   				.mask = GENMASK(5, 3),
> >   			},
> >   		},
> > +		.lir = {
> > +			.addr = 0x58,
> > +			.mask = BIT(0),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_fifo,
> > @@ -470,6 +478,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   				.mask = GENMASK(5, 3),
> >   			},
> >   		},
> > +		.lir = {
> > +			.addr = 0x58,
> > +			.mask = BIT(0),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_fifo,
> > @@ -585,6 +597,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   				.mask = GENMASK(7, 4),
> >   			},
> >   		},
> > +		.lir = {
> > +			.addr = 0x56,
> > +			.mask = BIT(0),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> > @@ -715,6 +731,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   				.mask = GENMASK(7, 4),
> >   			},
> >   		},
> > +		.lir = {
> > +			.addr = 0x56,
> > +			.mask = BIT(0),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> > @@ -822,6 +842,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   				.mask = GENMASK(7, 4),
> >   			},
> >   		},
> > +		.lir = {
> > +			.addr = 0x56,
> > +			.mask = BIT(0),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> > @@ -1416,6 +1440,17 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> >   	if (err < 0)
> >   		return err;
> >   
> > +	/* enable Latched interrupts for device events */
> > +	if (hw->settings->lir.addr) {
> > +		unsigned int data;
> > +
> > +		data = ST_LSM6DSX_SHIFT_VAL(1, hw->settings->lir.mask);
> > +		err = regmap_update_bits(hw->regmap, hw->settings->lir.addr,
> > +					 hw->settings->lir.mask, data);
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> >   	err = st_lsm6dsx_init_shub(hw);
> >   	if (err < 0)
> >   		return err;
> >   

