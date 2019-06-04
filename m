Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93434704
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFDMiw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 08:38:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42651 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfFDMiw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2019 08:38:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so8291974plb.9;
        Tue, 04 Jun 2019 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t6p3O8G7Bhczja2EaMiJrgzvF31T1unkuQeJqUj7zZA=;
        b=eaVexESDvZrLu/1v6BuXlFfkx0129P5nzVs0O9AffAVZWEda/NHSdnAlPxceUBy/hu
         dMFzOPxP6WR+T/gc/gujVrBOoaTcQrxzN+ZoPtfyw/8DnISUKLpMOIwphPXE/wX5fEEz
         KzFlMKlAb/jbfTb7cl6tTctiVacZ/SeB8UZR0zvJcb2ETx9CzAyA1enXue4tDmoi/vIo
         mrIb2OW6DZLQb5pTTl2zpm/1CQqK4W/sXxFJKL9p/BvdLSWM467Q7qcreCvwBagpG6rD
         R2nxaEqX5meOhVIzj+Ur248oX2QZoAAzchOl6oqxjEPHVGBYsj+YaAAukSiaxURFhFyA
         0oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t6p3O8G7Bhczja2EaMiJrgzvF31T1unkuQeJqUj7zZA=;
        b=t1uylnTnKrrMHR2klZtjSZl36Dh+aPXjzU8ot9SQgBI4/AaVqkvgwass6xx1+qxN4w
         1I20JnhsuwBWB8C1Mq5EhmhV8ZYNf8pNkO/IZbiwwQSRuNQCpIyW6FacAezszqDTMjtQ
         zGmRo75S1HSaF6vIUFhweiTEOigOzETEsbqs8HHIRBOl2izJeeujr+U+fYFm9mS/NFAt
         OQGX6IHfz8t7aE9q+FEY9jAZTMKFLrCwMQYiyxBkm6cAR+wi8isA3wZIcKGXATDxmqxe
         OZKO2UAI96M9zIvqJbx1oSOf1FtlAkBlE69vIzuSpsUB30UOOjoUPYmJUsR5IRv7gmda
         oumA==
X-Gm-Message-State: APjAAAUhEh8bjUSQljS/EAzN5eSA/Novmj86ARoxVIV5zkHq857r+h2B
        LkV7om5Vh7cXCjLD+K9pp5M=
X-Google-Smtp-Source: APXvYqwZ834hkYLv69+lDOPH+CsgYwM71HGit6MDC9WMWVBREye+TMlrP2lkbO/tbWAM14IMoxXV3g==
X-Received: by 2002:a17:902:2924:: with SMTP id g33mr36941909plb.57.1559651932044;
        Tue, 04 Jun 2019 05:38:52 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id d24sm15086660pjv.24.2019.06.04.05.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 05:38:51 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] iio:core: Fix bug in length of event info_mask and catch unhandled bits set in masks.
Date:   Tue,  4 Jun 2019 20:40:00 +0800
Message-Id: <1559652000-18333-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The incorrect limit for the for_each_set_bit loop was noticed whilst fixing
this other case.  Note that as we only have 3 possible entries a the moment
and the value was set to 4, the bug would not have any effect currently.
It will bite fairly soon though, so best fix it now.

See commit ef4b4856593f ("iio:core: Fix bug in length of event info_mask and
catch unhandled bits set in masks.") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/iio/industrialio-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f5a4581..dd8873a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1107,6 +1107,8 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 	char *avail_postfix;
 
 	for_each_set_bit(i, infomask, sizeof(*infomask) * 8) {
+		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
+			return -EINVAL;
 		avail_postfix = kasprintf(GFP_KERNEL,
 					  "%s_available",
 					  iio_chan_info_postfix[i]);
-- 
2.7.4

