Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF59C224109
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGQQ5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgGQQ4Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E1C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so11853852wrp.10
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxERIJkNFUQ5ozpJhehQBvzBnN2ugWiIznLPwHBPnFk=;
        b=JoPHqajgOW42YICPAe8k9IXDr8Oq0uyPpS778IQ3CfxvDtIbl5D8zR0Df+QDdALhPU
         por7Z1VCalQYriqoUWjMGqkkEBx9qImCE5FFvIaMi8hJpomwggTqQgOJ19UYPdPO8rBY
         I5PSktHvzMysiadqwkX2LWNDAzwUcNS7uAwz2NvAxFZ/Iy+S1Ud5WLrixqzfdLf/pbGg
         yxYjRYaAjHvYP+zH3MJwVQX8O0kle7SSULEcwJKMfkMqnqKsaCZyjvK/G3JNJRGNdFjx
         zJ/JJ2pXTBy6xWQXBvuRm3uIllaX05mGTqtnfXfw3uviQ82rG8NtpnmP3o0TmmXYzwHb
         XSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxERIJkNFUQ5ozpJhehQBvzBnN2ugWiIznLPwHBPnFk=;
        b=om7DND5RO7eKz7QcskOdaXwouPjLIE3AIGAf87Rcddg0iCgnr7pIjwMTBRP5ynJIaM
         KrkgdwZAjR2QdpLl2mB4zFQdTRvyKVzMJlAHN98V25Paa0ielWeqn+IDEB9FA7PVgjoj
         owc60GwUXRbAe9TMcvUx0Y6IVWXrPmbJIZcWUUAlY7jA9CRB1YpRT2XYyxHlsMXTkiv5
         gF8RkOBUnE61nLp5ccqD4zoBKVS3+3Qf7fjpyFZXFCHRQGpBY+/LEekgiWsSYD2mEhBM
         7Wie5kIbasPKUb9ZmY5sr2g2zJtVJwgqH2FANnBZrpzMRH0Hx9TwDU/HaMV8M/4THaUi
         3RJA==
X-Gm-Message-State: AOAM531yNF75K65joeUcKvUfVShuxK0II/gsplaMc8R+wMn3Cf+feAr9
        /3otff4zRJjnX3aAt8A8ihVXcg==
X-Google-Smtp-Source: ABdhPJyoyi3KXxofIeitDa3r5dXgzfyGk9VTWMvKp/iCGqvFymG0cwak1NwrvETpg7f4cCGxPyMThw==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr10668408wrn.94.1595004984144;
        Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pradeep Goudagunta <pgoudagunta@nvidia.com>
Subject: [PATCH 23/30] iio: adc: palmas_gpadc: Demote non-conforming kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:31 +0100
Message-Id: <20200717165538.3275050-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Very few of the struct attributes have been documented here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'dev' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'palmas' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_0' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_1' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'adc_info' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'conv_completion' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_data' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_data' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_enable' not described in 'palmas_gpadc'
 drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_enable' not described in 'palmas_gpadc'

Cc: Pradeep Goudagunta <pgoudagunta@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/palmas_gpadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 46e595eb889fa..81b0a76a767e8 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -76,7 +76,7 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
 };
 
-/**
+/*
  * struct palmas_gpadc - the palmas_gpadc structure
  * @ch0_current:	channel 0 current source setting
  *			0: 0 uA
@@ -94,7 +94,6 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
  * This is the palmas_gpadc structure to store run-time information
  * and pointers for this driver instance.
  */
-
 struct palmas_gpadc {
 	struct device			*dev;
 	struct palmas			*palmas;
-- 
2.25.1

