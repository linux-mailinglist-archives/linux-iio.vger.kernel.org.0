Return-Path: <linux-iio+bounces-12900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA69DF32D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8B2810EA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877901AAE1B;
	Sat, 30 Nov 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwbPjeKP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5E1AA1CD;
	Sat, 30 Nov 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000045; cv=none; b=owkKK17yw6mOwmaIJ76QP50wnR5bUwiTjScArMJyvHehWS36z9z2oyYAEjLPW+ItyYzwhxqG2+yVfRMlMYn2q757AG7HFuD9+IinIxDYdtYTnEW/EWRuZ5EMLbbfBZAMUuqG/GOGi8luPaz5c8eeq8w8yqn7EL8dL+KdUk4yBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000045; c=relaxed/simple;
	bh=gl/GbrgSPFDVbqUNbABQllXl56GvqgbhfjjiUymMaig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4l5VHZnCdr+ZF4p8lKBGoAM40M6HWLd+Ks0JnatjF+BmYeuw2yJk8q2r1q8rpyTnc8uRPDXoH87P2H0NBTlNovQo5m1AdVBh5W4EUgP3cdMZ404pg4eXI6sgX4tce86dz5jbCb5rmnBCWj/y/pLdUXx9hyHYXLjf5ecpIU+WKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwbPjeKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0FDC4CECC;
	Sat, 30 Nov 2024 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733000044;
	bh=gl/GbrgSPFDVbqUNbABQllXl56GvqgbhfjjiUymMaig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwbPjeKPXztyAbqlzrJv4Ll4E7UtPRLGuEBZkIksCZLFKx6pjLAvunEmzJI3W2ZC2
	 fEhPsTsDbm40B9RQTfZNQN5JAWZsrCPSH1jbmaQFSg1Z5vuOUjZR52t/cE08cTK2it
	 81R7ciqYTOlstHpIUEKWsJ4JydQ3NNMvmiR6of53Dfie+YOjuwa5/0mZqS/EJt/GhN
	 88TDnbWp912nFaANahg0+MQa7nn2OkP3Xq1pOMbABdtkGZlf23LTFq8GP4VAE01UDD
	 wRvQGplxAx4pmD6C8zJJ27g9iDDmCH6coDP9243r4jnl2pqCGcfxqNA30LXDv8jePh
	 VWtwYYxoj3LjQ==
Date: Sat, 30 Nov 2024 20:53:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH 07/11] iio: light: bh1745: fix information leak in
 triggered buffer
Message-ID: <20241130205355.0c4238c7@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-7-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-7-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:15 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'scan' local struct is used to push data to user space from a
> triggered buffer, but it does not set values for inactive channels, as
> it only uses iio_for_each_active_channel() to assign new values.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/light/bh1745.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> index 23e9f16090cc..2ffc839c7501 100644
> --- a/drivers/iio/light/bh1745.c
> +++ b/drivers/iio/light/bh1745.c
> @@ -746,6 +746,8 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
>  	int i;
>  	int j = 0;
>  
> +	memset(&scan, 0, sizeof(scan));
> +
>  	iio_for_each_active_channel(indio_dev, i) {
>  		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
>  				       &value, 2);
> 


