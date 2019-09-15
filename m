Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5EDB2FA7
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfIOLDx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 07:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfIOLDx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 07:03:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE50920644;
        Sun, 15 Sep 2019 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568545432;
        bh=t7c13Y0AsNsxfVMiGsnH8HGgO++9ey1EnZQpFaQRiS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHckUWUpmJ4QJWmnvrkcjT5poga3Q/eEUanl2nqm6I3FOiFp+4pq8Z3BckrArKAm5
         DQFqSFc0UQ0x4xGkAFzUmQv0sEivGA9BfJ3LeHtpZLqotHDNjByWJKAszn6YCj6zhF
         bUU0Bax1q9h5A+8T3XxuvP11mToXdPM26BSTd/sA=
Date:   Sun, 15 Sep 2019 12:03:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, mario.tesi@st.com,
        armando.visconti@st.com, denis.ciocca@st.com
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: enable clear on read for
 latched interrupts
Message-ID: <20190915120347.0a2819c4@archlinux>
In-Reply-To: <d132a857-9bcb-6273-e2bd-95b0c2c87d0e@geanix.com>
References: <cover.1568184231.git.lorenzo@kernel.org>
        <d2c9b90f277826a4b3403d44885fff1cd36d9245.1568184231.git.lorenzo@kernel.org>
        <d132a857-9bcb-6273-e2bd-95b0c2c87d0e@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Sep 2019 14:37:16 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 11/09/2019 08.50, Lorenzo Bianconi wrote:
> > Enable clear on read feature for latched interrupts. This bit allows
> > immediately clearing the latched interrupts of an event detection upon
> > the read of the corresponding status register.
> > It must be set to 1 together with LIR.
> > This feature is available just on LSM6DS0/LSM6DSR/ASM330LHH
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> Tested-by: Sean Nyekjaer <sean@geanix.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> > ---
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 ++++++++++++++++++++
> >   2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index 3ea0dc13d101..fefd9042590a 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -216,6 +216,7 @@ struct st_lsm6dsx_ext_dev_settings {
> >    * @decimator: List of decimator register info (addr + mask).
> >    * @batch: List of FIFO batching register info (addr + mask).
> >    * @lir: Latched interrupt register info (addr + mask).
> > + * @clear_on_read: Clear on read register info (addr + mask).
> >    * @fifo_ops: Sensor hw FIFO parameters.
> >    * @ts_settings: Hw timer related settings.
> >    * @shub_settings: i2c controller related settings.
> > @@ -239,6 +240,7 @@ struct st_lsm6dsx_settings {
> >   	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> >   	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> >   	struct st_lsm6dsx_reg lir;
> > +	struct st_lsm6dsx_reg clear_on_read;
> >   	struct st_lsm6dsx_fifo_ops fifo_ops;
> >   	struct st_lsm6dsx_hw_ts_settings ts_settings;
> >   	struct st_lsm6dsx_shub_settings shub_settings;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index a208da865efe..b65a6ca775e0 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -601,6 +601,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   			.addr = 0x56,
> >   			.mask = BIT(0),
> >   		},
> > +		.clear_on_read = {
> > +			.addr = 0x56,
> > +			.mask = BIT(6),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> > @@ -735,6 +739,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   			.addr = 0x56,
> >   			.mask = BIT(0),
> >   		},
> > +		.clear_on_read = {
> > +			.addr = 0x56,
> > +			.mask = BIT(6),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> > @@ -846,6 +854,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >   			.addr = 0x56,
> >   			.mask = BIT(0),
> >   		},
> > +		.clear_on_read = {
> > +			.addr = 0x56,
> > +			.mask = BIT(6),
> > +		},
> >   		.fifo_ops = {
> >   			.update_fifo = st_lsm6dsx_update_fifo,
> >   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> > @@ -1449,6 +1461,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> >   					 hw->settings->lir.mask, data);
> >   		if (err < 0)
> >   			return err;
> > +
> > +		/* enable clear on read for latched interrupts */
> > +		if (hw->settings->clear_on_read.addr) {
> > +			data = ST_LSM6DSX_SHIFT_VAL(1,
> > +					hw->settings->clear_on_read.mask);
> > +			err = regmap_update_bits(hw->regmap,
> > +					hw->settings->clear_on_read.addr,
> > +					hw->settings->clear_on_read.mask,
> > +					data);
> > +			if (err < 0)
> > +				return err;
> > +		}
> >   	}
> >   
> >   	err = st_lsm6dsx_init_shub(hw);
> >   

