Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40CD16B0B6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 20:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXT7W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 14:59:22 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53597 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXT7W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 14:59:22 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so209641pjc.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2020 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D4b30bsFaM6aQ6rqyFLlBvmrkLtttzdiSpKK5W3uPsQ=;
        b=OLSAsUBE9Mu3JoY5a8xmaNZ++B2E03CuwO9FLQfTppS/VgA9WgcCIMZQ3lMxIakQO9
         aeukzi+XoBHSDOgYoOr/19AKu4dZgoHbE8DStNw3xtAhKg7P+AAX83R5T2CSEiQSga7c
         vioTb5TzzXlju2wwlvJCJXzCC9beEBscZxH1ULjgf4EhsRVyU6jLjSq4iEPCgexcsFfQ
         aKQYgUfG9AdIPDLaznwg1Yz8ahXhieRWRd6aa4uHThGUZDV+GAj3xKB/TSqOmHoHMu2E
         Yhx5Y/R1qO+ZDt0RevJlL0SMM1L0PfqcYLm3X/1RExp/AWVRNZWAHMd0N4sGw438rupd
         pIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D4b30bsFaM6aQ6rqyFLlBvmrkLtttzdiSpKK5W3uPsQ=;
        b=R0abnapnUsyc969XW8aFyd3G6gMJ7M7tdrQ/0jUXkBiMzkl+Riwznv8pdOlOkKOqQm
         OMnNNcd2iExhjozViCpom9UmfoZoVp+mBq6vashPysBdKZb2N5s1OveY5bT3OVji6esf
         DqVQyZNXtKaQatkn6nDX4JqCzVFmFG8eCrVTMPoHeQ1k9ch6sEuULKpZqSHHrQT5K3NI
         1c6VoLcizcr9CUJi8BHKB0epwCjWoDfa9WC8PtbEEiQONjaZEnmmV70Qsfts1D+aA+8t
         Pyq//VDoCtvZbOeOk/fBWTzH7B5LcOdAKjlnV813pz107mBVIHGJKPDAOHsl5ZX4jYt7
         kMJQ==
X-Gm-Message-State: APjAAAWCJcPGtJb8ey+8sKHXUr8tbpFROBEd01hSAADRstmAqPNaiX49
        gL0xy6ep8HVhEMk8b2YAZ6rxHGDSjcU=
X-Google-Smtp-Source: APXvYqzMO6snqqS4kZrtZMsvWd04UcispwWolEkebly7CBw6rrm+l1c+XOUPvI86A/qE9F8b8P6auw==
X-Received: by 2002:a17:90a:f012:: with SMTP id bt18mr884273pjb.8.1582574360420;
        Mon, 24 Feb 2020 11:59:20 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id b1sm13789918pfp.44.2020.02.24.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 11:59:19 -0800 (PST)
Date:   Tue, 25 Feb 2020 01:29:15 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     rohitsarkar5398@gmail.com, devel@driverdev.osuosl.org
Subject: [PATCH] staging: iio: update TODO
Message-ID: <20200224195915.GA8371@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

gregkh@linuxfoundation.org, jic23@kernel.org
Bcc: 
Subject: [PATCH] staging: iio: update TODO
Reply-To: 

Since there are no more uses of the old GPIO API in iio staging drivers
remove that work item from the TODO.

Add other work items with reference to the conversation in [1]

[1]: https://marc.info/?l=linux-iio&m=158256721009892&w=2

Thanks,
Rohit

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/iio/TODO | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 1b8ebf2c1b69..783878f25f08 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -1,11 +1,13 @@
-2018-04-15
+2020-02-25
 
-All affected drivers:
-Convert all uses of the old GPIO API from <linux/gpio.h> to the
-GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-lines from device tree, ACPI or board files, board files should
-use <linux/gpio/machine.h>.
+- Documentation
+  - Binding docs for devices that are obviously used via device tree
+  - Yaml conversions for abandoned drivers
+  - ABI Documentation
+  - Audit driviers/iio/staging/Documentation
 
+- Replace iio_dev->mlock by either a local lock or use iio_claim_direct.
+(Requires analysis of the purpose of the lock.)
 
 ADI Drivers:
 CC the device-drivers-devel@blackfin.uclinux.org mailing list when
-- 
2.23.0.385.gbc12974a89

