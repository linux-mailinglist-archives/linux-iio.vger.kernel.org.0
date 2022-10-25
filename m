Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1906060D183
	for <lists+linux-iio@lfdr.de>; Tue, 25 Oct 2022 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiJYQUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 25 Oct 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiJYQUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2022 12:20:37 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D03A3F78;
        Tue, 25 Oct 2022 09:20:22 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id b25so8408597qkk.7;
        Tue, 25 Oct 2022 09:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv2B/ttXmvVZtAJ+uQ/eIe+Op/L8T4+42ZzG50QIqi4=;
        b=WVmwoWTY+ivE1ZzYzbIEN3sRdqabdgDL6BdsBhR7EE+6Olk9sikSLBqx6V4+wBgk6g
         Vu2Kg1Bq0+HKwlPRqa9oyNnjKd/H07UEN8O9Zy0LgnHxTfmlDoUy2x0X6+0nVLk8d6g0
         PhMFQRQqlY+XndfCJjomoS9EyLNrTH49/Er8LQfaDBXRqXxttAl6EucZUzZruO+1JgXv
         h0JBxMiYqdDEEO6TqSMM6peUQRB3r7uj+PxDPFx0nh+ygarjTYYQqhU8f+XxCmE7VojR
         ruSsLw5CKfZGEGvHjvioaeOIgEij2sULWN5TQx+j1I3oryOkr9brti7mgPRD2mevfZXq
         1KTQ==
X-Gm-Message-State: ACrzQf2917nJj0VqpA9cGOhuF5705CQg8UNrLNxV3zIsj+nOPptZnZxv
        PcChNV919pRKqAEZADIVLkQLdFU3jTfeyVlxrNQ=
X-Google-Smtp-Source: AMsMyM59RyVZyO6Oh5nFrD0xUOSdbiPfcyvyhfzmHcH5V5n4+F2i4ECQj9IzdLY/DafNLK1kvxk6hrh6IesU6NF02hw=
X-Received: by 2002:a05:620a:4547:b0:6ee:dc16:d67a with SMTP id
 u7-20020a05620a454700b006eedc16d67amr27799057qkp.23.1666714822034; Tue, 25
 Oct 2022 09:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220929144618.1086985-1-marten.lindahl@axis.com> <20220929144618.1086985-2-marten.lindahl@axis.com>
In-Reply-To: <20220929144618.1086985-2-marten.lindahl@axis.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 18:20:10 +0200
Message-ID: <CAJZ5v0jhk8tGw9iak+BKr=3AUG5iPdn+0_KnmToDLji1ttV7hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Synchronize PM runtime enable state with parent
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 29, 2022 at 4:46 PM Mårten Lindahl <marten.lindahl@axis.com> wrote:
>
> A device that creates a child character device with cdev_device_add by
> default create a PM sysfs group with power attributes for userspace
> control. This means that the power attributes monitors the child device
> only and thus does not reflect the parent device PM runtime behavior.

It looks like device_set_pm_not_required() should be used on the child then.

> But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
> only on a single device that has been enabled for runtime PM, but also
> on its parent, it should be possible to synchronize the child and the
> parent so that the power attribute monitoring reflects the child and the
> parent as one.
>
> As an example, if an i2c_client device registers an iio_device, the
> iio_device will create sysfs power/attribute nodes for userspace
> control. But if the dev_pm_ops with resume/suspend callbacks is attached
> to the struct i2c_driver.driver.pm, the PM runtime needs to be enabled
> for the i2c_client device and not for the child iio_device.
>
> In this case PM runtime can be enabled for the i2c_client device and
> suspend/resume callbacks will be triggered, but the child sysfs power
> attributes will be visible but marked as 'unsupported' and can not be
> used for control or monitoring. This can be confusing as the sysfs
> device node presents the i2c_client and the iio_device as one device.

I don't quite understand the last sentence.

They are separate struct device objects and so they each have a
directory in sysfs, right?

> Add a function to synchronize the runtime PM enable state of a device
> with its parent. As there already exists a link from the child to its
> parent and both are enabled, all sysfs control/monitoring can reflect
> both devices, which from a userspace perspective makes more sense.

Except that user space will be able to change "control" to "on" for
the parent alone AFAICS which still will be confusing.

For devices that are pure software constructs it only makes sense to
expose the PM-runtime interface for them if the plan is to indirectly
control the parent's runtime PM through them.

> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/base/power/runtime.c | 18 ++++++++++++++++++
>  include/linux/pm_runtime.h   |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 997be3ac20a7..b202d513684a 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1499,6 +1499,24 @@ void pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +/**
> + * pm_runtime_sync_parent_enable - Synchronize enable state.
> + * @dev: Device to handle.
> + *
> + * Synchronize the device enable state with its parent.
> + * NOTE: This function should only be used if the parent will never disable
> + * PM runtime (i.e. calling __pm_runtime_disable()) without telling its child.
> + */
> +void pm_runtime_sync_parent_enable(struct device *dev)
> +{
> +       struct device *parent = dev->parent;
> +
> +       if (parent && !parent->power.ignore_children
> +           && pm_runtime_enabled(parent))
> +               pm_runtime_enable(dev);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_sync_parent_enable);
> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 0a41b2dcccad..5054427adbd1 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -89,6 +89,7 @@ extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>  extern void pm_runtime_release_supplier(struct device_link *link);
> +extern void pm_runtime_sync_parent_enable(struct device *dev);
>
>  extern int devm_pm_runtime_enable(struct device *dev);
>
> @@ -315,6 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
>  static inline void pm_runtime_new_link(struct device *dev) {}
>  static inline void pm_runtime_drop_link(struct device_link *link) {}
>  static inline void pm_runtime_release_supplier(struct device_link *link) {}
> +static inline void pm_runtime_sync_parent_enable(struct device *dev) {}
>
>  #endif /* !CONFIG_PM */
>
> --
> 2.30.2
>
