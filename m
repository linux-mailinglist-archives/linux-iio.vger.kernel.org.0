Return-Path: <linux-iio+bounces-21110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FEAECEC0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FB91894777
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F422CBC0;
	Sun, 29 Jun 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/7H30jC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923E23CE;
	Sun, 29 Jun 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215556; cv=none; b=lasByjt/RwWlUKnxZKoyu59k5bVBhCodL8MP6KrwaSsj71P4f7mwmLjUpTPwItq70pUgAwvOhwQyXChHdejT3NNPjagOqsek+yDiyMeXLDav848iOj5cdszxyW8jNxxF0E4Sa7wR36Y+wSPLPLx5mrtpiLN/zF3DPUK5STPaEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215556; c=relaxed/simple;
	bh=YsVeaB+odhd7lEFQCXOGLfgAFP+Pem0GSIU2uvKRT8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/Gt/Ls55Gh7PF5gfyXSR2SFCmyqwQVtjB7kb7iuy5vulv6Hi1ZCatKOKeKIz8pOk8ToX2QrYrFOxQo9Cl6ahmJfmS2DqGFgMRETf2Pfn2RFY2cim05ySPnkpOMz5CyM8GBYFaf7dPjR5JIqJhbo7atiKgM0ya7/KoYxos4kqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/7H30jC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1E2C4CEEB;
	Sun, 29 Jun 2025 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751215556;
	bh=YsVeaB+odhd7lEFQCXOGLfgAFP+Pem0GSIU2uvKRT8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/7H30jCgeK1AeeYl9JeuzSx3xhpKZ48EATJEqa325oWigkWAVBbKncxFC5+2C0kU
	 8jK7jbWno8I9a/PuC6+snECi8p+EHB4NyQO3RvvTIfIrNeL4N173RQ1ghj8TzWDK+a
	 bQCnVx79yU9kGZ+oUhNJ0GGyp9rKwTNMtj39JlNwntqnuOUNk9AW0yQDAqRZivh2If
	 O1mVuooOLoQUs2sCxQXUjAxeQQUJYx4mSygt8hLGriLMu9yEQ/m+SMsfQN+PVAKou/
	 O8O7Bkzd9df1zVIBdaFI+tji7fy9cwzj529727Q83Ae07he0BML719lDfCuYyxJSXg
	 5p7/vnetEM7ag==
Date: Sun, 29 Jun 2025 17:45:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9553: make mma9553_event_info const
Message-ID: <20250629174549.1dc6ab33@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-2-v1-1-a61da3a0941e@baylibre.com>
References: <20250628-iio-const-data-2-v1-1-a61da3a0941e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:00:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct mma9553_event_info mma9553_event_info[].
> This is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Seems fine to me. Applied to the togreg branch of iio.git
and pushed out as testing.

This one was a little fiddly to check though so more eyes
would still be good!

Jonathan

> ---
>  drivers/iio/accel/mma9553.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index ffb0d6ff37124e5f364168c5c4f348a02d28842a..f85384a7908f253f9ed55dae4e0a41a39ae6016b 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -97,7 +97,7 @@ enum activity_level {
>  	ACTIVITY_RUNNING,
>  };
>  
> -static struct mma9553_event_info {
> +static const struct mma9553_event_info {
>  	enum iio_chan_type type;
>  	enum iio_modifier mod;
>  	enum iio_event_direction dir;
> @@ -152,7 +152,7 @@ static struct mma9553_event_info {
>  #define MMA9553_EVENTS_INFO_SIZE ARRAY_SIZE(mma9553_events_info)
>  
>  struct mma9553_event {
> -	struct mma9553_event_info *info;
> +	const struct mma9553_event_info *info;
>  	bool enabled;
>  };
>  
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-2-7d2afbbe7f88
> 
> Best regards,


