Return-Path: <linux-iio+bounces-12090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E89C2E2B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F67B20BAB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774481991A5;
	Sat,  9 Nov 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUG41mnq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC56E2BE;
	Sat,  9 Nov 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165628; cv=none; b=UZwXlRDH+P5usTpYR9wzJQJnQ0+zXmZPVMeWZ6jEKdcRfQ11XsJMRkqocPV0TxRj/Ae+o3QPYHs111YQQUucSKStWNNwTv3Y7raNfwjvozMCnhTp5x3BNmsagGhN0b+CM2pCP3tRbFg9FYhgTVSbeSdqHZZ7AtaHWKGoH5frxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165628; c=relaxed/simple;
	bh=ePvH/Wk8JbhJwp9OKOfv7kEqoxuV4yAaLcZcwS+hiKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVZxgWXzVRKTXcCSKY/QwQt3dvWMx4qRMD2WHSw8e1T8s9l44kQQcawFX3++8fiC0g845ktSvDQKRDaUEj2J6WDUL4vaXr6vB2n76HaDD2DkgeMXrmUXbpj1QfqhjaYgy8vY9BEynZ6shj0eLEFfcP6lH0QGni7aKgPLN9RoCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUG41mnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56786C4CECE;
	Sat,  9 Nov 2024 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165625;
	bh=ePvH/Wk8JbhJwp9OKOfv7kEqoxuV4yAaLcZcwS+hiKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUG41mnqBg2j9nxixhDbIXwS0FU14ePThK3uL5Ikekn4gynwBlKafO3KvWrlb8zyi
	 NUrBXKDrtpUtsDdznSaIo3zkBhEhhLMmu3gMsh4a0+wT1RbtpDEv+8SE2cw82NaAWD
	 NHyloQG/ak5hM3IXqZ4vd1Rs0C6yPsenePplIjsQd06UAGayZttvS4h/XNdE3YDISQ
	 wg30ZV62JS32u1hHD+mTRcqFz+N9fecVGMeNnecWRVNtM2uHHKPcGuQ232/tGVA4O6
	 IZYWXHl3XPQrq/JvbOGOy/l6hDfqVZfW+qmk7tIzrtZ76upwyh4pLQ4JsrH+248XpP
	 q2afKIdIZjZ6A==
Date: Sat, 9 Nov 2024 15:20:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp4725: Use of_property_present() for
 non-boolean properties
Message-ID: <20241109152019.7eb9051e@jic23-huawei>
In-Reply-To: <20241104190846.278417-1-robh@kernel.org>
References: <20241104190846.278417-1-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 13:08:46 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Applied to the testing branch of iio.git. I'll rebase that on 6.13-rc1
once available and push out for linux-next to pick up.

thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4725.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 25bb1c0490af..1337fb02ccf5 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -379,7 +379,7 @@ static int mcp4725_probe_dt(struct device *dev,
>  			    struct mcp4725_platform_data *pdata)
>  {
>  	/* check if is the vref-supply defined */
> -	pdata->use_vref = device_property_read_bool(dev, "vref-supply");
> +	pdata->use_vref = device_property_present(dev, "vref-supply");
>  	pdata->vref_buffered =
>  		device_property_read_bool(dev, "microchip,vref-buffered");
>  


