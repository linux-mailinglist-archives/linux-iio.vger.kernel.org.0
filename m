Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB44D3BA1
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiCIVBl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiCIVBi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184247DA93
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so7758203eje.10
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=qq/alwNNEOVFrUkFrnbvhhj6JjcAGn+KalJRtjNkPy7zoGW21n7eLJGiUOPcwKDGAR
         hf+okHmtPDUJjYwBUcNDRwM5ylPMUruzDdenUUUJz/+gi01HlVTdyOuvmftGlN7OC5d5
         +ckIpv9kIg1L2d3U75wQUwD+5I3AaJ01pjLo3r3MAsyAjTB9ONz3EKqA4c4gjGEi59Yp
         hMyxXDaR3yX+hAdgtiWqKdHGnaKdBGufVKm4DkdVAMZUfNcSO2OmRWnUqiYEA43NY5ME
         6wSvHDkEo42TaspFtvBWFUb3n4/GRpgf0Coc3hljlziXbsUFaYKhT/DpeRKR/D8uv3+e
         jD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=pMC/9QvLO7qRYouauRfU6sEGhd13Z4WmOAcAERhYDjlXcuIEyaL+bwvDlorsjmZACe
         dbJtkuZyAaHd48GfOvjoHOzcK9ZY4HSuh+5c6ElHghvGcwsb1W1CqqF4FhfV3YDVYmAQ
         hk2Sw4De7Jc4QJJnOYtXJpm0cQNwVJJInQLwsi9MNx8rf1aYUYqZWRYT7NVcebklfoV8
         RbjsotFkNWY64BUe7qCnfg8h5fns16FOvEspn9XsS9S0Uh7StB/1AeG/tK5XEZmaYquk
         zTymZ3V3nSbLv29Asid752NBomhI9zBgm8Pc6q4E67h4qYljkR9sSRt7QrPJaeE/Q7r9
         Rvcw==
X-Gm-Message-State: AOAM531Qyyw+p+tqyGILVbtYLdFoZbE/koO5hj75HtorcKdxchmfywfi
        sFzTnrU7lUfrAuYsudcpCrqEYnjK2GVpjQ==
X-Google-Smtp-Source: ABdhPJwYHJpGiqlIkuUsFqY3leNZUODSYBdhCNdHcYApRekfpWzRrOVIGHPwYniRQjzt8BtWiBA4sg==
X-Received: by 2002:a17:906:3144:b0:6ce:de5d:5e3b with SMTP id e4-20020a170906314400b006cede5d5e3bmr1514568eje.689.1646859637575;
        Wed, 09 Mar 2022 13:00:37 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:37 -0800 (PST)
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
Subject: [PATCH v11 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Wed,  9 Mar 2022 21:00:13 +0000
Message-Id: <20220309210014.352267-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309210014.352267-1-caleb.connolly@linaro.org>
References: <20220309210014.352267-1-caleb.connolly@linaro.org>
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

