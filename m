Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA568B40B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfHMJ0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 05:26:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35151 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMJ0Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 05:26:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id g17so18965126otl.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2019 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpJ1HxR677rrqzN3EZzIQmcSGDvCixhXFxeFq0HwGK8=;
        b=fh2sYXeqSoNNkGtVSxX5I16eWwUzyEm4MHtIYg2B96Pcu0Lg4ILesreXhgaVDdIMR/
         jcXguxUx3Gp1VqbeJO4DBt1Ru0w6G7DnAc4EoYT3OGZs3nJvHQDHYfMm6m/B0CgxO4/v
         syKO3uKULX1QakQ6JDfUTeyg43UI7J6iZ6dsocuSVWu09IOoiNGlinkdwybw0sDySVmh
         imMQKp0NTMYOWQvOXylcGtOGOY/6eVBS+7I87p7jPQj/s4yGB4xSyentXehYbAMstf+A
         RatG1V9hPRbH+axk17QuqWmtUq9Yp4O1C3FdmuypyGIbXCkkfJb0dG1KdnzMm53kHGIE
         D6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpJ1HxR677rrqzN3EZzIQmcSGDvCixhXFxeFq0HwGK8=;
        b=Dc0UtAo11/B6X+FfHE+LwkPWkHeYtSxoDf6yYOmfDz27FumZUu1LjI19x6nrbhkYsf
         ohYEHvoc+1wT6k/0g5WmJT5Yx+aNNMyWQQSIPAecgMXxIa9D0Asg4pQrS2/6opu9wEOJ
         JuZjc88kqqZRwZjcqKWH2KF2DfwS/B6bqI+4gqmksOUwG+FffQ2J9pNYzyejwwiaSxGe
         pHYV22GJxFgCLg58qiwuD0SfIkuYwNjA8I3WPTI4KB1AC5SmucrUwOX8tbO0TwCNVoAi
         VNbusowP7fgm7y0CG8ThWDnRbKRlzZojdpzbK3i9eO8EIQTov/NQdXgDt7b/uyuhXcp+
         mnuA==
X-Gm-Message-State: APjAAAUD+mMa1pdyMp9cNTj0b9XO1UxI2faR06Gtm4V1zRxyUQeQHT3O
        PgXyvgATDxozTCiw9NacUG8K4Y7O3EoiySngrTzirg==
X-Google-Smtp-Source: APXvYqw6rHeiUiFJPgLV2nZLRO2wFPedXMqbwY4AU85yc+77oWTCo7iuxm3ZNj1wVwAdT+N6Np9t0/htAnPMIOK+cf8=
X-Received: by 2002:aca:f003:: with SMTP id o3mr875487oih.59.1565688375236;
 Tue, 13 Aug 2019 02:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190813060234.11940-1-efremov@linux.com>
In-Reply-To: <20190813060234.11940-1-efremov@linux.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Tue, 13 Aug 2019 11:26:03 +0200
Message-ID: <CAKKE0ZHEsHHTJNx=T4HdPp3j6GTjPh1_Dg+B-O0yfhDYsrM2TQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ftm-quaddec: Fix typo in a filepath
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 13, 2019 at 8:02 AM Denis Efremov <efremov@linux.com> wrote:
>
> Fix typo (s/quadddec/quaddec/) in the path to the documentation.
>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-iio@vger.kernel.org
> Fixes: 517b2d045aeb ("MAINTAINERS: add counter/ftm-quaddec driver entry")
> Signed-off-by: Denis Efremov <efremov@linux.com>
Acked-by: Patrick Havelange <patrick.havelange@essensium.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b4717ea2cfe..f31b852acdf3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6321,7 +6321,7 @@ FLEXTIMER FTM-QUADDEC DRIVER
>  M:     Patrick Havelange <patrick.havelange@essensium.com>
>  L:     linux-iio@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
> +F:     Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
>  F:     Documentation/devicetree/bindings/counter/ftm-quaddec.txt
>  F:     drivers/counter/ftm-quaddec.c
>
> --
> 2.21.0
>
