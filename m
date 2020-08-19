Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E53249A6D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 12:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHSKcU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 06:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgHSKcS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 06:32:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B02C061757;
        Wed, 19 Aug 2020 03:32:15 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f193so11448160pfa.12;
        Wed, 19 Aug 2020 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anNefZypNBNyeAiop+Awx8oJbDXiIkICXZ8m5YrLk34=;
        b=OcjB70+iaINz8+km8ALYsIDidVUELFZ5RZJb7PaZ37nIwMbCOssnD8pIZH11dawT+J
         4AbF3evMUTKdRnWlphEkKXkEfW8N0fda5qiej4LW75S3Z/fb8cepse7hvQWoI5jjJG5I
         IfX9Uzp7QxgfOcW0btEWH9WHxj4Cjs/P6XVW/TRmsSlMOd81+cWZl9FSXh6KMI0CPc5A
         +hJYQ8yqYwKvmlfxKuu97tedKwQNbOneZK3YKzaa+3VuN+vlW+dRLGq1demCof337wEb
         SoZo5p0KnC13KZh5Q4salCJzr29uCqv6j1iMySqUasFpo2ZomL883zHHK2ZuHb0VhtRY
         diiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anNefZypNBNyeAiop+Awx8oJbDXiIkICXZ8m5YrLk34=;
        b=GqIIRwFDb+/Xui029976StX6YeUam+vZhX4pJvOUQ3AK4zbXmA/pfBScL0H5bFNxAS
         Mq6ga0BziId4cyW6efLmQg9wbPfl+zH6ayKNwXJZ6P95vzar/Kw7udxDFz6IUOJhN1Mv
         9PSSrzGAV5bzDe9hsLiGKAaLO1buOPbIQBUstcLTFPDUY5Bb52VqV16i2fnWNttjSCDo
         5AR9FKV0PdGrgFajkijLhkc6cCvBp3ZC1k8aQ3AUpw5SJ+VG5O0VcSROHdgDKr3eZHCt
         VLbnvufOORVl/zMstP4n3J/9ch2FjLoC4p/Umx9mUGm/Muv/alKKQEiJ7byTwPkEiUUy
         rZQw==
X-Gm-Message-State: AOAM531Ib1DOnP/S7d2Y/KwESSlQB2CWX9PTM1Qym3WDMhBizP8mlUV+
        4TlzTlguXI/e0cDBjWxU/RILNPi0jVs+1wli47s=
X-Google-Smtp-Source: ABdhPJy9N5GGtZRfM6arZTfwY2ew99jvNw44O9fYuyo18fzwV1ajUpxYutlhdyjuuwNhVxVoG4Sx8JFkY+5d5vfERo8=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr15765794pgh.74.1597833134742;
 Wed, 19 Aug 2020 03:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213055.103962-1-Sandeep.Singh@amd.com> <20200810213055.103962-4-Sandeep.Singh@amd.com>
In-Reply-To: <20200810213055.103962-4-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 13:31:58 +0300
Message-ID: <CAHp75VfO-6UOy=u+tX-iFb0XtNs_6Xfk3ZAQn6Rg9739JxULdg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] SFH: Transport Driver to add support of AMD Sensor
 Fusion Hub (SFH)
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Richard Neumann <mail@richard-neumann.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 11, 2020 at 12:31 AM Sandeep Singh <Sandeep.Singh@amd.com> wrote:

> This part of module will provide the interaction between HID framework

of the module

> and client layer.This module will registered client layer with

register

> HID framework.

...

> +/*

Is it kernel doc or not? Fix this in all occurrences.

> + * amdtp_hid_parse() - hid-core .parse() callback
> + * @hid:       hid device instance
> + *
> + * This function gets called during call to hid_add_device
> + *
> + * Return: 0 on success and non zero on error
> + */

...

> +static void amdtp_hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype)
> +{
> +       int rc;
> +
> +       switch (reqtype) {
> +       case HID_REQ_GET_REPORT:
> +               rc = amd_sfh_get_report(hid, rep->id, rep->type);
> +               if (rc)
> +                       pr_err("AMDSFH  get report error ");

Use dev_err() and similar in the other places.

> +               break;
> +       case HID_REQ_SET_REPORT:
> +               amd_sfh_set_report(hid, rep->id, reqtype);
> +               break;
> +       default:
> +               break;
> +       }
> +}

...

> +       if (!cli_data->request_done[i])
> +               ret = wait_event_interruptible_timeout(hid_data->hid_wait,
> +                                                      cli_data->request_done[i], 1500);

Magic number!

> +       if (ret > 0)
> +               return 0;

Usually we return errors first...

> +       else if (ret == -ERESTARTSYS)
> +               return -ERESTARTSYS;
> +       else
> +               return -ETIMEDOUT;
> +}

...

> +       hid = hid_allocate_device();
> +       if (IS_ERR(hid)) {

> +               rc = PTR_ERR(hid);
> +               return rc;

Why do you need two lines here?

> +       }

...

> +       hid_data = kzalloc(sizeof(*hid_data), GFP_KERNEL);

devm_kzalloc() ?

> +       if (!hid_data) {
> +               rc = -ENOMEM;
> +               goto err_hid_data;
> +       }

...

> +#define AMD_SFH_HID_VENDOR     1022

Decimal?!

> +#define AMD_SFH_HID_PRODUCT    0x0001

...

> +#include <linux/dma-mapping.h>
> +#include <linux/hid.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>

> +#include <uapi/asm-generic/errno-base.h>

Huh?! linux/errno.h

+ blank line here.

> +#include "hid_descriptor/amd_sfh_hid_descriptor.h"
> +#include "amdsfh_hid.h"
> +#include "amd_mp2_pcie.h"

...

> +#define PERIOD  200

Too generic name (namespace?), absence of unit.

...

> +       for (i = 0; i < cli_data->num_hid_devices; i++) {
> +               if (cli_data->hid_sensor_hubs[i] == hid) {

if (!...)
  continue;

?

> +                       struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
> +
> +                       if (!new)
> +                               return -ENOMEM;
> +                       new->current_index = i;
> +                       new->sensor_idx = cli_data->sensor_idx[i];
> +                       new->hid = hid;
> +                       new->report_type = report_type;
> +                       new->report_id = report_id;
> +                       cli_data->report_id[i] = report_id;
> +                       cli_data->request_done[i] = false;
> +                       list_add(&new->list, &req_list.list);
> +                       break;
> +               }
> +       }

-- 
With Best Regards,
Andy Shevchenko
