Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF03913ED
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhEZJp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 05:45:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:33196 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhEZJp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 05:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622022265; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dJaORiynPBuvkjAWsqcMzg6v86lDxZ7MA5lLqZSlAf9GDRCfB8BkPd2Cdlc8g0cXe0
    9OoDJNeYChpjowAbohHhx0xItnjNhzhXXCUkhyWMM/NlRYKZXB/qW5Uq4wwRutt06Ux7
    gnYVJTd96DgkAWmtjt04a9V9it47gasb1U/8SliFHQ4N6qGvhnjI/Ghq14hEUb/tuRLW
    HUSd+jRp39l2VUWg51/QOv58eMKcAUksKdtnkl57E+NygCgJ0LA15kI0U3trhmyWrZht
    AO+NyoMLhNYqQgU8lyfYNmQS1/qJf5rbuPbbnHBSkXdTB3u0ihbqeMOic6XX/SpWvGAJ
    EEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622022265;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H9Fct0num8/7BbmsVgTLiFgWIuT2Rte5NxqkRkhm974=;
    b=GBuZ+MmrYvpoX+poCek6m93ufIWF4nWmGCKn+2LUzD1XuABl08RS/8kwvQPNlo537p
    9SO3M88nQpGpOPX3rDuqyuG6Q0o+Ymz/yv929ijWP7b298uFiZRJQAwF6tcAJkqTGEOC
    G32mQeBL/77KR1mi9TVm7N165kTum3u2m/OCl0Owa3XerBjwtKxMiUMbzPe9XQJ5aBW4
    KjtCg/4H9mvdfXYLZnMjvh3T370RP9d/rbEXnNk5SwTnbrzKqS1Q0xuzTBmtnwnmN7SB
    BPvOW87pqA5DfHzcIThCoiUyymqRKqAx9le369QY8DRcarIIW2plt8GVoZ+5eoeHxNEj
    MW/g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622022265;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H9Fct0num8/7BbmsVgTLiFgWIuT2Rte5NxqkRkhm974=;
    b=fnBbfxUIH7CSQZt9IPSKbs+qmkFcERQqrufqfUFVJRji9AYXnwLBFgIrcfD10fO/8e
    euL3uw4av5jQ+E3sKSUwfjGFbXlAC4vDdCT0Yo5m3GIw+iyxOTrXOnEskaBrvVrtHTvn
    aH9JHKLgPr14js0aG9LHVvBxoivwS+OgrdeWbTIJO92JhGaNSjl2dulh9kaRHz8vrcqX
    JMupuOaB44+gmdfts5+T3id36/c2BG99KKZgPjJPUzHW2Dqp14P4/ov1VDlVXmH4tYbh
    pwK/RD9iuSudBNwvIYNWQg+h9UKtHABzUEgXIANI4xvVUgPzzmhSyzQemxXK6BCoFNOd
    JXRw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6JG0s="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.2 DYNA|AUTH)
    with ESMTPSA id w02ed1x4Q9iO6KA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 May 2021 11:44:24 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/2] iio: accel: bma180: Fix BMA25x bandwidth register values
Date:   Wed, 26 May 2021 11:44:07 +0200
Message-Id: <20210526094408.34298-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526094408.34298-1-stephan@gerhold.net>
References: <20210526094408.34298-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the BMA253 datasheet [1] and BMA250 datasheet [2] the
bandwidth value for BMA25x should be set as 01xxx:

  "Settings 00xxx result in a bandwidth of 7.81 Hz; [...]
   It is recommended [...] to use the range from ´01000b´ to ´01111b´
   only in order to be compatible with future products."

However, at the moment the drivers sets bandwidth values from 0 to 6,
which is not recommended and always results into 7.81 Hz bandwidth
according to the datasheet.

Fix this by introducing a bw_offset = 8 = 01000b for BMA25x,
so the additional bit is always set for BMA25x.

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma253-ds000.pdf
[2]: https://datasheet.octopart.com/BMA250-Bosch-datasheet-15540103.pdf

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Fixes: 2017cff24cc0 ("iio:bma180: Add BMA250 chip support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
After spending some more time with the driver I noticed that BMA253/BMA254
would actually be better supported by the bmc150-accel driver (which
doesn't have this problem and also supports the motion trigger/interrupt).

I'm preparing a separate patch set to move BMA254 to bmc150-accel at least,
but I'm not sure about BMA250 so this patch is relevant anyway. And I had
it almost done already, so I thought it's better to send it. :)
---
 drivers/iio/accel/bma180.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 97e991581960..81d1e070a2ee 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -55,7 +55,7 @@ struct bma180_part_info {
 
 	u8 int_reset_reg, int_reset_mask;
 	u8 sleep_reg, sleep_mask;
-	u8 bw_reg, bw_mask;
+	u8 bw_reg, bw_mask, bw_offset;
 	u8 scale_reg, scale_mask;
 	u8 power_reg, power_mask, lowpower_val;
 	u8 int_enable_reg, int_enable_mask;
@@ -127,6 +127,7 @@ struct bma180_part_info {
 
 #define BMA250_RANGE_MASK	GENMASK(3, 0) /* Range of accel values */
 #define BMA250_BW_MASK		GENMASK(4, 0) /* Accel bandwidth */
+#define BMA250_BW_OFFSET	8
 #define BMA250_SUSPEND_MASK	BIT(7) /* chip will sleep */
 #define BMA250_LOWPOWER_MASK	BIT(6)
 #define BMA250_DATA_INTEN_MASK	BIT(4)
@@ -143,6 +144,7 @@ struct bma180_part_info {
 
 #define BMA254_RANGE_MASK	GENMASK(3, 0) /* Range of accel values */
 #define BMA254_BW_MASK		GENMASK(4, 0) /* Accel bandwidth */
+#define BMA254_BW_OFFSET	8
 #define BMA254_SUSPEND_MASK	BIT(7) /* chip will sleep */
 #define BMA254_LOWPOWER_MASK	BIT(6)
 #define BMA254_DATA_INTEN_MASK	BIT(4)
@@ -287,7 +289,8 @@ static int bma180_set_bw(struct bma180_data *data, int val)
 	for (i = 0; i < data->part_info->num_bw; ++i) {
 		if (data->part_info->bw_table[i] == val) {
 			ret = bma180_set_bits(data, data->part_info->bw_reg,
-				data->part_info->bw_mask, i);
+				data->part_info->bw_mask,
+				i + data->part_info->bw_offset);
 			if (ret) {
 				dev_err(&data->client->dev,
 					"failed to set bandwidth\n");
@@ -880,6 +883,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.sleep_mask = BMA250_SUSPEND_MASK,
 		.bw_reg = BMA250_BW_REG,
 		.bw_mask = BMA250_BW_MASK,
+		.bw_offset = BMA250_BW_OFFSET,
 		.scale_reg = BMA250_RANGE_REG,
 		.scale_mask = BMA250_RANGE_MASK,
 		.power_reg = BMA250_POWER_REG,
@@ -909,6 +913,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.sleep_mask = BMA254_SUSPEND_MASK,
 		.bw_reg = BMA254_BW_REG,
 		.bw_mask = BMA254_BW_MASK,
+		.bw_offset = BMA254_BW_OFFSET,
 		.scale_reg = BMA254_RANGE_REG,
 		.scale_mask = BMA254_RANGE_MASK,
 		.power_reg = BMA254_POWER_REG,
-- 
2.31.1

