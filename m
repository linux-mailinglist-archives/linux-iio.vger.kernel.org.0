Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1137105EFE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 04:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKVDZi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Nov 2019 22:25:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43745 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfKVDZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Nov 2019 22:25:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so5245822oie.10
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2019 19:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjaZPGOfYTOY0o/kp53ZeG9BQGmHEKuNZWM3NEtQEM0=;
        b=JOTtqtIbfH8dF/wJembhGFBcKFN9YXpmqiOWecjCHHhvhhrtdINmbMaY0IUAdSXFM5
         4yvILxWOKhkdc4zMRYlyk8qs26qPPuiWxGGAR2M7R9gdwI0LB/yQXl+gIzGYERiS4yI/
         G4RXcWMIuI+aUvalmNXgAa/eJW5z5MfxS9De9b3ESNKtD+btcsG89yUfzGeB9ykIOzch
         RA8bMQDV+3sf63LuhFoxZgejOuQhJr6a7/v4s/FoqjTH2a5VuuH5lpXjFsf8BYjkqdV9
         3E2Df5xrekvtLFaCR3WkGNF2nWUB3tRnLcB60xISE1Z2bP0I+Vvwh6Y1JNYNY8mYurCd
         8otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjaZPGOfYTOY0o/kp53ZeG9BQGmHEKuNZWM3NEtQEM0=;
        b=KGWZyl5FVsvhxp38baGisAP2YG5J17uLAqy6F/pgyV06yJrtFbv0soRDw4Omb+pSq4
         QwE32EdajZb1mV1mqHYW47ph7Kh5T3Hcxy48lsJkh6h5AAMvEuwZE+6JIslt6hbgsn4x
         P6sS0DoMIqPCgCfvyMbhCcQjhSnIJLwRs/vP4amXK6jgWq94Q9Wx2IvzMMnzaOENW5jR
         bCnam3v8zb1kWiHHA9nkVhM0i4v4OowMfrNFGsqY11ZONHHtZs2omAg7/6ErrZB7xY5K
         lNNlT/khVum2sCHSJPfakSfK+x4uTPDaA/WHJ0jDix7+175DwaadHAvL0u/7Zatn6DPR
         b8lQ==
X-Gm-Message-State: APjAAAXIm+VonxBvRUusptRWG5dq6oEZ7ZPv7CV0rkPuHTABmwYGRZKv
        4xanjLKS5kte9C3KHZmdj8LCbsaA8jFmdCnf1qY=
X-Google-Smtp-Source: APXvYqyf7Y80rQ81GQeQqkgmX2DmrmXaQgTx5hn95pM5Uky8ZheeqZgtcuh+4T9+ndyo34nYfCFfFt1H5fSkhIJm8/c=
X-Received: by 2002:a05:6808:8ce:: with SMTP id k14mr10250630oij.76.1574393137486;
 Thu, 21 Nov 2019 19:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20191121203932.17249-1-chris.lesiak@licor.com>
In-Reply-To: <20191121203932.17249-1-chris.lesiak@licor.com>
From:   Matt Ranostay <mranostay@gmail.com>
Date:   Thu, 21 Nov 2019 19:25:01 -0800
Message-ID: <CAKzfze_J35bP2=NKX6Pxd+q6iXS_X5R-ReuwXk=DHBh=qPmDKA@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel reporting
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 21, 2019 at 12:39 PM Chris Lesiak <chris.lesiak@licor.com> wrote:
>
> The IIO_HUMIDITYRELATIVE channel was being incorrectly reported back
> as percent when it should have been milli percent. This is via an
> incorrect scale value being returned to userspace.
>

 **sigh** another failure by me to follow the iio ABI.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 066e05f92081..ff6666ac5d68 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -229,7 +229,7 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>                         *val2 = 65536;
>                         return IIO_VAL_FRACTIONAL;
>                 } else {
> -                       *val = 100;
> +                       *val = 100000;
>                         *val2 = 65536;
>                         return IIO_VAL_FRACTIONAL;
>                 }
> --
> 2.21.0
>
