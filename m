Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308F3F7127
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhHYIgE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhHYIgD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 04:36:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524AEC061757;
        Wed, 25 Aug 2021 01:35:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 18so20637180pfh.9;
        Wed, 25 Aug 2021 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytE9mOWAlah10zDnFQHKw2rTefoO0zuG4LcfP+0Qd+0=;
        b=pXcyD5z+BAaAEyCjqkAjLDY6VuYtpppDKB7p56gE0WdqxXizzMEzhxrdD9/o+F+IPz
         sWHm3O/1ndg1EngAk9pXM7qiIDJhGjqFODgCNHOwPImdHeZxAAu9ylquHnpFt0uEmzub
         tf2qtV86SjJAc1Fqji4T7M8sb92T5Oj9Ou6QJQYorD4/YO13ZxCTzTUwgiZpZEVDMnW6
         t0Hhlaw4iKDnzp1tltEWCD7rIx4iDSLWu2ORmR4x1nLEQSKPQVLgarhJUvm/wiXrLOoq
         K6b8nUX/blGMwtTlW3KRu7M7hNhYmC6FUxUhkEE8UpHrYHUmllnRDYWaeDeibzSoFcw0
         WrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytE9mOWAlah10zDnFQHKw2rTefoO0zuG4LcfP+0Qd+0=;
        b=djwzUAUKR/anfzo/tTg5KGG7KPCI/wDiP+XtNzyKIa1l6FE0FskHg/KgR7oyrLNDIB
         ZMt3hZ0YiVdZ7nuwNOseuC5T+5bW25uT1BYhfCyrTjdcjYDi6OaZJcX8B53dhIGGnBLT
         Fmc+LB6amamFjCre/ZrX/J92AOIzpSMt8Baa4gfMY5DP4xBnJPkCQ8RrxZrDNx+sLahZ
         Q6D6pr9tZjEzo4w0qVXi8BKvvJyzngp9e+Agk60HV9B9lARlLmMGFt5mS1qeUXBxvDk7
         bQ+ScL9I3ed25ByDNpC6cp/4k04dqebvjtIv1COq56XogugzORHYJDAEajNBMnnKjr1B
         7VlQ==
X-Gm-Message-State: AOAM531wb5GQrN6wguSGYI7TuIaw8gd2LIgKy1k4T1HZ95qJMhYZO/V6
        IhoLoB3wE39dNVBPT7pgWnCf+PEaNakTQBY85I0=
X-Google-Smtp-Source: ABdhPJyMQtZ0wPf2vcScYbLJI3JlaoSsuxeLlqVgTKGe9qmrwgQXrl3xxWss0pne3Vz1n/jkN5nF/1fOSjI103A+jv8=
X-Received: by 2002:aa7:9254:0:b029:3c9:268e:ae68 with SMTP id
 20-20020aa792540000b02903c9268eae68mr43426456pfp.58.1629880517810; Wed, 25
 Aug 2021 01:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210820165927.4524-1-mihail.chindris@analog.com> <20210820165927.4524-2-mihail.chindris@analog.com>
