Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643C72A24EF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 08:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKBHAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 02:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgKBHAK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 02:00:10 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE2C0617A6;
        Sun,  1 Nov 2020 23:00:09 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n11so11703034ota.2;
        Sun, 01 Nov 2020 23:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4vgNMTMUB46HaV5RHDr4oq897erSMEyTZZMxcOAnPw=;
        b=INZ/dhqlQnS6khlYf7Ghou6DB2xqU2VucPCg/uIRMOPrveOfLKTpEm2wbk3AA13jaU
         tebn9ncB2kEe2OOxB1WmeYheDM0Q/GywhQ4wDW9F+FlH0XXGzNUc/xbqN0oRARCA30r1
         JSi5IhMXfmsfNiphx7kjKMdffpX6ZTUlniIVDtg/W2hU/49ne1vHenWjHx3A/U7hOdT0
         3kCVdxk7NiVirbwXoDxBAeyF4vPBWij43VJOc0CwADialjM8n3dDnAiF6F2SlIWqDtQY
         ihzbmi27NfauAQA8Tih8k95xQtjNp0sZC+vo8qhW7V+It9gfWP/8E4hHT4U8YpxLtMJ3
         cZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4vgNMTMUB46HaV5RHDr4oq897erSMEyTZZMxcOAnPw=;
        b=HN6NV+M3K4uG2li1uMysokFadvNGLBhU17YJRMxrZFvNQrtf/UQH1Dpx4jBZfs1ftu
         /dU2BuAUuXu/ag6bidDNGE4TKLKhrrmz5RrhxtuuTgUZl8GOzltAupdJ0u8Oxt9QC2eg
         /qBtnEJKAnfri67hnfoSUTd+iiki6oZyo6yqoYD0HxCFkJhatMpvlRq4U51plxpNhrY0
         IfY1aIjMrjnNzynY86YCNWuV7mEN+8H7/ZIVVbPO31+NFPP2XUYPYoj0Np/mZF+E6ZHb
         hm51jhFQacR4gG1d+4be7Gp2zrhfc1001zms6YTxaJYarnrb6ZbAuH5Mxzu8VYau7i9f
         Cy8A==
X-Gm-Message-State: AOAM533fdo73+gRWTZTAzFYdpWPO5iszWEtPlMDKnSRhv6YBe+wXXSJQ
        MmrGUUJJcplt5NZ8iJyjAFXNca6i/ihnyMjh9HQ=
X-Google-Smtp-Source: ABdhPJyx1usjjkRUsVoJaMP36W4OIN9WCFX0HEpVi4SZdudTxN0TXJ1+geAjOfTGFIJcYGe23vWfvkgVzDObqhFtpsY=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr10689391otp.207.1604300408848;
 Sun, 01 Nov 2020 23:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20200924084155.99406-1-alexandru.ardelean@analog.com> <20200925133805.062c0b1c@archlinux>
In-Reply-To: <20200925133805.062c0b1c@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 2 Nov 2020 08:59:57 +0200
Message-ID: <CA+U=DsqVomxim2SVqkC8LVYguUaSv-w0kw-B-shz7S0Yeka6Gg@mail.gmail.com>
Subject: Re: [PATCH] iio: core: centralize ioctl() calls to the main chardev
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 25, 2020 at 3:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 24 Sep 2020 11:41:55 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > The aim of this is to improve a bit the organization of ioctl() calls in
> > IIO core. Currently the chardev is split across IIO core sub-modules/files.
> > The main chardev has to be able to handle ioctl() calls, and if we need to
> > add buffer ioctl() calls, this would complicate things.
> >
> > The 'industrialio-core.c' file will provide a 'iio_device_ioctl()' which
> > will iterate over a list of ioctls registered with the IIO device. These
> > can be event ioctl() or buffer ioctl() calls, or something else.
> >
> > Each ioctl() handler will have to return a IIO_IOCTL_UNHANDLED code (which
> > is positive 1), if the ioctl() did not handle the call in any. This
> > eliminates any potential ambiguities about negative error codes, which
> > should fail the call altogether.
> >
> > If any ioctl() returns 0, it was considered that it was serviced
> > successfully and the loop will exit.
> >
> > This change also moves the handling of the IIO_GET_EVENT_FD_IOCTL command
> > inside 'industrialio-event.c', where this is better suited.
> >
> > This patch is a combination of 2 other patches from an older series:
> > Patch 1: iio: core: add simple centralized mechanism for ioctl() handlers
> >   Link: https://lore.kernel.org/linux-iio/20200427131100.50845-6-alexandru.ardelean@analog.com/
> > Patch 2: iio: core: use new common ioctl() mechanism
> >   Link: https://lore.kernel.org/linux-iio/20200427131100.50845-7-alexandru.ardelean@analog.com/
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >
> > Note: since this is a change to the IIO core, we don't need to put this in
> > right now; especially if there is a tight schedule, or we are too close to
> > a merge window.
>
> Looks good to me.  As you suggest, lets let this one sit on the list for a
> while though!

