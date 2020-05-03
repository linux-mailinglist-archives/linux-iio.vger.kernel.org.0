Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F51C2E72
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgECSB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728831AbgECSB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 14:01:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7FC061A0E
        for <linux-iio@vger.kernel.org>; Sun,  3 May 2020 11:01:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so18162404wrb.8
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2020 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yq7OS+fmfIyIhWEO7cmy1+d/sKzgA7OIv80VKiprsGU=;
        b=c3Pe3aLDA3oibPPkjCJHgFVSz0/E/wG26P/eS9dKfIgrwrsIl2u6BE6RFlnzcy3u6o
         ur2OxEHk5JFVBNd/Ny3BEpU1S56GquUCCkjNy4bZ9wMfNpnC8wV/Jvjos5DAhSyX9+Hh
         JAQurqaddckij3cXGn1oAN4RQzy0/A4WwKqTNY8Gm9xVFUhlbDViz53doc77JkL0b/lG
         oxufpfQt4Y1b9hmyagkHJT443IVeQi0Rvadvt95mAF5p6jjy1oz+Yz+sg2NQfc2KxQ7C
         YDiFD6J5PORafyiVHdUyuXO7lUAYjJLhQ/1JjyMkM8BGc+RMEAJsGfqPWIk/8urPkGo+
         BCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yq7OS+fmfIyIhWEO7cmy1+d/sKzgA7OIv80VKiprsGU=;
        b=JIYsM6Fax3qpN1vOb5z4HiR0qw4aC5EWU9G+q6VJa3bpgTese1j2eIba4Gp1wUUZyM
         Ms2iR6GkuBa3uVmXlE9IIVJgCrO1pbEUfebkabho+fr+JT7bdeBQTLsh7vjx3xI4lVYB
         apn0HZdxmjGF0te5k5mkeD08aFTKhn2JAriQeAbdgsu5ldo0A1zYjZn2uZZAoBNtWy5c
         DuuIrNeQwcREEcWNWxnftoEZPjSm20rK29sXICzxux9ZkyF8cAIOqo1ZtHlOy6pOdFue
         GSevb2ZcOCFnVizC1t6Ckc3BAJoCSPHWRnV9q3YlrmKWYKbVp0GZPdHJfTaO1EjkMfkF
         6cPA==
X-Gm-Message-State: AGi0PuZGiu6bLSpM5yx89Q97pXXSKe9GHKQLm3Nt5GCFOx8vUPnpXmrk
        jKN55TFajzl5IJXbMNTanr0=
X-Google-Smtp-Source: APiQypK6tSggXJpyaCBFPCVLp5Bx+htGp9ybX1ugmpzzg5xLMr5zNWm/OE34B2Zk2yiNYmyPAYNCPg==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr14852637wrn.364.1588528917797;
        Sun, 03 May 2020 11:01:57 -0700 (PDT)
Received: from nunojsa-N551JK.fritz.box ([2001:a61:2488:b501:889a:1d04:1d51:f2d0])
        by smtp.googlemail.com with ESMTPSA id e11sm14786447wrn.87.2020.05.03.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 11:01:57 -0700 (PDT)
Message-ID: <8069360d699a6699eb7768a07681c78e4b94b250.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: kxsd9: Fix alignment of local buffer.
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Sun, 03 May 2020 20:01:56 +0200
In-Reply-To: <20200503172235.207632-1-jic23@kernel.org>
References: <20200503172235.207632-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2020-05-03 at 18:22 +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
> is not guaranteed by an array of 8 __be16.
> 
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/kxsd9.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 0b876b2dc5bd..4c42d1200914 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -209,14 +209,16 @@ static irqreturn_t kxsd9_trigger_handler(int
> irq, void *p)
>  	const struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	struct {
> +		__be16 chan[4];
> +		u64 ts;
> +	} hw_values;

A nitpick from my side. Maybe a comment woudn't be that noisy. It might
be not that obvious for some people why this construct is needed and it
might prevent new driver's from doing the same mistake.

- Nuno Sá


