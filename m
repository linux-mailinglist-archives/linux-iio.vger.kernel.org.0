Return-Path: <linux-iio+bounces-4796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97CA8BBAE1
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C221C20CC4
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB0F1CFB2;
	Sat,  4 May 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdodTOiw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3017577;
	Sat,  4 May 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823059; cv=none; b=a5x0ImtR2RUX5vmL+S6uf8GIbPnUzGtRyXfV3H4/dfk5y4pRmn0KsOm8bxuT6VYfXuotigpI70ZB+vpYBdsQT2CIUXG7TaV0TQVHe+UioGDZ+9+K7kooPharFffo1Ssu65jQMLw7efm8gozA+9FbvSM9N1O7rUwR5dvNZoUamLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823059; c=relaxed/simple;
	bh=nhPPpbOqhYfSHBSbXUHRoGUDplochmKW9eJvPRWtz/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESXcGAXYY/orG/MtHYdoDbCSEHh1r5GwZPzuLqZa0vSIeFoCHfbmcKyGjwLj0BVlwT1mWK5GxzJ3eJtWeXlLLgIVs+JNRQOr2p8w9tUgstewAic/UgT2vZljOoPPcn+on+rLAJHgdb4UFXEf/VspjMj9QPvDSqkcJLBISP8mm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdodTOiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7E5C072AA;
	Sat,  4 May 2024 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714823058;
	bh=nhPPpbOqhYfSHBSbXUHRoGUDplochmKW9eJvPRWtz/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdodTOiwwafOYFjvddOqmNk4bECY9u/MWGWPgX0XjO+XKZXF5kI/cc/74NeSCECRD
	 IYFnQLaik9GXt2WXY04hKUD3SbnN4WV1ZVjeEX8tW5b+ybfIMipEdWChg0/XI0mcSU
	 qd1/YWG/yFSV2ibQIYCclAUQnL0eLhkqWtn+DDj3NtKUan6Zqih/iGSOzcX2/uxjCE
	 S4+YqXAMkWYgnRne6y0W9Svd09SkAbe7XB7oz/YCewb1IG4v1NtBgNPMHnUR94LQLs
	 yA5jceGG4maEM3S8NbZUv4AbVxjGRJc8rItNHG2/NWmBwZGMLyF0o1qS0lmlaEp8qu
	 WteNqIxbwGBcQ==
Date: Sat, 4 May 2024 12:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Remove some unused field in
 struct gp2ap020a00f_data
Message-ID: <20240504124407.1ac6f07e@jic23-huawei>
In-Reply-To: <57e9f29c7062d1bb846064bf6dbd7a8385a855e7.1714568099.git.christophe.jaillet@wanadoo.fr>
References: <57e9f29c7062d1bb846064bf6dbd7a8385a855e7.1714568099.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 14:55:17 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> In "struct gp2ap020a00f_data", the 'pdata' field is unused.
> 
> Moreover the "struct gp2ap020a00f_platform_data" is defined nowhere.
> Neither in this file, nor in a global .h file, so it is completely
> pointless.
> 
> So, remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git and pushed out as testing to let
the bots play with it.

Note I'll be rebasing that tree on rc1 once available.

Thanks,

Jonathan

> ---
> Compile tested only.
> 
> It was added in the initial commit bf29fbeaa13d ("iio: gp2ap020a00f: Add a
> driver for the device") but was never used.
> ---
>  drivers/iio/light/gp2ap020a00f.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 9f41724819b6..9a476697aa1f 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -237,7 +237,6 @@ enum gp2ap020a00f_thresh_val_id {
>  };
>  
>  struct gp2ap020a00f_data {
> -	const struct gp2ap020a00f_platform_data *pdata;
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	char *buffer;


