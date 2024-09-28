Return-Path: <linux-iio+bounces-9830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735E98901F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9CB2138B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99F266D4;
	Sat, 28 Sep 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWhaS5NJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8B1F956;
	Sat, 28 Sep 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538324; cv=none; b=W+LFE24ev4Zq5e8jJdmwzZwcgejIQh0tnxROxQW6NOLHcsUvw9GtyCu16fHV4oQ5+yTugFX/df+k0YANySDSAKcs6qv5/RI/R0QFxo3pRa2aLvDu0z1erFEc81HVU6EXvkjJNlt2kdrmzzoYEpOuRmV5rzDQVjlTs9bnJp1hmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538324; c=relaxed/simple;
	bh=7EFEc7JvwkPfQcKLQDueB8d7yvPvW8iLO9S8ad318yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jnz31gmhcXVaNHIPsqj3Qq0dgOmHAp84a5Fnrdswiyo3pm/IZwgis3GmF5jzfygFvE9gMVKrbDnFzVYez1pTq+9mBmp0QxBRZGx/DkZ9mGu4pTSVD2WO7TLPkR1qfxreVpUPg2j1VC/+PjOOUVx2ZSwQxzNQM8hiYNv5rZFmcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWhaS5NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E590BC4CEC7;
	Sat, 28 Sep 2024 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727538324;
	bh=7EFEc7JvwkPfQcKLQDueB8d7yvPvW8iLO9S8ad318yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWhaS5NJB+Gg9swULFZ+uwuMHBWMLtkVRq1uDiwFVEMP51ASBnM8zCHf23CHKvBKr
	 ALg14doZVwV8VvAjsJXjqhX2lJRU2lEfwAUsrzLW/eaywJJ3eBWamjGBHgeuUeiUjB
	 JbYIVbWdwiXAJbS3K4wFo5Pl0e39+bg63cbNM7WIauBYweVoRRm5PhjffAvzwrsn3p
	 vmznq21ulWnno0xDCMwlfwxPMsP+GVvfRQFoan73Dr0xsAOIUyeXEWR2PnezkvgOvt
	 lUl04o/1yyBwFv3153GcmlmMEjDr9QzpQ7P+8wkls38EFKiPxe4pcJ/yY47I9xw19K
	 d9Jke7KI4ZWSA==
Date: Sat, 28 Sep 2024 16:45:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: light: ltr390: Interrupts and threshold
 event support
Message-ID: <20240928164516.548c923f@jic23-huawei>
In-Reply-To: <20240914181246.504450-4-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
	<20240914181246.504450-4-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 23:42:45 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Added support for threshold events for both the ALS and UVI channels.
> The events are reported when the threshold interrupt is triggered. Both
> rising and falling threshold types are supported.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
I made a few more tweaks whilst picking this up.
Please take a look at the result.

Jonathan

> ---
>  drivers/iio/light/ltr390.c | 212 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index e152009b5..57bf48595 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -25,8 +25,11 @@
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
>  #include <linux/device.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
I moved these as well + cheeky move of the bitfield.h in here
as that was beginning to annoy me.

>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/events.h>

> +
>  static int ltr390_probe(struct i2c_client *client)
>  {
>  	struct ltr390_data *data;
> @@ -428,6 +627,19 @@ static int ltr390_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
>  
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
we have dev, so I used it.
> +						NULL, ltr390_interrupt_handler,
> +						IRQF_TRIGGER_FALLING |
Dropped this specifying of direction. Direction should be set by firmware not the driver.
We have it done in some older drivers and can't fix that now, but for new
code we should never force it here.

> +						IRQF_ONESHOT,
> +						"ltr390_thresh_event",
> +						indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
return dev_err_probe(dev, ret, ...

in keeping with other local code and as it is generally nicer.
> +			return ret;
> +		}
> +	}
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  


