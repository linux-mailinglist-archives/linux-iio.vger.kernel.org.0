Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA41D326FF8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 02:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhB1Bda (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 20:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhB1Bd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Feb 2021 20:33:27 -0500
Received: from chill.innovation.ch (chill.innovation.ch [IPv6:2001:470:1:5ba:222:15ff:fecf:4ca5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4081BC061756
        for <linux-iio@vger.kernel.org>; Sat, 27 Feb 2021 17:32:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id BB43F6401BC;
        Sat, 27 Feb 2021 17:26:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at innovation.ch
Authentication-Results: chill.innovation.ch (amavisd-new);
        dkim=pass (2048-bit key) header.d=innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Mc_SY7zFZNI0; Sat, 27 Feb 2021 17:26:54 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 4D41E640186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1614475613;
        bh=yqkjLYjbiyTHjaBgcNcDvq5q01Pg0kINgxo7MEPqnVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2L1QXb4VPIHw3yI7Vz/2/q9aVtJdItdM+xz9eQMdt3k6aInGuhfYv68H+KtJtfme
         v/6RHhc/gbD8oGmqryFzGdo0is/CuOb5xVBz3glbhXspgLatfenSaRGHCzIKuSlyH/
         lTTFLgle2MX3OdtfkUXmgJQl1ZydblZwVwY5g7VxkU0xtqEU/xZoNGjpc+PwFkRIME
         WX4Hr1S+eRRBUVrD/4btuMrzdKSFurQOtVX9qjRsQ9wH0IJb7IS9MPtznUC/+xZsFn
         K1hTn/Cn8nkbDr+WiD11zpVglgNnKbtwLxXyU7Gz0p1ceVgQ8fTchvcZpuhubYPeI0
         Pr+816QalWEoQ==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/5] iio: hid-sensor-als: Support change sensitivity in illuminance too.
Date:   Sat, 27 Feb 2021 17:26:40 -0800
Message-Id: <20210228012643.69944-3-ronald@innovation.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210228012643.69944-1-ronald@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Recent MacBook Pro's specify the usage of the change sensitivity field
as illuminance (with a change sensitivity modifier) rather than as
light.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/iio/light/hid-sensor-als.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index a21c827e4953d..849ee37dcd866 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -252,6 +252,14 @@ static int als_parse_report(struct platform_device *pdev,
 			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 			HID_USAGE_SENSOR_DATA_LIGHT,
 			&st->common_attributes.sensitivity);
+
+		if (st->common_attributes.sensitivity.index < 0)
+			sensor_hub_input_get_attribute_info(hsdev,
+				HID_FEATURE_REPORT, usage_id,
+				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+				HID_USAGE_SENSOR_LIGHT_ILLUM,
+				&st->common_attributes.sensitivity);
+
 		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
-- 
2.26.2

