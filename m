Return-Path: <linux-iio+bounces-25787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05725C28354
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 17:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8CB188A40D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6658274B55;
	Sat,  1 Nov 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjK8zRVp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC922253B0
	for <linux-iio@vger.kernel.org>; Sat,  1 Nov 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015899; cv=none; b=IDl/eZrI3JRzRnF1fMZXRLKdywhjTRIiqcVS8WzDHaXDbM/pmqG3OFwBpCQNAyILMfvegoxXAd5rFMtpg99WMSNXUMIZjiSQ4EGEfSsm9yr1p9xbBo+gn+oq7J8lf7vSdHOVP1e1737/l+RZHz5LF+FrhvsLvJT88q8HAIup9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015899; c=relaxed/simple;
	bh=+nCVMnQEEcjRAwuXFDJnpv6pifa85NJqd7hYknnAczQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2o5eaarnB/exQb8zxB5Ph+TkAZXT+gfN+/2A4uTNEAN5wWdEbRLGdMKtSOjLEOcYYu7Qs3aQaKMgrYkXQ02/jf6zITEPXw+/m7d4vOfd5s9K4YlpGGlStGPUSa+kjBWcIElsjFK7mZ2htdZegaEgvFgSADFnu7K8aQdBbC8teY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjK8zRVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87EFC4CEF1;
	Sat,  1 Nov 2025 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762015899;
	bh=+nCVMnQEEcjRAwuXFDJnpv6pifa85NJqd7hYknnAczQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rjK8zRVpDl68DnACk/uBA0d9PFNI5o+NcWmjY7UWmCkOJdl0EKGt+YK71grs5AvmZ
	 TSbZAqpm4bxUdJvr0LzhYGCUum8dhSoI+m7nqn6z8huzoXG+wfCxhkvcThVxnISiWk
	 Hj6BaieCeljYhsFeflnF+LGcu+8iznaETn34tsU/sctZzCb4Ppd6j4VpQ5GqFjvNUb
	 bA9NcVZFc7CNulbu6B/hb1cLHbQVO80ZfyQxhgYJzihaNxNIaT0Y04AhlK+fdMIdOk
	 L10ppbLFe5pKIsWyrd7xWYtPsYbCzf8yfT049P9qXLdGiQYeDnhuIfyXfa3o/vqhXe
	 2zueMCT5ZDAFg==
Date: Sat, 1 Nov 2025 16:51:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 09/10] iio: dac: ad5446: Fix coding style issues
Message-ID: <20251101165133.334b93c7@jic23-huawei>
In-Reply-To: <20251031-dev-add-ad5542-v3-9-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	<20251031-dev-add-ad5542-v3-9-d3541036c0e6@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 12:31:30 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Fix style issues as reported by checkpatch. Additionally, make sure
> include files are given in alphabetical order and that we include the
> ones that were missing and remove the one we don't really use.
If it's only 1 say what it is.  I see quite a few so guessing that
was meant to be plural?

Headers and white space are different things so really should be
2 patches.

Actual changes all look good

Jonathan

>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/ad5446.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index d288fb56e324..bf9f7edb1a81 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -5,21 +5,17 @@
>   * Copyright 2010 Analog Devices Inc.
>   */
> =20
> +#include <linux/array_size.h>
>  #include <linux/cleanup.h>
> -#include <linux/export.h>
> -#include <linux/interrupt.h>
> -#include <linux/workqueue.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
> -
> +#include <linux/export.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> =20
>  #include "ad5446.h"


