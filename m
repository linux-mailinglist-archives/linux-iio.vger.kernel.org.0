Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF32918CE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJRSWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgJRSWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 14:22:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B223CC061755;
        Sun, 18 Oct 2020 11:22:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so4303283pjr.3;
        Sun, 18 Oct 2020 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY5ozoK35dRnsBBWPfOvH0U314VRK+4OEsZHw3VNig4=;
        b=cQr9ttHhvapYCUz+VPP9SA8DkrjAg3KcoyOdt8AGWI2S5vlVuZqUHYvA4y1s8TFd1n
         kKXJ3Uz8d6h0HR2EbS78JBu2J89I7WgyTYq1jp9jSWmw9JXr8zxjPBW8nEVz6UP+r5Ox
         fIWE69FB1PnOCqKGZXMNb2DF5j1T0kKrVAnrKWK/GVDwfuyA6yAKwD/kdGD6vxItqBnk
         9yuXTsvBA5AONiYOZMnRAHxO5riIG5WRu3aaZ1recO2ky98psDl2zKg5iAJttoUXqzPY
         kFROsIKia9Ao6yQP+AEz/67MkZn7KCtXiFUXcbYtpXHgCtwPCFEguv/HUn6FDnas1qsg
         9o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY5ozoK35dRnsBBWPfOvH0U314VRK+4OEsZHw3VNig4=;
        b=Ioo9dQ+ohnavZEYSSvWCCaO1XHnsn56OET0R38dKwKbinAM/VixyVJNk3gR8RBPZe2
         99BAn6vKrE+kvBZEOeUst1/fwjX/AmhnaXbihzeQJFHcgS9UF98EO05na6e5Ki+B0GNk
         lVcemVkwla15ZGTQHhpZHDx8zP3AtS+dB/hca+9mK00wzblyCPN0+hv2BI5wa+oYwgrQ
         VBr7F53hRqOmB+7r+UONudEJk5A2zAYiABzv0t3w1P0MNt1MtB9EJ4pxg4boSQFeNHAJ
         LyOt0XF7u3r8pSrnMAd4p8XgxGwham1YQltixDYSjdDaJWghHRfy3D7yM8RI2MkHbQnG
         5xwQ==
X-Gm-Message-State: AOAM532y28JsFbc5MdV0wcXWPomOMBYMAAvD1rSMrEFztI7xaxPHXTif
        QjLsy8jMVbQZ+IA5OaeM6dsbLq9MNfBn+qDp5/U=
X-Google-Smtp-Source: ABdhPJzziWgcBdW4Gqfv/w3u1LFvfuJxbfkeyl1rvFENQL/8QBWnJtxQH+3Rih3k2WOZNL+/XdNjn/hPOaD6F+GiVf0=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr13468957pjs.181.1603045332185;
 Sun, 18 Oct 2020 11:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
 <1602983516-22913-1-git-send-email-LinoSanfilippo@gmx.de> <1602983516-22913-2-git-send-email-LinoSanfilippo@gmx.de>
In-Reply-To: <1602983516-22913-2-git-send-email-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 21:21:56 +0300
Message-ID: <CAHp75VcJGMNnU4j8S=J5wk1yTMgDLJcg-SD9Nh415L_TJju9zA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio:core: Introduce unlocked version of iio_map_array_unregister()
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 4:13 AM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
>
> Introduce an unlocked version of iio_map_array_unregister(). This function
> can help to unwind in case of error while the iio_map_list_lock mutex is
> held.

Both looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

if Jonathan is okay with them.

> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>  drivers/iio/inkern.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ede99e0..39c1d63 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -24,6 +24,21 @@ struct iio_map_internal {
>  static LIST_HEAD(iio_map_list);
>  static DEFINE_MUTEX(iio_map_list_lock);
>
> +static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
> +{
> +       int ret = -ENODEV;
> +       struct iio_map_internal *mapi, *next;
> +
> +       list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
> +               if (indio_dev == mapi->indio_dev) {
> +                       list_del(&mapi->l);
> +                       kfree(mapi);
> +                       ret = 0;
> +               }
> +       }
> +       return ret;
> +}
> +
>  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
>         int i = 0, ret = 0;
> @@ -57,18 +72,12 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
>   */
>  int iio_map_array_unregister(struct iio_dev *indio_dev)
>  {
> -       int ret = -ENODEV;
> -       struct iio_map_internal *mapi, *next;
> +       int ret;
>
>         mutex_lock(&iio_map_list_lock);
> -       list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
> -               if (indio_dev == mapi->indio_dev) {
> -                       list_del(&mapi->l);
> -                       kfree(mapi);
> -                       ret = 0;
> -               }
> -       }
> +       ret = iio_map_array_unregister_locked(indio_dev);
>         mutex_unlock(&iio_map_list_lock);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(iio_map_array_unregister);
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
