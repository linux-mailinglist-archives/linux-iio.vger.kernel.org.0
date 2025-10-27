Return-Path: <linux-iio+bounces-25488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C41C0E950
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2606F4E95D8
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273E2C0F95;
	Mon, 27 Oct 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1ecJbEg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B74A3E;
	Mon, 27 Oct 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576213; cv=none; b=T2F5ALQ9zJEknqlSVoNpWNbpsQ0ljdZwFk4/C4G0J53Dx1WJ1QnfIyIVRQInmTY37f0iL0ODytmp5iR7S5jafzZjCuy56L50BGBL3D0aOOZEHWqrtgB2kuqSdY0vELQig2GMe2sRhcbmlB9M0TfAkbl1Bs1SVzO4flivy6/YRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576213; c=relaxed/simple;
	bh=DhOX7cgjBI/Y2+aAqeEvHLgr6AQ4KXFc7yQ7G3VryxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5IjQxahpVdR8si7LtulSaZgGyNexUIn4XsADe2aXaqKAwB71IINeucnvyOUVXwzv3sgbhU3sCuHcplRr6xLgyo2MD3stssQniLo7JqTSe2czbCgRuDLn2/cWvXmU4AXaxRywR+Gnsgb3Dohqc1uI1hsxkWbY/WXnDzChccfN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1ecJbEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BC1C4CEF1;
	Mon, 27 Oct 2025 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576213;
	bh=DhOX7cgjBI/Y2+aAqeEvHLgr6AQ4KXFc7yQ7G3VryxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g1ecJbEgErVHmKLNUgl7HW1vwRzEYHpLa5eYuRzZDd8RVrclOPXaZb+jJCKBLgG6/
	 hGjTS8VtdoKsfmv764odRmy5Uq8c/EJsMoRmRTgD+BD0MN+ALCMyXdLti1usz29hTA
	 3nHWsRk10afHLlyRAz7cDJXJSo1RNKwA79GOHRX04tzURZSPvmh1fmLkquM87vyl3+
	 8ja/N7zoruhCEQ6j8lLnkYq4+yF3isBc/omhDPSrVeKW2ety6K6hMqkmS1ZAc4tI5Y
	 fbGxAHeh4DDkJpB1i/dVHpT6Z9DqYXBZhg0iQ5boQ8tBGY6+CEJ9r7rVAQ8voZnRIg
	 v4BeqTFJ/9gJw==
Date: Mon, 27 Oct 2025 14:43:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
Message-ID: <20251027144327.09f59982@jic23-huawei>
In-Reply-To: <20251027124210.788962-1-wens@kernel.org>
References: <20251027124210.788962-1-wens@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 20:42:09 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> Some IIO drivers do not provide labels or extended names for their
> channels. However they may provide datasheet names. axp20x-adc is
> one such example.
> 
> Use the datasheet name as a fallback for the channel label. This mainly
> benefits iio-hwmon by letting the produced hwmon sensors have more
> meaningful names rather than in_voltageX.

I definitely don't want to have different behaviour for in kernel requests
and for people reading the _label attributes.  
https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/industrialio-core.c#L1232
would need modifying to allow for the sysfs attributes to be created.

In general I'm not sure I want to do this.  Datasheet names can be exceptionally
obscure which is why we've kept them hidden from userspace.  At least dts writers
tend to have those names on their circuit diagrams and tend to have datasheet access.

Let's see if anyone else has feedback on this suggestion over next week or so.

Thanks,

Jonathan

> 
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 88c3d585a1bd..d410ea2e7963 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -749,6 +749,9 @@ ssize_t do_iio_read_channel_label(struct iio_dev *indio_dev,
>  	if (c->extend_name)
>  		return sysfs_emit(buf, "%s\n", c->extend_name);
>  
> +	if (c->datasheet_name)
> +		return sysfs_emit(buf, "%s\n", c->datasheet_name);
> +
>  	return -EINVAL;
>  }
>  


