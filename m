Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154BB19D78E
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbgDCN1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 09:27:24 -0400
Received: from www381.your-server.de ([78.46.137.84]:34596 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCN1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 09:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mKLtDFlWzGTg0/5VkHR2G7E5TZJyHDnYIgUzIEAvaIY=; b=FHY4MvB6vAfvskY7KhCSWF4sf2
        Ygm5ir+iCki35fy/UjRlTFnILMIlLJHtpIYd6lDy8XoX0Sq0d3YEhFmXcP5icyEC3+bt5d288W8wM
        KJ/0gCrRaxemSjJh7AlFnsV+dLYZaPLPlS7ViXE1+QdCoR0WvTGYQDjx7vJkYBwC1uKI2KrgTlv49
        iwxOQl5xNkfi1dTqD0s4bU9nnVZ2VRmgNlpw7F4foBjpMlt3Y2O9y9999DSpT1zmZLe/hH+7dG7s1
        t46eM7yOzysOgGifYIz5Z9GuFc4o481X+VH27CPsxIonvr/9l/T9ACwLlmGO2Vi0heVMX1WfGrYHo
        SQSr9j4w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLx-0004Em-NG; Fri, 03 Apr 2020 15:27:22 +0200
Received: from [82.135.69.229] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLx-000CaC-Ek; Fri, 03 Apr 2020 15:27:21 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio: xilinx-xadc: Fix ADC-B powerdown
Date:   Fri,  3 Apr 2020 15:27:13 +0200
Message-Id: <20200403132717.24682-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The check for shutting down the second ADC is inverted. This causes it to
be powered down when it should be enabled. As a result channels that are
supposed to be handled by the second ADC return invalid conversion results.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 2d6505a66511..4fcf1729341f 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -722,13 +722,14 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 {
 	uint16_t val;
 
+	/* Powerdown the ADC-B when it is not needed. */
 	switch (seq_mode) {
 	case XADC_CONF1_SEQ_SIMULTANEOUS:
 	case XADC_CONF1_SEQ_INDEPENDENT:
-		val = XADC_CONF2_PD_ADC_B;
+		val = 0;
 		break;
 	default:
-		val = 0;
+		val = XADC_CONF2_PD_ADC_B;
 		break;
 	}
 
-- 
2.20.1

