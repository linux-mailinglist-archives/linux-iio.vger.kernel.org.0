Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA627507C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 07:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIWFzQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 01:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIWFzQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 01:55:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B42221EF;
        Wed, 23 Sep 2020 05:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600840515;
        bh=aOKtZI1CbPAyR48GMLTux6LI2qtvqlpc7xFg/7KZEb0=;
        h=Subject:To:From:Date:From;
        b=NeFdYXOaTjHxkGuZvH3TwenyaJZ5mqVnhNGVJmnpRZasVMg/k7f9rWW6I6b18k7tY
         dREaf2vtaWKnONyvMqBaQWBkaP4Xhyh0R9jT/xEQMsPloLU+oriqsOijnK45hQWnCr
         aNxqmnVi5SXZi+WhHwbhB5tTN1+Apy6EqiQEg2nY=
Subject: patch "MAINTAINERS: Move Hartmut Knaack to Credits" added to staging-next
To:     krzk@kernel.org, Jonathan.Cameron@huawei.com,
        andy.shevchenko@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 23 Sep 2020 07:55:31 +0200
Message-ID: <1600840531222121@kroah.com>
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
in the staging-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


