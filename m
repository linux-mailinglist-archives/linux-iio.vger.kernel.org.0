Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B457F2B38C3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgKOTcL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:10 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E77B22450;
        Sun, 15 Nov 2020 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468730;
        bh=x71USCiHj/GQY0jK4FvaaciNOHo6Au4EPLPmumf7GyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmyfKjVc/PsBbRPrgZo/RXBK1rZ3UiMRaEwzD1Ph7azHx3eyCaGf3j/S4uZkIMbyx
         QwMfXCJHa/S9udvCMSSb6JFLfpXAbONWEUHsfVlFogYaCgHKSYRI9BcVy4o9EovfYC
         Tv3+2lYWzTBuq96CsmutcXDo7qhG/N2JnEfxbcZY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 6/9] ARM: dts: qcom-pma8084: Drop incorrect use of io-channel-ranges
Date:   Sun, 15 Nov 2020 19:29:48 +0000
Message-Id: <20201115192951.1073632-7-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property is used by io-channel consumers, not providers so should
not present here.  Note dt_schema will now detect this error as there
is a dependency between this property and io-channels.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-pma8084.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index ea1ca166165c..e921c5e93a5d 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -68,7 +68,6 @@ pma8084_vadc: vadc@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 
 			die_temp {
 				reg = <VADC_DIE_TEMP>;
-- 
2.28.0

