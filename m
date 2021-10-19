Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0C432E81
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJSGro (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 02:47:44 -0400
Received: from smtp1.axis.com ([195.60.68.17]:27136 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSGrn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 02:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1634625931;
  x=1666161931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OCzsBZ1UYObgnkazmJWe5p/esmlOxq+X2TO4w+LwJdM=;
  b=EfF1SY5tGzLPN4vRAJGy2i0SJigorRuWtN9HEkbq7RyDdW8qwGUGYCk/
   2qyZPiXuN2aTxxiC2Etvilj6QF37Sn2wy3HPzPGZ+oMue84mkCPFnIY5l
   X50lFgfx8TlbAGiBV9PZkUBdU5mmJakFmiNtYjqXzcUL8Q3vjV3IdTwk/
   6RC9gMCFc7yZXwCX7Tuc7SGsc6kU0Z/uY3AVDAhCNeGRAfxffIYuR2YiN
   NMqAAeXLvl6gSIME8Tu9KZdiw1UJ8w0jWMKEJfDCubxsYWVG8cPw/JJ9i
   T9aJvzPFEF+Q6hpMeVM4F32hE2NmGUFyJ/yt6/9zpp2wKm1tjlapwckJi
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mux: fix kernel doc prototype
Date:   Tue, 19 Oct 2021 08:45:21 +0200
Message-ID: <20211019064521.18113-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix this warning from scripts/kernel-doc:

 drivers/mux/core.c:391: warning: expecting prototype for
 mux_control_try_select(). Prototype was for
 mux_control_try_select_delay() instead

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index dee6945e92f7..22f4709768d1 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -371,7 +371,7 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 EXPORT_SYMBOL_GPL(mux_control_select_delay);
 
 /**
- * mux_control_try_select() - Try to select the given multiplexer state.
+ * mux_control_try_select_delay() - Try to select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
  * @state: The new requested state.
  * @delay_us: The time to delay (in microseconds) if the mux state is changed.
-- 
2.28.0

