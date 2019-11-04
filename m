Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FCEE409
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfKDPjl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:39:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40420 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDPjl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:39:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so12413714pfl.7;
        Mon, 04 Nov 2019 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nfnRrxBa0z3rlP8AZ8oPOA1x6dlENumbdaVhl7WFFL4=;
        b=kCJtm8UOvxqWt8J6FEKTE7jojzU5Pdh742fhyp8GSJgUEaePyQt3MgzjCbkR6T9N7N
         6vEzFyTJcpNFqxKImttV2pTWsZoU+6MhoSggw21rzX42Ooq/4t/PgIpFkkUWDMFqp7h8
         R7I0TEtgwxQQOl++s2SeH7BHWAgnGyxgncPL6dclxTBzoMFrvIShk1Uof9W1ZJfNFTMD
         wR2gUSCM38eEA9/j2T4F8nhHIZMu3Gmw7bYOhlAb5RfT+S+okK8THcocFm4jpgx9cLXr
         HvUXzGXzZ3m7rgs2/h2mIX7m4p6Hs96wdv7QqsjQJPRHoYz0U/oRMHizkMREoSXD4DHP
         Kb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nfnRrxBa0z3rlP8AZ8oPOA1x6dlENumbdaVhl7WFFL4=;
        b=A/6sHLE9Bgsq6RIQuP08MHTkRB3+ExHAyMT111yg3fIKM33YrYlDr6HCC0U4HCRsIp
         TDKbOT4xQJW7xFMVHXZk8YS2n8cvKNW2LUbDrUFEtZFm7wDaVQGFVrCuz5nPxcSBjmA/
         ciqzk5ZrJMGvjg00Zu+r0nXO2zGyrl+kfpMb52dmFj2AwlrXmUXJ2VoLpFtLkrWkhJ8b
         0w8N6ZQiu810zn0/gqjrPDvmnk/WCie79nkBIR0Z3r082VFOu0Kn6Q+PFifOgs8gtfcV
         5i/NaPdm42NzcEIDfdU8dOh8BOZg/0Cyn9Pgw0kSgtXHBoH60pJbkhCOof2d6U6cY5TL
         ntxQ==
X-Gm-Message-State: APjAAAVeLM+eVq5jrnxFFo4v+F7S3ZJ82UAnh+DK+UKWp15AlfDjqPf6
        tSyQXuJlpRQVlx1NFqT4UxU=
X-Google-Smtp-Source: APXvYqwp7tkc+cXtXWu5YP6A0OgBo+Ncy3eo1+Je3q4QIatken1fTQV8FYF61FB4Pmztv1qzxYqDKw==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr14104772pjb.33.1572881980739;
        Mon, 04 Nov 2019 07:39:40 -0800 (PST)
Received: from localhost.localdomain ([106.51.108.222])
        by smtp.gmail.com with ESMTPSA id j7sm4774324pjz.12.2019.11.04.07.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 07:39:40 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v6 3/3] iio: documentation: light: Add veml6030 sysfs documentation
Date:   Mon,  4 Nov 2019 21:09:28 +0530
Message-Id: <1572881968-15583-1-git-send-email-gupt21@gmail.com>
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
Changes in v6:
* in_illuminance_period_available now shows values in seconds 

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

 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6804516..faaa216 100644
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
@@ -1715,3 +1718,11 @@ Description:
 		Mass concentration reading of particulate matter in ug / m3.
 		pmX consists of particles with aerodynamic diameter less or
 		equal to X micrometers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
+Date:		November 2019
+KernelVersion:	5.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of valid periods (in seconds) for which the light intensity
+		must be above the threshold level before interrupt is asserted.
-- 
2.7.4

