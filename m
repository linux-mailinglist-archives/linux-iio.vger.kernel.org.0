Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9765F4BED03
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiBUWIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 17:08:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiBUWIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 17:08:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF622BE5
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:08:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v12so29390097wrv.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=HZsY+p7ecLmebf7xsFvUeG8OOs8cpM9mvLAD6KN3VT+rbJ5o/QxgekaNkhp67C4rmS
         lUBIL7anCOHPlR4IgW85M7DuomafWOvSuAsAkMw7E4fLfVRGJEppobmHduZWlUrqa5Na
         nrFfO90Sk9YdJ+OiG7OkJLYt7u2GUPcVkMlDYqLX0wQ4IJXxpXoSzU1bdv0plv/PEUlB
         qslJsD7rG8QOaY2U3zbGF2cBBicXGRZ6OLKA2C4q8rxg4DEGFbRyiX7RUqO8lFq3tvWW
         tUOq0VUqcoLOAgitw94Mbgtiut8cF9lGpXycjIN2yPIbhazMJTJWckZM1OItjsya/cm6
         3N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=gVb3q9/UzPsdK6RdSLkPdMTnAEYZ1pcVjV3ATtM0iS/QHUsJEk6WlITIYcVQmdnhgB
         EYwAX4tuvJiFYI8y+vaah8RbWl75Eh3+oGSADUzPNc81UaHsFniE5/wKBQOJI2sd6nmJ
         gcK8K5+NSENrudeEqQOaw+Wxl2KjhZ4o387vSGJVfzl9Qytc+LC5vUiBY7wZf80ZaQVx
         Hi3mHIBfhAd/9rJq6nKh8Nvop4DdjGYLO4gANWAq2UTykcQ9VZ6uE1adbKpsEdVArKfO
         Cw0xp3LuUdAJUpk3XgNEAqiH+pnnkz24Q912gOxAaOKFZlPsEfnlecYZDa5Ka4lD2Gu0
         PKiA==
X-Gm-Message-State: AOAM532Fm6iNxXO5+z0/1yod+JqVSpxVjKvu+zN+39SEiGlBaUsrxiiY
        K7WarNA57YV87yRBf1RNxjsHJw==
X-Google-Smtp-Source: ABdhPJxGZtLI5i/SRC1lsUFIbGJQqTZYAJ9mKQv1NxK3XyENNLeH/j+vEcjsMFrCjALeJroWrMaGRQ==
X-Received: by 2002:adf:8122:0:b0:1e7:b111:3b92 with SMTP id 31-20020adf8122000000b001e7b1113b92mr17748215wrm.695.1645481285737;
        Mon, 21 Feb 2022 14:08:05 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id w8sm51626093wre.83.2022.02.21.14.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:08:05 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v8 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Mon, 21 Feb 2022 22:07:42 +0000
Message-Id: <20220221220743.541704-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221220743.541704-1-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the Round Robin ADC for the db845c.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 13f80a0b6faa..1c452b458121 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -595,6 +595,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.35.1

