Return-Path: <linux-iio+bounces-9561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95697915B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F231C215D7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A651CFEBF;
	Sat, 14 Sep 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqzUFhHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F81DFFB;
	Sat, 14 Sep 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323721; cv=none; b=t5QcvmFKJl7olxY1kX2ncHt5iDeHIDNAcSQCRRoXgXwUVOeK1Iq3G5Wlf0kt3uRsbQK40q31HlEG87N1yRDT1YU9PtB4UsMmDnaZCz09+afz2PHJcQnL8FsGzQx7nUPPqGzky49TcszuDdEPLBRfh8dJ44Mwbm97anc6L80xvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323721; c=relaxed/simple;
	bh=DJw+zD1ONsQb6UFWuhlj3hFjx1QgK17KY/bmJZCAjyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0i1oEZUWZb+Uciid9/FxmSFDb0fXbAyRpF14iHhJxT1Yyi+4dav1RhEv3iPo1M8JyLTpJAxhXA+qIyUYnTuqcA4NEQFYFAZuBnxoU3MywkhWWWRD6RZ2rIs0kViAEQiFt2xROEvdsfn/Cd1mq9OeSv3TC/BLdBGezylSKYaFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqzUFhHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3D1C4CEC0;
	Sat, 14 Sep 2024 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323720;
	bh=DJw+zD1ONsQb6UFWuhlj3hFjx1QgK17KY/bmJZCAjyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MqzUFhHlMfxUnOocrOoASAu0DbQZVvrblQc0MK3a/DrYpOrJHq++YhsJ52k41BQbF
	 gt6Udc2AsKltYNmldKHKDmtCCMVQLGRn7pwEvrgbkGNj00YZGXBuhtEYTbMx6VZhsN
	 yK9ogxSgqdTpNDe9CyAMZY7Y7GzqwXbUjcldnXdTyIYLLSuNEI/VqBU/Cv4K4gl7M+
	 VDiE5tvQWIeaaodq2yK/ZgD7t4Q9SRBDJKvZP0+CAZN4fd5x7NTSK6d0J5UpIxxFaJ
	 djp7qUhnLIGD3kRtiyp8yPuefZthD8PBhkRs3vB4lbaVV0e1HjlNDTDcPgBv7mzPyu
	 SflZYahGvPtxA==
Date: Sat, 14 Sep 2024 15:21:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Denis Benato <benato.denis96@gmail.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: bmi323: Fix some bugs in suspend resume
Message-ID: <20240914152154.2263b31d@jic23-huawei>
In-Reply-To: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>
References: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 10:54:25 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> These were a couple bugs I found using static analysis.  I have not tested
> this code.
> 
> Dan Carpenter (2):
>   iio: bmi323: fix copy and paste bugs in suspend resume
>   iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()
> 
>  drivers/iio/imu/bmi323/bmi323_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

These look good to me, but because I'm not planning another pre merge window
pull these will need to wait for rc1 so I have the code in my fixes branch.

If I seem to have lost them, feel free to poke me around rc2 time.

Thanks,

Jonathan

