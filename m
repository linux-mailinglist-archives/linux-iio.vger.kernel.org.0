Return-Path: <linux-iio+bounces-11800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531819B95A6
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6E281008
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149E145FE0;
	Fri,  1 Nov 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH1q8YKC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60E61AC88B;
	Fri,  1 Nov 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479293; cv=none; b=VVuyX7aGNXkPcqODtuEf+wdW+lUd9wjpy6yzyrW3WTtkTTY/BjnuYwbEofJiHj4kXdx1jlVEGXwKmC2HidMUe4RicyNe3+hYHERr0RIOoHKwL5TrQgNnz+7FlpRcVkssSfbk2DyhCPLgMphHAQl4QX/BIkgrz+ScJC0ZD683haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479293; c=relaxed/simple;
	bh=RnVmu4KMn0cYcEtJmqOHewUj8MapyZAuXdZ2ik2BBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuEuyIM5PfQo9LoMjNo+qUV/FwEvXLrLFydVS/2wyuUN8lqwEHMXr3+XfEKYOr9bz/nlqDsrlb0C6es1tVjRLqStiE4nxEbCEU+zc5br9cwxbG1uwABpEzl7V3g64LuZ5ESXrN8KTTV6MvHQtICoIcBSAN7YTmStqzheS0VPYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH1q8YKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B2C4CECD;
	Fri,  1 Nov 2024 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730479292;
	bh=RnVmu4KMn0cYcEtJmqOHewUj8MapyZAuXdZ2ik2BBwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FH1q8YKCIGY6guripygnr5/X3GiZsfOtWqz7B5YyRdEvi8alczpqthsNyfSEUf0QE
	 YzPta1HyOjTt0iwV6ZiaRFc/LWdu+oebKdb7Vf/HU8ceebCZDvSdPhdIZgmVHJWpNF
	 CLNuIm9LO+SzfRdv3Xe+9ZNj2teoce5Dhx4e93vAu8wKuVO/obJOETKj2wOz6jWNN7
	 tz79KaeMKPC9QDSpUeIegKhgfvMTg6DX1VpOvI+6O0gec03aeih35q3Ke76Vhbv7dy
	 ptiYxEM0cX485g/gkeSLwRNLiMVLcHppe+BF3g0GWoz69Mpcp7c+yMzBrdctpinnxu
	 GDm7jaLHfT9hA==
Date: Fri, 1 Nov 2024 16:41:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit
 Ghosh <subhajit.ghosh@tweaklogic.com>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 13/15] iio: light: apds9306: simplifies if branch in
 apds9306_write_event_config
Message-ID: <20241101164118.687be624@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-13-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-13-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:08 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Simplifies the regmap_wite if branch in apds9306_write_event_config.
Applied.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/apds9306.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 8adc74040db2bddf93fbb773e3519abcc726b9a6..9c08e7c3ad0c17519689a630d42fe9b90438dfe8 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -1125,10 +1125,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>  		}
>  	}
>  	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> -		if (state)
> -			return regmap_field_write(rf->int_thresh_var_en, 1);
> -		else
> -			return regmap_field_write(rf->int_thresh_var_en, 0);
> +		return regmap_field_write(rf->int_thresh_var_en, state);
>  	default:
>  		return -EINVAL;
>  	}
> 


