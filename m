Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0105646DDEA
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 22:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhLHWBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 17:01:17 -0500
Received: from mx1.librem.one ([138.201.176.93]:45316 "EHLO mx1.librem.one"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhLHWBQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Dec 2021 17:01:16 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 17:01:16 EST
Received: from smtp.librem.one (unknown [192.241.214.14])
        by mx1.librem.one (Postfix) with ESMTPS id 5E87681B0B
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 13:50:15 -0800 (PST)
Authentication-Results: name mx1.librem.one; dmarc=fail (p=none dis=none) header.from=librem.one
Authentication-Results: mx1.librem.one;
        dkim=pass (2048-bit key; unprotected) header.d=librem.one header.i=@librem.one header.b="P7tJync4";
        dkim-atps=neutral
From:   Zach DeCook <zachdecook@librem.one>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=librem.one; s=smtp;
        t=1639000213; bh=t5dhQo7lKbSB0gm8FfszNuXJIM9GZbmEzQSX56qZ59o=;
        h=From:To:Cc:Subject:Date:From;
        b=P7tJync4YdeA9ph4v56ghQLfyHic8Yva1PKS74mwI2m3Ee+WM90nn7naR0HTya9fD
         Kzy8DIoRIJAwCxzilfyniq2JOl2lGfV424d4QIJYgsRTzehRcINFP8Xy7GeQm7WQEf
         upQspc3To7jxeNuvUalCBPG2XypqdqY4Gnddel1vW6npA/CPDkbEK+AyKTYOgISRi+
         +J9TAaLS+aSKC9o7Z6O3J6+aKEvgkH7yMODXUkDg/vehPtjhDqikI2PGXBYc92hhlj
         cXSoLRPEF7bzmNUyBoKA7EBzaAyNLc5GQ7wCEhTxki9aBRjSd+osH8nFHNw6sZsDx8
         LeSyHTnkryB3g==
To:     linux-iio@vger.kernel.org
Cc:     Zach DeCook <zachdecook@librem.one>
Subject: [PATCH] iio: event_monitor: Flush output on event
Date:   Wed,  8 Dec 2021 16:48:08 -0500
Message-Id: <20211208214806.3225-1-zachdecook@librem.one>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By flushing the output, iio_event_monitor can be more useful to programs
chained along with it.

  iio_event_monitor stk3310 | awk '/rising/{system("my_unlockscreen.sh")} /falling/{system("my_lockscreen.sh")}'

Without this flush, the above example would buffer a number of events,
then after a while run the lock/unlock scripts several times.

Signed-off-by: Zach DeCook <zachdecook@librem.one>
---
 tools/iio/iio_event_monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 0076437f6..b94a16ba5 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -279,6 +279,7 @@ static void print_event(struct iio_event_data *event)
 		printf(", direction: %s", iio_ev_dir_text[dir]);
 
 	printf("\n");
+	fflush(stdout);
 }
 
 /* Enable or disable events in sysfs if the knob is available */
-- 
2.34.0

