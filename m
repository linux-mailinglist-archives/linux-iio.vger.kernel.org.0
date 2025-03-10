Return-Path: <linux-iio+bounces-16697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E5BA5A466
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159F93AEA06
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938F1DDC07;
	Mon, 10 Mar 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS/TOYtf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83771CAA6E;
	Mon, 10 Mar 2025 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637215; cv=none; b=lbUUUblFp53QIbE7EkBk5oVDgRqJD3DHqW85vxyLp4NXUyknNIdYAgra7klK76YzKPiGnlet0n3Q7ZVbBsoU7VAUn3NI0XuqBKTfM43yTi2s+rovxV86bdfWmgoCjIZ9JyuCJVpH2r4H6KZt6ThEAg4TTAWxwy2JwrGosFWWYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637215; c=relaxed/simple;
	bh=mvsj4gSpSS3O55/p9GpyJpVuJA5OZcl2oK0ddr3TSSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtKfTaQ+I42E6fh/BQjUMhuH5mAzfd2ZfWScuyHOPqpv6wqLcblRnc4NlBdd8BTeNI3lQiMcw0SCCRkuMfRJmIzQQdiZe2irwp3qfuF/4Rx1yvZjdNHFVaV9KfNx0TpMpc0I4YMv67kohOhLfxA07GluHDYbb5AeNeddoPEm044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS/TOYtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B341FC4CEE5;
	Mon, 10 Mar 2025 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637215;
	bh=mvsj4gSpSS3O55/p9GpyJpVuJA5OZcl2oK0ddr3TSSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JS/TOYtfHkN031uoQRAc3vAF4HAmhRYlXpTtToslsYB7AuzzqDAnHWIqODKQSxuHL
	 X/KHvcy5DDhje8Me6R6ii3L3VsnzClhbtBSH65C7SR0szoBy1mKyGzLIVYSlv1B0SX
	 YTD3OEEov9hNa+tUy5qEEcHhHQr0BlNrYGCPNtsBnoxRZjdg+pdHcG01De2M8jdaXk
	 tqH6FJ7pyxHa8dA2DkYxWLK3YC6GZs0IvJSB3si7y2ODeLVhoU+2yAb8oJGzCi4rdC
	 VRXkdRzo/BEIGFqZYi3J8dbXie64lDIKGjdt50VGjUZyEnOidDC1HJiTcoYtmjSvfT
	 B+TGslNvneU2g==
Date: Mon, 10 Mar 2025 20:06:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Silvano Seva <s.seva@4sigma.it>
Cc: lorenzo@kernel.org, a.greco@4sigma.it, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: fix possible lockup during
 FIFO read
Message-ID: <20250310200647.6570b543@jic23-huawei>
In-Reply-To: <20250310142501.29535-1-s.seva@4sigma.it>
References: <20250310142501.29535-1-s.seva@4sigma.it>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 15:19:17 +0100
Silvano Seva <s.seva@4sigma.it> wrote:

> Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
> from falling in an infinite loop in case pattern_len is equal to zero and
> the device FIFO is not empty.
> 
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")

That's going to make a messy backport.  I assume each fixes
tag refers to one instance below?  If so would you mind splitting the
patch into two parts, with appropriate single fix tag for each?

That would hopefully remove need for manual backporting to older kernels.

Thanks,

Jonathan

> Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> ---
> 
> Changes since v1:
> * st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
> * st_lsm6dsx_read_fifo: dropped check for zero fifo_len
> * added Fixes tags in commit message
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 0a7cd8c1aa33..8a9d2593576a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
>  		return 0;
>  
> +	if (!pattern_len)
> +		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
> +
>  	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
>  		   ST_LSM6DSX_CHAN_SIZE;
>  	fifo_len = (fifo_len / pattern_len) * pattern_len;
> @@ -623,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
>  	if (!fifo_len)
>  		return 0;
>  
> +	if (!pattern_len)
> +		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
> +
>  	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
>  		err = st_lsm6dsx_read_block(hw,
>  					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,


