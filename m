Return-Path: <linux-iio+bounces-9820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6D988FC8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CCB21769
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAD1C287;
	Sat, 28 Sep 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLkM2wWS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4121802E;
	Sat, 28 Sep 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535512; cv=none; b=Nnk8126Y+TJNgN1Ee/SnwBymhY+33ZqX8LuVyitTGQap+YK06c2ZTieFreGJbaEbsnmkXSBe7YwpxApJmXVMAWrqz8k7MShyqPzuw/CuDJxibkV7iehKybJZycCNecwAQ0n2ZajZlZZnwKQ29d11tahqz5neIfpLIAR+TiO1RQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535512; c=relaxed/simple;
	bh=ulGxmfgTsMoP4GdYihDJwe5x0S6nyQ94oMsu6oy3PMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbItIULUOUIZQwJTtlnbpdXn8yhrTgrhu3ldAtb0iRNjaNoU4bbCfGE7GIxgBhHJJERbgMxrj+EnNsFFZvFvC+Huc3Kc7Z0kZbi6Ozv7C1tKnYiOtFmdrCuKt0XLPYnNXV4QlU5pv29E6wa81RQqIYwZjv0Y/bryZHLs4GSo5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLkM2wWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0ECC4CEC3;
	Sat, 28 Sep 2024 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727535512;
	bh=ulGxmfgTsMoP4GdYihDJwe5x0S6nyQ94oMsu6oy3PMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RLkM2wWSWJxwZHmiAeuhah5AOf0ZoYuuGJr3wvrS8ABNpad8CoqA3SasmR7yCGL4I
	 bQi1LSwAmth6Dgli0QAx4fTOQ6n/UW9UHFaj2B/lJgUdSKZ9CumLUw0m7w1YS7My+J
	 E71GzK7YBvM35B1iLs8h0Z9qFdKVUd4BrQy+HH9s4Kw8NGwLYaMmPjEhBIkYSMELlk
	 UAW8ciz5rO8KoFVG3ldwrerq/n7eCq88/IKxUL3/ObIYEp35EvYBk2vji0xxAWkpX3
	 RjXXAS6D2PDJMwryDij6IPgSn1GHFEzZ97KUsTqc9VKPHRZb6C673/QMgFY2wJRMsX
	 pClwquY9to8GA==
Date: Sat, 28 Sep 2024 15:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: acpi-als: Use elvis operator to simplify if
 statement
Message-ID: <20240928155824.22dc03fd@jic23-huawei>
In-Reply-To: <20240922160304.520613-2-vassilisamir@gmail.com>
References: <20240922160304.520613-1-vassilisamir@gmail.com>
	<20240922160304.520613-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Sep 2024 18:03:04 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> By using the elvis operator here, we can get rid of the if statement
> and simplify the code.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/light/acpi-als.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 2d91caf24dd0..cea3499c3af3 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -171,10 +171,8 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
>  	 *
>  	 * If the timestamp was actually 0, the timestamp is set one more time.
>  	 */
> -	if (!pf->timestamp)
> -		pf->timestamp = iio_get_time_ns(indio_dev);
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   pf->timestamp ?: iio_get_time_ns(indio_dev));
Hi Vasileios,

If the original code had looked like this I wouldn't mind, but 
I actually prefer the original from a readability point of view, particularly
as it keeps the comment and code more closely coupled than after the patch.

So to my eyes this isn't an improvement.

Thanks

Jonathan

>  out:
>  	mutex_unlock(&als->lock);
>  	iio_trigger_notify_done(indio_dev->trig);


