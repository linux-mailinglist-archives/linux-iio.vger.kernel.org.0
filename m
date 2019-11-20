Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67E103DA7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfKTOtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39539 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfKTOtX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so107356wrp.6
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dW+Z64oSlVI0UEL1kpDuI9nX6HWNagHFv6yFzU7lfsA=;
        b=kZ54j4MIcnixX+Jyj/zwgwTcJv8op1dzPr9PhED+vFvPQf5pZSZeoHUAcj+ej6gsIj
         /d+m9rfPPNcnrGpzNcUgcxzLO/T1Fqr/rwMsOKx66HsfCJhO8izvdjmpI0X/55PqH90x
         97j+9MqjiVO9y8Fmc0DEjK+/vuF+AnCWR8BLAMj1i3+sbinAVK2iPErWRLWy/r4v86wy
         HhvIfqC0PUEXBrHetwyVbWD3YMNbw9Sq5H+hGn5DIfnk347e/McFkzMV5GozI9qu7zhJ
         7kbdckrwwBfKMvlBd4IwMsrUliFLw6FICVvgqCba1loh+KB2J1vFSjYYvYjWS56R+CkR
         1Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dW+Z64oSlVI0UEL1kpDuI9nX6HWNagHFv6yFzU7lfsA=;
        b=Vqi/6AGL3Loi8XOhn/YK/MA/m7DgraT3+MBqknv4kaNiy1QV7pH9T7UEavv2W9pK3T
         aPVUErgbA4/lztpGaae65ge5Ywpv15VgFKp88SleJr79zGigQIuYQdEmZ2O77Pbe3YDL
         xXHE+ZHP3dDpfFjrB6ZLg/TbyyX4LKqEW34uURYUDwzjMBculv3xagqtbiBhdaP9+8M4
         R13GYX1YL6TD86TJzca77YxmRheybtJiKUI+K3EcY4uUM1DD4TsYwvUUYzw6cbrYhkQS
         bqg733A5VheQguohGycFoq5HYkIO9SZlwHaVOgrddwAfmMi7+rl8+oh1gyc3bpcQwcQ3
         /0Hw==
X-Gm-Message-State: APjAAAWtagK1pllXIUcFkQ9w4Nzk81SEx5RXrH8N8XNuGJqfqNy+2t/R
        6xBHvuCJ5wfi9jSawfJ1udE=
X-Google-Smtp-Source: APXvYqzeZh5CQ/NCYrYnSjkxNurSJjJjvk6DXnxhsGD8Y7m1T+u4Yvqy4kqcAlIZ19SweZiyVlXpvA==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr4027419wrv.304.1574261360745;
        Wed, 20 Nov 2019 06:49:20 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:20 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v3 2/9] Documentation: ABI: document IIO in_temp_filter_notch_center_frequency file
Date:   Wed, 20 Nov 2019 15:47:49 +0100
Message-Id: <20191120144756.28424-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

max31856 IIO driver introduced a new attribute
"in_temp_filter_notch_center_frequency".
This patch adds it to the list of documented ABI for sysfs-bus-iio

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index faaa2166d741..94f7eb675108 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1726,3 +1726,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		List of valid periods (in seconds) for which the light intensity
 		must be above the threshold level before interrupt is asserted.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
+KernelVersion:	5.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Center frequency in Hz for a notch filter. Used i.e. for line
+		noise suppression.
-- 
2.17.1

