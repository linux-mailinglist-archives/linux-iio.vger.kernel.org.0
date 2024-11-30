Return-Path: <linux-iio+bounces-12894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53B9DF318
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E2280C5C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EAA1AA7BF;
	Sat, 30 Nov 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1tvJ2hD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51017BD3;
	Sat, 30 Nov 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999355; cv=none; b=q/IOohs6frGiTI6YivNbUGLBnzZGeohN0uHbljw4cjJn59SjVayGzeG7xe6iyimLSoR6bZMJsh9dD80UDbkjEjK+YdsoL/AYm38pO8YTaauDFioBAfGM+ypD8g16JQY4nl0B6Fs1kmrylsd+s20ZitGWuYaZgYM3UwzEi3e/tMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999355; c=relaxed/simple;
	bh=ncOcn9nruxIv2iSFGumuaD5pTHHSY9QwxwwbQrvQb5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giv8aYyqFPsj22Tj2scWNEgMVDWR6Ck3VzTQKEqxlMdgtVzrmMh2RAlIMJ6GXsVnYOgb5xqyU9m4kztguDNFPoM35s1GW8sV9p776Cl33C0xrCyxihDIUn9ibBJ3JOI7KGjvgMUUMJacd8SWUOLbS8pEiZfSShuG+YL1L4ma4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1tvJ2hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DB1C4CECC;
	Sat, 30 Nov 2024 20:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999354;
	bh=ncOcn9nruxIv2iSFGumuaD5pTHHSY9QwxwwbQrvQb5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1tvJ2hDyaODvsYnATau97V1xwEOr6320da1VyebjLNNKI3v8y0kaWUfmR1ElS6EJ
	 vLvrAmWzMruPbSltpcrxhvZ+3ld8lrz8IUTKv+pml1RvV1NTshqUDDfpwIGB6QSIq7
	 ZRyN0e7PkvmEpgNqYUTgHs5h5f/1HUBFfbe1Gm1dTpzcQwOvSLxYMKeXhlDrBmBK2b
	 VAGBUHX/vJ4d8AXkGE7yueQfkitsp5tQhvTz9/lf5UsH7dJQKmsys/ggQ25vdUWkqs
	 RXL06qyON/hhcl9qiiIFWKyM2eqL+Cid6NDOx8RcYV+Oeek92Q9+sld9WNpoq/3Dsr
	 5IB/1tPgmuvMw==
Date: Sat, 30 Nov 2024 20:42:25 +0000
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
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 11/11] iio: core: fix doc reference to
 iio_push_to_buffers_with_ts_unaligned
Message-ID: <20241130204225.2a9aec77@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-11-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-11-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:19 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Use the right name of the function, which is defined in
> drivers/iio/industrialio-buffer.c
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied this one via the slow path.

> ---
>  include/linux/iio/iio-opaque.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index a89e7e43e441..4247497f3f8b 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -28,7 +28,7 @@
>   * @groupcounter:		index of next attribute group
>   * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
>   * @legacy_buffer_group:	attribute group for legacy buffer attributes group
> - * @bounce_buffer:		for devices that call iio_push_to_buffers_with_timestamp_unaligned()
> + * @bounce_buffer:		for devices that call iio_push_to_buffers_with_ts_unaligned()
>   * @bounce_buffer_size:		size of currently allocate bounce buffer
>   * @scan_index_timestamp:	cache of the index to the timestamp
>   * @clock_id:			timestamping clock posix identifier
> 


