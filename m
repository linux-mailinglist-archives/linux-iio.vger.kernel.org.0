Return-Path: <linux-iio+bounces-5624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926B08D7584
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41521C20EE4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D31D3B1A3;
	Sun,  2 Jun 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtbxBYMc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55538385;
	Sun,  2 Jun 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333455; cv=none; b=ENqRV8JLRGG6+pGBknonVu5zzW84P9LR6lITZk7Fy4orAgPkiwmVQ34T7ZLX/rWwa6rudnX5WIlXPj4wWdanwOSJhybFGu7QmMBXONtBkn4CT+4cSaWSNpmEfqbYc2umjRpaKXH4RiugL/6iYeIJucUeEdRnQ9mzZdx2mV7FWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333455; c=relaxed/simple;
	bh=6kOdU4pa/axOKVqqBYDd13ehS/HE8WpaiUQmEES9AUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HI7Ixo2QUC0gfhflgNZzTQRrjmuUFyTOmhEBOj6GaaKJ9IiOB96dgijJOcE7plB4NHlhr4zWxPUKphJmUGDyZYZCZYcykZzlj+cMefuLrnur7yFuC8oOE8IsC04X6Sd+ZSDH32BMuPIi+Kn6f3o2diMNTrsyn0Xe9tHLM0XY+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtbxBYMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77FBC2BBFC;
	Sun,  2 Jun 2024 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333455;
	bh=6kOdU4pa/axOKVqqBYDd13ehS/HE8WpaiUQmEES9AUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DtbxBYMcikdPVSqtbqX1q6AEk+wiUclkV4istu38JQpAgCJKp4CeKufWy7GDaRVjq
	 23NXCOMk2+UnIa+zL2xMdXAO4Dxlf7F7795kwZbS6Iw3g9kTVjf9TB6+TerFYEuCkl
	 zKhWDJvi0p2kZBLV/IsB3ys0GiH4rtMafpj1BAdSsJoUV5lLvwej0FfBP0cffNdmFG
	 EwM5MziTG6OKsM5KfJOxXa+VvrQQEYwfEdxTjsopEKlIH/3gu4u8dnCUK3BYzSCsdJ
	 85TAJ0n0JlU9ima2BTt/0ZRiE4+A6bhBCG5UeopZ2XaXSAhxD6gsNw0DE4BF58HEaq
	 iDkV0Yx2v3jQA==
Date: Sun, 2 Jun 2024 14:04:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/17] iio: chemical: bme680: Refactorize reading
 functions
Message-ID: <20240602140405.7d6a71d0@jic23-huawei>
In-Reply-To: <20240527183805.311501-18-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-18-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:38:05 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The reading of the pressure and humidity value, requires an update
> of the t_fine variable which happens by reading the temperature
> value.
> 
> So the bme680_read_{press/humid}() functions of the above sensors
> are internally calling the equivalent bme680_read_temp() function
> in order to update the t_fine value. By just looking at the code
> this relation is a bit hidden and is not easy to understand why
> those channels are not independent.
> 
> This commit tries to clear these thing a bit by splitting the
> bme680_{read/compensate}_{temp/press/humid}() to the following:
> 
> i. bme680_read_{temp/press/humid}_adc(): read the raw value from
> the sensor.
> 
> ii. bme680_calc_t_fine(): calculate the t_fine variable.
> 
> iii. bme680_get_t_fine(): get the t_fine variable.
> 
> iv. bme680_compensate_{temp/press/humid}(): compensate the adc
> values and return the calculated value.
> 
> v. bme680_read_{temp/press/humid}(): combine calls of the
> aforementioned functions to return the requested value.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
This and patches I didn't comment on (1-3, 6-9, 12, 15-17)
all look good to me. 

Thanks,

Jonathan

