Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3252249CE4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfFRJRu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:17:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfFRJRu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:17:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so7354049pga.0;
        Tue, 18 Jun 2019 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8iho8zB2EI5q4Vs8qH35kthzunfwFzXsVq/N63fSg8=;
        b=DnxmFqcYaL4E0yzWf4Ny5XU9Lmr/iNvLlEKA5tvmoA4m4tj3jhKkImeaeUHgor7hzs
         kcKgPn51oQkNGADmzyWj8AzIZoR5a6pXcfGzQ2FijHCV/BvmCCeZI7YOSp4NJdKcrR+V
         GK8iJkCzAO0Ath3MeQwKo/aBK+hEqkYugd7mGs5ejJCr1QKHQLQlCA2YXspN5D+Z/xaU
         AAyTECbtdH59r1Skk0PiabZiNtSBPOhQQl8O769/sk0dGao+xhdvYN0FdMwVbc99giAr
         BunOzlcA6JOZi0hd0AGcULuhbdOFSkAwOMprauXIYES3otB3MFPejHFeo5wO/AARyE9Q
         oskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8iho8zB2EI5q4Vs8qH35kthzunfwFzXsVq/N63fSg8=;
        b=UqwNFLERpueOe7pFKnIVejAqy77G2sLLVy1C8xgqA8hdkyG1BxX0CpI/bd3XCWawbM
         I1rfg6PTDaITq95+BTi25v/SHmV/CILK2z5NiN3iQFKgrQlEu3IHfBb7GuC1Ior4bQip
         2AFqBLplMlqSl+ayf41tasLbefs2kjrOYs+74JIACYLSB9p1uOxeRbuCREPGJ/vpw0YZ
         7JNgTZY7n4i0oblkqxXP72edw0v3pZGJnd9LjJzUykkawi0C9bsk0U5jWUlUfP+gh1sT
         Pox4h9T0BSUlkZH6RtDeQbWCpfcn2h4fwI78O9Bhlj8PjZF32GFeU8XgrmN9oxak5cd/
         OXSw==
X-Gm-Message-State: APjAAAVQJZTaqVdgAGbU33xtblA6EKVYaaS3MmmMnGRSN/E24JhNunJP
        4J/A3f+Hy/Spz6h+/JzI6aw=
X-Google-Smtp-Source: APXvYqznfc4oBivpsKSj5zEbVhuvELVe7pEx+mqDBog7fgwcN7DeBJo8RqY39olEqs5lV86NOwGOkA==
X-Received: by 2002:a63:4d0f:: with SMTP id a15mr1779210pgb.101.1560849469025;
        Tue, 18 Jun 2019 02:17:49 -0700 (PDT)
Received: from icarus ([2001:268:c0c9:ec1e:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id i127sm14163574pfc.91.2019.06.18.02.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 02:17:48 -0700 (PDT)
Date:   Tue, 18 Jun 2019 18:17:31 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/1] counter/ftm-quaddec: Add missing '>' in MODULE_AUTHOR
Message-ID: <20190618091731.GA8257@icarus>
References: <20190618090542.13885-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190618090542.13885-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 18, 2019 at 11:05:41AM +0200, Patrick Havelange wrote:
> The last '>' chars were missing in the MODULE_AUTHOR entries.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
>  drivers/counter/ftm-quaddec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index c83c8875bf82..68a9b7393457 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -352,5 +352,5 @@ static struct platform_driver ftm_quaddec_driver = {
>  module_platform_driver(ftm_quaddec_driver);
>  
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
> -MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");
> +MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com>");
> +MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
> -- 
> 2.19.1

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Jonathan, please pick up this fix as well.

William Breathit Gray
