Return-Path: <linux-iio+bounces-23100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB5B2F711
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DDE3A6D8E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5299B30F7E4;
	Thu, 21 Aug 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="W5qsGTLF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7713093B8
	for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776819; cv=none; b=OYWzZTMS0gM20wG5zdyLiQIEfF8zVio56RH+Fu5wtZciz7DP0/Roy0Sg9Gvdkec0j00+SiukX6JZbqMNssrNISElCGI59sKncBTP6rYNY7ZVqQzre7dr9MDg0bL7aJ3Fcp2ywVQQ2IR+wRUT7n2y4rGcWgY2+7goGXERNPrpAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776819; c=relaxed/simple;
	bh=4ghCPkutuCK2fYk1NWAXL/WCPM/HDvA0p1GJ8ZLtZiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHzYqF/i8+DHg4udKIB4ZLLCwAUOWT2rpnmPDObS5BP6uodkHvC1nZ3wKaEWQWBnCu/H21uO1sgdmpTobp+Ied6gLc31fCYXFpb9GAvs5hh1QQpe48xMGrwA5mEo9Uz1DCXgA73NdzsAh+3InBiRvmZSgdVzp4BreXqIYUwP8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=W5qsGTLF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e86f90d162so97955785a.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1755776816; x=1756381616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=incQm52u2R7cws2GVTot8B10CBfXRhBg5cxU8b8je2s=;
        b=W5qsGTLFfmzfHDQ49d7Oy8VTkEVDFNHtdyIIVErTnUad5lSeYiegnlYlTn/7Md/nYw
         +OKqYSHhyhmCFX7jAGKCjCi7GCoxqCGM7bPseKewMZJnx9T9+zDztqB1L1nW9dLcO/5B
         393f4UXMD6Y27C9GV2hxNWPIABl2jWknN0KyzOck1hozl7YCjNfscFM8nWjE4M2RW3bq
         g1mrQO2LCLWDV+xurmiaTiC2IDV4Sxoh7jF/dw5teHEmUXL+XSgUWGrIbqJXSXfCMofV
         xQ7zZpLje5faccm5hnHwDAQATw2Bd6RGo2FO/1QFTXaxuJ0Qsum8zfgNSqpos5dJzold
         5Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776816; x=1756381616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=incQm52u2R7cws2GVTot8B10CBfXRhBg5cxU8b8je2s=;
        b=Zafp9brz1ODJutvZ5T0usUv1ayaSgebybPQEdcqDpy5xpCq92t7bduk7nGAtm5KIoL
         gnu6l4bPqDMzcoXdXuBnwik2XwnxE2Lmj4aPCyY9LmkrR2tQ+iYSVYDcwhlHO6ucSHeR
         dk1xo0IQZpb7fZnMC7BBDeHb/lIwiyWCd+936b4fqGQkKriRPJOAUu3NMTrBWPU0TDts
         EYsKlRN9QuXwZlqko/W3kU2qifpC0+E9PplfFXiJUU4DZi9zFloDMArAo2jgdMQlkzGA
         z0DWc09rd41tbyHBYoaQKev05T2aBMR2w7FJDF4/mSGx3YYg7Gl0ZG6JQgA8p8xGePeR
         090Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsuMm2HZT2efcBS9qBUGFLCFPKECoDup9qyyG85MChur17RMhaI6NMwK9fGLWwEwcEsBd6haEZBbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96oQagL3qhR3PlJs1JDgDsFsoVyi9gKrRgbDmF+HvBxBwHPjd
	NSGjNCMNu+M45gzfXfySMkL+vLig7Y4ddxkiPENby/W4N9WoFp347vs1exI2wHlKiwoAB4EEgWw
	L9GkznHQtbl0wqDpRX8HOdlGj0l707hCWcXz4OfMt
X-Gm-Gg: ASbGncsvXhtYCFK12NEGlucqq7Q/ahUvYuauBUv9oftsem7v2t6dJC2BNFBtq4U8FrL
	TEUU2NVl0qJZI+ECyog7ufjbU0q47iMKFcBJs5lYFABG5BkRnW5rH7pxLU3OUcG6cGWR80Sdp5s
	CSPE9tNiUYOgbKpPB3QwYdzU9iP2fa39hkm+4Fp4vL4Wi2ir6sBExAIBs9BMsReVkJALyUsX3f4
	7JFRFRhFcRBsoTn+74M
X-Google-Smtp-Source: AGHT+IGcg5sCtpZTYrIqU0S3P212TEo70q3ZLTkCJTYJNMj+3zLr/OnUd+pklhVWGQLCAJARERF/BYFnDgEXBjf2les=
X-Received: by 2002:a05:620a:c55:b0:7e8:62e9:7fb5 with SMTP id
 af79cd13be357-7ea0970bf72mr183834185a.33.1755776816353; Thu, 21 Aug 2025
 04:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <20250821080723.525379-8-zhao.xichao@vivo.com>
In-Reply-To: <20250821080723.525379-8-zhao.xichao@vivo.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 21 Aug 2025 13:46:19 +0200
X-Gm-Features: Ac12FXxWSgJdG-W8UPYo7Sc_QZdPcmNoT2HwWT_Zp_zNw3zqULm1d2DtaIBBD5A
Message-ID: <CAKv63usy7FsiUCjrqibcr196kVGb5_FDeU__OwLWJxasb3MgZg@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: temperature: mlx90635: Remove dev_err_probe() if
 error is -ENOMEM
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:MELEXIS MLX90635 DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I am not sure I agree with this. It provides an error message with
reason and I understand we want as few as possible, but this would be
a valid remark inside the logs?

On Thu, 21 Aug 2025 at 10:08, Xichao Zhao <zhao.xichao@vivo.com> wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iio/temperature/mlx90635.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index f7f88498ba0e..6d386d887855 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -939,7 +939,7 @@ static int mlx90635_probe(struct i2c_client *client)
>
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90635));
>         if (!indio_dev)
> -               return dev_err_probe(&client->dev, -ENOMEM, "failed to allocate device\n");
> +               return -ENOMEM;
>
>         regmap = devm_regmap_init_i2c(client, &mlx90635_regmap);
>         if (IS_ERR(regmap))
> --
> 2.34.1
>

