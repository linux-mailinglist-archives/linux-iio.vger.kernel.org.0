Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AD515AB2E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBLOp3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 09:45:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgBLOp3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 09:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581518728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yxu7FAFWwnIWX0SIGmGmSoK4AorTJs9H07QQ92CKAE=;
        b=i4MtEetD5RhwTIUKPQVuzOY0P9ku3syFHu78K3hsLtI6kFkNrGY4N5pJM8RBCIzTNn/c1J
        g7+cwzj3VCEpqBwd/GHsr68sgPiqgLvM0QvNSYvkxVp5z4JDdxic0bvLOaU9UBBac4rndb
        mbHOD53kotEi3jcEcI0AnbFYHzFatHw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-9-fnYFBlP1OlCnJU6cpl4g-1; Wed, 12 Feb 2020 09:45:21 -0500
X-MC-Unique: 9-fnYFBlP1OlCnJU6cpl4g-1
Received: by mail-wm1-f70.google.com with SMTP id n17so817933wmk.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2020 06:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yxu7FAFWwnIWX0SIGmGmSoK4AorTJs9H07QQ92CKAE=;
        b=isAZiatug5nsKQmsoDO5svtAVx//eVcz0xLM7RiqrFdHCNYep4/KUz6bwmA9gn+1xK
         cz8e6dJjDZA9u2I1OvmzbwQyJEEcI5ao0PLihtH7u5UaxGroQ9xyH+QuzkPZu5n2hzmt
         Ycgp8axnPsdDzbRjWDPbqymEHcf5JyhldMNvZsQtKmo4TNTW/u7frtZx4M8iOLvz+6V/
         njoP6Q4CDakC7VCkJtyttAFayK2ey7SgXiEsYdsQBtUT2q+aoEqFdr0NbH7WGCfTp6t/
         zcDjIBSgPBjM+4aJhW1kuwdIrzmprwyZeevv1AW9co22ZwBAzPhvfdCOpFlIFjNm8tFL
         Hc4g==
X-Gm-Message-State: APjAAAXn2eYddZiqV6GFRyP6aPRdBRUbS5H4v5GUrpi362zNmwFmpGVY
        NwrQd/EeoZRM08BmzQf9Eqk4P1EiA6kug+rs7LrA4j8gwfZ3uq8jIVsd76FR34q+iyisaoQJxlj
        rIPN2R5dFu4UZPafWGTi0
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr13285287wml.138.1581518719658;
        Wed, 12 Feb 2020 06:45:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/DPnyNQBFf9qRLXEDxykkC41nBOMiGj9xsFs5aS89vZNDZnDfVr0gows1yjwgUiGwyd6Rsw==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr13285259wml.138.1581518719307;
        Wed, 12 Feb 2020 06:45:19 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id m9sm893216wrx.55.2020.02.12.06.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 06:45:18 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org,
        Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
Message-ID: <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com>
Date:   Wed, 12 Feb 2020 15:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/12/20 3:56 AM, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
> is part of MP2 processor (MP2 which is an ARM® Cortex-M4
> core based co-processor to x86) and it runs on MP2 where
> in driver resides on X86.The driver functionalities are
> divided  into three parts:-
> 
> 1: amd-mp2-pcie:-       This module will communicate with MP2 FW and
>                          provide that data into DRAM.
> 2: Client driver :-     This part for driver will use dram data and
>                          convert that data into HID format based on
>                          HID reports.
> 3: Transport driver :-  This part of driver will communicate with
>                          HID core. Communication between devices and
>                          HID core is mostly done via HID reports
> 
> In terms of architecture it is much more reassembles like
> ISH(Intel Integrated Sensor Hub). However the major difference
> is all the hid reports are generated as part of kernel driver.
> AMD SFH driver taken reference from ISH in terms of
> design and functionalities at fewer location.
> 
> AMD sensor fusion Hub is part of a SOC 17h family based platforms.
> The solution is working well on several OEM products.
> AMD SFH uses HID over PCIe bus.

I started looking at this patch because of the phoronix' news item on it.

First of all I want to say that it is great that AMD is working on
getting the Sensor Fusion Hub supported on Linux and that you are
working on a driver for this.

But, I've taken a quick look, mainly at the
"[PATCH v3 5/5] SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)"
patch.

AFAIK with the Intel ISH the sensor-hub itself is actually providing
HID descriptors and HID input reports.

Looking at the AMD code, that does not seem to be the case, it seems
the values come directly from the AMD sensor-hub without being in any
HID specific form, e.g.:

