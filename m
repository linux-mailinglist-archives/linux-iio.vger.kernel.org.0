Return-Path: <linux-iio+bounces-7647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AF932FCF
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 20:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C647C1C220BD
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48C1A01B7;
	Tue, 16 Jul 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFJDd2n5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89F19B587
	for <linux-iio@vger.kernel.org>; Tue, 16 Jul 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153690; cv=none; b=RfODgVLxw6WUPTYPqs3OJ3cq+E//48UDPIrDNwWtOOdGPJPB3O+OwDTodmaolkbtVobqudZfYxk93dLJdB9YokPLkJV5OZKxn/aYEgzJ6M9b+sh7wQuvlBVhFl9tE64WMSOHzImmov60AvQSZycseasvHXLsOz9ZfkqHn7RbllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153690; c=relaxed/simple;
	bh=/lj6tWbPM1QWIyGfUEOzRvZaXXIWxLgOU8uhkRU2sDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5vGmdsm2S1nFie1Y5c1yCIG6qscL8Kqy0hePefhiK89xSPF839f4mYnDYqT6Dxw951FYJXQVNdGPnzQYKMZ40YpcrAwv8Ysn/uabiTn7zfPzvH13a9sABYvBq4pDv14lwCuLcRFeafGAfmSE6xzfpAfRV2SGXI8XrkIRS49ZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFJDd2n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4052C116B1;
	Tue, 16 Jul 2024 18:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721153690;
	bh=/lj6tWbPM1QWIyGfUEOzRvZaXXIWxLgOU8uhkRU2sDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BFJDd2n5VQXlrW4V/9G93TYqXiHed1FGgQPIaPXpCSyYYG6BTAxQSAqbTQJqo78Cl
	 EuYoUkIRgPGeQSLi65tlmm0U+FUoWABXlC3kRvSkTdy18mhEkttUgbniX8t+bWXD20
	 y6HkJaETaAEjdseTPbunx4RpgyjhotL84lN+nu+lMjl3JGI0NMKS7JuYrRHQheGIcP
	 zjoOwKmp1CJqStST4/2a/DDVroiM8c9ihz/OmcMgk4xBggkRFWrkAmBz1sK5YQ8+GC
	 yBjPZRRzAcOneOb9WhXBLUhCE3mfTm43IX2WtKY0Z/HdzTTAXpEqaoWiS86Twh3xs4
	 AJwrxSBUxVAYQ==
Date: Tue, 16 Jul 2024 19:14:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/9] iio: backend: add debugFs interface
Message-ID: <20240716191443.397c1278@jic23-huawei>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-3-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	<20240709-dev-iio-backend-add-debugfs-v1-3-fb4b8f2373c7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 13:14:30 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> This adds a basic debugfs interface for backends. Two new ops are being
> added:
> 
>  * debugfs_reg_access: Analogous to the core IIO one but for backend
>    devices.
>  * debugfs_print_chan_status: One useful usecase for this one is for
>    testing test tones in a digital interface and "ask" the backend to
>    dump more details on why a test tone might have errors.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Debugfs deserved docs as well as sysfs.
Same place in Documentation/ABI/

Obviously we've neglected this in the past, but nice to do it right
nor new stuff.

one trivial comment below.

> +
> +/**
> + * iio_backend_debugfs_add - Add debugfs interfaces for Backends
> + * @back: Backend device
> + * @indio_dev: IIO device
> + */
> +void iio_backend_debugfs_add(struct iio_backend *back,
> +			     struct iio_dev *indio_dev)
> +{
> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> +	char attr_name[128];
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
If this happens, d will be null anyway...  Maybe it's worth keeping
as a form of local docs though.

> +	if (!back->ops->debugfs_reg_access || !d)
> +		return;
> +
> +	snprintf(attr_name, sizeof(attr_name), "%s_direct_reg_access",
> +		 back->name);
> +
> +	debugfs_create_file(attr_name, 0644, d, back,
> +			    &iio_backend_debugfs_reg_fops);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_debugfs_add, IIO_BACKEND);
>

