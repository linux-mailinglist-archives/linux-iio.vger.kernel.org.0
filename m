Return-Path: <linux-iio+bounces-14456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA4A15DD8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18ABD188781D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E8219CC27;
	Sat, 18 Jan 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV9PWiBw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBA1422A8;
	Sat, 18 Jan 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215827; cv=none; b=sSdpSyMefgFmytsDEXHvlixebgfaVfE2T6w0hBssUhIGNA2/rhUq9vT8ZLqLdgTzs1sRD8ajeCCbnBZXBZdauZAWNwL+5RPofs/NfOv5A21T0owF+E8VMh9mEWDdOnqYT4kBabkMJDkXK9uXApne1hHY5E3kTS135Rxt1JueKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215827; c=relaxed/simple;
	bh=eUgSRXTGhiU36DFs2yPvSsbWY93J0aZSaio9qM0kRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyMQlNZzFISn3fbS4lTOKPEqB3j1QUY1N8LuE+fqvLWj37r/AX5+uWykLaYQgevwTQjn/lyhkuZVvZOFczqjwh0jAe8bqwYEjjWVUC066eP2WIauXf/dz+mFJbQwL9XUaecnps3xxcKkKOXU7a+roO1ldsZOm1tjUQ+CW8W+tsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV9PWiBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB97C4CED1;
	Sat, 18 Jan 2025 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737215825;
	bh=eUgSRXTGhiU36DFs2yPvSsbWY93J0aZSaio9qM0kRdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PV9PWiBwQFFDCBjXj6ZYt50I6XTGREeujEf3ucgIZkDavhT6CW2O1Sjf1Alo5FLwr
	 xsmdJy+b07YcI75jqVk6BbYVN0oI03VzOLv+sqlsgyEuwlK2qdNv04yWU5Vb1ksUeC
	 IB0Sg2u9hWljxPaw9j3UM9VBaMdECskA0D6Rqx72t7ey+KrAYKPlJ6NmKm20FB+jPJ
	 /rYLoztv4xQZNasJFJ5I7bh1RT/iJEN56l3aCbzsSwv2fnDOv4kSP8H6ci2ia5COec
	 o61GA591fQ7daX6KQS91vawpCId6W5UhCyoTASxXbQwKUzo295WHhMUHpq08dNiL3G
	 EF5djZkcvLn1g==
Date: Sat, 18 Jan 2025 15:56:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Use str_enable_disable-like helpers
Message-ID: <20250118155659.0d2facf7@jic23-huawei>
In-Reply-To: <20250114192716.912476-1-krzysztof.kozlowski@linaro.org>
References: <20250114192716.912476-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 20:27:16 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
I can't claim to get excited about this, but I don't mind using
these functions. So applied to the testing branch of iio.git.
I'll be rebasing on rc1 once available.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/dht11.c    | 3 ++-
>  drivers/iio/proximity/irsd200.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index c97e25448772..48c59d09eea7 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/sysfs.h>
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
> @@ -99,7 +100,7 @@ static void dht11_edges_print(struct dht11 *dht11)
>  	for (i = 1; i < dht11->num_edges; ++i) {
>  		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
>  			dht11->edges[i].ts - dht11->edges[i - 1].ts,
> -			dht11->edges[i - 1].value ? "high" : "low");
> +			str_high_low(dht11->edges[i - 1].value));
>  	}
>  }
>  #endif /* CONFIG_DYNAMIC_DEBUG */
> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> index b09d15230111..b0ffd3574013 100644
> --- a/drivers/iio/proximity/irsd200.c
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -10,6 +10,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/string_choices.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> @@ -783,7 +784,7 @@ static int irsd200_set_trigger_state(struct iio_trigger *trig, bool state)
>  	ret = regmap_field_write(data->regfields[IRS_REGF_INTR_DATA], state);
>  	if (ret) {
>  		dev_err(data->dev, "Could not %s data interrupt source (%d)\n",
> -			state ? "enable" : "disable", ret);
> +			str_enable_disable(state), ret);
>  	}
>  
>  	return ret;


