Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5743308CC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 08:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhCHH3x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 02:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCHH3v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 02:29:51 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC62C06174A;
        Sun,  7 Mar 2021 23:29:51 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e2so8006688ilu.0;
        Sun, 07 Mar 2021 23:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5H5nrzuIR4RcW9BVBgG2vSdDrTaNCUfMiVLT/XwqOc=;
        b=YCchU6mhDYHgeH5o6551EHQ+B6MKrjCQDFfFrKsrhyt45/U6eFsJnFveDQ18c8a+Wk
         gDAHF8Y+XBe22CRvtbwtT1hVMsP/MXb6TFThGZRgV2eb5j+liYrf8cl3JmZhHiufG9jI
         DUnXluDMYL20qaYDPA2M8bPQec+fH/9oGqaTntcJGSD4gMLr4frd+59JdByTLYhS0Dwp
         XAORzaZ6XoZOjpup1gZFDU8U4RwQn/oVECOs4fINYlGBrsUzmPm+xZtkcogPzXS3mZsT
         fNLhCijGs0NffUPqsq2HHJzQg5bjUyZKIdIR4lIEu31dBXgSW0LhjxVvinXZFYZMciy5
         xQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5H5nrzuIR4RcW9BVBgG2vSdDrTaNCUfMiVLT/XwqOc=;
        b=X2Z40iRoFjDGG/SRYsEEf5G+mEclpQ/AJZxft2KQiTNvZMz9yXV1scRfKc1tvNyQle
         NW9iyzWpGY/65gQb7cHJxRVToEaXaytzIvF44X5L+UtHAWL2i97HFLjYFSWLzvMfTbCm
         wNRMgoJO/lUFZmxdLQPbsMajOWDnobt6ZUpHAj9lK2nbBQ6sE4QLsVUNLXNrWabalCuP
         n9Ni9OykecfhmSCbxmWzXOuuujURgGdwbhVUPMlOHRy92kJ5mQQ/1XWqo8mhhExuvKNa
         9UKxojEwhY5vt5Y00AM/iUvnH3ZtpKmMAmybWOIjNKgF455TfIDjtG/KuesVyHjevT4B
         aINQ==
X-Gm-Message-State: AOAM5329b98imCfVFw2mkI8xzwhA1KSs2yk9ZxZRINQokB+q0J99phoB
        CnhPufhgf/Fpnr4WLToqlJXdmoF/z/Yj0MBkkzwbU11ss5FOEQ==
X-Google-Smtp-Source: ABdhPJxVMi5Iel6Yepp+LvSP6+4j3MNAp44x5tWsfICBiLno8T8Qz21Ge1yEOgcaRnMZ5eJDGmf4WvF3VoN8g4YFitg=
X-Received: by 2002:a05:6e02:138f:: with SMTP id d15mr19153485ilo.217.1615188590479;
 Sun, 07 Mar 2021 23:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20210306164710.9944-1-ardeleanalex@gmail.com> <20210307185444.32924-1-ardeleanalex@gmail.com>
In-Reply-To: <20210307185444.32924-1-ardeleanalex@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Mar 2021 09:29:39 +0200
Message-ID: <CA+U=DsoutVL5yeV_piZLJBSkUrMwTRZurUqW=mrZ-S-=LVw2VQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: buffer: fix use-after-free for attached_buffers array
To:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 7, 2021 at 8:55 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> Thanks to Lars for finding this.
> The free of the 'attached_buffers' array should be done as late as
> possible. This change moves it to iio_buffers_put(), which looks like
> the best place for it, since it takes place right before the IIO device
> data is free'd.
> The free of this array will be handled by calling iio_device_free().
> The iio_buffers_put() function is renamed to iio_device_detach_buffers()
> since the role of this function changes a bit.
>
> It looks like this issue was ocurring on the error path of
> iio_buffers_alloc_sysfs_and_mask() and in
> iio_buffers_free_sysfs_and_mask()
>
> Added a comment in the doc-header of iio_device_attach_buffer() to
> mention how this will be free'd in case anyone is reading the code
> and becoming confused about it.
>
> Fixes: 36f3118c414d ("iio: buffer: introduce support for attaching more IIO buffers")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---

Forgot the changelog.

Changelog v1 -> v2:
* rename iio_buffers_put() -> iio_device_detach_buffers()

>  drivers/iio/iio_core.h            | 4 ++--
>  drivers/iio/industrialio-buffer.c | 9 +++++----
>  drivers/iio/industrialio-core.c   | 2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 062fe16c6c49..8f4a9b264962 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -77,7 +77,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
>
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> -void iio_buffers_put(struct iio_dev *indio_dev);
> +void iio_device_detach_buffers(struct iio_dev *indio_dev);
>
>  #else
>
> @@ -93,7 +93,7 @@ static inline void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
>
>  static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
>  static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
> -static inline void iio_buffers_put(struct iio_dev *indio_dev) {}
> +static inline void iio_device_detach_buffers(struct iio_dev *indio_dev) {}
>
>  #endif
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 1a415e97174e..1ff7f731b044 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -326,7 +326,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL(iio_buffer_init);
>
> -void iio_buffers_put(struct iio_dev *indio_dev)
> +void iio_device_detach_buffers(struct iio_dev *indio_dev)
>  {
>         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         struct iio_buffer *buffer;
> @@ -336,6 +336,8 @@ void iio_buffers_put(struct iio_dev *indio_dev)
>                 buffer = iio_dev_opaque->attached_buffers[i];
>                 iio_buffer_put(buffer);
>         }
> +
> +       kfree(iio_dev_opaque->attached_buffers);
>  }
>
>  static ssize_t iio_show_scan_index(struct device *dev,
> @@ -1764,7 +1766,6 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>                 buffer = iio_dev_opaque->attached_buffers[unwind_idx];
>                 __iio_buffer_free_sysfs_and_mask(buffer);
>         }
> -       kfree(iio_dev_opaque->attached_buffers);
>         return ret;
>  }
>
> @@ -1786,8 +1787,6 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
>                 buffer = iio_dev_opaque->attached_buffers[i];
>                 __iio_buffer_free_sysfs_and_mask(buffer);
>         }
> -
> -       kfree(iio_dev_opaque->attached_buffers);
>  }
>
>  /**
> @@ -2062,6 +2061,8 @@ static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
>   * This function attaches a buffer to a IIO device. The buffer stays attached to
>   * the device until the device is freed. For legacy reasons, the first attached
>   * buffer will also be assigned to 'indio_dev->buffer'.
> + * The array allocated here, will be free'd via the iio_device_detach_buffers()
> + * call which is handled by the iio_device_free().
>   */
>  int iio_device_attach_buffer(struct iio_dev *indio_dev,
>                              struct iio_buffer *buffer)
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d74fbac908df..3be5f75c2846 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1587,7 +1587,7 @@ static void iio_dev_release(struct device *device)
>         iio_device_unregister_eventset(indio_dev);
>         iio_device_unregister_sysfs(indio_dev);
>
> -       iio_buffers_put(indio_dev);
> +       iio_device_detach_buffers(indio_dev);
>
>         ida_simple_remove(&iio_ida, indio_dev->id);
>         kfree(iio_dev_opaque);
> --
> 2.25.1
>
