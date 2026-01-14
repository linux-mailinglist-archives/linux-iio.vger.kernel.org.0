Return-Path: <linux-iio+bounces-27773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F14D1EC8D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1E2B30A2A3A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08BA397ADE;
	Wed, 14 Jan 2026 12:29:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D62396B85;
	Wed, 14 Jan 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393741; cv=none; b=G1lwP9DDaO65oaTxCfbvuLNgoAVhp+lDDVyud9WkvmNSpF7JdH3Gzh3NUbgal3O+fWqaI/cL9QCG6hauGY6HMJinu8KLE8bNWunGZBnC+5F04baVjEgM9SUZfrYE8oVI4maLzGd1vd62Mep5nd2kTygWEhSbW94AC7kOPsyEEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393741; c=relaxed/simple;
	bh=VJT/U+rU00Thff5wxfKXgQlJ4EEOZkqgo//7cwhg/5U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAGSnZ7OP9FKccHDWwRxRnhF7WB+5/XdFnXcz20x523MvMNrv7qEcF6Y2bcBQYM7HAyX2+GWC2pRoNMY4x2M3ZyDLK45MsMtLFkuZdTU7LK1My+ApffLkUqgUbCzGSS+c4s1KYs3IaeVuacyTjTcfcr2MDMcxlMICAyrUNyNqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drllY4bKRzJ468c;
	Wed, 14 Jan 2026 20:28:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4653040569;
	Wed, 14 Jan 2026 20:28:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 12:28:55 +0000
Date: Wed, 14 Jan 2026 12:28:54 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Tomas Melin <tomas.melin@vaisala.com>
CC: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
	<nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, "Andy
 Shevchenko" <andy@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
Message-ID: <20260114122854.00000aa0@huawei.com>
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	<20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 10:45:51 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Not all backends support the full set of capabilities provided by the
> industrialio-backend framework. Capability bits can be used in frontends
> and backends for checking for a certain feature set, or if using
> related functions can be expected to fail.
> 
> Capability bits should be set by a compatible backend and provided when
> registering the backend.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Hi Tomas,

One thing inline.

Thanks

Jonathan


> ---
>  drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
>  include/linux/iio/backend.h        | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..0a98fdd5df9db6cc233af819ac5243ba8cd5266f 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -56,6 +56,7 @@ struct iio_backend {
>  	void *priv;
>  	const char *name;
>  	unsigned int cached_reg_addr;
> +	u32 caps;
>  	/*
>  	 * This index is relative to the frontend. Meaning that for
>  	 * frontends with multiple backends, this will be the index of this
> @@ -774,6 +775,21 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_has_caps - Check if backend has specific capabilities
> + * @back: Backend device
> + * @caps: Capabilities to check
> + *
> + * RETURNS:
> + * Non-zero value if backend has all the requested capabilities,

It doesn't...   back->caps = 0x1, caps = 0x3 returns 0x1 which
is non-zero.   I'd do
return (back->caps & caps) == caps;

Though that also rather strongly indicates this would be better returning
a bool.


> + * 0 otherwise.
> + */
> +int iio_backend_has_caps(struct iio_backend *back, u32 caps)
> +{
> +	return back->caps & caps;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");




