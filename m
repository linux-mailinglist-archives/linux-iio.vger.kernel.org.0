Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17452F4E58
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAMPTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jan 2021 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAMPTQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jan 2021 10:19:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291CAC061794;
        Wed, 13 Jan 2021 07:18:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y187so1943713wmd.3;
        Wed, 13 Jan 2021 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JsdSUNZU99CHRQyMB9nKABToZIcF8rJvcssapQJw4y0=;
        b=Ch1KhYlhffbk5gv+IuSss/VlfSKStLM8in2fHduMKnP0obMKqCMFJuTUnC95lDN9wX
         BPDESYjtsVxkNXFBl/VmdbDdEGpTauVYZta0E/U2/ihnu+CcNcIwqo5ZwFm07AWD4RS1
         Z2yqHu2B5sfAQ1HnWBP4t/W9ZwOU3Z8AVK2utVWq0V9lQGU/lhBzYxkOkR0IOXeCKPEF
         RJyfkuyDRYD63M2RpT9Vryc+CJhfGUARhyWGbBTi1+WCIfpM5iI5rZAVwcse4bsBt1bJ
         YjUV9d6JeEOiCeiC97VVaebpJH/zTHPZvx8ITKxOWSAXuAgkj6JYNj/0puYasc9erqC0
         sCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JsdSUNZU99CHRQyMB9nKABToZIcF8rJvcssapQJw4y0=;
        b=OyE1YzLpuEz4E8xge4m090MY/Xw7ZtArl1RyHh7VgEr2PXE4F6rFbPHn2U4/ip6PNI
         m1lJEWHDMXohlYPiI8X0kDWf4Q6q7UX2ZZxT/CwB82CKqm9B63UjdKoJJSobb580eKdi
         6Lv/7Nk1kYbotBm2BfqqX77BIwVumHAVlfYUzQ//A4+s2B9vDz6eK9Qeg4ihjHa7t3t5
         TWyVxITGcQfq/eIiKmB2mYsyszcV3TNt0phaNDu2b5J/GHnUaDjACDetNyxKJmoxe1cJ
         zkIZ0qkRwsTXYkqm3C3zoesYX5M4q6c1yWwTHHH51Iavf8Hh3aPPXjuDS4ROQO0uihAH
         Sq9Q==
X-Gm-Message-State: AOAM532Dl6IXi79P4h/Tgu5KrdEonPG8/BaBCiUiKku0qy5BkhZgh4HF
        zN5iC+0jdW4sGQJUUPqeQbDepf21r8qyYj1b
X-Google-Smtp-Source: ABdhPJz2+fYAm1rMr/3Y5rMo3ehR7RQaXsru4ydlnOsujNuNsouSVHMjCNTnFuZ3Y1bOwqFtxAflhQ==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr158199wma.53.1610551114481;
        Wed, 13 Jan 2021 07:18:34 -0800 (PST)
Received: from jonathan-N53SV.station ([151.81.101.204])
        by smtp.googlemail.com with ESMTPSA id w1sm3890553wrr.84.2021.01.13.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:18:31 -0800 (PST)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio:adc:qcom-spmi-vadc: add default scale to LR_MUX2_BAT_ID channel
Date:   Wed, 13 Jan 2021 16:18:07 +0100
Message-Id: <20210113151808.4628-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113151808.4628-1-jonathan.albrieux@gmail.com>
References: <20210113151808.4628-1-jonathan.albrieux@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Checking at both msm8909-pm8916.dtsi and msm8916.dtsi from downstream
it is indicated that "batt_id" channel has to be scaled with the default
function:

	chan@31 {
		label = "batt_id";
		reg = <0x31>;
		qcom,decimation = <0>;
		qcom,pre-div-channel-scaling = <0>;
		qcom,calibration-type = "ratiometric";
		qcom,scale-function = <0>;
		qcom,hw-settle-time = <0xb>;
		qcom,fast-avg-setup = <0>;
	};

Change LR_MUX2_BAT_ID scaling accordingly.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index b0388f8a69f4..7e7d408452ec 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -598,7 +598,7 @@ static const struct vadc_channels vadc_chans[] = {
 	VADC_CHAN_NO_SCALE(P_MUX16_1_3, 1)
 
 	VADC_CHAN_NO_SCALE(LR_MUX1_BAT_THERM, 0)
-	VADC_CHAN_NO_SCALE(LR_MUX2_BAT_ID, 0)
+	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0, SCALE_DEFAULT)
 	VADC_CHAN_NO_SCALE(LR_MUX3_XO_THERM, 0)
 	VADC_CHAN_NO_SCALE(LR_MUX4_AMUX_THM1, 0)
 	VADC_CHAN_NO_SCALE(LR_MUX5_AMUX_THM2, 0)
-- 
2.17.1

