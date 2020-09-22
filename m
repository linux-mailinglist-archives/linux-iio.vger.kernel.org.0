Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5A273C54
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgIVHq6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 03:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgIVHq4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 03:46:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC4623A84;
        Tue, 22 Sep 2020 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600760816;
        bh=4oZ5by09yITB4SUrcqDrlAJHzG/2I+TXgRFmJYiQigU=;
        h=Subject:To:From:Date:From;
        b=TEMf6TCsF31EVmLTToEzY3MW7IfKN7W6N6vwTxRiV+ierZWmwf21r+qnCCo8xw6vC
         m9Yw758AQmVWCNKYhJl6yufD1ovckjR91cPUliP9jma1tPTNfAaA7AqoMgnSFigRP2
         hXKLftnJEqYVWXGH4SPe3Ic7TIYTyZhC27+GTTPI=
Subject: patch "MAINTAINERS: Move Hartmut Knaack to Credits" added to staging-testing
To:     krzk@kernel.org, Jonathan.Cameron@huawei.com,
        andy.shevchenko@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 22 Sep 2020 09:46:45 +0200
Message-ID: <1600760805112137@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    MAINTAINERS: Move Hartmut Knaack to Credits

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the staging-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From d3333e21f2d76fa384200a0826d766285787493f Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 3 Sep 2020 20:19:26 +0200
Subject: MAINTAINERS: Move Hartmut Knaack to Credits

Hartmut Knaack was an active reviewer and contributor to the IIO
subsystem and drivers.  However his last message on LKML is from
October 2015.

In thanks for Hartmut's effort, move him name to the Credits.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Link: https://lore.kernel.org/r/20200903181926.5606-2-krzk@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 32ee70a7562e..c741455498a4 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1942,6 +1942,10 @@ S: Post Office Box 611311
 S: San Jose, California 95161-1311
 S: USA
 
+N: Hartmut Knaack
+E: knaack.h@gmx.de
+D: IIO subsystem and drivers
+
 N: Thorsten Knabe
 E: Thorsten Knabe <tek@rbg.informatik.tu-darmstadt.de>
 E: Thorsten Knabe <tek01@hrzpub.tu-darmstadt.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e4fe7d2cec7..950e1d657411 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8451,7 +8451,6 @@ F:	drivers/iio/multiplexer/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
-R:	Hartmut Knaack <knaack.h@gmx.de>
 R:	Lars-Peter Clausen <lars@metafoo.de>
 R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
-- 
2.28.0


