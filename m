Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D681E8011
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE2OUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgE2OUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 10:20:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0533C03E969;
        Fri, 29 May 2020 07:20:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 124so1548195pgi.9;
        Fri, 29 May 2020 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OJmrKOHHlXt7NP9bkLNDHCpGZ2EjIOPWYOS0RLvnE0=;
        b=q1kjfqc3RRLiSD+Qp/Y9UK/eewwfd9pJjcEOClVDTDr3dzd96gerZD85cMrPnNbs9e
         tJVbn//lbxVRcizy+BGQQQ2erYf7XYItKQjqzgST6YXTiuzHffFPgCVyvgdpnAAbJOZq
         nyvALeXnOh/XkUCkoTF20SUq3hyHTc90jNkQ8/FOvwTjySR2XJQg3fVDhyiQW6SEhoY2
         gXgoQxigSdWXeBMlu4TrjsfiS5WBaQkLoIIctGZLfXiyBnS1HFElw8M3u3dAmRohXGXO
         mdKpt9wBAcrN9OjKKQdSJZSNjnRjqJ9x95hSOYzMrAEo/9G/nYlqKc9lePc1d5vlotBA
         542w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OJmrKOHHlXt7NP9bkLNDHCpGZ2EjIOPWYOS0RLvnE0=;
        b=T1T1T5YjichAIn8DOYDCmZ8Z1QQfd8xkGwgwIkwP286MhwYGsnKhuqadY8h9MgT1nv
         ywy1QXenrtpAhz/alIP+j/LZk37lIDNmJc4nux3Fm7qpBL1IBLXt/fS5XgNViu5x3wjA
         UPNQ+7D1GIDSGeUT8YSdqe0zBXKDMGp0w3XEV0v7w4YXDi4Lh4QRAjrxJl46CjQD0oQR
         JN8b7uX6gF6HHFGPt/fjz6Z2F4OpNgsQIXwl3qLu+TxVtd8+Cgucmx53QH7d5RUcbUR4
         OXtz1DCHNrL3h7Zf6dU6QxUfJOltQaYYSaxTG0F+a4RVpHtRcC+C/JZ6h1zw4xb/LyY7
         TIqA==
X-Gm-Message-State: AOAM532Dr4Xle7Y+esmutEj+DiYPo5oBW4olpA5bi3yLSM0nWOYDcqMC
        OblREFO5jJJN1o7gOPKnIFEND60daw2TTs+wxJU0bWOFwKU=
X-Google-Smtp-Source: ABdhPJz+WvIZlLvcGgzIepxU5V6Q4jamnceyUOW7NIBpcGJaREvgKHJVu6j28LQeqXR7YTHoKvdL3WoI8NjTscblVOk=
X-Received: by 2002:a63:545a:: with SMTP id e26mr8363969pgm.4.1590762047235;
 Fri, 29 May 2020 07:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com> <1590759730-32494-4-git-send-email-Sandeep.Singh@amd.com>
