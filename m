Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC9E04A3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbfJVNLj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 09:11:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42316 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbfJVNLi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 09:11:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so10629507pff.9;
        Tue, 22 Oct 2019 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MN/TNI8bhievwfVsfEYoH9ojxY2lOhIiY1YrA76NRdk=;
        b=Za4hspMtXw5UpWM+KsWuknJr9/56jY0+KReCafnA8AELw0CGxDEx98aMmyRQ6phQYk
         Z+QukVcjtJIEIW8OQ6HsiqNUwmSU2XDlYHTHn4mMD6YSAJ1FcKrl54uvcg045eGFvg6L
         Yi+YKryT2cjOhYnB3oOoR95h9cdAZjv8Q83/dqXoJg/SooHgLYEzd5sCSbOLhSgkW58z
         3EF087HDEPqk6mIPZHbVh8TGepNISLXrNKRklKbN8U28Mk7/KxSvBTMf2K/fuTwtDQuJ
         65QWXeW4lF7Bfy7IrGiu4Ul871Y8BgIn7xQImfYKVqdFxQ71A63TvaXJzNsSurl9Gbwm
         2n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MN/TNI8bhievwfVsfEYoH9ojxY2lOhIiY1YrA76NRdk=;
        b=HubBW9BqrsXhjUHHaHqG3wdOvTNAj3HmUQQvfsKZ0kyszWkBsotATIP2mc//OpBidV
         fN3Famzjpc4NcGKOs6YrXSkUncB4IDZw51Q2wweZoxofQdMoM3kf8lHslvOt1DWuUJPd
         dC1O4tJ5QxhUruiW1spYCG2ricI5D9LbIKPnxtpghUVNR/ckfCpy6XZb+CYX6SgTeJk2
         Uu3FdsQftI1MOnXotkaUM+H5bnwgsboKTR5RnIBWtQEkIZq5283YpiTdLjvK74EzsHSX
         FC/DlzQvbOROnrGIWnriigDlRyps8pTysz28yZJVS7rvPx+RB6v/39id8t6htOdauLPi
         Nn0A==
X-Gm-Message-State: APjAAAUgvFDpjhQOv7TE1sP4RAB29+gchHL/1YLk4sml+5x3PcsspHOh
        AsckxucWJWzTL9YaepomTjn+AK0yi0w=
X-Google-Smtp-Source: APXvYqxQHwjAgvoTXTtrpwmDoo+sYvTfZpw9uCVDFoLmkhVrfxkFUDbvAq3zIhUfoGd+Zi/ElDFZEw==
X-Received: by 2002:a17:90a:9104:: with SMTP id k4mr4592526pjo.39.1571749897780;
        Tue, 22 Oct 2019 06:11:37 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.161])
        by smtp.gmail.com with ESMTPSA id q2sm28407845pfg.144.2019.10.22.06.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 06:11:37 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v5 3/3] iio: documentation: light: Add veml6030 sysfs documentation
Date:   Tue, 22 Oct 2019 18:41:27 +0530
Message-Id: <1571749887-9054-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver for veml6030 light sensor provides sysfs
entries like configuring cutoff for interrupt. This
commit document them.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v5:
* Use ABI/testing/sysfs-bus-iio to document sysfs files for veml6030

Changes in v4:
* None

Changes in v3:
* Updated Date from September to October
* Updated KernelVersion from 5.3.1 to 5.4
* in_illuminance_period_available is now in events directory

Changes in v2:
* None

 Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6804516..a26d532 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -753,6 +753,8 @@ What:		/sys/.../events/in_illuminance0_thresh_falling_value
 what:		/sys/.../events/in_illuminance0_thresh_rising_value
 what:		/sys/.../events/in_proximity0_thresh_falling_value
 what:		/sys/.../events/in_proximity0_thresh_rising_value
+What:		/sys/.../events/in_illuminance_thresh_rising_value
+What:		/sys/.../events/in_illuminance_thresh_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -972,6 +974,7 @@ What:		/sys/.../events/in_activity_jogging_thresh_rising_period
 What:		/sys/.../events/in_activity_jogging_thresh_falling_period
 What:		/sys/.../events/in_activity_running_thresh_rising_period
 What:		/sys/.../events/in_activity_running_thresh_falling_period
+What:		/sys/.../events/in_illuminance_thresh_either_period
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1715,3 +1718,12 @@ Description:
 		Mass concentration reading of particulate matter in ug / m3.
 		pmX consists of particles with aerodynamic diameter less or
 		equal to X micrometers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of valid values available in multiples of integration time
+		for which the light intensity must be above the threshold level
+		before interrupt is asserted. This refers to persistence values.
-- 
2.7.4

