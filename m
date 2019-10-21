Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D913DE719
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfJUIvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 04:51:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35818 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUIvk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 04:51:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id 14so5213579wmu.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2019 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpIfs3oAhANu8KErAVl/aNInUPfajrw6HPIOXQBEpdU=;
        b=StKa37yByHJ1X8+4uRAcZRV+b8XAE4CocJgYxM48kDqO71J3DyIK3/Q186kuOvKFy3
         +SBKj42Zvx4p7aAzKtz1TVsGbago57cS8RwJenZUqRlOfRzZAUefYNzPgTQweOBt2qC/
         rsH6ciiBixfstb71QeN0+id3OhFQ+jy4pWF4QZ+B4JvwAthA3M/t69j8mlWdqV/wbTZ8
         CkLUdDxifHvK6K5o8UCRoPd3OLMJ3p+DSH3YWBn5CzsQfC+tTqExcXgslZ4sHiYANj/D
         OIwz+2U7A4yda8ihJZPwQvoS//O6J6t2H6nqX4Rt9pAmFpB00QgHNko7ejmKsZGh5GRT
         AKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpIfs3oAhANu8KErAVl/aNInUPfajrw6HPIOXQBEpdU=;
        b=BWjH7w3bpofdOhS47P7WSrbWXnxyifZ1Q5YqT1X0udJVHAHXK1tgYNZ4mk9f3HgN24
         KEtyxlIK3wcmqvSlc5GRLURErS8kJONBtFfd2KDzbkL5ibinaykK3Fp5AiSt9u0s8xXq
         +7hXZ3iUboIA6ZQLImnkvBEUz1uDjThgOUxbablW0iPJNc+uqDom161/slL3ShdH+Q50
         gO6pFSbxhyoIeKdG/QoCXGMpO+3M3g9fvOvnbW0+OIPnUyZNIMYJr6bADslXyj84YnC+
         ISs2Q8bOHtNHYvMEZVRJAb1QhSYB/zbx8e/mC0rEfiRRMA0cj/LscwYybVUb+7ERP5Ic
         849Q==
X-Gm-Message-State: APjAAAWmFIfXsONcTDGZpySnTqF+/qhNdRxLj4fFPdoWsNqJXtpt4T2d
        EI1h37AgRvSk2pdQ8q51jyJcPg==
X-Google-Smtp-Source: APXvYqwLuPHtT+Cm/9GtGChkiJbTO/vzknu+9WRUI7pErP5OAkxn2xT8bIBZbHu36JR1k8JYjy+XZg==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr18406311wmh.76.1571647896894;
        Mon, 21 Oct 2019 01:51:36 -0700 (PDT)
Received: from ch-sta-l-li0012.sensirion.lokal ([209.206.26.2])
        by smtp.gmail.com with ESMTPSA id h3sm675867wrt.88.2019.10.21.01.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 01:51:36 -0700 (PDT)
Message-ID: <f7b5a222c49f82f0555eed514a95a0720f01caf1.camel@elementarea.net>
Subject: Re: [PATCH] iio: chemical: sgp30: drop excess semicolon
From:   Andreas Brauchli <a.brauchli@elementarea.net>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Mon, 21 Oct 2019 10:51:35 +0200
In-Reply-To: <20191013165412.2090798-1-jic23@kernel.org>
References: <20191013165412.2090798-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ACK, lgtm. Thanks for forwarding.


On Sun, 2019-10-13 at 17:54 +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Suggested by coccinelle / coccicheck.
> 
> CHECK   drivers/iio/chemical/sgp30.c
> drivers/iio/chemical/sgp30.c:486:2-3: Unneeded semicolon
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Brauchli <a.brauchli@elementarea.net>

Signed-off-by: Andreas Brauchli <a.brauchli@elementarea.net>

> ---
>  drivers/iio/chemical/sgp30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/sgp30.c
> b/drivers/iio/chemical/sgp30.c
> index 8cc8fe5e356d..403e8803471a 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -483,7 +483,7 @@ static void sgp_init(struct sgp_data *data)
>  		data->iaq_defval_skip_jiffies =
>  			43 * data->measure_interval_jiffies;
>  		break;
> -	};
> +	}
>  }
>  
>  static const struct iio_info sgp_info = {

