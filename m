Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2A174768
	for <lists+linux-iio@lfdr.de>; Sat, 29 Feb 2020 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgB2Oh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Feb 2020 09:37:27 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39599 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgB2Oh1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Feb 2020 09:37:27 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so2513846pjr.4
        for <linux-iio@vger.kernel.org>; Sat, 29 Feb 2020 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=RQ63tn6wCU4bwsUCms9Q/+Wuf/O1k0oWayITUDxYZxo=;
        b=nUY/3JzAKdJKQpLHiLDNANlrI6dJRKsU8I++kDzsC3aIAVEQ0CHjYYla6eUyOL6cm2
         5BKUGC5IijaOoO9vf5zOcMID51o4Xf0C+YFlUyLRfOubMxZgFE9u7hlTlmzlgXonKXSk
         /DWF6v5FcCZQwHZxAV4+yj/Ypc5jCiVWVgVNs/xWwXTN14S7HCykKo8jEr0G5JUmCRGX
         PJI1oBffYogvK/8rDD3GEL18IFeuFkSTa7IcXkAR+5N5AbcB3bsPWNbNXxV8wbanBnA9
         HZKIUr9HKWVWjgJCJZbK2NtGbsCn4Qat0roY/6hDn5pjnBY6jnKgpe4H9B7QSqpCa/Cq
         GMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=RQ63tn6wCU4bwsUCms9Q/+Wuf/O1k0oWayITUDxYZxo=;
        b=ZVJ8I4JAxx1owbiG4absGOmE3KcZA3/FtS8IinqT1JqCgktqNVC3960rQHl0XAbSym
         zdbhjgthEtsF1g/S7gThSsl5Xc/YpluF1XboDQZR+a9bYI6Y1sVMpUQ3TzOr3/ndCp6X
         Ugjpn+FaPZ8J0rAD5KjlYlH/3i8a3J4EUzycTg0ceW4LX8pIu2XSizhr5mhQ7qcvkHIE
         nOoIbUhRwzTqykh8G2u6BBipfDQ/D3tuWPgir4OiHyL6XjrWtz5RtyuDStC79bz1xF3J
         wLrJ8LTk3Yto/ZeglGdf2OnbMFjWWeeXYwbzsh1+stwLoKq2gmO0XeBeVlGR+aKOHEp6
         g0ig==
X-Gm-Message-State: APjAAAUm6PB3cx+6l8xsHxik0EEJSrNXoS+6IHHD2CUv1Y4LoOPjqVsZ
        9GohxSuJUAYnIkxzWebfVNJzEDfxnrnweg0X
X-Google-Smtp-Source: APXvYqxAPjv8UfC2gQ11u0jaPmtPXADgr2is3kFbvKm+68WIniQjj3BW6Ef9yDES36Ih+o6/KY/dqA==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr10559018pjt.95.1582987045762;
        Sat, 29 Feb 2020 06:37:25 -0800 (PST)
Received: from SARKAR ([49.207.56.215])
        by smtp.gmail.com with ESMTPSA id r198sm16194504pfr.54.2020.02.29.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 06:37:25 -0800 (PST)
Message-ID: <5e5a7725.1c69fb81.e50cb.9224@mx.google.com>
X-Google-Original-Message-ID: <20200229143721.GA3975@rohitsarkar5398@gmail.com>
Date:   Sat, 29 Feb 2020 20:07:21 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH] iio: add a TODO
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a TODO file with some work items added with reference to
the conversation in [1].
A TODO file is immensely useful while onboarding new contributors who
are looking for some low hanging fruit to get their foot into the door.
Since these items affect all drivers the file has been placed in the
root iio directory instead of augmenting the staging TODO.

Thanks,
Rohit

[1]: https://marc.info/?l=linux-iio&m=158256721009892&w=2
Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/TODO | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 drivers/iio/TODO

diff --git a/drivers/iio/TODO b/drivers/iio/TODO
new file mode 100644
index 000000000000..498f9336def0
--- /dev/null
+++ b/drivers/iio/TODO
@@ -0,0 +1,26 @@
+2020-02-29
+
+Documentation
+  - Binding docs for devices that are obviously used via device
+tree
+  - Yaml conversions for abandoned drivers
+  - ABI Documentation
+  - Audit driviers/iio/staging/Documentation
+
+- Replace iio_dev->mlock by either a local lock or use
+iio_claim_direct.(Requires analysis of the purpose of the lock.)
+
+- Converting drivers from device tree centric to more generic
+property handlers.
+
+- Refactor old platform_data constructs from drivers and convert it
+to state struct and using property handlers and readers.
+
+
+ADI Drivers:
+CC the device-drivers-devel@blackfin.uclinux.org mailing list when
+e-mailing the normal IIO list (see below).
+
+Contact: Jonathan Cameron <jic23@kernel.org>.
+Mailing list: linux-iio@vger.kernel.org
+
-- 
2.23.0.385.gbc12974a89

