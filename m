Return-Path: <linux-iio+bounces-24487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4DBA6060
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D584C188AAC6
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB62E0B42;
	Sat, 27 Sep 2025 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLG+54S8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96E18DF89;
	Sat, 27 Sep 2025 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758982059; cv=none; b=K0SFbHcepgwOhhsGhqHCcH4/dIDePhp4p0rEUQCsKCwNplYPpiuOdiJW3ZRIV1JTRs0PKdw8tF69oLTZDpUs1yyVOHrFeUvLf7ZgSmlai72+J1URUHxR09Her0vTqhIaLybRD0YklYFS3DZOSbow9D3b5cr4DIL3bQRwJ82nfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758982059; c=relaxed/simple;
	bh=Gs38SQ/LKyYJc4ic+XsILfLJqbN6NUj+cn7yw53dsVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOZnYhWqvb9WQm2IhZWowHVFMbbnt4jOdAszhP85N8UtbPMv57Bhh6FjV8ocyDe1rgnFJzErzz9HNm5JLBDWtYSsyEUTrp833MoWj1PQcl0QrsuF3JlN9f/HN+Rd+U4IrluG0oCKqc7qo5YcDg8WL1OJqIOixS7KYw0rn08qPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLG+54S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F5C4CEE7;
	Sat, 27 Sep 2025 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758982059;
	bh=Gs38SQ/LKyYJc4ic+XsILfLJqbN6NUj+cn7yw53dsVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dLG+54S8zEm2xjBHGehUSA+e2tCY7gr/4PX2TbavdUviKTOJBUpTNz9aeUxsKWdIS
	 BqamkUiiR3hi7+1i9kxtHoLYoRMmPuZpOSBUpRp29p/s9C5w++diw1QylE1yw0D8RQ
	 8ubX0+uei2zMUw/qbXJjwxPCjU2s2wbrCAPWyPbPGWIOUpnckvt0pibCOWoVaNCo2h
	 OLwtVHxv+WyJzl2Ir3Mswz9H8FRrKcWDTN/uU0Qn5oPRqXHhcp+/MRTcJXFuq/ObrK
	 OTLEy163+GC2u7q1aJ2/BO8d0MiP4I44TY11cKhKzSsD5wBsmiOiWMkDMeUdzh3dOX
	 3gAtrDRtDYVQw==
Date: Sat, 27 Sep 2025 15:07:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/18] iio: accel: bma220: populate buffer ts in
 trigger handler
Message-ID: <20250927150729.786e29d8@jic23-huawei>
In-Reply-To: <20250913-b4-bma220_improvements-v3-11-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
	<20250913-b4-bma220_improvements-v3-11-0b97279b4e45@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Sep 2025 18:39:32 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Populate buffer timestamps in trigger handler instead of in the
> top half. Otherwise all timestamps read zero.
Say why.   Key here is that not all triggers can run the top half handler
that provides pf->timestamp.  Use an example of which ever one you are
testing this with.

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> v2->v3 split out from bigger patch (Jonathan)
> ---
>  drivers/iio/accel/bma220_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 73ce9a9511734961c2c6dadc99c21418070dce00..728bf08c2cfb250266be56e69b11af4b6c4a1347 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -188,7 +188,7 @@ static irqreturn_t bma220_trigger_handler(int irq, void *p)
>  		return IRQ_NONE;
>  
>  	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> -				    pf->timestamp);
> +				    iio_get_time_ns(indio_dev));
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -409,8 +409,7 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      bma220_trigger_handler, NULL);
>  	if (ret < 0)
>  		dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
> 


