Return-Path: <linux-iio+bounces-6053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC39011D5
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749A32827D6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42817A92C;
	Sat,  8 Jun 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+CEJSDl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C7179652;
	Sat,  8 Jun 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856212; cv=none; b=ifiZBL9ik3s2EW3TN5dmwcmpjCFbA3ef9NpgqQBhULe3HqE1S4urQFdI98102qWpkTJmW/HFoft0CYGZ5DLj7XW8faUhohh3cQsSXcwuQJZsEcFDEYyNh0HWdz1emX6OrRVUYt7eq8Jc1pAA8ADfjawLUKUATsPwWxgxdAG3eAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856212; c=relaxed/simple;
	bh=Y0RqWg41gTp2+bnmNIZlUVnvMEc4erjUmvjDN4eKdCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2oZ9Z03/ILCU3o3obIopnnmUpCDoegIYLYyuCVWldGMXRcwiXL5Fo1IydVe92FN5Ttmht7a4leRkW5yMoLzWGU+LBGkbf7HARY+LOAdDPK/05gT4FdQPChG04knDJRpVo8ZlyIWIcJhomFdLBxC4gG/siox/oouCiPCdzm6Qgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+CEJSDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4D6C2BD11;
	Sat,  8 Jun 2024 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717856212;
	bh=Y0RqWg41gTp2+bnmNIZlUVnvMEc4erjUmvjDN4eKdCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+CEJSDl6MsJ2ZOkktECryQlDO+kMpVVhp5WK9E0lLLMGwVP5ISrbF3BTecnM8s9u
	 roa6bx7iTr3BjcPROVhdGvEsy+PnW6Tw9Gj1QLPxlxU6KS45Y5BYtHfwyLEJ69wKJ1
	 wGAc2WADfNftSNQH3g8ZPkHq1fK78fkIsWu26q7Vx05iLcBjhbO7jYFeKfmNkenNJv
	 CDpWV8HDmlGAySDgtC1QudXt2SkmeAnvs/KblwB1cgC1aEfAYue7wUSPhSbHUCiY6l
	 jVf2K7Dz0f61NyOwNmeBC8vl3mMPEZyUpms7wd8UQLWnMLqgGKrtdtTdt2A7ZmbxuZ
	 XnVuzUjpTJ53Q==
Date: Sat, 8 Jun 2024 15:16:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt
 <justinstitt@google.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: event: use sizeof(*pointer) instead of
 sizeof(type)
Message-ID: <20240608151643.5f82e10d@jic23-huawei>
In-Reply-To: <AS8PR02MB7237D024459C314CECE72EAF8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237D024459C314CECE72EAF8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Jun 2024 19:23:54 +0200
Erick Archer <erick.archer@outlook.com> wrote:

> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). At the same time refactor
> the NULL comparison.
> 
> This patch has no effect on runtime behavior.
> 
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Applied.
> ---
>  drivers/iio/industrialio-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 910c1f14abd5..b99bfeff7d37 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -572,8 +572,8 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  	      iio_check_for_dynamic_events(indio_dev)))
>  		return 0;
>  
> -	ev_int = kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> -	if (ev_int == NULL)
> +	ev_int = kzalloc(sizeof(*ev_int), GFP_KERNEL);
> +	if (!ev_int)
>  		return -ENOMEM;
>  
>  	iio_dev_opaque->event_interface = ev_int;


