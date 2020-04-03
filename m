Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CC19D78F
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgDCN1X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 09:27:23 -0400
Received: from www381.your-server.de ([78.46.137.84]:34604 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDCN1X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 09:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5LIMNj7aL7Luva0dPbsX5fUhHcBa+AmvTONQjXkj9uI=; b=lPWdrJdBr2t87+TDH9Fi7uXDtF
        AKm5k2DDVSKZeNhaYuiDl4+2KeX/42TqsHfHlBvJWImr+orFHPuCzWbuSNkUJT6fxiI3toUFmtic0
        FUJiDpYK67DZzl+DlAHmiX5xaSllVSRA5QWrBYFn/Y6gTkww+zUbVLdMg2GaxUomHV8m5/MVYzTSq
        D9mM9cx2fvUINmm8faUn1fcJbbKECKUvbFWBHBLpQcpJqsU9FPqVYJXAJ1a29KEC05bBhJ8AiudnT
        4G4NQmlgp8P7WD/w40JDSGFnFAwDk5ywo0u8wE7jDX2O94TQm0ggpzb3SDKH1W++F+FNPhngcI4Cp
        /+I/cQsQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLy-0004F6-Md; Fri, 03 Apr 2020 15:27:22 +0200
Received: from [82.135.69.229] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLy-000CaC-Ds; Fri, 03 Apr 2020 15:27:22 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] iio: xilinx-xadc: Fix sequencer configuration for aux channels in simultaneous mode
Date:   Fri,  3 Apr 2020 15:27:15 +0200
Message-Id: <20200403132717.24682-3-lars@metafoo.de>
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

The XADC has two internal ADCs. Depending on the mode it is operating in
either one or both of them are used. The device manual calls this
continuous (one ADC) and simultaneous (both ADCs) mode.

The meaning of the sequencing register for the aux channels changes
depending on the mode.

In continuous mode each bit corresponds to one of the 16 aux channels. And
the single ADC will convert them one by one in order.

In simultaneous mode the aux channels are split into two groups the first 8
channels are assigned to the first ADC and the other 8 channels to the
second ADC. The upper 8 bits of the sequencing register are unused and the
lower 8 bits control both ADCs. This means a bit needs to be set if either
the corresponding channel from the first group or the second group (or
both) are set.

Currently the driver does not have the special handling required for
simultaneous mode. Add it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 04a2a609ced4..4acababda4d5 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -798,6 +798,16 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err;
 
+	/*
+	 * In simultaneous mode the upper and lower aux channels are samples at
+	 * the same time. In this mode the upper 8 bits in the sequencer
+	 * register are don't care and the lower 8 bits control two channels
+	 * each. As such we must set the bit if either the channel in the lower
+	 * group or the upper group is enabled.
+	 */
+	if (seq_mode == XADC_CONF1_SEQ_SIMULTANEOUS)
+		scan_mask = ((scan_mask >> 8) | scan_mask) & 0xff0000;
+
 	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(1), scan_mask >> 16);
 	if (ret)
 		goto err;
-- 
2.20.1