In-Reply-To: <20210820165927.4524-2-mihail.chindris@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 25 Aug 2021 11:35:06 +0300
Message-ID: <CA+U=DsqcOcKmgM2A0w+jcafe_8VTaDNmuYkbhVo1UeoxFyNijg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] iio: Add output buffer support
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 8:01 PM Mihail Chindris
<mihail.chindris@analog.com> wrote:
>
> From: Lars-Peter Clausen <lars@metafoo.de>
>
> Currently IIO only supports buffer mode for capture devices like ADCs. Add
> support for buffered mode for output devices like DACs.
>
> The output buffer implementation is analogous to the input buffer
> implementation. Instead of using read() to get data from the buffer write()
> is used to copy data into the buffer.
>
> poll() with POLLOUT will wakeup if there is space available for more or
> equal to the configured watermark of samples.
>
> Drivers can remove data from a buffer using iio_buffer_remove_sample(), the
> function can e.g. called from a trigger handler to write the data to
> hardware.
>
> A buffer can only be either a output buffer or an input, but not both. So,
> for a device that has an ADC and DAC path, this will mean 2 IIO buffers
> (one for each direction).
>
> The direction of the buffer is decided by the new direction field of the
> iio_buffer struct and should be set after allocating and before registering
> it.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/iio_core.h            |   4 +
>  drivers/iio/industrialio-buffer.c | 133 +++++++++++++++++++++++++++++-
>  drivers/iio/industrialio-core.c   |   1 +
>  include/linux/iio/buffer.h        |   7 ++
>  include/linux/iio/buffer_impl.h   |  11 +++
>  5 files changed, 154 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 8f4a9b264962..61e318431de9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *filp,
>                                  struct poll_table_struct *wait);
>  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
>                                 size_t n, loff_t *f_ps);
> +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
> +                                size_t n, loff_t *f_ps);
>
>  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
>  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
>
>  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
>  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
>
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev *indio_dev);
>
>  #define iio_buffer_poll_addr NULL
>  #define iio_buffer_read_outer_addr NULL
> +#define iio_buffer_write_outer_addr NULL
>
>  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a95cc2da56be..73d4451a0572 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -161,6 +161,69 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
>         return ret;
>  }
>
> +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> +{
> +       if (buf->access->space_available)
> +               return buf->access->space_available(buf);
> +
> +       return SIZE_MAX;
> +}
> +
> +static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
> +                               size_t n, loff_t *f_ps)
> +{
> +       struct iio_dev_buffer_pair *ib = filp->private_data;
> +       struct iio_buffer *rb = ib->buffer;
> +       struct iio_dev *indio_dev = ib->indio_dev;
> +       DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +       size_t datum_size;
> +       size_t to_wait;
> +       int ret;
> +
> +       if (!rb || !rb->access->write)
> +               return -EINVAL;
> +
> +       datum_size = rb->bytes_per_datum;
> +
> +       /*
> +        * If datum_size is 0 there will never be anything to read from the
> +        * buffer, so signal end of file now.
> +        */
> +       if (!datum_size)
> +               return 0;
> +
> +       if (filp->f_flags & O_NONBLOCK)
> +               to_wait = 0;
> +       else
> +               to_wait = min_t(size_t, n / datum_size, rb->watermark);
> +
> +       add_wait_queue(&rb->pollq, &wait);
> +       do {
> +               if (!indio_dev->info) {
> +                       ret = -ENODEV;
> +                       break;
> +               }
> +
> +               if (iio_buffer_space_available(rb) < to_wait) {
> +                       if (signal_pending(current)) {
> +                               ret = -ERESTARTSYS;
> +                               break;
> +                       }
> +
> +                       wait_woken(&wait, TASK_INTERRUPTIBLE,
> +                                  MAX_SCHEDULE_TIMEOUT);
> +                       continue;
> +               }
> +
> +               ret = rb->access->write(rb, n, buf);
> +               if (ret == 0 && (filp->f_flags & O_NONBLOCK))
> +                       ret = -EAGAIN;
> +       } while (ret == 0);
> +       remove_wait_queue(&rb->pollq, &wait);
> +
> +       return ret;
> +}
> +
>  /**
>   * iio_buffer_poll() - poll the buffer to find out if it has data
>   * @filp:      File structure pointer for device access
> @@ -181,8 +244,18 @@ static __poll_t iio_buffer_poll(struct file *filp,
>                 return 0;
>
>         poll_wait(filp, &rb->pollq, wait);
> -       if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> -               return EPOLLIN | EPOLLRDNORM;
> +
> +       switch (rb->direction) {
> +       case IIO_BUFFER_DIRECTION_IN:
> +               if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> +                       return EPOLLIN | EPOLLRDNORM;
> +               break;
> +       case IIO_BUFFER_DIRECTION_OUT:
> +               if (iio_buffer_space_available(rb) >= rb->watermark)
> +                       return EPOLLOUT | EPOLLWRNORM;
> +               break;
> +       }
> +
>         return 0;
>  }
>
> @@ -199,6 +272,19 @@ ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
>         return iio_buffer_read(filp, buf, n, f_ps);
>  }
>
> +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
> +                                size_t n, loff_t *f_ps)
> +{

I was wondering about adding this wrapper or not.
It's technically allowing some classical buffer access for DACs by
just writing to the /dev/iio:deviceX chardev.
Which should be fine.
And [personally] I do like this convenience for simple DACs.

> +       struct iio_dev_buffer_pair *ib = filp->private_data;
> +       struct iio_buffer *rb = ib->buffer;
> +
> +       /* check if buffer was opened through new API */
> +       if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> +               return -EBUSY;
> +
> +       return iio_buffer_write(filp, buf, n, f_ps);
> +}
> +
>  __poll_t iio_buffer_poll_wrapper(struct file *filp,
>                                  struct poll_table_struct *wait)
>  {
> @@ -231,6 +317,15 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
>         }
>  }
>
> +int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data)
> +{
> +       if (!buffer || !buffer->access || buffer->access->remove_from)
> +               return -EINVAL;
> +
> +       return buffer->access->remove_from(buffer, data);
> +}
> +EXPORT_SYMBOL_GPL(iio_buffer_remove_sample);
> +
>  void iio_buffer_init(struct iio_buffer *buffer)
>  {
>         INIT_LIST_HEAD(&buffer->demux_list);
> @@ -807,6 +902,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>         }
>
>         if (insert_buffer) {
> +               if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
> +                       strict_scanmask = true;
>                 bitmap_or(compound_mask, compound_mask,
>                           insert_buffer->scan_mask, indio_dev->masklength);
>                 scan_timestamp |= insert_buffer->scan_timestamp;
> @@ -948,6 +1045,8 @@ static int iio_update_demux(struct iio_dev *indio_dev)
>         int ret;
>
>         list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
> +               if (buffer->direction == IIO_BUFFER_DIRECTION_OUT)
> +                       continue;
>                 ret = iio_buffer_update_demux(indio_dev, buffer);
>                 if (ret < 0)
>                         goto error_clear_mux_table;
> @@ -1159,6 +1258,11 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
>         mutex_lock(&indio_dev->mlock);
>
> +       if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT) {
> +               ret = -EINVAL;
> +               goto out_unlock;
> +       }
> +
>         if (insert_buffer && iio_buffer_is_active(insert_buffer))
>                 insert_buffer = NULL;
>
> @@ -1277,6 +1381,22 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
>         return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
>  }
>
> +static ssize_t direction_show(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf)
> +{
> +       struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> +
> +       switch (buffer->direction) {
> +       case IIO_BUFFER_DIRECTION_IN:
> +               return sprintf(buf, "in\n");
> +       case IIO_BUFFER_DIRECTION_OUT:
> +               return sprintf(buf, "out\n");
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>                    iio_buffer_write_length);
>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> @@ -1289,12 +1409,20 @@ static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
>         S_IRUGO, iio_buffer_show_watermark, NULL);
>  static DEVICE_ATTR(data_available, S_IRUGO,
>                 iio_dma_show_data_available, NULL);
> +static DEVICE_ATTR_RO(direction);
>
> +/**
> + * When adding new attributes here, put the at the end, at least until
> + * the code that handles the lengh/length_ro & watermark/watermark_ro
> + * assignments gets cleaned up. Otherwise these can create some weird
> + * duplicate attributes errors under some setups.
> + */
>  static struct attribute *iio_buffer_attrs[] = {
>         &dev_attr_length.attr,
>         &dev_attr_enable.attr,
>         &dev_attr_watermark.attr,
>         &dev_attr_data_available.attr,
> +       &dev_attr_direction.attr,
>  };
>
>  #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> @@ -1397,6 +1525,7 @@ static const struct file_operations iio_buffer_chrdev_fileops = {
>         .owner = THIS_MODULE,
>         .llseek = noop_llseek,
>         .read = iio_buffer_read,
> +       .write = iio_buffer_write,
>         .poll = iio_buffer_poll,
>         .release = iio_buffer_chrdev_release,
>  };
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dbb37e09b8c..537a08549a69 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1822,6 +1822,7 @@ static const struct file_operations iio_buffer_fileops = {
>         .owner = THIS_MODULE,
>         .llseek = noop_llseek,
>         .read = iio_buffer_read_outer_addr,
> +       .write = iio_buffer_write_outer_addr,
>         .poll = iio_buffer_poll_addr,
>         .unlocked_ioctl = iio_ioctl,
>         .compat_ioctl = compat_ptr_ioctl,
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index b6928ac5c63d..e87b8773253d 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -11,8 +11,15 @@
>
>  struct iio_buffer;
>
> +enum iio_buffer_direction {
> +       IIO_BUFFER_DIRECTION_IN,
> +       IIO_BUFFER_DIRECTION_OUT,
> +};
> +
>  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
>
> +int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data);
> +
>  /**
>   * iio_push_to_buffers_with_timestamp() - push data and timestamp to buffers
>   * @indio_dev:         iio_dev structure for device.
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 245b32918ae1..8a44c5321e19 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -7,6 +7,7 @@
>  #ifdef CONFIG_IIO_BUFFER
>
>  #include <uapi/linux/iio/buffer.h>
> +#include <linux/iio/buffer.h>
>
>  struct iio_dev;
>  struct iio_buffer;
> @@ -23,6 +24,10 @@ struct iio_buffer;
>   * @read:              try to get a specified number of bytes (must exist)
>   * @data_available:    indicates how much data is available for reading from
>   *                     the buffer.
> + * @remove_from:       remove sample from buffer. Drivers should calls this to
> + *                     remove a sample from a buffer.
> + * @write:             try to write a number of bytes
> + * @space_available:   returns the amount of bytes available in a buffer
>   * @request_update:    if a parameter change has been marked, update underlying
>   *                     storage.
>   * @set_bytes_per_datum:set number of bytes per datum
> @@ -49,6 +54,9 @@ struct iio_buffer_access_funcs {
>         int (*store_to)(struct iio_buffer *buffer, const void *data);
>         int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
>         size_t (*data_available)(struct iio_buffer *buffer);
> +       int (*remove_from)(struct iio_buffer *buffer, void *data);
> +       int (*write)(struct iio_buffer *buffer, size_t n, const char __user *buf);
> +       size_t (*space_available)(struct iio_buffer *buffer);
>
>         int (*request_update)(struct iio_buffer *buffer);
>
> @@ -80,6 +88,9 @@ struct iio_buffer {
>         /**  @bytes_per_datum: Size of individual datum including timestamp. */
>         size_t bytes_per_datum;
>
> +       /* @direction: Direction of the data stream (in/out). */
> +       enum iio_buffer_direction direction;
> +
>         /**
>          * @access: Buffer access functions associated with the
>          * implementation.
> --
> 2.27.0
>