In-Reply-To: <1590759730-32494-4-git-send-email-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 17:20:35 +0300
Message-ID: <CAHp75VeWeda-LBEScCLKF5OFwHjCrXayzotOW1YrGpDFCEjSQA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] SFH: Transport Driver to add support of AMD Sensor
 Fusion Hub (SFH
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
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 29, 2020 at 4:43 PM Sandeep Singh <Sandeep.Singh@amd.com> wrote:
>
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> This part of module will provide the interaction between HID framework
> and client driver.This modules will registered client driver with
> HID framework.

...

> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>

Use proper sequence and Co-developed-by if applicable.

> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

What has been reported? Absence of the drivers?

...

> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <linux/hid.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/dma-mapping.h>

Keep ordered?

> +#include "amdsfh-hid.h"
> +#include "amd_mp2_pcie.h"
> +#include "hid_descriptor/amd_sfh_hid_descriptor.h"

...

> +void amd_sfh_get_report(struct hid_device *hid, int report_id,
> +                       int report_type)
> +{
> +       struct amdtp_hid_data *hid_data = hid->driver_data;
> +       struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +       int i;
> +
> +       for (i = 0; i < cli_data->num_hid_devices; i++) {
> +               if (cli_data->hid_sensor_hubs[i] == hid) {

> +                       struct request_list *new_request = kzalloc
> +                                 (sizeof(*new_request), GFP_KERNEL);

Bad indentation.

> +                       new_request->current_index = i;

Huh? NULL pointer dereference!

> +                       new_request->sensor_idx = cli_data->sensor_idx[i];
> +                       new_request->hid = hid;
> +                       new_request->report_type = report_type;
> +                       new_request->report_id = report_id;
> +                       cli_data->report_id[i] = report_id;
> +                       cli_data->request_done[i] = false;
> +                       list_add(&new_request->list, &req_list.list);
> +                       break;
> +               }
> +       }
> +       schedule_delayed_work(&cli_data->work, 0);
> +}
> +EXPORT_SYMBOL(amd_sfh_get_report);

...

> +static void amd_sfh_work_buffer(struct work_struct *work)
> +{
> +       struct amdtp_cl_data *cli_data = cl_data_context;
> +       unsigned int i;

> +       u8 report_size = 0;

Redundant assignment.

> +       for (i = 0; i < cli_data->num_hid_devices; i++) {
> +               report_size = get_input_report(cli_data->sensor_idx[i],
> +                                              cli_data->report_id[i],
> +                               cli_data->input_report[i],
> +                               cli_data->sensor_virt_addr[i]);
> +               hid_input_report(cli_data->hid_sensor_hubs[i],
> +                                HID_INPUT_REPORT,
> +                                cli_data->input_report[i], report_size, 0);
> +               }
> +
> +       schedule_delayed_work(&cli_data->work_buffer, PERIOD);
> +}

...

> +static int amd_sfh_hid_client_probe(struct platform_device *pdev)
> +{
> +       struct amd_mp2_sensor_info info;
> +       int rc = 0;
> +       int i;
> +       struct amdtp_cl_device *cl_dev;
> +       struct amdtp_cl_data *cl_data;
> +       u32 feature_report_size = 0;
> +       u32 input_report_size = 0;

Are you sure all those assignments are needed?

> +       cl_dev->pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> +                                     PCI_DEVICE_ID_AMD_MP2, NULL);

I'm not quite sure you understand what you are doing here.
The code below is full of leak.

> +       if (!cl_dev->pdev)

> +               return -ENOMEM;

What?

...

> +       cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);

> +       cl_data->num_hid_devices = amd_mp2_get_sensor_num
> +                                  (cl_dev->pdev, &cl_data->sensor_idx[0]);

Strange indentation.
NULL pointer dereference!


> +       for (i = 0; i < cl_data->num_hid_devices; i++) {

> +               cl_data->sensor_virt_addr[i] = dma_alloc_coherent
> +                       (&cl_dev->pdev->dev, sizeof(int) * 8,
> +                       &cl_data->sensor_phy_addr[i], GFP_KERNEL);

Indentation.

> +               cl_data->report_descr_size[i] = get_descriptor_size
> +                               (cl_data->sensor_idx[i], descr_size);
> +
> +               feature_report_size = get_descriptor_size
> +                               (cl_data->sensor_idx[i], feature_size);
> +
> +               input_report_size =  get_descriptor_size
> +                       (cl_data->sensor_idx[i], input_size);

Ditto.

> +               cl_data->feature_report[i] = kzalloc(feature_report_size,
> +                                                    GFP_KERNEL);
> +               cl_data->input_report[i] = kzalloc(input_report_size,
> +                                                  GFP_KERNEL);

NULL pointer dereference.

You probably need to understand how memory allocation and heap usage works.

> +               info.period = PERIOD;
> +               info.sensor_idx = cl_data->sensor_idx[i];
> +               info.phy_address = cl_data->sensor_phy_addr[i];

> +               cl_data->report_descr[i] = kzalloc
> +                       (cl_data->report_descr_size[i], GFP_KERNEL);

Indentation.

> +               if (!cl_data->report_descr[i])
> +                       return -ENOMEM;
> +               rc = get_report_descriptor(cl_data->sensor_idx[i],
> +                                          cl_data->report_descr[i]);
> +               rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
> +               amd_start_sensor(cl_dev->pdev, info);
> +               cl_data->sensor_sts[i] = 1;
> +       }
> +
> +       cl_dev->cl_data = cl_data;
> +       cl_data_context = cl_data;
> +       platform_set_drvdata(pdev, cl_dev);
> +       schedule_delayed_work(&cl_data->work_buffer, PERIOD);
> +       return 0;
> +}

...

