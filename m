Return-Path: <linux-iio+bounces-18171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08615A90613
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56F719E3242
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BC1F9A89;
	Wed, 16 Apr 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TY4PgM1K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1801F872D
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812773; cv=none; b=T1PdSABwOH/cWnXSuF0e1x11tB7ZcP19B/G7z3qIN1v+BBuNJMRAoQqLOWaB82rFBIF84LSV1g87q5ud+iqwTiebS7xzKqNHL1VjJip9kv+2ghGLoBtb+lUynM62yrAwGBwVQGcGXGNsIzuU1RRvZzGfDgfVxL18ne4ALy+DbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812773; c=relaxed/simple;
	bh=XTkntqDwePYCb0luiS2lGmMOslSaMPOKVqshcejczDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFHPvAYq7rsMjrsuej1Wa35Z7GyrQAmswsQ8MK5H76wqH1ziUiuXe/pg5OObNcU/6AgRKvuvgzM2woSPyZwvcvbyUtCr0UZd9G8OO9g4ubIAu548hzX9btOl/ple+Gyv+varlG8wZfBuV4jhrG9tthFQzMEIJo3DRl7thqMaguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TY4PgM1K; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so11087810a12.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744812769; x=1745417569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TZMTVb3pZE6oHhA0d7W1SxUDzw2vnyZ2X+M+C9eM56o=;
        b=TY4PgM1KfaShKUCbyX8HFFo774fz2AkxuG6Jju0esbmx2rV51BlG9AZD4JKuo+xeBR
         MDpv0aYKAOwI+5RHBE5OI8E0rElv/hL6Nn6UJx+PZs63A2m+j1dW2FiC0GtPD49GY+qG
         xVgBSbCCNdn3O8N315LimcJLVIKai4VlzBFhWVwvhQfUqgfPS8DMqB7B5kL3vDwSADo5
         tsBW5n8rWH7xrwcuW5m+7TN1irh1fBObtNEiAcimR8+vXXKjUEhN7nrtdoWQh6ndwfkX
         kqqSf5vfB6jEkun/pLOGMrY6glyZTEFBt7b9pON5h2qnIzlonZIOWKPJQNyg5GVl3DI3
         DkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812769; x=1745417569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZMTVb3pZE6oHhA0d7W1SxUDzw2vnyZ2X+M+C9eM56o=;
        b=gdGhV7G/571V7kFXMUdf/m8YNDYKkxnZZdNNDbsR/uuNMCKS2qJ5HzyaAA1FlCQZYb
         X8UY9vQ1Xl0DuSY00pQOe+K23GeP4KBjBwthsafBfNb9lFT7a58B086zldyFD+pSXl0t
         bIjkdin31eWYhRG2H9DqbC1IL1QjflnH7E62KhHK5aSrvvlzZian+MH2M81dpjMUVJSv
         HwZSg2mvQC7s3rNlTudnOkLziNx6V5OJsJ40ulQh710WuyC81Rx+TiZD1Sp7qy+S8aWi
         ZXdk5S+f/cwHitoiHiSCuu47SLjmF+4a8qxfldhwXnK72iIAoDHeEy7NJs+JKxXsvDcm
         fUIA==
X-Forwarded-Encrypted: i=1; AJvYcCXzExVRsCq2vh2UCHR9UnhDKC5Ln7mQe2uFLmOmWfJCnVViGpfHlQE8r2YRgZFaYoHPuZyB6dpR9eI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9K9cx3qs7Ndz1x35f969DZFpkaGOJz8sYZ02MvZz2tEsXCMkk
	TObn+vFY1CpzqTAujWY+rBBqSBtT27T12pmNdu3y10DE/1pTQGouv2cStjQd6cExAEiI0NAxZU0
	+C7RCkbgqZPpQzbsH7mjMe7tWfVmxxC/qJj86+Q==
X-Gm-Gg: ASbGncuwfa6JE2n+HmZjRWPJxCexVXuoLcUw307xehkJGtRLZJepbu+mAGHXHRAVdRf
	6HY+FJhUP8j6bfCBnl93LDTBvAzISfMpLtVFkGK8Qc7gID+r6qYx9MDh2S0RSuD44cyP0JjSVbb
	SPvuWI+vBp6CWSZdEM7LIWHYC1iKZBFGhFwfvaIClBjS8aFdYYpujTu1g=
X-Google-Smtp-Source: AGHT+IFKh78VHVMJondHG+OsJwidPfNrFauRyCcIsVgg2sFjRBzYe5AIwmVRBEBBtiTUMeOMLDkaj0i2I1JGEUQ+Qgk=
X-Received: by 2002:a17:907:3d9f:b0:ac2:cdcb:6a85 with SMTP id
 a640c23a62f3a-acb429839b2mr140366666b.22.1744812769573; Wed, 16 Apr 2025
 07:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_-P7bsD3KL5K25R@stanley.mountain>
In-Reply-To: <Z_-P7bsD3KL5K25R@stanley.mountain>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 16 Apr 2025 16:12:37 +0200
X-Gm-Features: ATxdqUGQSIwu5i_6p0YPHLy3HbMNhNvwue3TIyNU5eKcYhwj52asxFGUhRcPQLE
Message-ID: <CACMJSesQ1NZZ5jHy=h6eaRyV+-FaRpzVKtfnycv_5Z4YXJ+o-Q@mail.gmail.com>
Subject: Re: [PATCH next] iio: dac: ad5592r: Delete stray unlock in ad5592r_write_raw()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 13:09, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> This code was converted to use guard locks but one of the unlocks was
> accidentally overlooked.  Delete it.
>
> Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iio/dac/ad5592r-base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 217a8a88818d..5f2cd51723f6 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -324,10 +324,8 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>
>                         ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
>                                                 &st->cached_gp_ctrl);
> -                       if (ret < 0) {
> -                               mutex_unlock(&st->lock);
> +                       if (ret < 0)
>                                 return ret;
> -                       }
>
>                         if (chan->output) {
>                                 if (gain)
> --
> 2.47.2
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks for spotting it.

