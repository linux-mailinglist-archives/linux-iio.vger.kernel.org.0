Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D929105
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbfEXGeT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 02:34:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32985 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfEXGeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 02:34:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so7751663otq.0;
        Thu, 23 May 2019 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WweuK19xa24l5W9LMdbztVqMPaDctoIgcKyXzOqKMhE=;
        b=Rx4R/PCrjzbiBEVKS5NJc/b+SHaiNOuSv+5G49HOQQGH6DkE3C1/wTUPfg7sYNHf+U
         YdtBdAp3raM+VpCc7/4rj1on2Tzwbu/jo5h8h+hrKPZCrp4COegxgM4Ih8y/Jx0bMZnQ
         JUujxGiy2IkVnrl4zeP5yj0opuw3jtGp0rytygCyrgfTTD6GNRGFtvjDZPCQbJ8lPUWP
         FUl0gxd5EBNtTqZM+98nzi+i7KkxeNrHQ2kICnbra09Swxh9rMLSB+2n9aY+Pq7oWG3W
         Ik7x26/j0+Tbwknb9ub8x+gKEi1mwqisoGxYCHCs7G1rT0FeQ8pC/+YknKFC9/G57ZdJ
         5LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WweuK19xa24l5W9LMdbztVqMPaDctoIgcKyXzOqKMhE=;
        b=bEMRVeiWeOvjfA4tO4kio5w96YNXDMbqwh2TzlmVibpmkg+iRC7NdK+D4dB28gc6pA
         chXkYpbYOUprPeIQrXi66J0+2G4/5Up1Kqt5tMUxsecvlC3vcFB2Fssk3XldQvA9mLuu
         FuHAcQDyHcVb4a+ru0Ng+i0UhwvD1drUcdgY1j64EAzaGoM4XgC+E4E8oqo+ZKiFtgxP
         /SeZjg5/Op0w3VKq7b9qQe2M1Af754XLoJjLcua4wYqBc4k6PdjmQLOrpcReGg+8TeXo
         ZteqJ/BLfmtCzqQXTELxtwx+0V/OGnD5pL+nD0UYBwH5mIAnSL8fo6gwMc638fZj6kGh
         /gGA==
X-Gm-Message-State: APjAAAXjCazTTHQYJWosFfbr1twlwbBtxQ/+WZnnh5FG7QYJI/q5JdQp
        /8kRXUPiZBb6QID+v+c7imI6jkH9enJtZ8o2Quc=
X-Google-Smtp-Source: APXvYqwO4WAV/RQ6brDgsW2z6/O0nT1SeWLWXXXfQbL7jqStL+jI/RDuC/HbNHoTbPa1sLafu+feh2zqkD9UvOvNj9g=
X-Received: by 2002:a05:6830:1182:: with SMTP id u2mr11542717otq.71.1558679658680;
 Thu, 23 May 2019 23:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190524032950.2398-1-rodrigorsdc@gmail.com>
In-Reply-To: <20190524032950.2398-1-rodrigorsdc@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 24 May 2019 12:34:05 +0300
Message-ID: <CA+U=DspqLFBMrRcV6VmypHOpE6Qs7OqmiDzWAd6pxpA7B=4S4g@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adis16240: add of_match_table entry
To:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 24, 2019 at 6:30 AM Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
>
> This patch adds of_match_table entry in device driver in order to
> enable spi fallback probing.
>
> Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16240.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 8c6d23604eca..b80c8529784b 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -444,6 +444,7 @@ MODULE_DEVICE_TABLE(of, adis16240_of_match);
>  static struct spi_driver adis16240_driver = {
>         .driver = {
>                 .name = "adis16240",
> +               .of_match_table = adis16240_of_match,

This patch is missing the actual table.

>         },
>         .probe = adis16240_probe,
>         .remove = adis16240_remove,
> --
> 2.20.1
>
