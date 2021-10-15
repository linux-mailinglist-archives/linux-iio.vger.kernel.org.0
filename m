Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93942F705
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhJOPfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 11:35:03 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:60226
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232267AbhJOPfD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 11:35:03 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 38D8F40037;
        Fri, 15 Oct 2021 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634311975;
        bh=Tg9IeCCBv4+HHQfWd/djCoMaz0+627g42eee6E57FUI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Qauj/MjpinRaX/jHJt4wKqaOIJFslib8A/Nm3D83GO7GpcCEhoMXfHHg877mlwSgO
         o3vXC+PznKTclx/Jnc3gs5WMPpkVbPdPreDRzbg853Bc6oSSd1GgbbHihnAA78Em72
         DpSPU68N/6yo7qRBpsR/BBt7OKliNImlR9bHfSztUZ+EgBJcdOG40FJpiVuNHvbFaP
         TqxW7tu3DfbbEukwRXrOkQhKWRvp3BmFqLn6/knB9tkua2aYP10KjbfxOISopu4E50
         JGvRDjaKs25lppDMtW9zuxa2hCW2Zv37L2tUZouBKzN5na5TT6IZ4azKQAtH8YCPd9
         8UQ5Edb5VjxdA==
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: Fix uninitialized variable ret
Date:   Fri, 15 Oct 2021 16:32:54 +0100
Message-Id: <20211015153254.33783-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

When !iio_buffer_space_available(rb) is true and signal_pending(current)
is false the end of the do-while loop is reached and the uninitialized
variable ret is zero checked. Fix this by initializing variable ret to
zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: ffabbffd40f2 ("iio: Add output buffer support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b884d78657cb..c97fb8462395 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -179,7 +179,7 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 	struct iio_buffer *rb = ib->buffer;
 	struct iio_dev *indio_dev = ib->indio_dev;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int ret;
+	int ret = 0;
 	size_t written;
 
 	if (!indio_dev->info)
-- 
2.32.0

