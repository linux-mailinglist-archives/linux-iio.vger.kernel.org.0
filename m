Return-Path: <linux-iio+bounces-16876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C4A631B0
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2400173A8D
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1F20551A;
	Sat, 15 Mar 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPhXcnWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26221F8901;
	Sat, 15 Mar 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063812; cv=none; b=R+Iw7c0Qrt4lvilKfin0l3hHMkgvtdyGXohWOAxl4tDlv75xtG5A6YdypB9O+Hnu0aO6gS0VskTCZ4wV5e2nC6EiyJWTHedCOCuJAqfWHXKfxMTJACRZ7lBUOjxsHG7gGb/vwD/TSvVBmTW3dhR2NTmNQ843s89lYoFW4zYcMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063812; c=relaxed/simple;
	bh=K/WeHyYe88JhtenDvvSoJGOFF2LZ+hiyvYhppLQkWEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIkhkIxdskQ9GnK5i3gt6sc71+eDNRSQrXDZAZyMz2SptQjDTThLGMyNI4ArA6r6GXuQM5ARCrpQwdojCvlGIIgJ8oLhaNFz0iZAIlG8solPoHfRD6zQGkYHZuT6v1TSBk+5jpyh5YuMHCw33BDxcVt57F0mbp2CwHXE1b4E8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPhXcnWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27EBC4CEE5;
	Sat, 15 Mar 2025 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063811;
	bh=K/WeHyYe88JhtenDvvSoJGOFF2LZ+hiyvYhppLQkWEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPhXcnWFhfUOtQaR8LE0DzjlEIm5GSsvI28Ef+ClHtM18dX/X8WdPyb2pAyo01Awv
	 pXh+bSy5W0iffxHW7OzLnmRKJP0JyZRFYfgWwg/6WwiAdOJZZGsgZtMxBWNg340b7K
	 molZa4X2MkIAWFFvaOlGhBShnWKNwsYHQ0ANwuijBeAQsPeEDgOI6cf+03jsulZIVb
	 liNlthu2+BVxWj4JSCnA28aVYfpEDxtl7BWbMcSbtrwk8BQvCR/W833Ob5RVRGKi+T
	 6BJnAczkEpZYgnAxaIsdFpSFPPjttSvRwoOdXXnex6pD3NYPOvHqtqnq73nEYN1IQ8
	 CrJ3BYrUX+pqg==
Date: Sat, 15 Mar 2025 18:36:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Silvano Seva <s.seva@4sigma.it>
Cc: a.greco@4sigma.it, Lorenzo Bianconi <lorenzo@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: st_lsm6dsx: fix possible lockup in
 st_lsm6dsx_read_fifo
Message-ID: <20250315183644.04fd688b@jic23-huawei>
In-Reply-To: <20250311085030.3593-2-s.seva@4sigma.it>
References: <20250311085030.3593-2-s.seva@4sigma.it>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 09:49:47 +0100
Silvano Seva <s.seva@4sigma.it> wrote:

> Prevent st_lsm6dsx_read_fifo from falling in an infinite loop in case
> pattern_len is equal to zero and the device FIFO is not empty.
> 
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Silvano Seva <s.seva@4sigma.it>
I think you could validly have kept Lorenzo's ack given this was
just breaking the patch into two parts. I put it back and applied
these with them marked for stable to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> 
> Changes since v1:
> * st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
> * st_lsm6dsx_read_fifo: dropped check for zero fifo_len
> * added Fixes tags in commit message
> 
> Changes since v2:
> * split patch in two parts, one fixing st_lsm6dsx_read_fifo and one fixing
> st_lsm6dsx_read_tagged_fifo
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 0a7cd8c1aa33..480a9b31065c 100644
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


