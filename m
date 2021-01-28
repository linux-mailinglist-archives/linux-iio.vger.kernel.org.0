Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18256306B0C
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 03:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhA1CWF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jan 2021 21:22:05 -0500
Received: from m12-18.163.com ([220.181.12.18]:56237 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhA1CV0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Jan 2021 21:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jiZho
        EVTW/lCYKd8Ruwn3xN+HZWEAkjKH956OKc2B44=; b=cqCqvLo1i7XaRCL3rDNOP
        a5Cwbf3qY0fCfSAKD8ELLk8DOtvs92OIpMrhzhW7ryJTkMa0zQaH1suXFMv3Vi3f
        LcnzjZPamR9PrGpr585HpGRnftUE2JxCB/Wis6fqDEr0qXvyoI5wtHMpWRUoOI4J
        MHrBoswCkYXjygZGLAINo0=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAD3z80cHxJgPpqARQ--.46368S2;
        Thu, 28 Jan 2021 10:19:13 +0800 (CST)
From:   zuoqilin1@163.com
To:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] iio: fix typo
Date:   Thu, 28 Jan 2021 10:19:05 +0800
Message-Id: <20210128021905.963-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAD3z80cHxJgPpqARQ--.46368S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWUXFyruF43GryDJw18Krg_yoW3WrbE9w
        18AFn5WF1rurW0yrWaqrnxZr9a9a4UWrs7Z3Z2gayakFyUZFZ5Zrykur47Zr18XF4UGF1D
        Zrn0gF9YyFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe0tC5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRQEoiVPAJzE6bQAAs3
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

change 'regster' to 'register'

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/iio/dac/ad5791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index e3ffa4b..615d72c 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -76,7 +76,7 @@ struct ad5791_chip_info {
  * @chip_info:		chip model specific constants
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
- * @ctrl:		control regster cache
+ * @ctrl:		control register cache
  * @pwr_down_mode:	current power down mode
  * @pwr_down:		true if device is powered down
  * @data:		spi transfer buffers
-- 
1.9.1