+u8 get_input_report(int sensor_idx, int report_id,
+		    u8 *input_report, u32 *sensor_virt_addr)
+{
+	u8 report_size = 0;
+	struct accel3_input_report acc_input;
+	struct gyro_input_report gyro_input;
+	struct magno_input_report magno_input;
+	struct als_input_report als_input;
+
+	if (!sensor_virt_addr || !input_report)
+		return report_size;
+
+	switch (sensor_idx) {
+	case ACCEL_IDX: /* accel */
+		acc_input.common_property.report_id = report_id;
+		acc_input.common_property.sensor_state =
+					HID_USAGE_SENSOR_STATE_READY_ENUM;
+		acc_input.common_property.event_type =
+				HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+		acc_input.in_accel_x_value = (int)sensor_virt_addr[0] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		acc_input.in_accel_y_value = (int)sensor_virt_addr[1] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		acc_input.in_accel_z_value =  (int)sensor_virt_addr[2] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		memcpy(input_report, &acc_input, sizeof(acc_input));
+		report_size = sizeof(acc_input);
+		break;

And the descriptors are hardcoded in the driver so as to fake a HID
device.

So going through the HID subsystem seems like an unnecessary detour,
which just makes things needlessly complex and harder to debug
(and extend).

The HID devices which the current patch-set is creating ultimately
will result in a number of devices being created under

/sys/bus/iio/devices

And this are the devices which userspace uses to get the sensor data.

IMHO instead of going through the HID subsys the AMD Sensor Fusion Hub
driver should simply register 4 (*) iio-devices itself and directly
pass the data through at the iio subsys level rather then going the
long way around by creating a fake HID device which then gets
attached to by the hid-sensor driver to ultimately create the same
iio-devices.

There are examples of e.g. various iio accel drivers under:
drivers/iio/accel/ you could start with a simple driver supporting
just the accelerometer bits and then extend things from there.

Benjamin, Jiri, Jonathan, what is your take on this?

Regards,

Hans


*) One for accel, gyra, magneto and light each


> Sandeep Singh (5):
>    SFH: Add maintainers and documentation for AMD SFH based on HID
>      framework
>    SFH: PCI driver to add support of AMD sensor fusion Hub using HID
>      framework
>    SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
>    SFH: Add debugfs support to AMD Sensor Fusion Hub
>    SFH: Create HID report to Enable support of AMD sensor fusion Hub
>      (SFH)
> 
> Changes since v1:
>          -Fix auto build test warnings
>          -Fix warnings captured using smatch
>          -Changes suggested by Dan Carpenter
> 
> Links of the review comments for v1:
>          [1] https://patchwork.kernel.org/patch/11325163/
>          [2] https://patchwork.kernel.org/patch/11325167/
>          [3] https://patchwork.kernel.org/patch/11325171/
>          [4] https://patchwork.kernel.org/patch/11325187/
> 
> 
> Changes since v2:
>          -Debugfs divided into another patch
>          -Fix some cosmetic changes
>          -Fix for review comments
>           Reported and Suggested by:-  Srinivas Pandruvada
> 
> Links of the review comments for v2:
>          [1] https://patchwork.kernel.org/patch/11355491/
>          [2] https://patchwork.kernel.org/patch/11355495/
>          [3] https://patchwork.kernel.org/patch/11355499/
>          [4] https://patchwork.kernel.org/patch/11355503/
> 
> 
>   Documentation/hid/amd-sfh-hid.rst                  | 160 +++++
>   MAINTAINERS                                        |   8 +
>   drivers/hid/Kconfig                                |   2 +
>   drivers/hid/Makefile                               |   1 +
>   drivers/hid/amd-sfh-hid/Kconfig                    |  20 +
>   drivers/hid/amd-sfh-hid/Makefile                   |  17 +
>   drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 243 ++++++++
>   drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 177 ++++++
>   drivers/hid/amd-sfh-hid/amdsfh-debugfs.c           | 250 ++++++++
>   drivers/hid/amd-sfh-hid/amdsfh-debugfs.h           |  14 +
>   drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 260 +++++++++
>   drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
>   drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  85 +++
>   .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275 +++++++++
>   .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
>   .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
>   16 files changed, 2458 insertions(+)
>   create mode 100644 Documentation/hid/amd-sfh-hid.rst
>   create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>   create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
>   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
>   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h
>   create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
>   create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
>   create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h
> 

