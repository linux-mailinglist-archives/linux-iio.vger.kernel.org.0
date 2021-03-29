Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBFC34D9D1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 23:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhC2V6b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 17:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhC2V6Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 17:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A41961481;
        Mon, 29 Mar 2021 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617055096;
        bh=ARxgytYYbc0pvxc9szjy73NYkLMwf11cpxbHeU690ek=;
        h=Date:From:To:Cc:Subject:From;
        b=h98V8oc5H1o6eE1RXoALvixBgKafkpcm1VRxrmrZ6JUKku0TJrda1xJ3kceLyC5GH
         qUJL+1jA1R8MU0Bc7lrZ5JSP9qGhDOzhgBT5pEo+ghLHMviMBYNWeRIaw8rR2tfkvt
         //2qQHgek3RMySa78iHvsFqdHpSI8ziiu30jte3k6bLXDhQsCZyay7SMsn0ej3bpLt
         l9caVojhwOn/b+e2vfdxlgS5sf8xb6qMWaacFIbNSBszLt54AOWuKwWdWCRQRV8MwU
         lkD5lxlHxqYh8ExIx1RDr4gLUIxEtYi7I2jF/ChILUnh2qG7/QL57dLeqY7TwBo8dY
         VHrWGDAfhA9aQ==
Date:   Mon, 29 Mar 2021 15:58:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] iio: hrtimer-trigger: Fix potential integer overflow
 in iio_hrtimer_store_sampling_frequency
Message-ID: <20210329205817.GA188755@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add suffix ULL to constant 1000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is being used in a context
that expects an expression of type unsigned long long, but it's
currently evaluated using 32-bit arithmetic.

Addresses-Coverity-ID: 1503062 ("Unintentional integer overflow")
Fixes: dafcf4ed8392 ("iio: hrtimer: Allow sub Hz granularity")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 51e362f091c2..716c795d08fb 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -63,7 +63,7 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
 	if (integer < 0 || fract < 0)
 		return -ERANGE;
 
-	val = fract + 1000 * integer;  /* mHz */
+	val = fract + 1000ULL * integer;  /* mHz */
 
 	if (!val || val > UINT_MAX)
 		return -EINVAL;
-- 
2.27.0

