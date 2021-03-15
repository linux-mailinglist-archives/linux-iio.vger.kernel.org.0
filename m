Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22C33ACE0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 08:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCOH53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhCOH5I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 03:57:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0915CC061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:57:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o11so32436751iob.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Czj+quBHCqKhps1Re3ZcrIIxNeHMa3VxY46tAQeChQ=;
        b=JAz1VacwcTDqwKQMgKUmlT8sjnc+tHaX0/blAHqP8PuFgk3BhGgSNzJf2JHCcvntsA
         I6sHoJnQyQ2q/KSHoKP6SWppp22YrbL+AY0l97QApprUVzD4RuOHtDqT+wuE86bKhT04
         cp+WInGL83LRVZk5E0sjXT7w06Fp0Nbo4oR4cnoSqu/EQgvFBm/iR/CtolLKQWdcA/JL
         EV/beO4dH+v8UmrMSHsSqCd4CCGA6qKdRWfGl7QKi4H51yAWyvTCvA1MprDmJ9Bn7nVr
         VGbw0Sttej2wFINGhmusOme0ctyEZv6hTyzEE7cIo+nEg7/1RiDHnAjV6H6DmD69f6Qb
         2zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Czj+quBHCqKhps1Re3ZcrIIxNeHMa3VxY46tAQeChQ=;
        b=ort4d0jbR07XhxDrOdevOCCGw7B1u3pXXStHbQhBaAz1at8GN+z+8ih5zdw78Wk7Fc
         MkdhQtyA5iZ4ebX/v2aIJwMaRXax28HZuTpGuCrURtSBTQrM/7I32tgRcF0U67dQnV+y
         WdxTeBAT6W5RSpNTlmk+34UfW0uXKWKF0rGbUYxf1Cc0afJdxVLZMQo1hNthKWTR7b0H
         acHzS3AxNg41nLm5jfT2R1QWppPzvBGdTNpIhKQuui8JAURFj7g33l8PyoU0Zy99l0nX
         o+t+pujqMMUDKWsv1Nqfo70wIjopRWduFaIJ09PqHiASeewRXAmNAhPYZrLYP9WdkUaW
         LQEg==
X-Gm-Message-State: AOAM532mDIbPkjf6ml+h4NJz5MhKny2diB1Z4zaIB9n/AJhXQMAzvohV
        lieAubcKWKQ/PXmXY8MgKMwxBejcGEaGe2ITr/0=
X-Google-Smtp-Source: ABdhPJwgGtOj5AV3sKkjYjTrIuhq1uA5Ms2Zbg2siOStwDHGMMjS7H0moznBZNO9tiQdK2qmeQmnLBCw9fJMFtYE3C8=
X-Received: by 2002:a05:6638:91:: with SMTP id v17mr8276637jao.69.1615795027539;
 Mon, 15 Mar 2021 00:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210314164655.408461-1-jic23@kernel.org> <20210314164655.408461-4-jic23@kernel.org>
In-Reply-To: <20210314164655.408461-4-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Mar 2021 09:56:56 +0200
Message-ID: <CA+U=Dsrk8CAROmNFXPDEMdBWKZfUkeqO5pqCeMDqxZDCeACrQg@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: dac: ad5770r: kernel-doc fix case of letter R
 wrong in structure name
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 6:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Nothing useful to add beyond this causing a warning with W=1
>

Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---
>  drivers/iio/dac/ad5770r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index 84dcf149261f..4e7a8ed83cc1 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -118,7 +118,7 @@ struct ad5770r_out_range {
>  };
>
>  /**
> - * struct ad5770R_state - driver instance specific data
> + * struct ad5770r_state - driver instance specific data
>   * @spi:               spi_device
>   * @regmap:            regmap
>   * @vref_reg:          fixed regulator for reference configuration
> --
> 2.30.2
>
