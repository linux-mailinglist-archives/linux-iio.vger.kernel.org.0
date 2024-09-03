Return-Path: <linux-iio+bounces-9107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9545896ACE1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 01:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BEA281439
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD3126C13;
	Tue,  3 Sep 2024 23:28:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD81EC01D
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406100; cv=none; b=HjQxxnG7cV80LUv3kanj+jYY/C+gM39NECXKFFnjE6gxde4s+CivAkWEZQHAiQkeudp34Lk7ZfXjTkdXeB+3lnlORhmytYzJ/aSs5gN6kbF6iB4fMuA6BeZ3t3Vk7lawHR6qbp246HNAWFdTU4VLfPcszOiNjr6au/dQBa5cE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406100; c=relaxed/simple;
	bh=4aZLyiaXjXzyZDXWBCeDhL4IvZTYCLWT7OnTnVf+N4o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRqT/xKi7+DkHejKL7S/e4ZMIc0zTQpQb2e51zceI5kAPCm+muXUFKJ+UT9iRKuucTwO1JVmmm7Vx2icW1l8OYwqngnQXZzTeHporJEttwqXVcP5fTtn+qg3g+3a6ojJ9g6GB7abNHOWBL/z2jd4HV29rxIK9WU8dRKhEUTAURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 3266ba95-6a4c-11ef-8ecf-005056bdf889;
	Wed, 04 Sep 2024 02:28:16 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 02:28:16 +0300
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, jean-baptiste.maneyrol@tdk.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Message-ID: <ZtebkIvceS5x9_ib@surfacebook.localdomain>
References: <20240901120839.9274-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901120839.9274-1-gye976@gmail.com>

Sun, Sep 01, 2024 at 09:08:39PM +0900, Gyeyoung Baek kirjoitti:
> 'flush_fifo' label performs same task as 'endsession' label
> immediately after calling 'env_reset_fifo' function.
> So i remove that duplication.

...

> -end_session:
> -	mutex_unlock(&st->lock);
> -	iio_trigger_notify_done(indio_dev->trig);
> -
> -	return IRQ_HANDLED;

You missed

	goto end_session;

here.

>  flush_fifo:
>  	/* Flush HW and SW FIFOs. */
>  	inv_reset_fifo(indio_dev);
> +
> +end_session:
>  	mutex_unlock(&st->lock);
>  	iio_trigger_notify_done(indio_dev->trig);

-- 
With Best Regards,
Andy Shevchenko



