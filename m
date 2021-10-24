Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC634387E5
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJXJ3s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 05:29:48 -0400
Received: from www381.your-server.de ([78.46.137.84]:60886 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXJ3r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 05:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=OWUzf+fvC3aoz13ITh2Is6uOmBCraHFJLrucmFH18kA=; b=TnC70BcfaIqlhyGAc67r+uJDzs
        AI8SvoXJ99eUK6eBBlhJZraPLGUoIhDzfaZZKIefosj/C8tk+CxOpC0LiFGrdP/3IcO4BzJJzbu/H
        5Ll0OZib65onTJ3A2JV2KlGfr7wLISmiDfARl4UNi8oIg2ByDl2xklaD7WMznyehj/IzF7WMxT+5N
        1FBeg+Tx5WI2cWuJPTnFSEp0qqw2WAJ0zjv5bcqryAhbSEgwe1A6wMqFpsMt3Rhn+R8aECIQeLZ8k
        oz1RBG+7HoXWIcYsuOFRfx1sXjGo/hlAQowsLS+7p3Mbjipz+DC0GCNwg3CHYykVoTJZh9sQrATLl
        wOJAqU9A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meZmn-000BcJ-8v; Sun, 24 Oct 2021 11:27:25 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meZmn-0003Um-2I; Sun, 24 Oct 2021 11:27:25 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: mma8452: Fix trigger reference couting
Date:   Sun, 24 Oct 2021 11:26:59 +0200
Message-Id: <20211024092700.6844-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The mma8452 driver directly assigns a trigger to the struct iio_dev. The
IIO core when done using this trigger will call `iio_trigger_put()` to drop
the reference count by 1.

Without the matching `iio_trigger_get()` in the driver the reference count
can reach 0 too early, the trigger gets freed while still in use and a
use-after-free occurs.

Fix this by getting a reference to the trigger before assigning it to the
IIO device.

Fixes: ae6d9ce05691 ("iio: mma8452: Add support for interrupt driven triggers.")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 715b8138fb71..09c7f10fefb6 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1470,7 +1470,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = trig;
+	indio_dev->trig = iio_trigger_get(trig);
 
 	return 0;
 }
-- 
2.20.1

