Return-Path: <linux-iio+bounces-21609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE885B0315D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CCF3B8ADB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D26149C4A;
	Sun, 13 Jul 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWkz1Oia"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60D1DA23;
	Sun, 13 Jul 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415995; cv=none; b=CFc2AfYg7r0vmsRRlIIHnKotMMQhJGtQGt2+vqw+uk//2PRIePcf0ZjSKQrZTh4iUKlb4+e3DIqp/SGpOWjkdhMHKhCtO6j2HKz5zCTQbSCB3NN8Qv9SH9M/pcf/fKnZZkaTWFggG/hn7faagbtaZoGKLiWIXCJaOif7s5uro7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415995; c=relaxed/simple;
	bh=DzFqMElFthrzmk5X9QQ73UbSvrlmETE2ggERpkLH+1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUTbrubZDuoiUwNTKz2k6DujgWtA1wNsqe15ITdy32Z9r7lzy1QOhUj7C0XlkoMhc0uOYVIb+GVRvLzxbvAHtZJj1C52lGHlwy57vy3tSpgbkFb0vNF8gyc37BaoGKZWDlsg0oBXLJAA7Vdwb5YdgerGsZf7IvKXflFur2VM338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWkz1Oia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6AEC4CEE3;
	Sun, 13 Jul 2025 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752415995;
	bh=DzFqMElFthrzmk5X9QQ73UbSvrlmETE2ggERpkLH+1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWkz1Oiak/52Z23/vQsSSSIfU4SB9OsWRwgD8Okn5bHC0yBbDteRfToUTKH9Nuwvv
	 Vr1OzJUQZZiglhyvMiJY+2WlZyqHNetpkbBX5VKPDxu1Op9nfU/kzAuBrtL6p9DzAj
	 1RSLl7V0KL2VS+c1D1vMfrHyDc/hGF+5HQGx2y57CE6xq47v2gGFJVUIrx1Ssq0Vqp
	 /44pWC/xS/agRZKasIfVgPTBPe5V7aUtvrzLwHqsP7nu+VLX6rV3xGxz60Py2eD36F
	 3zSKH/LjDF96Qm18D1JIg+hgWaRLBFt9YN05EP4kuE9+B0knX91qHrdKOHwa093l1R
	 OcBzZbRFOD0Zg==
Date: Sun, 13 Jul 2025 15:13:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma180: use stack allocated buffer for scan
Message-ID: <20250713151309.30fa9a95@jic23-huawei>
In-Reply-To: <20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com>
References: <20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 18:00:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> in bma180_trigger_handler(). Since the scan buffer isn't used outside
> of this function, it doesn't need to be in struct bma180_data.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
As with the other similar cases I'm a fan of structures whenever
we can because the let people see the memory layout in the code.

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 4fccbcb76e0423bee37463a72c637af80e356a19..d83d5becca6fc72b855310a31c3de5443e4e2311 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -139,11 +139,6 @@ struct bma180_data {
>  	int scale;
>  	int bw;
>  	bool pmode;
> -	/* Ensure timestamp is naturally aligned */
> -	struct {
> -		s16 chan[4];
> -		aligned_s64 timestamp;
> -	} scan;
>  };
>  
>  enum bma180_chan {
> @@ -865,6 +860,7 @@ static const struct bma180_part_info bma180_part_info[] = {
>  
>  static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  {
> +	IIO_DECLARE_BUFFER_WITH_TS(s16, scan, 4);
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bma180_data *data = iio_priv(indio_dev);
> @@ -879,12 +875,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  			mutex_unlock(&data->mutex);
>  			goto err;
>  		}
> -		data->scan.chan[i++] = ret;
> +		scan[i++] = ret;
>  	}
>  
>  	mutex_unlock(&data->mutex);
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan), time_ns);
> +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan), time_ns);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
> ---
> base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> change-id: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6
> 
> Best regards,


