Return-Path: <linux-iio+bounces-13197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B729E813A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5D1659AE
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A051448E4;
	Sat,  7 Dec 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkp/fCCM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB01E885
	for <linux-iio@vger.kernel.org>; Sat,  7 Dec 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733592653; cv=none; b=MTFtG5QWbXysixP2iR8qJfDGO+VkXI+FhjHt8Dnu0I+EpWG0IRwxTfgZq0EVDCkL00xlwHUM9+439XXZ4//juKExSuPG13LD54wdEDIEqHaEk5dRU+CRy9Lij7Ru9Bf6caFfOv0BN4swVC3tEX+SUsJpUpBmth/aG8CYg5xh2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733592653; c=relaxed/simple;
	bh=W4WwpXVdK0RkueBevpZp+1+989VuIDtakUhqFVD01G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byUlOaff0QfICdVze9B9jNXwrjDYGjFaqAAJ9qEf8kOFZ2O8oCelHQHsVaLOACSJCFNR8NpXL1CsdTvKlIydW429/vZ54FQzYrvm7ymxk7TvxkGj1tcqrAsvWSlL1/LXpnAdCcZ/I0TLDbMPy9ZrAdNstQKY+Vt7q8yuhDQhBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkp/fCCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819DCC4CECD;
	Sat,  7 Dec 2024 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733592653;
	bh=W4WwpXVdK0RkueBevpZp+1+989VuIDtakUhqFVD01G0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gkp/fCCMrkz6gxAjghQ+A3IBIICaxCM1lnzKF/RS9CN+AQQqgWUF0t5FLTWZZO2GF
	 XWuhu9krFii+TrkKA4TjiAVFkyiGNUKxi0TQppZXPG4Ch6aNh9XDIjoOFKV+6GDlvf
	 bD3N3Yh8bRZWU53dX6D2qhV3Ragski/1/KQhrreJnoWlVNxeAgB8zQy3epSQewP6jS
	 +fQrpgyTTJgcYPdRW0w+U7grDEnFaWcRhqthegnKcDjtXrqnqaPYnFx37FKwE0glaS
	 0rHxMK/cGfgKag1Jh88xy0dmoeEFxGqFz/PsbikLljEQft9gJit4htO6ZUC/6clB8o
	 A/1yrfHPL96+w==
Date: Sat, 7 Dec 2024 17:30:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: lars@metafoo.de, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91: call input_free_device() on allocated
 iio_dev
Message-ID: <20241207173046.375dd855@jic23-huawei>
In-Reply-To: <20241207043045.1255409-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241207043045.1255409-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Dec 2024 13:30:45 +0900
Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:

> Current implementation of at91_ts_register() calls input_free_deivce()
> on st->ts_input, however, the err label can be reached before the
> allocated iio_dev is stored to st->ts_input. Thus call
> input_free_device() on input instead of st->ts_input.
> 
> Fixes: 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens without TSMR")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Hi Joe.

Good catch.  Longer term I'd like this driver to be fully converted to devm
managed cleanup though which would have made this bug go away.

However, having looked at it, that conversion is a rather substantial, if simple
patch, so I'm fine taking this fix and maybe someone will revisit to do that
cleanup later.

Applied and marked for stable.

thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index a3f0a2321666..5927756b749a 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -979,7 +979,7 @@ static int at91_ts_register(struct iio_dev *idev,
>  	return ret;
>  
>  err:
> -	input_free_device(st->ts_input);
> +	input_free_device(input);
>  	return ret;
>  }
>  


