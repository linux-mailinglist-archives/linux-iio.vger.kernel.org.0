Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962634710E8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Dec 2021 03:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbhLKC02 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 21:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbhLKC0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 21:26:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C421CC061B38
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so34704248edd.9
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4F5z90YwZ0RiEGzI0D+aa0jkXM6rObDGUTi8CCIv+cU=;
        b=QcwlGBpCYMzXFyCORsK6wBY3dOlB/Q/mhwnsNtTG9WItFKyfrqMYbaUv3n2mpzaEXF
         p7Hbr4os44THPRiYfbjLNYenvq5JAbysBnoYdBCWP5uFpBKaFXzstSZ4KbFq9P98V+hN
         Nr70sPmjx9RgZJ4bSX8gXCPGwSPjLuQ5xFvkDm1KWetzI9KU3/Iyx+18SUmqzvWwDM1d
         iHvWyZlDk1/xUZsrI6RWXRGP/6HTBFXTmQCP5zU9tMRdb9c2tl3Va0KwIZQdljOXKcT5
         ChzVt8hDxAF2mJebX4xKZo8bbc4GGZScKDOQif/TM+eaAtluLjn9paWcLWv1m4m/2tLk
         lArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4F5z90YwZ0RiEGzI0D+aa0jkXM6rObDGUTi8CCIv+cU=;
        b=yamDOrzneUIFiQyhQOq0TKSi0wDGapj7ZtIOWVfMNXQsBM4ZKeh0syD7EfnnwGw24A
         ebiSp6P7hXHOdLx+haSBYxsolIXs2Q7YgbGX1cLBZmTTScC6LJ3vjbWRbJFamZ1bHTRh
         wp5igpJBKYKPFA+oHm4WYZ6rTF7wUJ/VP4w2dyuhSA8XVtXM7GBnEnOLRDzQLcpMY/To
         sNwtqKJob/LQZb7lT/d5HPB8PLGus+VbHH2OXBZCCdBql6DG+eJ9SC+4hUP2MBugHhhL
         f/KzahTlVSGZNcqv+SyI6cX7hStPtNNGyAdISh5J1J0uP4MZ2Hrpa50q46CjFyRHILlc
         2u2g==
X-Gm-Message-State: AOAM531WZ4tAm+STg8cjoVvs7FYuZxZu0dLIPQ+BA6JzAtkHWPYJF77I
        pPVAwxNdXWcJjnhA7pUDNo7jiA==
X-Google-Smtp-Source: ABdhPJweTOUDXwubeBdCK7QhTg06GCwERKfQaf2j45gyOyBxQWTURJrROQlrmfvCKfvxg4ftJk2hOA==
X-Received: by 2002:a17:906:c109:: with SMTP id do9mr28059191ejc.48.1639189360389;
        Fri, 10 Dec 2021 18:22:40 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:40 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Sat, 11 Dec 2021 02:22:23 +0000
Message-Id: <20211211022224.3488860-7-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211211022224.3488860-1-caleb@connolly.tech>
References: <20211211022224.3488860-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

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
2.34.1

