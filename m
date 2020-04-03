Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1019D790
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDCN1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 09:27:24 -0400
Received: from www381.your-server.de ([78.46.137.84]:34650 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDCN1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 09:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QNulSPFYe2rb7/1as5iAxcoShdThpR0LSaF8Xw4+98M=; b=AAGNkgaVq6fgHt2AaXZNS/oqJX
        Gf/L5NmhirbZrYE+4tlZfDC57KG8bDKtwGMgyJDwa1j/DvAClU+MvJASiazQqxeSTR5x2iWoEF83v
        rPBrK0coV9+qM0EJVmr0Eg5mhaAkQKDaruMlGtHKp0E5yySkyUjPxUPQyCUrPLIu34bjO02khBarY
        Ab8Ol2oMOBnLAy8t6ctH4mBvaTOvByEcyy8TA/dUCm2Xr0/2ykPQBOBmdXMHvcgrDkIYoJjB75cjS
        HwSeAEowZJ34deJseap0qtO8sS1WAIBOKawB//2pKTVrQysloq9NwaY2WE1IMPPpPBMAtJ06/BWPi
        YwHZYpIw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLz-0004Fb-IJ; Fri, 03 Apr 2020 15:27:23 +0200
Received: from [82.135.69.229] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLz-000CaC-9X; Fri, 03 Apr 2020 15:27:23 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] iio: xilinx-xadc: Fix typo
Date:   Fri,  3 Apr 2020 15:27:17 +0200
Message-Id: <20200403132717.24682-5-lars@metafoo.de>
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

Fix a typo. 'at the a time' -> 'at a time'.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index c724b8788007..d7fecab9252e 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -663,7 +663,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 	mutex_lock(&xadc->mutex);
 
 	if (state) {
-		/* Only one of the two triggers can be active at the a time. */
+		/* Only one of the two triggers can be active at a time. */
 		if (xadc->trigger != NULL) {
 			ret = -EBUSY;
 			goto err_out;
-- 
2.20.1

