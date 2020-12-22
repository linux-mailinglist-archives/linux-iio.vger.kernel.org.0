Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216D52E0EC7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLVTRf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 14:17:35 -0500
Received: from www381.your-server.de ([78.46.137.84]:48162 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgLVTRf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 14:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2nX1NBMok7jKryviJeJx3ToSK4VKI1dP9A2A4eKLMTQ=; b=Fkdo58SEkzqd4TdVlHPWYlMhfW
        h7NIrwQ46xMde/ECQk5XXFvYRLV9dMgQojxhJY5PE9jZzTASYOgUtep0FcD5y/am5JfYcAUAgrZaL
        O2rE+S36eU5kOwIJOragVifNtgRYP5vBgvDv3XhYfkY3X9K8+8VYRf9jJvmYZgr5VlEXYJlwH1eEl
        7hJft/v3+1+0HBC9Ub16o/KjxY/7abiMqYGm24uv53DNKP7/8a7QMxcT6CDGurFJrCzdNQ35xrdGz
        lsYgdxFELPr2s0/CBKrZIWzCuton7XMmQkZwU73bAfGBcAsWs3/KNgPomsDm/WMhCFETQ8Wm4JE5B
        JBbKFfaQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1krn9Q-000GFW-Sz; Tue, 22 Dec 2020 20:16:52 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1krn9Q-000OSz-NE; Tue, 22 Dec 2020 20:16:52 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: sc27xx_adc: Use DIV_ROUND_CLOSEST() instead of open-coding it
Date:   Tue, 22 Dec 2020 20:16:18 +0100
Message-Id: <20201222191618.3433-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26025/Tue Dec 22 13:51:35 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use DIV_ROUND_CLOSEST() instead of open-coding it. This makes it more clear
what is going on for the casual reviewer.

Generated using the following the Coccinelle semantic patch.

// <smpl>
@@
expression x, y;
@@
-((x) + ((y) / 2)) / (y)
+DIV_ROUND_CLOSEST(x, y)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/sc27xx_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index aa32a1f385e2..301cf66de695 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -307,7 +307,7 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 
 	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
 
-	return (volt * denominator + numerator / 2) / numerator;
+	return DIV_ROUND_CLOSEST(volt * denominator, numerator);
 }
 
 static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
-- 
2.20.1

