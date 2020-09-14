Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67E268441
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgINFwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 01:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgINFwb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 01:52:31 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288FC06174A
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2020 22:52:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d189so16583336oig.12
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2020 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnIDDp6+nNnmGGvGsV03RPXkG6VIqZ7Dah2p4SdkLDs=;
        b=Faz+ImWVM4mDFuKyA1LCRRKNZaR18rzAv4mj3qUr8oA48r7tB2RJT/7xG5afr+zNPo
         gfwSEpEOh3kbnjx6MQ2aF26zsUpIMy4du4HwJO/IcmUsfd18VOqCVAjeU82E2nhb3OIh
         yAZ7XWEDkKvK+lzO+wdp1sX4AIrvReFueMN9r3WuLOkeVjaDtSk9+ujURPKF2072rr7w
         nC7uzJJECdda36b4Zs2m5YJjbPVtU1MLQ3ezur4CjOsOgR6qRiXpBNU+Ua3D1v7Wd/ok
         B60LJyHGhEISKDfSwvXW8oECuqzdMxi3cVK+jTGakEll8KJFoX0qiH93LgLqB2ALmsJQ
         336w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnIDDp6+nNnmGGvGsV03RPXkG6VIqZ7Dah2p4SdkLDs=;
        b=r3PNFchDKkrgUUZWJYQjZwIPr1uU1GA3OIzGIcoAwNtqJqveFLdOec3onKA1EW5E2t
         Z7COWvGCFE5mNSUV2AN0lglgpx4VPDqf5vyQ0oq/QQImkuL2Bd4de1sD5KctezxTGAkb
         UIZECN9lmng2FPH1cI3ZFJ8X1lkloulRJC90Fg9GOVA8z++zgO4X2GJ5KvokcLQZMPwn
         aO0DjTelk7+O6mmnLv8mu6yadf2Oh+xRljAbkgX4GOi5Pwjx64mYbrhnoP7Zz/sLd1gV
         2UJvtN71dzR6zCa9LgH7X4o0414MRYJsMiLeuK5cMQ5DUZmFe1vCnHiWQpOu4q8WMPQ0
         nyVw==
X-Gm-Message-State: AOAM533HUuWxoztGv8od7F5WZ7HxgbL2OtSdoTE5OK2k3t5ZcIxU0/RH
        pRLZVGVx3dsCTYvMzOEyC8l/Wtsk8nVZyM59GVc=
X-Google-Smtp-Source: ABdhPJw0UOtyPjUupSE3l/bXDAuK1uhTxJhO58sur9l7ZFY300mKns9yb0XsMetcm2hHUZMUZFc+A+K1MVfCdHZIsP0=
X-Received: by 2002:aca:72ca:: with SMTP id p193mr7515351oic.124.1600062765431;
 Sun, 13 Sep 2020 22:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200913132115.800131-1-jic23@kernel.org> <20200913132115.800131-2-jic23@kernel.org>
In-Reply-To: <20200913132115.800131-2-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 14 Sep 2020 08:52:34 +0300
Message-ID: <CA+U=DsougYec6z-4qmbuKE8XkFzB2PUwwmxPGoUtcN+5cDep4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio:imu:adis16400: Sort out missing kernel doc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 13, 2020 at 4:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I'd like to be enable W=1 for all IIO builds as it catches real issues as well
> as more minor documentation issues such as this (also good to fix though!)
>
> drivers/iio/imu/adis16400.c:183: warning: Function parameter or member 'avail_scan_mask' not described in 'adis16400_state'
>

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/imu/adis16400.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 1ebe3e50d3e6..140cfc65ee8c 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -173,6 +173,8 @@ struct adis16400_chip_info {
>   * @variant:   chip variant info
>   * @filt_int:  integer part of requested filter frequency
>   * @adis:      adis device
> + * @avail_scan_mask:   NULL terminated array of bitmaps of channels
> + *                     that must be enabled together
>   **/
>  struct adis16400_state {
>         struct adis16400_chip_info      *variant;
> --
> 2.28.0
>
