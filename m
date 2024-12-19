Return-Path: <linux-iio+bounces-13668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A09F8164
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137D27A2641
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6E1A08A8;
	Thu, 19 Dec 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgjRT2Y0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941319DF75;
	Thu, 19 Dec 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628187; cv=none; b=oFnm2fWV9b3qkw7fYykfVKo7ptbMR9JS6ptoS5d3d7YNiLVYtDlEXzqxkR31KXq7w9e2q+Gzv7n5nTrOzABDVSgxwFHADaadYvsSv6Url3HhaYc9i5nscYhbfUZmxKJBbGJkkwPapmptwvmLOnmoTzQ9bmcbaqtyMEQhobY8o4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628187; c=relaxed/simple;
	bh=b7avAG7kNoASZgSicFMrsetuqqeMJmL6xCtTvMAJC00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS0ljpM1RYrCe+2+AmCGdCng7Tx9mIU5Z+A8qz5L+ew+DkWZHtKYhm2pffgRcpgpaM0CHNXrKuE4wBApx0CuLFjZdutFEDWOgXcxcvKGaayYNb2oF2KR5hsiyf4lrHx0ZQ00a9PNoR06tRUbh3f6I1ebgHOLDvY3aMMC6WqJkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgjRT2Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3C6C4CECE;
	Thu, 19 Dec 2024 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734628187;
	bh=b7avAG7kNoASZgSicFMrsetuqqeMJmL6xCtTvMAJC00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jgjRT2Y0CTYI8WU8CQrBHtM824b4Yc9D7cTtJDjfrCxGvZuE0gZ1vqKM63jwcp+wt
	 wPze9LrJJ8Rz/fvpZWBZ9d4Bhs1yZfcqcSYeCxfN281iKp749toUse32q3qpxGjpca
	 eGmNSPQxNDQuLBHyvVZaukkdmtCejLdXpJSkdMeMA4ekWIftUgB9wz2GLDkj0EGwqR
	 /UZ7yBd0D9wpIBELnaGFObj3QFDGk762Fp3kwQ+uWcWTahNofcwaGi3YqGlzB2uJVa
	 sDiY+IEV+IssQLFDB/8NOCDEdRZL8DLmvM9pqxSJdGMkBHP9x+l5n16yDza588OHzf
	 Km71EI5LPqjhA==
Date: Thu, 19 Dec 2024 17:09:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ABI: document in_illuminance_hardwaregain
Message-ID: <20241219170939.4f7b2f88@jic23-huawei>
In-Reply-To: <20241215-iio_abi_in_illuminance_hardwaregain-v1-1-d94a59efb937@gmail.com>
References: <20241215-iio_abi_in_illuminance_hardwaregain-v1-1-d94a59efb937@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 22:18:21 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This attribute is used for the vl6180 (see vl6180.c), but it is still
> not documented. Add it to the _hardwaregain list.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.

thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..c044f1608ba9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -681,6 +681,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_hardwaregain
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 
> ---
> base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
> change-id: 20241215-iio_abi_in_illuminance_hardwaregain-9e024b9dca90
> 
> Best regards,


