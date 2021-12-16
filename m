Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F027476B30
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhLPHst (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 02:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbhLPHss (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 02:48:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9FC061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:48:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id j11so22357827pgs.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5Ano8NpCXr+Gf9VuSmZWf3k/DDn2mDjYZvPbsAQ6ts=;
        b=a9NuXmWBhVwjdzAYa6nZdCroWpYGsrvHiDWWGUH1xKsV83oeVOBS8+PUDsdhTlVIUW
         WwhXo59zHlZRanDDSR4hfiMfKdqsv3TRm2tEmvKLtRsSylUd/MBSb0ais3RyYfn292RB
         +DKlTL2UWPtMQOEv9PRqt75hmAZ8bzmTGe5GD+tSg3C4kY8v+/a+EdCjSHVjZ3N814zY
         tYJ7qVzhaXchtfy2GO3r4x6b+tRtEvDdLLL7U/FFmPQvzsWYT7HafXeM23okwYfC1O5z
         MGSLjzg+IDLSBTtqX3GO+54EY76L2RmoetmJEmndg9FyQbrVfR3W3b1CFWRt2CB3WeEn
         SNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5Ano8NpCXr+Gf9VuSmZWf3k/DDn2mDjYZvPbsAQ6ts=;
        b=TQq4Yc/barluQ4zc9+FNkGvEawDKqC/4lNEnvGDXK552byfdEX+yS/59nrSotjgegP
         KW1qFQYhQCRa2jSjjbAsM5aLv4WMIarslnbGE7OucYaQDhZxzeRI2RqtRcqvbBlrV5sC
         YADZKPUv8Ipg8sIOgOx17z9E2nI2PN83h1RBz5TWUK/Pbq7/96OQy6HeOTN4B9uI8/+w
         /ghUy7uZ5WFgFrObCq9nfU01BeqtBWufbHGorHwyIFkaVRwG6x3lScjQLLV7GDTCiXpp
         tRhoc3VIhzGcz9xZn70SM4ug7T04J3xtq0Br6C4ST61HTdycm3bX7G3HhX/FjxYiasUw
         e5vA==
X-Gm-Message-State: AOAM533y+rxjGObzdm8FHFriKAEXrKYKy1Fabo2XKseyAu04P5M+IVMI
        rr/yTsknLr7Mpp8Bg9dOBjgZ16qpvDem/iFGK8s=
X-Google-Smtp-Source: ABdhPJw37nSL/+aWzXPk0a5OznA08D0osWEUYbz0mFmkEn+5CCTXC0nDwFkHPpx2wV6iS5NjK7wbUCbW9Bf63Qlu1ag=
X-Received: by 2002:a63:6886:: with SMTP id d128mr4292956pgc.418.1639640928186;
 Wed, 15 Dec 2021 23:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-9-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-9-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 09:48:36 +0200
Message-ID: <CA+U=DsoMLD1EpK7yDXaQ_HwTQgm_TeZvM_eykE6jWYgg6P3Y7w@mail.gmail.com>
Subject: Re: [PATCH 08/10] iio: core: Move iio_dev->currentmode to the opaque structure
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This entry should, under no situation, be modified by device
> drivers. Now that we have limited its read access to device drivers
> really needing it, and handled modifications through another dedicated
> helper within the core, we can easily move this variable to the opaque
> structure as well as the write helper in order to prevent device driver
> from playing with it.
>

Ah, the set-helper becomes inline.

The helpers make more sense now.

[ regardless of the naming of the helpers]
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/industrialio-core.c | 15 +++------------
>  include/linux/iio/iio-opaque.h  | 16 ++++++++++++++++
>  include/linux/iio/iio.h         |  5 -----
>  3 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 5c7e0c9e1f59..9836a57ff151 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2064,21 +2064,12 @@ EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
>   **/
>  int iio_get_internal_mode(struct iio_dev *indio_dev)
>  {
> -       return indio_dev->currentmode;
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +       return iio_dev_opaque->currentmode;
>  }
>  EXPORT_SYMBOL_GPL(iio_get_internal_mode);
>
> -/**
> - * iio_set_internal_mode() - helper function providing write-only access to the
> - *                          internal @currentmode variable
> - * @indio_dev:         IIO device structure for device
> - **/
> -void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> -{
> -       indio_dev->currentmode = mode;
> -}
> -EXPORT_SYMBOL_GPL(iio_set_internal_mode);
> -
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 2be12b7b5dc5..72f35270a387 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -7,6 +7,9 @@
>   * struct iio_dev_opaque - industrial I/O device opaque information
>   * @indio_dev:                 public industrial I/O device information
>   * @id:                        used to identify device internally
> + * @currentmode:               operating mode currently in use, may be eventually
> + *                             checked by device drivers but should be considered
> + *                             read-only as this is a core internal bit
>   * @driver_module:             used to make it harder to undercut users
>   * @info_exist_lock:           lock to prevent use during removal
>   * @trig_readonly:             mark the current trigger immutable
> @@ -36,6 +39,7 @@
>   */
>  struct iio_dev_opaque {
>         struct iio_dev                  indio_dev;
> +       int                             currentmode;
>         int                             id;
>         struct module                   *driver_module;
>         struct mutex                    info_exist_lock;
> @@ -71,4 +75,16 @@ struct iio_dev_opaque {
>  #define to_iio_dev_opaque(_indio_dev)          \
>         container_of((_indio_dev), struct iio_dev_opaque, indio_dev)
>
> +/**
> + * iio_set_internal_mode() - helper function providing write-only access to the
> + *                          internal @currentmode variable
> + * @indio_dev:         IIO device structure for device
> + **/
> +static inline void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> +{
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +       iio_dev_opaque->currentmode = mode;
> +}
> +
>  #endif
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 27551d251904..d04ab89fa0c2 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -492,9 +492,6 @@ struct iio_buffer_setup_ops {
>   *                     registering the IIO device and can be filed up by the
>   *                     IIO core depending on the features advertised by the
>   *                     driver during other steps of the registration
> - * @currentmode:       [INTERN] operating mode currently in use, may be
> - *                     eventually checked by device drivers but should be
> - *                     considered read-only as this is a core internal bit
>   * @dev:               [DRIVER] device structure, should be assigned a parent
>   *                     and owner
>   * @buffer:            [DRIVER] any buffer present
> @@ -521,7 +518,6 @@ struct iio_buffer_setup_ops {
>   */
>  struct iio_dev {
>         int                             modes;
> -       int                             currentmode;
>         struct device                   dev;
>
>         struct iio_buffer               *buffer;
> @@ -679,7 +675,6 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
>                                            const char *fmt, ...);
>
>  int iio_get_internal_mode(struct iio_dev *indio_dev);
> -void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
>
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
> --
> 2.27.0
>
