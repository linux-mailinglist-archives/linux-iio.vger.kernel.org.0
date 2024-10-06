Return-Path: <linux-iio+bounces-10231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B1991E2E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852802828D3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 11:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA86173355;
	Sun,  6 Oct 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+7ogUuF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC1184F;
	Sun,  6 Oct 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215051; cv=none; b=Pa0Yc7NdIeeias2kE+F8xNzo15mC8ZzDDkyKUzuRJuwXnta5IhD6snfX+1rknd/7DJrgdU6USeMy2bmm2yOJyPb2Woil/sdXGLVzG7d6jGNAX1NzHImZRZT0NznQq/DN5ylKi/UwRF7wg8FEVF4cmhLT4t6nSDbWVkFkGx8zoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215051; c=relaxed/simple;
	bh=7Rwt46zuE+8BxWcGBI75z5bmOzDwac4nrnflTqjEbFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIs/dMfcxrMrljF9wzVoyb8PhVIWSGnxStlfGMTLlmPbbdGyaoOnfTCbG2FJRtvxnuuI7BAW64q27jHHOpdUcMBNNzU6+IQLrAss+wI3Y4UQYvyjgIYl39jzYi4Fj5gxiF5L3NrnoUJgJKNTgN7u+Pb2qXZ/oK+nSDOleZ5TT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+7ogUuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93417C4CEC5;
	Sun,  6 Oct 2024 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728215051;
	bh=7Rwt46zuE+8BxWcGBI75z5bmOzDwac4nrnflTqjEbFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+7ogUuFYSOzNHERl0q4a685+z/5rWpH/a+JTbTwH7VMZ+bZP15yCyi71xrpNt8YV
	 v9GZDNfcxZorKdTmMINmpzxXl/AWDw1m7/XfAERivzKk1+WrlW+jJ4jgGuF3BS9rDx
	 MBpGrEd9gi0T8UKCScfNCAZIk+tMl8+PByCx64xBAyaZmnUIevMyBrPp6fRP22dZcI
	 niI83E2iQrcq4FkIn3WD5U6TA6eYb9euIeyH3Hs4/XtXWGMayf31QxLsGFWxKxCo+q
	 leBd6GR3SLucW/mj2L8vZcDmwODhNhDRdkDY9YF+C9pUBL1FNtjaM3PujFZiuecXdU
	 6B0YNsKuNyWFg==
Date: Sun, 6 Oct 2024 12:44:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ivin Joel Abraham <ivinjabraham@gmail.com>
Cc: linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iio: fix grammatical error
Message-ID: <20241006124403.2a37dfe0@jic23-huawei>
In-Reply-To: <20241002100341.110435-1-ivinjabraham@gmail.com>
References: <20241002100341.110435-1-ivinjabraham@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 15:33:41 +0530
Ivin Joel Abraham <ivinjabraham@gmail.com> wrote:

> Clarify the instruction for disabling autocalibration by adding the word
> "by"
> 
> Signed-off-by: Ivin Joel Abraham <ivinjabraham@gmail.com>
Applied.

Thanks,
> ---
>  Documentation/iio/bno055.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
> index 9a489a79d8f5..f1111ff3fe2e 100644
> --- a/Documentation/iio/bno055.rst
> +++ b/Documentation/iio/bno055.rst
> @@ -22,7 +22,7 @@ This driver supports also IIO buffers.
>  
>  The IMU continuously performs an autocalibration procedure if (and only if)
>  operating in fusion mode. The magnetometer autocalibration can however be
> -disabled writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
> +disabled by writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
>  
>  The driver provides access to autocalibration flags (i.e. you can known if
>  the IMU has successfully autocalibrated) and to the calibration data blob.


