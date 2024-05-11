Return-Path: <linux-iio+bounces-4949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6928C2F7B
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 06:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E8B2837FF
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 04:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB276405E6;
	Sat, 11 May 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmB9G6H9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290C3F9ED
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715400917; cv=none; b=klex1IYUPQxALncKInwvaH/kTIl7AV3LTLsl+eNr5VMjdFw7XNwEfG5ulgdoM0fcxM2J/sDQ4tlFucASv+en1S4WtUddgesSF3GbsktnUuM7FfQziJtC91gmm29LgNnBTNDB9f1VdyouZWDfpu2IjeQ9iLpKy75Qaoq3DnfvLMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715400917; c=relaxed/simple;
	bh=il06Fle3dnZqjVV5e68RlBbESBZXUPApX+mo5ojtMqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFTjW7S+EiEY79gEIDHy81KoaoHv4ojZXqR2FG+RHtrPcO3jzgCB5CO/Kf/zsS8K8L2gkHPWGk7yNDkhw4nw1CTNXtjF8zq/y62sxjKzSUVwVQ51vosojQI1p1ZALPmUClyZSttK9kVuWwFxhljZYtSEZmSsRtkSjuw5ZU9dcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmB9G6H9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b37731c118so2152500a91.1
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 21:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715400915; x=1716005715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2tzyuWNUJWmawoV39+6aK/ujbp59yaA/AjnL78utqA=;
        b=AmB9G6H9IoCdc9i5bRx+qSvaPORqeOBjNK5QPzQp+V9gt0ORjU6hPkR+0r68RNL9lc
         BVFscCU7TQryGv9ZcX9Pk0sddGxcdGJe+FMUCcFGEGYNfTrCw17h76eajUEHVVty5l9s
         D9ufpaY2apqvGGU7CgrohGIwo0SI1GTeNsS9hSyeARUHn7cWp/Lo6Z3deF8utsDIKLbT
         VntMF6jPWA2ITBnJ6TmgUgX7jbLcuBinbLh4dA8iEvuAoRfiYH5qOVPxrwS2e0pYp33e
         jA9GbZ0aVg/V5aVwt9EF+MmKMqjFi3YWPKcENogTunKt8k9XDAEZE1XrHjHOph4iL0AN
         NdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715400915; x=1716005715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2tzyuWNUJWmawoV39+6aK/ujbp59yaA/AjnL78utqA=;
        b=vd/kJds1vJ7n7FFX8bzjw/Jh1+Ga1aWq6TXnr3CuJHHPE+fulsxVRy8l6JHhswWpsm
         d74rZqm7ydRTPKA6huYRpCCbSru301YlnhCPX87g0IljiJigfN3b8wuk1qh2qamQcglK
         rC0Dn7vQzrdccuXxHmZ77HJ7jM9rJRuG3qT/BAfeGJqgGQ7dvWWEbQXsvWY0kARLOFTa
         v74p4gn5rurZJ4jMlFRrdG42WhO17BOXKhPdYstNptEobhSXn6A681rvEF9r/JiCdp6W
         ZaDlbe5PyQM502KDljvBUHxtvYpReaYMiJ27YWuIZc0gGjGiWVk/S8J8aCVcK3VBWDad
         Nl7g==
X-Gm-Message-State: AOJu0YzvzWCLroAeCce3HuAKHeanGVN2DCGCtcasUY+SmNFlF8w8ICDN
	mB6kpzIkDCuH8BN3udN9x+novbJmuIWgIJ+gmUo7Y7W4M0UGxQhm1cAz8Q==
X-Google-Smtp-Source: AGHT+IGBQXqGrk9xn0Tzs1v/I1boKxOyuXyMP9ncv+p/P7Z/5WcTLIhYO7JS3KDqDD0drdlnW86b2w==
X-Received: by 2002:a17:902:82c8:b0:1ec:5f1f:364f with SMTP id d9443c01a7336-1ef43d18196mr42248975ad.26.1715400914752;
        Fri, 10 May 2024 21:15:14 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d18basm40464505ad.57.2024.05.10.21.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 21:15:13 -0700 (PDT)
Date: Sat, 11 May 2024 01:16:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eduardo Figueredo <eduardofp@usp.br>
Subject: Re: [PATCH] iio: adc: adc7266: Use iio_device_claim_direct_scoped()
Message-ID: <Zj7xCMU9cJodgR03@debian-BULLSEYE-live-builder-AMD64>
References: <20240508155435.183850-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508155435.183850-1-hagisf@usp.br>

Hi Fernando, Eduardo,

The patch idea looks good. Though, there are some aspects to improve.
First thing is this patch doesn't really apply to IIO testing branch [1].
Please, check the commits you have in your local branch.
Most often, each commit generates one patch. Looks like the commit from this
patch should be squashed with some other commit.
Then, certify that the patches you generate apply cleanly to IIO testing branch.
e.g.
git am 0001-my-awesome-patch.patch

More comments inline.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

On 05/08, Fernando Yang wrote:
> Switching to the _scoped() version can make the error
> handling more natural instead of delayed until direct
> mode was released.
> 
> Co-developed-by: Eduardo Figueredo <eduardofp@usp.br>
> Signed-off-by: Eduardo Figueredo <eduardofp@usp.br>
> Signed-off-by: Fernando Yang <hagisf@usp.br>
> ---
>  drivers/iio/adc/ad7266.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 8b03d4469..3fc34a3a8 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -63,12 +63,14 @@ static int ad7266_powerdown(struct ad7266_state *st)
>  static int ad7266_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
This should belong to a separate patch. Conceptually, this is a different type
of change compared to the update to use claim direct mode scoped advertised in
patch message and body. The blank line additions would make up a code style
patch.
>  	return ad7266_wakeup(st);
>  }
>  
>  static int ad7266_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
This also goes into the code style patch.
>  	return ad7266_powerdown(st);
>  }
>  
> @@ -151,15 +153,16 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,

I think after updating to call claim direct mode scoped the ret variable that is
nearby can be removed. You may have removed the variable in your local branch
but it would be nice to also have the removal in this patch.
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  			ret = ad7266_read_single(st, val, chan->address);
>  
> -		*val = (*val >> 2) & 0xfff;
> -		if (chan->scan_type.sign == 's')
> -			*val = sign_extend32(*val,
> -						 chan->scan_type.realbits - 1);
> +			*val = (*val >> 2) & 0xfff;
> +			if (chan->scan_type.sign == 's')
> +				*val = sign_extend32(*val,
> +							 chan->scan_type.realbits - 1);
This change actually introduces another code style issue for checkpatch to nitpick on.
Please, consider also running checkpatch on generated patch files. e.g.
./scripts/checkpatch.pl --terse --codespell --color=always -strict 0001-use-claim-scoped.patch

>  
> -		return IIO_VAL_INT;
> +			return IIO_VAL_INT;
> +		}
>  		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		scale_mv = st->vref_mv;
> -- 
> 2.34.1
> 
> 

