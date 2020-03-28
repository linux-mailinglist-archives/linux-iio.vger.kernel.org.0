Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3441D1963F8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 07:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgC1GfR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 02:35:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38134 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgC1GfR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 02:35:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so5030597pfo.5;
        Fri, 27 Mar 2020 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etzlIQkap/HQGAt9AHwYnTRq8Pfsx8vvSgBOokn+rgg=;
        b=J/yaeS0Pl+8/sgomNJI/sCIe90HEWufMMdxyzcc61YUrYv7zt1ARMGDrTB2RQzrPQd
         okVWh0FYOSQvEoZM3Uw8KRrQ27ys40sEAu0fpjtXHPimt3AsfUNUigFdeQuanEjJGuZ7
         E+qzu6BPLh6p1/6SNI9jw12m81c6CArf5Th8BvyB9bTyqfIeZvIlvXwmbNcS3jbWRNTl
         QN6q69DMXrDyJEO/SdMGS2NPm4qCbVGZMdKRGJFC4WY/B8UL4JEVV+nGfRqn40vG1fPa
         h+rLKeyWxC/ZDhs1oa7x83vdZB8wGu8UGT3GaCjyLPooY8ntYuYTGQWNW6SLifrgxdSS
         oh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etzlIQkap/HQGAt9AHwYnTRq8Pfsx8vvSgBOokn+rgg=;
        b=BSI4Vid7ohrqR+5+hUL0E9kik4hSaNgt4xsR2/Dvj1BAGyaY5TfwKk8grv1OUxiFKr
         JXQ4kvjqPDQsuO3v8lD9b97sF5jw8QHyR6N8Vs9SzU4l2bDWL+hvB7mxXe0eHl/PTSxK
         MHqYRfL0s8WnbfGi/8WNlF5BZdIleG+X8BE5HtS17S75nlP+GsxurewRNh44hJHm9MaO
         h2esVDwlZquEl8mxZuBkck3+0bgFJwdCnOpm4a99SbwG1/izs4S0OaG80+zU72u4ywyp
         Jh+PTqiXmsQaIaPv5ZqDNUBMgjJe1TqW4jezA756knHrEUAPEe8nWhlz8t/sFh5EErEi
         RplQ==
X-Gm-Message-State: ANhLgQ3lOxYPAXtLK/KnUKjikLflldYmzKtvy1Tr+/Cda31mBvf8s3Xa
        zoIKqid5Jr0I1tTVd9qUc4pNQCj9zPM=
X-Google-Smtp-Source: ADFU+vsOAJPjdB9JlcfHibQkVn0JMjnqDb7yFnZs7ngsQpCeSboPRcw06uKUaAVsCsm34dCsFFornQ==
X-Received: by 2002:a63:5716:: with SMTP id l22mr3071643pgb.164.1585377315987;
        Fri, 27 Mar 2020 23:35:15 -0700 (PDT)
Received: from localhost.localdomain ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id l13sm4989976pjq.42.2020.03.27.23.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 23:35:15 -0700 (PDT)
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     dragos.bogdan@analog.com, Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Sat, 28 Mar 2020 12:04:53 +0530
Message-Id: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
X-Mailer: git-send-email 2.23.0.385.gbc12974a89
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The debugfs_create_file_unsafe method does not protect the fops given to
it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
which makes the fops aware of the file lifetime.

Further using DEFINE_DEBUGFS_ATTRIBUTE along with
debugfs_create_file_unsafe significantly reduces the overhead introduced by
debugfs_create_file which creates a lifetime managing proxy around each
fops handed in. Refer [1] for more on this.

Fixes the following warnings reported by coccinelle:
drivers/iio/imu//adis16460.c:126:0-23: WARNING: adis16460_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16460.c:108:0-23: WARNING: adis16460_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16460.c:90:0-23: WARNING: adis16460_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16400.c:278:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16400.c:261:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE

[1]: https://lists.gt.net/linux/kernel/2369498

Rohit Sarkar (2):
  iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
    DEFINE_SIMPLE_ATTRIBUTE
  iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
    DEFINE_SIMPLE_ATTRIBUTE

 drivers/iio/imu/adis16400.c | 4 ++--
 drivers/iio/imu/adis16460.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.23.0.385.gbc12974a89

