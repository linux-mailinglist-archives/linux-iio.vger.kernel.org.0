Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674792A37C7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 01:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKCAcq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 19:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCAcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 19:32:46 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D1FC061A47
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 16:32:44 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id x5so9902949qkn.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4FrNzJg1aR1e5IxdfhK5vpGCyHiDXQ0Jq8P4BQVMTZk=;
        b=PBgm8fy3QQi5IOq8hDzD4qxrNWroRHlYlatQPiR6flH42pcVtyQ6XYyA7LchOH+9Je
         7sPYI8Dj/kXh2pHBLJ0s652A7YdyaV2NTHyq9AXgCeFqD1MMqsVwRcqbDwIOj/G8VOY5
         Rkf7f0yUECJdsflxUgM9Gxd/PKPQEU11xE5LKKpOHTppeyKL83nT/NA2IuFFxhHHws5G
         XdoSlNk2yJ5Ju9xzlB0Plr0Srz3JBWvP9nj0X+x5hdDqxHendXfQ7s2hKSPNV371bWfW
         56zPbim7RHNqZT7fhiwlwpbKHPCV7tq7I4fAoJ5WIaIpNa9VIIi7GRTKQhe9I3mM8Mkm
         mbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4FrNzJg1aR1e5IxdfhK5vpGCyHiDXQ0Jq8P4BQVMTZk=;
        b=n3hUQhkD3yVwnkVFLWxNts+OPYx7SCWiIP7T/cICJFA4wA9/GKOurbZZeET1hX31tm
         aL6sUPuvzEmky/BnGwFyk605xE/lp8gFv4IwSF+gaY52rmqMwffOtc96Hp9ZyAta2xfN
         oEnj1iV154oTrDquH54bcsC5Uvsa1iLRixahBBwK23+1G1e4nGdBH4eU+7yga29tE9Yy
         88LGjJkPxtmqXmzSvoKmqMpYSYQGhG5+tBay68nCVuzgd1jR6O8I9FExiZ37L3vh4qWg
         WnCpP7YqIqC2ykNJAF3AJcGLeYlNih5gX/s/J5I64/vtv2A3BAKo40Oz2t1W9Xz/Prqb
         5Q+g==
X-Gm-Message-State: AOAM530x6JnXNJC9hnXlGMxtVz/4uO8OQ4FEYeiFekUoxPkaVMPKQLeG
        mXgmhO7TXkEz3FLbroLloLTRkFoqsP/6AJA=
X-Google-Smtp-Source: ABdhPJyk81T/dUq2WW/IVqG8pt9qyjKsvDRjHaakGQvyS+yoe4IpXlP8TrH+qKj18ohoqh8PysSvKlt/NeQuKRA=
Sender: "pceballos via sendgmr" <pceballos@pceballos2.nyc.corp.google.com>
X-Received: from pceballos2.nyc.corp.google.com ([2620:0:1003:510:de4a:3eff:fe70:84c])
 (user=pceballos job=sendgmr) by 2002:a0c:e40c:: with SMTP id
 o12mr25392268qvl.29.1604363563963; Mon, 02 Nov 2020 16:32:43 -0800 (PST)
Date:   Mon,  2 Nov 2020 19:29:39 -0500
Message-Id: <20201103002939.688690-1-pceballos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] HID: hid-sensor-hub: Fix issue with devices with no report ID
From:   Pablo Ceballos <pceballos@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pablo Ceballos <pceballos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some HID devices don't use a report ID because they only have a single
report. In those cases, the report ID in struct hid_report will be zero
and the data for the report will start at the first byte, so don't skip
over the first byte.

Signed-off-by: Pablo Ceballos <pceballos@google.com>
---
 drivers/hid/hid-sensor-hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 94c7398b5c27..3dd7d3246737 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -483,7 +483,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 		return 1;
 
 	ptr = raw_data;
-	ptr++; /* Skip report id */
+	if (report->id)
+		ptr++; /* Skip report id */
 
 	spin_lock_irqsave(&pdata->lock, flags);
 
-- 
2.29.1.341.ge80a0c044ae-goog

