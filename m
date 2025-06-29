Return-Path: <linux-iio+bounces-21115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A45AECECC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8143B4FA7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E185231A37;
	Sun, 29 Jun 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO7rDjNG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED165233136;
	Sun, 29 Jun 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216141; cv=none; b=ZfzF3+kwyL8tHzoQYMnpO0/2J8w55HAu7Biki45AxgsogRUDzFawL35W+eZ29EyL69lSR2V7QxDEB/8jmJoFNg1e8+0PI8sz5IrC5xEqUI5QU8gaBS3Ftgf6zEgFkbqGTSeDxXZNrb1/UizPouR9Wnhf/AkaczhKlDac6GnjJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216141; c=relaxed/simple;
	bh=E02PQCgMPHp3LS4Jkkx2tMZWvw0aLwfW9kpSvDEJLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZI9Nr5GknpGA/6U5dOdmMjBkb0S+l/ba7K75vgoaj9D0V8B7ibPIqC0Ar1jXs8mZJ/HDuvzKmdy1J0RF1iul6ZE1Wfu/For/tTNnJQ7bvcwmcGlyMICxDuI6AEDexi/c7LdyLTl7ELT9w2S0EK4ygMHBeKBPtSMvkIVJ/9WDBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO7rDjNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C541C4CEEB;
	Sun, 29 Jun 2025 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216140;
	bh=E02PQCgMPHp3LS4Jkkx2tMZWvw0aLwfW9kpSvDEJLGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VO7rDjNG56N+mDZqL/Twhx1+PabXntKAEf1xxFJ+pjvqYL1Grtzrw44yYs6sbEq18
	 4Tft60mWMdV28Bxb5dFbRkhBPxfbZ0dJQeHGrDz68WN9G8gfjC5iAMD0Oevpc3pcKn
	 isjTGBsK4cI8xnJVpJC12hBbVDJd/RPkIC/CWmGsJY3x6Obz81L8fNLUF7Z7O3Qi8E
	 QtrSsIpltIWDVJBpzLyHADQrvA4ML9VIDT2QfkVOeAfFwkj/eAjXDI+upwNizmPcKo
	 wMYHTCpEeHNrX7KfSvNF196rJ89691ASe7RVEoDcduNc27BeaG/ciAXrGeEmVP6p1i
	 gA43cmdpHFCtQ==
Date: Sun, 29 Jun 2025 17:55:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Saravanan Sekar <sravanhome@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mp2629_adc: make mp2629_channels const
Message-ID: <20250629175533.784fa929@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-8-v1-1-32ce79494d4a@baylibre.com>
References: <20250628-iio-const-data-8-v1-1-32ce79494d4a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:31:02 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct iio_chan_spec mp2629_channels[]. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git.  If anyone has comments
there is still time before I push this out as the non rebasing togreg
branch.

Mostly I assume that if David and I miss somethiing on these the
compiler will scream either in my local tests of when 0-day hits the
testing tree tomorrow.

> ---
>  drivers/iio/adc/mp2629_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index 1cb043b17437780970ce355f9d93fd36cbd26826..5a1d516f8dad8e2cf46a43e1a40d1cc7adaecc13 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -44,7 +44,7 @@ struct mp2629_adc {
>  	struct device *dev;
>  };
>  
> -static struct iio_chan_spec mp2629_channels[] = {
> +static const struct iio_chan_spec mp2629_channels[] = {
>  	MP2629_ADC_CHAN(BATT_VOLT, IIO_VOLTAGE),
>  	MP2629_ADC_CHAN(SYSTEM_VOLT, IIO_VOLTAGE),
>  	MP2629_ADC_CHAN(INPUT_VOLT, IIO_VOLTAGE),
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-8-8c8921ee3b3f
> 
> Best regards,