ping on this

thanks
Alex

>
> Jonathan
>
> >
> >  drivers/iio/iio_core.h           | 15 ++++++++-
> >  drivers/iio/industrialio-core.c  | 56 ++++++++++++++++++++++++--------
> >  drivers/iio/industrialio-event.c | 28 +++++++++++++++-
> >  include/linux/iio/iio-opaque.h   |  2 ++
> >  4 files changed, 85 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index fd9a5f1d5e51..fced02cadcc3 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -17,6 +17,20 @@ struct iio_dev;
> >
> >  extern struct device_type iio_device_type;
> >
> > +#define IIO_IOCTL_UNHANDLED  1
> > +struct iio_ioctl_handler {
> > +     struct list_head entry;
> > +     long (*ioctl)(struct iio_dev *indio_dev, struct file *filp,
> > +                   unsigned int cmd, unsigned long arg);
> > +};
> > +
> > +long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
> > +                   unsigned int cmd, unsigned long arg);
> > +
> > +void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
> > +                                    struct iio_ioctl_handler *h);
> > +void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
> > +
> >  int __iio_add_chan_devattr(const char *postfix,
> >                          struct iio_chan_spec const *chan,
> >                          ssize_t (*func)(struct device *dev,
> > @@ -74,7 +88,6 @@ static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
> >  int iio_device_register_eventset(struct iio_dev *indio_dev);
> >  void iio_device_unregister_eventset(struct iio_dev *indio_dev);
> >  void iio_device_wakeup_eventset(struct iio_dev *indio_dev);
> > -int iio_event_getfd(struct iio_dev *indio_dev);
> >
> >  struct iio_event_interface;
> >  bool iio_event_enabled(const struct iio_event_interface *ev_int);
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 261d3b17edc9..964a0a2d6f8b 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1567,6 +1567,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
> >       }
> >       dev_set_name(&dev->dev, "iio:device%d", dev->id);
> >       INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
> > +     INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
> >
> >       return dev;
> >  }
> > @@ -1660,26 +1661,47 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
> >       return 0;
> >  }
> >
> > -/* Somewhat of a cross file organization violation - ioctls here are actually
> > - * event related */
> > +void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
> > +                                    struct iio_ioctl_handler *h)
> > +{
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +     list_add_tail(&h->entry, &iio_dev_opaque->ioctl_handlers);
> > +}
> > +
> > +void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h)
> > +{
> > +     list_del(&h->entry);
> > +}
> > +
> >  static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  {
> >       struct iio_dev *indio_dev = filp->private_data;
> > -     int __user *ip = (int __user *)arg;
> > -     int fd;
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     struct iio_ioctl_handler *h;
> > +     int ret = -ENODEV;
> > +
> > +     mutex_lock(&indio_dev->info_exist_lock);
> >
> > +     /**
> > +      * The NULL check here is required to prevent crashing when a device
> > +      * is being removed while userspace would still have open file handles
> > +      * to try to access this device.
> > +      */
> >       if (!indio_dev->info)
> > -             return -ENODEV;
> > -
> > -     if (cmd == IIO_GET_EVENT_FD_IOCTL) {
> > -             fd = iio_event_getfd(indio_dev);
> > -             if (fd < 0)
> > -                     return fd;
> > -             if (copy_to_user(ip, &fd, sizeof(fd)))
> > -                     return -EFAULT;
> > -             return 0;
> > +             goto out_unlock;
> > +
> > +     ret = -EINVAL;
> > +     list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
> > +             ret = h->ioctl(indio_dev, filp, cmd, arg);
> > +             if (ret != IIO_IOCTL_UNHANDLED)
> > +                     break;
> >       }
> > -     return -EINVAL;
> > +
> > +out_unlock:
> > +     mutex_unlock(&indio_dev->info_exist_lock);
> > +
> > +     return ret;
> >  }
> >
> >  static const struct file_operations iio_buffer_fileops = {
> > @@ -1796,6 +1818,9 @@ EXPORT_SYMBOL(__iio_device_register);
> >   **/
> >  void iio_device_unregister(struct iio_dev *indio_dev)
> >  {
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     struct iio_ioctl_handler *h, *t;
> > +
> >       cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> >
> >       mutex_lock(&indio_dev->info_exist_lock);
> > @@ -1806,6 +1831,9 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >
> >       indio_dev->info = NULL;
> >
> > +     list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> > +             list_del(&h->entry);
> > +
> >       iio_device_wakeup_eventset(indio_dev);
> >       iio_buffer_wakeup_poll(indio_dev);
> >
> > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> > index 99ba657b8568..a2de2fd89067 100644
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -31,6 +31,7 @@
> >   * @flags:           file operations related flags including busy flag.
> >   * @group:           event interface sysfs attribute group
> >   * @read_lock:               lock to protect kfifo read operations
> > + * @@ioctl_handler:  handler for event ioctl() calls
> >   */
> >  struct iio_event_interface {
> >       wait_queue_head_t       wait;
> > @@ -40,6 +41,7 @@ struct iio_event_interface {
> >       unsigned long           flags;
> >       struct attribute_group  group;
> >       struct mutex            read_lock;
> > +     struct iio_ioctl_handler        ioctl_handler;
> >  };
> >
> >  bool iio_event_enabled(const struct iio_event_interface *ev_int)
> > @@ -187,7 +189,7 @@ static const struct file_operations iio_event_chrdev_fileops = {
> >       .llseek = noop_llseek,
> >  };
> >
> > -int iio_event_getfd(struct iio_dev *indio_dev)
> > +static int iio_event_getfd(struct iio_dev *indio_dev)
> >  {
> >       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
> > @@ -473,6 +475,24 @@ static void iio_setup_ev_int(struct iio_event_interface *ev_int)
> >       mutex_init(&ev_int->read_lock);
> >  }
> >
> > +static long iio_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
> > +                         unsigned int cmd, unsigned long arg)
> > +{
> > +     int __user *ip = (int __user *)arg;
> > +     int fd;
> > +
> > +     if (cmd == IIO_GET_EVENT_FD_IOCTL) {
> > +             fd = iio_event_getfd(indio_dev);
> > +             if (fd < 0)
> > +                     return fd;
> > +             if (copy_to_user(ip, &fd, sizeof(fd)))
> > +                     return -EFAULT;
> > +             return 0;
> > +     }
> > +
> > +     return IIO_IOCTL_UNHANDLED;
> > +}
> > +
> >  static const char *iio_event_group_name = "events";
> >  int iio_device_register_eventset(struct iio_dev *indio_dev)
> >  {
> > @@ -526,6 +546,10 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
> >               ev_int->group.attrs[attrn++] = &p->dev_attr.attr;
> >       indio_dev->groups[indio_dev->groupcounter++] = &ev_int->group;
> >
> > +     ev_int->ioctl_handler.ioctl = iio_event_ioctl;
> > +     iio_device_ioctl_handler_register(&iio_dev_opaque->indio_dev,
> > +                                       &ev_int->ioctl_handler);
> > +
> >       return 0;
> >
> >  error_free_setup_event_lines:
> > @@ -558,6 +582,8 @@ void iio_device_unregister_eventset(struct iio_dev *indio_dev)
> >
> >       if (ev_int == NULL)
> >               return;
> > +
> > +     iio_device_ioctl_handler_unregister(&ev_int->ioctl_handler);
> >       iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> >       kfree(ev_int->group.attrs);
> >       kfree(ev_int);
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index f2e94196d31f..07c5a8e52ca8 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -11,6 +11,7 @@
> >   * @channel_attr_list:               keep track of automatically created channel
> >   *                           attributes
> >   * @chan_attr_group:         group for all attrs in base directory
> > + * @ioctl_handlers:          ioctl handlers registered with the core handler
> >   * @debugfs_dentry:          device specific debugfs dentry
> >   * @cached_reg_addr:         cached register address for debugfs reads
> >   * @read_buf:                        read buffer to be used for the initial reg read
> > @@ -22,6 +23,7 @@ struct iio_dev_opaque {
> >       struct list_head                buffer_list;
> >       struct list_head                channel_attr_list;
> >       struct attribute_group          chan_attr_group;
> > +     struct list_head                ioctl_handlers;
> >  #if defined(CONFIG_DEBUG_FS)
> >       struct dentry                   *debugfs_dentry;
> >       unsigned                        cached_reg_addr;
>