> +static int amd_sfh_hid_client_remove(struct platform_device *pdev)
> +{
> +       int i;
> +       struct amdtp_cl_device *cl_dev;
> +       struct amdtp_cl_data *cl_data;

Reversed xmas tree, please.

> +       cl_dev = platform_get_drvdata(pdev);

> +       if (!(cl_dev))
> +               return -EINVAL;

When this will be true?!

This can be done directly in the definition block above.

> +       cl_data = cl_dev->cl_data;

> +       if (!(cl_data))
> +               return -EINVAL;

Ditto.

> +       for (i = 0; i < cl_data->num_hid_devices; i++)
> +               amd_stop_sensor(cl_dev->pdev, i);
> +
> +       cancel_delayed_work_sync(&cl_data->work);
> +       cancel_delayed_work_sync(&cl_data->work_buffer);
> +       amdtp_hid_remove(cl_data);
> +
> +       for (i = 0; i < cl_data->num_hid_devices; i++) {
> +               if (cl_data->sensor_virt_addr[i])
> +                       dma_free_coherent(&cl_dev->pdev->dev, 8 * sizeof(int),
> +                                         cl_data->sensor_virt_addr[i],
> +                                         cl_data->sensor_phy_addr[i]);
> +       }
> +

> +       kfree(cl_data);

Why not devm in the probe and nothing here?

> +       pr_info("%s:%s Exit\n", DRIVER_NAME, __func__);

No, no. Remove this noise.

> +       return 0;
> +}

...

> +static const struct acpi_device_id amd_sfh_acpi_match[] = { {
> +                                       "AMDI0080" },

> +                                       { },

No comma on terminators.

> +};

Indentation is horrible. You have to look into existing drivers
(better newer ones) to see how to have done things like this.

> +

Blank line in wrong place...

> +MODULE_DEVICE_TABLE(acpi, amd_sfh_acpi_match);

...should be here.

> +static struct platform_driver amd_sfh_plat_driver = {
> +       .probe = amd_sfh_hid_client_probe,
> +       .remove = amd_sfh_hid_client_remove,
> +       .driver = {
> +                       .name = "amd_sfh_platform",

> +                       .acpi_match_table = ACPI_PTR(amd_sfh_acpi_match),

ACPI_PTR() is redundant and/or provokes compilation warnings.

> +       },
> +};
> +module_platform_driver(amd_sfh_plat_driver);

+ blank line.

...

> +static int amdtp_hid_parse(struct hid_device *hid)
> +{
> +       struct amdtp_hid_data *hid_data = hid->driver_data;
> +       struct amdtp_cl_data *cli_data = hid_data->cli_data;

> +       int rc;
> +
> +       rc = hid_parse_report(hid, cli_data->report_descr[hid_data->index],
> +                             cli_data->report_descr_size[hid_data->index]);
> +       if (rc)
> +               return rc;
> +       return 0;

return hid_parse_report(...);

> +}

...

> +static void amdtp_hid_request(struct hid_device *hid, struct hid_report *rep,
> +                             int reqtype)
> +{
> +       switch (reqtype) {
> +       case HID_REQ_GET_REPORT:
> +               amd_sfh_get_report(hid, rep->id, rep->type);
> +               break;
> +       case HID_REQ_SET_REPORT:
> +               amd_sfh_set_report(hid, rep->id, reqtype);
> +               break;
> +       }

default?

> +}

...

> +static int amdtp_wait_for_response(struct hid_device *hid)
> +{
> +       struct amdtp_hid_data *hid_data =  hid->driver_data;
> +       struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +       int i = 0;
> +
> +       for (i = 0; i < cli_data->num_hid_devices; i++) {
> +               if (cli_data->hid_sensor_hubs[i] == hid)
> +                       break;
> +       }
> +       if (!cli_data->request_done[i])
> +               wait_event_interruptible_timeout(hid_data->hid_wait,
> +                                                cli_data->request_done[i],
> +                                                1500);

> +       if (!cli_data->request_done[i]) {

Shouldn't you rather check returned value from previous call?

> +               hid_err(hid,
> +                       "timeout waiting for response from  device\n");
> +               return -ETIMEDOUT;
> +       }
> +       cli_data->request_done[i] = false;
> +
> +       return 0;
> +}

...

> +       hid = hid_allocate_device();
> +       if (IS_ERR(hid)) {

> +               rc = PTR_ERR(hid);
> +               return -ENOMEM;

Huh?!

> +       }

...


> +#ifndef AMDSFH_HID_H
> +#define AMDSFH_HID_H

> +#include <linux/debugfs.h>

What?! I see useds of other stuff, but this...

-- 
With Best Regards,
Andy Shevchenko
