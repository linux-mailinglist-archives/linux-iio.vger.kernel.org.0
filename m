Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE31A5EBB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDLNZT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 09:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLNZT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:25:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E12720708;
        Sun, 12 Apr 2020 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586697918;
        bh=UmaqkBBl+42yu8lXyKqDRpZD/ixQ15ZME0qV2UrJuEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fxCDnFwaWP8a26cYv0+7Qp+KUvPwR45UWCjXwC0th+CkbY3EbBI5o+JTAS1o37BL/
         oFkngHaYsYfYiZ14aVQVtqcZ2Ow0CcBjyUei8QEOY8NDcRkQCPtwCKWWancd6BR40/
         g6n5UM2yMrcc3UWuThFoG9DW7too21tbPR5cpIoU=
Date:   Sun, 12 Apr 2020 14:25:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: limit variales scope reading hw
 FIFO
Message-ID: <20200412142515.0b30b2b5@archlinux>
In-Reply-To: <d7464094f82945ae7978a18e0117570b2c71c963.1586247885.git.lorenzo@kernel.org>
References: <d7464094f82945ae7978a18e0117570b2c71c963.1586247885.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 Apr 2020 10:26:44 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix following cppcheck warnings reported by kbuild test robot
> 
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:313:15:
> warning: The scope of the variable 'word_len' can be reduced. [variableScope]
>                  ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:314:6:
> warning: The scope of the variable 'err' can be reduced. [variableScope]
>         ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:11:
> warning: The scope of the variable 'sip' can be reduced. [variableScope]
>              ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:16:
> warning: The scope of the variable 'acc_sip' can be reduced. [variableScope]
>                   ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:25:
> warning: The scope of the variable 'gyro_sip' can be reduced. [variableScope]
>                            ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:35:
> warning: The scope of the variable 'ts_sip' can be reduced. [variableScope]
>                                      ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:43:
> warning: The scope of the variable 'ext_sip' can be reduced. [variableScope]
>                                              ^
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:341:62:
> warning: The scope of the variable 'offset' can be reduced. [variableScope]
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
I find it hard to care about these to be honest.  I got the original report
at chose not to fix them :)  Anyhow, if you want to tidy them up that's fine
of course.

More interestingly this doesn't actually apply any more due to your sensor
hub patches.  If you want to respin on top of the testing branch of iio.git
then feel free.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index afd00daeefb2..849f01fbe76c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -310,10 +310,12 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
>  					u8 *data, unsigned int data_len,
>  					unsigned int max_word_len)
>  {
> -	unsigned int word_len, read_len = 0;
> -	int err;
> +	unsigned int read_len = 0;
>  
>  	while (read_len < data_len) {
> +		unsigned int word_len;
> +		int err;
> +
>  		word_len = min_t(unsigned int, data_len - read_len,
>  				 max_word_len);
>  		err = st_lsm6dsx_read_locked(hw, addr, data + read_len,
> @@ -338,7 +340,6 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
>  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  {
>  	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor, *ext_sensor = NULL;
> -	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
>  	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
>  	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
>  	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> @@ -346,6 +347,7 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
>  	bool reset_ts = false;
>  	__le16 fifo_status;
> +	int err, read_len;
>  	s64 ts = 0;
>  
>  	err = st_lsm6dsx_read_locked(hw,
> @@ -370,6 +372,8 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  		ext_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0]);
>  
>  	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> +		int acc_sip, gyro_sip, ts_sip, ext_sip, offset = 0, sip = 0;
> +
>  		err = st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
>  					    hw->buff, pattern_len,
>  					    ST_LSM6DSX_MAX_WORD_LEN);
> @@ -399,8 +403,6 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  		gyro_sip = gyro_sensor->sip;
>  		acc_sip = acc_sensor->sip;
>  		ts_sip = hw->ts_sip;
> -		offset = 0;
> -		sip = 0;
>  
>  		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
>  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {

