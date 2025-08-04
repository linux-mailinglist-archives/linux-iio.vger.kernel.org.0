Return-Path: <linux-iio+bounces-22288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4EB1A629
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3109F163200
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAEB218845;
	Mon,  4 Aug 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDEtolHm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D324846F
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321868; cv=none; b=MLYTUueVWidG0y4MQNN7g7fd1SO9lRM6kxJ8UcONZT/bgA/Po37fWhP7AALHO8QGL7DXLqUBg4ytbK3Yb1pmrkt1KMYmlVCERwoYSrCPGPjPM2Ak6jacMfJ290rJfecLdWRXgbtohp5GBBwpdtDdndfX0SAnRYdulte88+fAtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321868; c=relaxed/simple;
	bh=UeRlf6t466jQ4Xs337HFTSut7jmNFbQcqNr6XZSW3mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDxXNFANNa4P3BrPaELA+QoVkUS81vaFmwUXxEVIrQjzFkMrwwXc2RFMWWmn10tllwMsj8+XOK6SsDQGVzEFFeATeCnpe46ryBiL8cypdEvXQhGF5VFHjCI4Rp4HIXAdafuZ8oS7Q7owzx0uw58/ms0pJ6zdrPmwBmTNf5PwuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDEtolHm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so5467795e9.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754321864; x=1754926664; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JSJsZ3QFmoe3t0Qtgl41hHTXXktKXrDGtrenBQqgBWw=;
        b=YDEtolHmFKazmCXHHao4Thp1UXvj9UzHc93JXjuCQCJL0hoejyJdlqBwBeckdtyTFn
         q9Zqz9Kx6ZaoS/gSwckaEkpfSHQDv4pNA3yZhBuaWDHcvr/4FBJltw33U/GoP2y2ypGz
         vtSF+k/cvMz92qLyucQxNBIU5+2etLzc6LkqH9sGPuy45T23hP0GIj/hBjYtjBhLhZ4Z
         2iy0oPQIVeGmUxiNWUsd4abW3zmnyA6uR6A2rVqsVragWroo5Ay0z0VOZ7G3/3dBpv5W
         bp/9JOoYjWZ2T/a8cL/cEZshB2+1cGzMuyhhOR7wEZqQwzbZySJryDhfsvIpPxmiJlBn
         2uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321864; x=1754926664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSJsZ3QFmoe3t0Qtgl41hHTXXktKXrDGtrenBQqgBWw=;
        b=NoKrmSBahUd16NxUGgXZ3imGEk10Zuu/dOWl3QFQ8xR9r70YGd/SUbuVAqoU0cAnx7
         3cIKxATrD8NTEIqNdK/3VfcyLBM847ZaFCG0X7cu0ZCK8f+nf7gt/4QdBklUNlikcWOu
         jc8XjBqjhjfRjSYZJuKSLNlZ5ETdBoUI+tQ2/Ds1Fw3D87JCBVk1VAc8BRAC6laI5guy
         p6KT0E3SyQ1LTcT1AfOkVxNbDcrNF1YLFu0FzkO4bvHEMDXtWs60/78W9rLdOvXNx8UI
         ZDJz48eMZD5PWZjSlYqMsruaaCAzQSFsIuovUaX+5ChO50uWb/zZGF77NcNo10g6cfwh
         kKWw==
X-Gm-Message-State: AOJu0YzhuVimxAeB9iRv2GrtBH+084nwRFIvL8BUjTTs5WrhZP0blVR5
	bxvMBwg0ZRjBOJldfDaFLmsCcODE5b1xrdADCXp2LWM1Z7xl25zpBzInZ0GtKRm41NmpSrbr
X-Gm-Gg: ASbGncvbPOeynG55xiB+GYX68BCXbpcvA2v0B4gXz4bxKhPyywVWQVTKUeHnJMZ5ZFe
	NWplDDsp9PfchDYhtkddHY+W2T2CW5BtBRle9VFQCy0x3WgAh6a+aim10u0oo762D5sKvydnzcP
	5v0voiM2WePKoVjIbhg5L0osz4RQ+co5dONkSBof+AfBCNZjtwv06/L3cm2nz+kXoEHt8Sd+IVg
	57XrtXChgSPUBQrHDy3/faXfDU1WSMLF8asWRklTNvqhYb3i6afapjHIPHURLPjv7cq+6Nudc1H
	si2OKJYDblqOgT7snob+4TujHtG6CdgXWbuZW2FVO+vp8rBzUI6l7YiROQtYM7YR5XBChYE+5G2
	N1+WDc2z6+VIgzw==
X-Google-Smtp-Source: AGHT+IGFnA/xn+m92JqqtCSeNsjbq4Ho2ZUyujLi81Q+32OCa8Ek6DV04mHyVo6YD+7qd6FTe0aloA==
X-Received: by 2002:a05:6000:144f:b0:3a5:8d08:6239 with SMTP id ffacd0b85a97d-3b8d9474fefmr7682663f8f.21.1754321864249;
        Mon, 04 Aug 2025 08:37:44 -0700 (PDT)
Received: from nsa ([185.92.210.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2187sm16409724f8f.70.2025.08.04.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:37:43 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:38:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Shen Jianping <Jianping.Shen@de.bosch.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
Message-ID: <73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
References: <20250802171539.518747-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802171539.518747-1-jic23@kernel.org>

On Sat, Aug 02, 2025 at 06:15:39PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The IIO channel demultiplexer code is there to deal with a mismatch between
> the channels captured and those requested by user space either due to
> driver supporting only particular channel combinations
> (available_scan_masks) or due to multiple concurrent consumers (e.g.
> userspace IIO buffered interfaces and an inkernel consumer such as a
> touch screen).
> 
> Whilst this code is exercised by many drivers, a corner case has been
> hiding there all along.
> 
> Consider an input of (postfix is the channel size)
> 
> a_32, b_32, c_32, d_32, ts_64
> 
> and desired output of
> 
> a32, b_32, ts_64
> 
> the current code ends up with
> 
> a32, b_32, c_32, d_32
> 
> because of a failure to iterate over the tail of unwanted channels
> (here c_32 and d_32).
> 
> Fix this by adding the code to walk the channels in the gap.
> 
> Reported-by: Jianping Shen <Jianping.Shen@de.bosch.com>
> Closes: https://lore.kernel.org/all/AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> This is an RFT because whilst the reporter has confirmed that it works
> for their case, it is touching fiddly code and I don't have the original
> set of tests to hand that I used when writing that code.
> 
> Hence I'd like a lot of eyes + some testing on this.  A number of drivers
> should have hit this such as some of the larger IMUs, but only with
> very specific channel combinations that perhaps were never of interest
> to users.
> 
> Thanks to Jiangping Shen for all their hard work figuring out what
> was wrong!
> 
> Whilst this is being tested I'll try to figure out a Fixes tag.
> There is some code movement so needs more digging that I have time for
> today.
> 
>  drivers/iio/industrialio-buffer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a80f7cc25a27..d7dd9764091d 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1082,6 +1082,20 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>  		out_loc += length;
>  		in_loc += length;
>  	}
> +	/* Walk remaining bits of active_scan_mask */
> +	in_ind = find_next_bit(indio_dev->active_scan_mask, masklength,
> +			       in_ind + 1);

I wonder if it matters to check that in_ind + 1 is in fact lower than
masklength? Not that it will be an issue for find_next_bit() but we will
fail the expectation:

if (unlikely(__start >= sz)) [1]

And being this a sensible path, I thought it's worth (at least) questioning...

Other than that kind of nit comment, patch looks good.

[1]: https://elixir.bootlin.com/linux/v6.16/source/lib/find_bit.c#L50

Thanks!
- Nuno Sá

> +	while (in_ind != masklength) {
> +		ret = iio_storage_bytes_for_si(indio_dev, in_ind);
> +		if (ret < 0)
> +			goto error_clear_mux_table;
> +
> +		length = ret;
> +		/* Make sure we are aligned */
> +		in_loc = roundup(in_loc, length) + length;
> +		in_ind = find_next_bit(indio_dev->active_scan_mask,
> +				       masklength, in_ind + 1);
> +	}
>  	/* Relies on scan_timestamp being last */
>  	if (buffer->scan_timestamp) {
>  		ret = iio_storage_bytes_for_timestamp(indio_dev);
> -- 
> 2.50.1
> 

