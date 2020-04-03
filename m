Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3219D78D
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgDCN1X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 09:27:23 -0400
Received: from www381.your-server.de ([78.46.137.84]:34592 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCN1X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 09:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1IrQdbu7tyYdSKK050q5g4YMCe3FnKIuycTwbg8brX0=; b=XWRHd4eFei1Aak4xapT1DpFhDf
        SGOY4M8H23myvNEfuUGMCPa3AB6x2UL6M475ouMCeZDyMRe58EhYW0eUpszmRRUdTGcWNAKFsPxX4
        4ptSRSU96NflOadmRFX6afVhiun73UKYP8sYGFb92xUExla6V4CPTwLIBNtjh3xIj8BQ89xKzf02y
        nV6lWgMgGJQCRnrRjZ53QLJH8pBCXBYju/1UYZx3ClcdiFdZAKFM3SmE2O9KGxIte8PhvgdIu6aQy
        ATX/es1aypKjqSmUX+h4N9L8QnmQA2aoqJT8IMnoNjtNpzeSgbYbZXfUbo0WuyoWK71TNQVBfKfUK
        Gx4lGPCg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLy-0004En-7a; Fri, 03 Apr 2020 15:27:22 +0200
Received: from [82.135.69.229] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLx-000CaC-UX; Fri, 03 Apr 2020 15:27:22 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] iio: xilinx-xadc: Fix clearing interrupt when enabling trigger
Date:   Fri,  3 Apr 2020 15:27:14 +0200
Message-Id: <20200403132717.24682-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403132717.24682-1-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When enabling the trigger and unmasking the end-of-sequence (EOS) interrupt
the EOS interrupt should be cleared from the status register. Otherwise it
is possible that it was still set from a previous capture. If that is the
case the interrupt would fire immediately even though no conversion has
been done yet and stale data is being read from the device.

The old code only clears the interrupt if the interrupt was previously
unmasked. Which does not make much sense since the interrupt is always
masked at this point and in addition masking the interrupt does not clear
the interrupt from the status register. So the clearing needs to be done
unconditionally.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4fcf1729341f..04a2a609ced4 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -674,7 +674,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 
 	spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, val & XADC_AXI_INT_EOS);
+	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
 	if (state)
 		val |= XADC_AXI_INT_EOS;
 	else
-- 
2.20.1

