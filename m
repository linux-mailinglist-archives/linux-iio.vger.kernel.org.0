Return-Path: <linux-iio+bounces-20710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AAEADB076
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 14:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357B73AD3D8
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF6285CB8;
	Mon, 16 Jun 2025 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g41kp1D5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD83C2F;
	Mon, 16 Jun 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077779; cv=none; b=rnd9YrBZGhnafXi913sLCpEXglQx1tIiX/zgomAZ3pNkT6YuUKfylr8v7RaabIZwn3uun9WHztps6K1A2F1mAFlOQV5k5TPL8++NwAZ3hX5sOy5KV4l7SReKgV9sIp0l9RdLfCgeojmMKvEAD1hCzACgZVUcFd+RDB/tjL1dK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077779; c=relaxed/simple;
	bh=jq+OyKPUZkG4G8TUH0uPnIYNqEcVvtwLdkEk+C5Nl9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWHroOAzAipu53ClFhvCGH5Uav1VYq/JFncbk91c9kWSy1qq0IvfaDtlFCMJE1VJk1TWwNlSgv9flzrCL12g2vsaoeD5EQnVZ0KaacmqIb2EDr961JxuR5R92jA1wb4T4O7hUbPQbL+g/2maH46Wp9/Uf0z2GQ2jc4O015XbwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g41kp1D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBEC4CEEA;
	Mon, 16 Jun 2025 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077778;
	bh=jq+OyKPUZkG4G8TUH0uPnIYNqEcVvtwLdkEk+C5Nl9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g41kp1D5HDtiboxIs47obLnIR30pejpJaJvarLq7HDvWEm/OUWJdTcK5G2mUHsp30
	 a9Kfr8qBV70ogl6g94yPIcUh41yQZh5+mcr+enVq+xw2lEDGTI797F40hQyw3K5XcE
	 Z0gRd95w8lLvfa4lmE/UDZRB0N7ri7iFvJ8NWFtwFheP4qk4daytfWIfpZ0DAVDVCM
	 350cGi8Y2XHbDsKaKKa+FGJG4GAu9fJLDHrM7cSKvL7U+NyXzKuA8PA+o2Ri68XAjG
	 93XHJxDETvuaxXBa21pGysJMK5nZQ13rbvH2q36fD6Rp1UfQaR44ayNd2BCl4S10Jk
	 Dt+BbICU4eJ/Q==
Message-ID: <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
Date: Mon, 16 Jun 2025 14:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 13-Jun-25 14:45, Marek Vasut wrote:
> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> which leads to bmc150_accel_core_probe() being called with irq=0, which
> leads to bmc150_accel_interrupts_setup() never being called, which leads
> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
> non-NULL, and which triggers NULL pointer dereference. This is triggered
> e.g. from iio-sensor-proxy.
> 
> Fix this by skipping the IRQ register configuration in case there is no
> IRQ connected in hardware, in a manner similar to what the driver did in
> the very first commit which added the driver.

...

> Fixes: 8e22f477e143 ("iio: bmc150: refactor interrupt enabling")
> Signed-off-by: Marek Vasut <marek.vasut+bmc150@mailbox.org>
> ---
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 744a034bb8b5..1c3583ade2b4 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!info)
> +		return 0;
> +
>  	/* map the interrupt to the appropriate pins */
>  	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>  				 (state ? info->map_bitmask : 0));

AFAIK the proper fix would be to not register any IIO-triggers. This fix will
avoid the problem, but userspace might still try to use non-working triggers
which will now silently fail.

I'm not an IIO expert, but IIRC other drivers simply skip registering their triggers
when there is no interrupt support.

Regards,

Hans



