Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F532F9396
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbhAQPl2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbhAQPlZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:41:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D69F122571;
        Sun, 17 Jan 2021 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898040;
        bh=RYkXWGHfhVE4eMgfzpphQMtyoLremfXqKTdnk7K4mE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcUyr7shWMexnQBdFt5rjTQ5Sg0xgS4pGGXEPz5rD/XvUUfqKdIxcmMBoD2O0+ruU
         xvhikNRXss/dnlF72LtMQxpdhigDVyyiP6rTNuMibQquQHinC+0nHIpm/jwqgWndq0
         gV1hzOJWfgM7RmKjof/winBkQx3EHChka2ljE2IaZAlYPoeEyEjxTeRJDnJyyVDvmm
         68Xv6A+dZUctRizmPwFgT0sOp6xUxE5t8m9gdEn9HzK27K3zGkyOswJkhrrEIDFNcy
         KFuXANQmNLF6dz/YbUHEfQhMjtfIOlD5nIUbyNkEAlMqNTosxP/Fexf8Je1JbPGT9W
         P336N/Ojff3Ng==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 3/7] iio:ABI docs: Drop device specific docs for _powerdown for the adf4371
Date:   Sun, 17 Jan 2021 15:38:12 +0000
Message-Id: <20210117153816.696693-4-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117153816.696693-1-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The interface is standard and the extra info provided on exactly what is
being powered down is not of interest to most users.  Hence this doesn't
need it's own documentation and can rely on the docs in sysfs-bus-iio

Fixes:
$ scripts/get_abi.pl validate
Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:36  ./Documentation/ABI/testing/sysfs-bus-iio:588

Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
index 544548ee794c..457f75903963 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
@@ -34,11 +34,3 @@ Description:
 		  out_altvoltage2_name: RF16x
 		  out_altvoltage3_name: RF32x
 
-What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This attribute allows the user to power down the PLL and it's
-		RFOut buffers.
-		Writing 1 causes the specified channel to power down.
-		Clearing returns to normal operation.
-- 
2.30.0

