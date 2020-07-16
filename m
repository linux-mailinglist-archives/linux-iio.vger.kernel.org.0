Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F8222487
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgGPN7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgGPN7j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3498FC08C5CE
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so7194675wrm.4
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fG8RCQ1K6Z0ZD4fhah06tp/GYuGMejEtwlGsSpFMXOU=;
        b=Jv6cEZz6qHBVpSVOcwxAwzMDLFTHVAMLrP4A4D4V+FHDXZFAj1flc7YVNIRB0ee/WE
         aGwz1qvHH5ne6KtO0pimqv30XyEUFcAkU23rYpnzcim2sUiERnCh6IOKBB5AawvDrf8C
         ehF69Fh15rdZX9cZB3/5QsQtMFIlc6Z/K5pwABNbOJZ3J9yl9OmDxcPn1ZmNQ73UBVdd
         1nd8eBuxEXNCHdgG3vNdNRXpWRlvHe1EONC1e4r2cMKbEMXWTcWXpn3M4bomO7+Qtk0Q
         f9bBWRoxYeSNIHsBfDB6eeNBmtIY/JWwik6Dn/F/JwVAb7FmkeG6bI8x/+y8B8xVwthK
         o+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fG8RCQ1K6Z0ZD4fhah06tp/GYuGMejEtwlGsSpFMXOU=;
        b=cFIk3b77e/BXJ0ItagHxLhM/MGtbk/i5vES4OPzbP61yFlUuQFj+OOJAYn35a/UvH1
         tUoCCDWKUm/qqufkSoaxG/2IMv2VPUTQwhVugcu3iBj1kRZEvtDfkjAjnmTzaFddb2CY
         LGxFRv5uY+nmyBAyyj8Mkkv6fV4YWx5GmZBzQL5WKO/udE0lv8QVyfamIE2dDPX/pZ4B
         z8c1MspTan4Q31WSMqaXdg15+/zhEDRwB38KTlvjIpqmLtvJ2d+x2ttLiHtntnWIOpFu
         0DRez/jWHFcu0Ov2mMoUpC22SA2MluGe/JUFdEmglA95K4sOLWSkBlIM13m/L/0rFS6s
         BqTw==
X-Gm-Message-State: AOAM532mZK5XfGRduAGpb2Tc1OBdnX3koB2Q0zxijsWyERI7YzVNXoGN
        W1hzoxNVdQvi8pn5zYM5YARIIA==
X-Google-Smtp-Source: ABdhPJyvpcH8qjv3cJarACK1MheVg11n29CkbWUPLk1zd4I4RoIeswrSswn++4ZubNJ1s43pi5gpJQ==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr4966047wrt.138.1594907977935;
        Thu, 16 Jul 2020 06:59:37 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andreas Brauchli <a.brauchli@elementarea.net>,
        Pascal Sachs <pascal.sachs@sensirion.com>
Subject: [PATCH 05/30] iio: chemical: sgp30: Add description for sgp_read_cmd()'s 'duration_us'
Date:   Thu, 16 Jul 2020 14:59:03 +0100
Message-Id: <20200716135928.1456727-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/chemical/sgp30.c:236: warning: Function parameter or member 'duration_us' not described in 'sgp_read_cmd'

Cc: Andreas Brauchli <a.brauchli@elementarea.net>
Cc: Pascal Sachs <pascal.sachs@sensirion.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/chemical/sgp30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 403e8803471a9..82e407d48a0aa 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -227,6 +227,7 @@ static int sgp_verify_buffer(const struct sgp_data *data,
  * @cmd:         SGP Command to issue
  * @buf:         Raw data buffer to use
  * @word_count:  Num words to read, excluding CRC bytes
+ * @duration_us: Time to sleep in microseconds
  *
  * Return:       0 on success, negative error otherwise.
  */
-- 
2.25.1

