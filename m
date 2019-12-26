Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9EF12AB33
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2019 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfLZJWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Dec 2019 04:22:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49995 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLZJWc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Dec 2019 04:22:32 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1ikPLi-0004iu-5G
        for linux-iio@vger.kernel.org; Thu, 26 Dec 2019 09:22:30 +0000
Received: by mail-wr1-f71.google.com with SMTP id b13so12104944wrx.22
        for <linux-iio@vger.kernel.org>; Thu, 26 Dec 2019 01:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TNt04kFlxAJX+WAKJE2NLOKKM37LIXZ+D9p7JEtCd3U=;
        b=bMrftaS8yeKyAHfI66JDfsG6wUD5rSCQj4F41rQ6ZdBp+HFIaDT52E8O1cvp/8+TWj
         W4GrnYdiCfZfie4U5mCUMEXxGmu9XENE2rNF+MniErvPJQa3KCZk4vtnrP61G5RJNZBY
         nXVnYvqvyEq8bsLFwov1JPtvSef0Orp65il9ZRsatgQDdNPj8tXhU5InY00OXwBfL6Il
         QYm7bsbklzWGTu7zlJx+Y0EfVIUfYY/LOxJmYQYmQrmZwIoMrG4CO8xCz5tpRuv/1B6A
         BpvOYtC45l7lodxbVrdlmjA3p3mN1PqrfItasFszKqadjKhrlsMH+pRqcsowdOpQOFGz
         cVcQ==
X-Gm-Message-State: APjAAAXURU9ZYdCJ6iYzlElOCHoFa2MjiiunnBFCTQ4d+xQjSDVOJXy7
        5ONHhDZE29/8B4wgDVHFK2AKAP/PvfnupwoiK3YIhrpMKh67jNMfiEcLLUqmh2TDEAynFAo8oFc
        OTpJddDVQPNL/oj1f8MDeLWJPDBSXSSBZqLasw5x5QM/2M8VwGcIxug==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr45315329wrp.378.1577352149521;
        Thu, 26 Dec 2019 01:22:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxru5cVc4h4n6ndB+KZ1f3fGjJXajZ/dftoXybIFxNlB5BFtYYghIVWuZcxoapi9bSViB8r6wshzsfsnhTLv94=
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr45315316wrp.378.1577352149359;
 Thu, 26 Dec 2019 01:22:29 -0800 (PST)
MIME-Version: 1.0
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 26 Dec 2019 17:22:18 +0800
Message-ID: <CAFv23QmiDdhe+xJw2y7CXiWq4-GK1S-1bcKxEpNhNJu3ZtzA_w@mail.gmail.com>
Subject: Display got wrong rotation after hid_sensor_accel_3d is loaded
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

I'm working on a new platform which comes with an accelerator meter.
It's a STMicroelectronics LSM6DS3US accelerator meter, it doesn't use
st_sensors driver, but hid_sensor_accel_3d.
After hid_sensor_accel_3d is loaded, the display becomes upside down,
so I tried to add some code to make it become normal.(ACCEL_X should
have the same modification)

I don't know how to fix this in a correct way, please give me some hints.
Thanks.

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
b/drivers/iio/accel/hid-sensor-accel-3d.c
index 24573eb647a3..8ca6a222b773 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -270,6 +270,8 @@ static int accel_3d_capture_sample(struct
hid_sensor_hub_device *hsdev,
               accel_state->accel_val[CHANNEL_SCAN_INDEX_X + offset] =
                                               *(u32 *)raw_data;
+               if (usage_id == HID_USAGE_SENSOR_ACCEL_Y_AXIS)
+                       accel_state->accel_val[CHANNEL_SCAN_INDEX_Y] *= -1;

Best regards,
AceLan Kao.
