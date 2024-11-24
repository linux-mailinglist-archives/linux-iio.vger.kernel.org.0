Return-Path: <linux-iio+bounces-12592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CEE9D7732
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C468CB37178
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524113AA3E;
	Sun, 24 Nov 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv7ux28t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C25136658;
	Sun, 24 Nov 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471085; cv=none; b=OGkyNO5eV2a8gjrLh8+r7iYshVHMQXhGt7fYDUASsui0OZ53imEZQ37FLSdphfG8oWqF5H3VhlNoniQMQmHAfjDXSeVotBXiayPdtACv7/35zqWREogoDFjq5e5u+R+sbPZTPPzZ2a5RW01igKiP4BJEWzSS8igWB7pYK2klxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471085; c=relaxed/simple;
	bh=AZ2HG3s7tQkBmLm3t1GbIsWYTfENxZQuxj+PkRA02fE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZNfDcnhDq9gvUszL3e7tVGRYqEnGIBU8wqMTIYC75LoXFEj/8OAV+iJxIJU0rhIfV9iEy5/gJUIh1vz0bwrvNnFFh4pf18N24fVsbkvdqSCSeEEmb80EucZwI6f/NAuKX1wDutvGG0R6ReDr/j7/FThjqwPhZoHQ7Yjc/oBRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv7ux28t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758E8C4CECC;
	Sun, 24 Nov 2024 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732471084;
	bh=AZ2HG3s7tQkBmLm3t1GbIsWYTfENxZQuxj+PkRA02fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dv7ux28tFI7g5X0MQ7X26S/lbo7JYNmAosHGfdJNF1E4nDoORv5O0CnToPr5Csj53
	 G6T5sZGZkWHPXZ2bmy/CiRo2DRwi4cWWRXk2rw+iLHGTpWzy6CbnNVywJYVaEExhC0
	 Q9GwJapMGArEssUPMCPhy2XVYmgCsIkLRyUCFpH6V2+Aa+he32K1mcCsuUTvk5oP9a
	 wu5zDRLc7SzavkMTpnLtbNTcjlJxWx2X3d4iHAIK7/SOVI5JopdAYVzeomv2oH9a6h
	 pAJlZpRnFQ9eAZSBwx5cV/cWuBLVj7wF05bZM0lQyfzFqGD8SjFhBk7eFOfnywBATf
	 K/g/PHkvCTeJw==
Date: Sun, 24 Nov 2024 17:57:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 01/22] iio: accel: adxl345: fix comment on probe
Message-ID: <20241124175757.3fe3c0ea@jic23-huawei>
In-Reply-To: <20241117182651.115056-2-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:30 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Fix comment on the probe function. Add covered sensors and fix typo.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 006ce66c0a..d121caf839 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -170,7 +170,7 @@ static void adxl345_powerdown(void *regmap)
>  
>  /**
>   * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
> - *                        also covers the adlx375 accelerometer
> + *                        also covers the adxl375 and adxl346 accelerometer
This is too easy to miss updating and to my eyes it doesn't makes sense to
have the list here. How about,

probe and setup for the supported accelerometers.
of just
probe and setup for the accelerometer.

>   * @dev:	Driver model representation of the device
>   * @regmap:	Regmap instance for the device
>   * @setup:	Setup routine to be executed right before the standard device


