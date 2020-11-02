Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D812A3694
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 23:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKBWfh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 17:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKBWfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 17:35:37 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01125C0617A6;
        Mon,  2 Nov 2020 14:35:37 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w13so7618026eju.13;
        Mon, 02 Nov 2020 14:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7nOY/CMBrCc1yEj5RA267szHi6fVAQcuYVsfxRG2l4=;
        b=MyC2MLo3fY+8+mqhUMbKTmdekGYgyuUib/UPpK5ahWOjDMEMJZTv6Jf8qy2hweyWym
         ZNGogdWY9PHc64A6YjzmB/p9Lgcg2x/Hp8zYISyAFDnuWG2oERhnL5b43raKXso3PzKA
         QyJ+uELWNrK8RGqOXNbhWsHO+SYXDiPdDdfz0CLXqwXFtnT2MzuMxnocY8MPRsJVmM9/
         qQus2vl1ujBWbFirBzOOkUg/JkLRN4f6enrOhU3L3pYzdtzjbqtbM62WpJAblPUVM/zR
         59SYp0LJf9PCpgwfeoE4+o060lCjPUPvXCjjdFfKwA9C8CMoqaNNR/8Xg5vtatDzpdjy
         EYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7nOY/CMBrCc1yEj5RA267szHi6fVAQcuYVsfxRG2l4=;
        b=bSekBdOio6IR+gufp8XllM5i4qLtHqDUAdE6/G59XEzafRWx3jNlVz40Z39fIpJOZ2
         yNn6n3WNeV/474MUs/+9Z796yZ3zModhBfrk8H7lWNe/FP/5QAqMBubMxcrU5u6wd+4C
         jVX1tIASmA18e89oX5ltKVEsWJK4qNkUcgaMDEOP7aSRZ0GoenSFQTJIzkRnz941TQNe
         aKiICLE8JOHadgggl2gB2EFXG1jJziXm5CjnCynr/dvc5eNWiV1Ws3eYkZb2vuVoV6wz
         2LB6QdSgItr6LWv7Nwyu+b25gjPbptmVZvFEt3CgD1Q1CFPwx0AJNMhx9WSebJk3zqnN
         wmdQ==
X-Gm-Message-State: AOAM530alJTAy555PJpQZT0MTJS43EO4RnCeantOuCBmsFALCOET54a+
        zZ4hATxykoiSCw8RgGM4RXVRZuEIEnV5jw==
X-Google-Smtp-Source: ABdhPJzf4mBvdfYdod1Rw2hhb5Xvo8/yAKwUJZbnBZdgLyZvf1m34Ub7JEwQD9YeiTwePAGsMc2CuQ==
X-Received: by 2002:a17:906:840e:: with SMTP id n14mr5266686ejx.147.1604356535728;
        Mon, 02 Nov 2020 14:35:35 -0800 (PST)
Received: from necip-pc.vpn.ucf.edu ([85.153.224.24])
        by smtp.gmail.com with ESMTPSA id la9sm1550707ejb.121.2020.11.02.14.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 14:35:35 -0800 (PST)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     jic23@kernel.org
Cc:     pn@denx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] iio: light: fix kconfig dependency bug for VCNL4035
Date:   Tue,  3 Nov 2020 01:35:24 +0300
Message-Id: <20201102223523.572461-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When VCNL4035 is enabled and IIO_BUFFER is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for IIO_TRIGGERED_BUFFER
  Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
  Selected by [y]:
  - VCNL4035 [=y] && IIO [=y] && I2C [=y]

The reason is that VCNL4035 selects IIO_TRIGGERED_BUFFER without depending
on or selecting IIO_BUFFER while IIO_TRIGGERED_BUFFER depends on
IIO_BUFFER. This can also fail building the kernel.

Honor the kconfig dependency to remove unmet direct dependency warnings
and avoid any potential build failures.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=209883
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index cade6dc0305b..33ad4dd0b5c7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -544,6 +544,7 @@ config VCNL4000
 
 config VCNL4035
 	tristate "VCNL4035 combined ALS and proximity sensor"
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP_I2C
 	depends on I2C
-- 
2.25.1

