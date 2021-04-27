Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9FF36C080
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhD0IEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhD0IEU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:04:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F61DC061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:03:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y1so14772916plg.11
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy9nMNaICBhistA96SfFjG7xjgVUyKaHo+oS7Bxtpgw=;
        b=ETs66fQH6pK0rqtIMZ/Lj97FObcAdHbR0X5UzAGiGGg4WoNvyYPETTnXgCTrJ2bAP4
         MR//F7GiARUQc/Rit5vleN3DwKozpGOlzy8uBYBC4aoNzLKzbaffi48D4frj7w+VZ51M
         MnNz7i844CWJCtr8zN2WMEMlGQufyQEBDfSMJnuYKCyPkWZLOlDeFnn3JbRAGb42/1/b
         CATwmCgLnwvQ+H4tog/LBxbvI2+6Vzv+OqRZ2Lqd+TQd/ZHKWIsCZTkaiYOwYQ8kmw8h
         4C6lVdvUgMrSg58AubIZZIW3Hi0MWof94VrxxnyxM5WxyIrktnbxZpvKOsHThKQJ7kaK
         cB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy9nMNaICBhistA96SfFjG7xjgVUyKaHo+oS7Bxtpgw=;
        b=KHPLohC+SAx1zoJ3s1/k2HP/CTUs2LvRhzAtFq1JZQW9AhGIFQY23WdL11r2RYqFNr
         x68oP1qqpQTAdk4mXtcMtL8JoHesVBcw1DgZfhXEO20ArBqfpZRsGnRVmHpzZQEj+nEG
         1Ujo2MoZMk4eahehndQwVZeFcQnxHALV8riaAc7w95CeuNzhBMNTPnKqlkAITWeJY03d
         O1Rkpd1nVzECmRM+bnWeeIco/msNIZnURShtM8QC+IL5/GHGDliP2l4kWS7HB0+z7nwk
         zTCOlj9dp8BcY/htD6b3mW56xzYdAhEl0csinOLRqiEv6GIRxEmhgonQ3O2WSfBj4NTW
         q2Lg==
X-Gm-Message-State: AOAM531Pr98B8ATOuiC1E/cOXfFPOLbeF2ON1YCuf+vA72/Xw6TYJCBm
        gz/aohzJSQGat4imV8iBwohsXes3r13CPciJors=
X-Google-Smtp-Source: ABdhPJyJlqZyosxdTok69bdWI9lLlZF3F0NPg3MSrTJgRQbFD4xL9VyoM20DwZIWVvfo2UeNrk+wapaHiIABvngOMSM=
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr26638702pjq.86.1619510617068;
 Tue, 27 Apr 2021 01:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-6-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-6-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:03:25 +0300
Message-ID: <CA+U=DspPDvdDF0W14wW2dBuPGu828oSuVJg=1VxqWFV60xFgNQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] iio: core: move @scan_index_timestamp to struct iio_dev_opaque
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 8:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> No reason for this cached value to be exposed to drivers so move it
> to the opaque structure.
>


Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-buffer.c | 7 +++++--
>  include/linux/iio/iio-opaque.h    | 4 ++++
>  include/linux/iio/iio.h           | 2 --
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 9a8e16c7e9af..9ecb3c58d94c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -601,8 +601,10 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
>
>  static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
>         return iio_storage_bytes_for_si(indio_dev,
> -                                       indio_dev->scan_index_timestamp);
> +                                       iio_dev_opaque->scan_index_timestamp);
>  }
>
>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
> @@ -1469,6 +1471,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>                                              struct iio_dev *indio_dev,
>                                              int index)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         struct iio_dev_attr *p;
>         struct attribute **attr;
>         int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
> @@ -1495,7 +1498,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>                                 goto error_cleanup_dynamic;
>                         scan_el_attrcount += ret;
>                         if (channels[i].type == IIO_TIMESTAMP)
> -                               indio_dev->scan_index_timestamp =
> +                               iio_dev_opaque->scan_index_timestamp =
>                                         channels[i].scan_index;
>                 }
>                 if (indio_dev->masklength && buffer->scan_mask == NULL) {
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 10aa97239117..02038fb2d291 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -22,6 +22,7 @@
>   * @groupcounter:              index of next attribute group
>   * @legacy_scan_el_group:      attribute group for legacy scan elements attribute group
>   * @legacy_buffer_group:       attribute group for legacy buffer attributes group
> + * @scan_index_timestamp:      cache of the index to the timestamp
>   * @debugfs_dentry:            device specific debugfs dentry
>   * @cached_reg_addr:           cached register address for debugfs reads
>   * @read_buf:                  read buffer to be used for the initial reg read
> @@ -44,6 +45,9 @@ struct iio_dev_opaque {
>         int                             groupcounter;
>         struct attribute_group          legacy_scan_el_group;
>         struct attribute_group          legacy_buffer_group;
> +
> +       unsigned int                    scan_index_timestamp;
> +
>  #if defined(CONFIG_DEBUG_FS)
>         struct dentry                   *debugfs_dentry;
>         unsigned                        cached_reg_addr;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 672f141f74c5..cbc9e9ece0a6 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -501,7 +501,6 @@ struct iio_buffer_setup_ops {
>   *                     channels
>   * @active_scan_mask:  [INTERN] union of all scan masks requested by buffers
>   * @scan_timestamp:    [INTERN] set if any buffers have requested timestamp
> - * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
>   * @trig:              [INTERN] current device trigger (buffer modes)
>   * @pollfunc:          [DRIVER] function run on trigger being received
>   * @pollfunc_event:    [DRIVER] function run on events trigger being received
> @@ -532,7 +531,6 @@ struct iio_dev {
>         unsigned                        masklength;
>         const unsigned long             *active_scan_mask;
>         bool                            scan_timestamp;
> -       unsigned                        scan_index_timestamp;
>         struct iio_trigger              *trig;
>         struct iio_poll_func            *pollfunc;
>         struct iio_poll_func            *pollfunc_event;
> --
> 2.31.1
>
