Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8A1C7DAE
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEFXDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgEFXDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 19:03:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E6C061A10
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 16:03:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so1735926pjb.5
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeM5IRsRnStDlAAc1OBZrO/PpgJ1sNAvS3ZP+2/6Z+k=;
        b=OZYuPX2S5ZWoQsz3JlyUfgm7faGJYkdHFfhl1pTJfp0Fy8Uytvm1TohSILkdM+SukY
         0ZTQB3Lq15a+uGMMvULtadQyPPwYIq0rspD0dPwv7MjOsjtB2ZXJwNxsZPzMLqT1j1n3
         i9BS6W+Bo9lXlVc6bvWzf/t3rUoekBUzWn5O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeM5IRsRnStDlAAc1OBZrO/PpgJ1sNAvS3ZP+2/6Z+k=;
        b=RFe1RN5UsOrXoe844xQZy0LgL1jURfVkmTDj4CuL9vk6W/YeKbc5C/uhmEQ6QuK+aG
         XUFSj5CcRvD3UjQ4dbsm8Zg7WnnhrXlJcfsQFuygtycTwJvixNaqby+eMxanslhHZLow
         guUAnpfamFX3dV/Kt+nh//CbOZuDusE9hDd/67zaCXGy1cwfAAxz5HNg3TT4vRiujXTc
         Fl4E8CzmUOLjwFQJ0vkPaLQ4AGI4xgdSF/D5UF+re+0hAjaCDHqz0Z+b1NNNLCcPTd1y
         QfCrInlGiuIVmZUGuhQNYUZBUcZIav8hf0FDXnnBNndzBstkDA/3pY+385Xo2/E8tLpN
         cdlg==
X-Gm-Message-State: AGi0PuZx5/nvCHUkcXTehDdn6cMOVsIf28N47CLTVzotbJJkN3s3wyeN
        lHAd8s7kstDa+ulORe1bQ6fTSg==
X-Google-Smtp-Source: APiQypL7Njfu/Eb5/3HGyvbMHDoG4E7X5U4dWIHfbHWKzKP+OqiE5RxvNQzRoK+89RvGazd5CMGp7A==
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr12373542pjb.25.1588806213979;
        Wed, 06 May 2020 16:03:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id v1sm5631496pjs.36.2020.05.06.16.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 16:03:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/3] iio: Add in_illumincance vectors in different color spaces
Date:   Wed,  6 May 2020 16:03:22 -0700
Message-Id: <20200506230324.139241-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506230324.139241-1-gwendal@chromium.org>
References: <20200506230324.139241-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Define 2 spaces for defining color coming from color sensors:
RGB and XYZ: Both are in lux.
RGB is the raw output from sensors (Red, Green and Blue channels), in
addition to the existing clear channel (C).
The RGBC vector goes through a matrix transformation to produce the XYZ
vector. Y is illumincance, and XY caries the chromaticity information.
The matrix is model specific, as the color sensor can be behing a glass
that can filter some wavelengths.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v2.

 Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3e53a6d8331b..256db6e63a25e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1309,6 +1309,33 @@ Description:
 		Illuminance measurement, units after application of scale
 		and offset are lux.
 
+What:		/sys/.../iio:deviceX/in_illuminance_red_raw
+What:		/sys/.../iio:deviceX/in_illuminance_green_raw
+What:		/sys/.../iio:deviceX/in_illuminance_blue_raw
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Illuminance measuremed in red, green or blue channels, units
+		after application of scale and offset are lux.
+
+What:		/sys/.../iio:deviceX/in_illuminance_x_raw
+What:		/sys/.../iio:deviceX/in_illuminance_y_raw
+What:		/sys/.../iio:deviceX/in_illuminance_z_raw
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		lluminance measured in the CIE 1931 color space (XYZ).
+		in_illuminance_y_raw is a measure of the brightness, and is
+		identical in_illuminance_raw.
+		in_illuminance_x_raw and in_illuminance_z_raw carry chromacity
+		information.
+		in_illuminance_x,y,z_raw are be obtained from the sensor color
+		channels using color matching functions that may be device
+		specific.
+		Units after application of scale and offset are lux.
+		The measurments can be used to represent colors in the CIE
+		xyY color space
+
 What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
-- 
2.26.2.526.g744177e7f7-goog

