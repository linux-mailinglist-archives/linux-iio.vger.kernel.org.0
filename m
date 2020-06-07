Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726A01F0C5A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgFGPHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgFGPHp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:07:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699D320659;
        Sun,  7 Jun 2020 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591542464;
        bh=BTgW61QWyZzSu/tOHMIvXdh6b4xQqwjJxYtzn4EnYjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ReRQ5UydL6+XV5i4Wwf28vFBThjtoO+X6uEuMOCN0poCukUCoqnj+PQQFeOy4sjdq
         HzR3whVBzc6Gz5ePPDSF3PMw6G7xtwAxAOAoradQ0KhelxxcduXuUiHYlTJh40iMdR
         ZQADBgsNkO5M6v7qoIZngeIkXRNVCxYnDx7OHsfE=
Date:   Sun, 7 Jun 2020 16:07:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 12/25] iio:imu:st_lsm6dsx Fix alignment and data leak
 issues
Message-ID: <20200607160740.25df8024@archlinux>
In-Reply-To: <20200526075838.GC339643@localhost.localdomain>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-13-jic23@kernel.org>
        <20200526075838.GC339643@localhost.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 09:58:38 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a set of suitable structures in the iio_priv() data.
> > 
> > This data is allocated with kzalloc so no data can leak apart from
> > previous readings.
> > 
> > There has been a lot of churn in this driver, so likely backports
> > may be needed for stable.
> > 
> > Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  5 ++++
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 ++++++++++---------
> >  2 files changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index b56df409ed0f..5bc724eadc83 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -411,6 +411,11 @@ struct st_lsm6dsx_hw {
> >  	const struct st_lsm6dsx_settings *settings;
> >  
> >  	struct iio_mount_matrix orientation;
> > +	/* Ensure natural alignment of buffer elements */
> > +	struct {
> > +		__le16 channels[3];
> > +		s64 ts;
> > +	} gyro_scan, acc_scan, ext_scan;
> >  };
> >  
> >  static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index afd00daeefb2..9bcffbfac797 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -341,9 +341,6 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
> >  	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
> >  	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
> > -	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> > -	u8 acc_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> > -	u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> >  	bool reset_ts = false;
> >  	__le16 fifo_status;
> >  	s64 ts = 0;
> > @@ -404,18 +401,21 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  
> >  		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
> >  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> > -				memcpy(gyro_buff, &hw->buff[offset],
> > -				       ST_LSM6DSX_SAMPLE_SIZE);
> > +				memcpy(hw->gyro_scan.channels,
> > +				       &hw->buff[offset],
> > +				       sizeof(hw->gyro_scan.channels));
> >  				offset += ST_LSM6DSX_SAMPLE_SIZE;  
> 
> what about doing?
> 
> offset += sizeof(hw->gyro_scan.channels)
> 
> it seems easier to follow, what do you think?
> 
> >  			}
> >  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> > -				memcpy(acc_buff, &hw->buff[offset],
> > -				       ST_LSM6DSX_SAMPLE_SIZE);
> > +				memcpy(hw->acc_scan.channels,
> > +				       &hw->buff[offset],
> > +				       sizeof(hw->acc_scan.channels));
> >  				offset += ST_LSM6DSX_SAMPLE_SIZE;  
> 
> same here
> 
> >  			}
> >  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> > -				memcpy(ext_buff, &hw->buff[offset],
> > -				       ST_LSM6DSX_SAMPLE_SIZE);
> > +				memcpy(hw->ext_scan.channels,
> > +				       &hw->buff[offset],
> > +				       sizeof(hw->ext_scan.channels));
> >  				offset += ST_LSM6DSX_SAMPLE_SIZE;  
> 
> same here

Agreed.  I also missed the tagged path needs alignment.  For that one I did it
directly on the stack.  Please take a look at v2 and let me know if it looks
right to you.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> >  			}
> >  
> > @@ -446,19 +446,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> > -					gyro_buff, gyro_sensor->ts_ref + ts);
> > +					&hw->gyro_scan,
> > +					gyro_sensor->ts_ref + ts);
> >  				gyro_sip--;
> >  			}
> >  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > -					acc_buff, acc_sensor->ts_ref + ts);
> > +					&hw->acc_scan,
> > +					acc_sensor->ts_ref + ts);
> >  				acc_sip--;
> >  			}
> >  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
> > -					ext_buff, ext_sensor->ts_ref + ts);
> > +					&hw->ext_scan,
> > +					ext_sensor->ts_ref + ts);
> >  				ext_sip--;
> >  			}
> >  			sip++;
> > -- 
> > 2.26.2
> >   

