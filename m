Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A33A0947
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhFIBfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:36 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:36631 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbhFIBfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:33 -0400
Received: by mail-pj1-f47.google.com with SMTP id d5-20020a17090ab305b02901675357c371so437064pjr.1;
        Tue, 08 Jun 2021 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqW2hWGxH1OOe0tpNz1yPTnzMBBEZl3N8Vv1hrlk7eY=;
        b=Nwj+0+En9LAEEELUjvHh1yiB0ynXLXG4RFBZXEri+yqNmldJc2IE4/nh9igsetTZKi
         Lu4b3QWO0Sz8vFmUgxKOjDlvhWJEY32U/ZTtjrRcEV55PZIFdgL7Zr16tsxBPuhZJWQ7
         7Cuwbw12cugFOr/41seJFulF3a15USU+VXWNMOCTOiwJwMX2dtO5u+v2DXryQk7vMrTG
         Hy28k4yfWUwYT3sMngurgN11ZArDAVEOK2/rBPIbrO8bJlsXlKy24NJ+XcXQ1hZg2Jq+
         EYp5iDt3FIS7vFv0vsaqiY7uUeGRpkH0B2NYl/VipwrG5QNIRteRwBwYU9MxPCUOCbuZ
         gSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqW2hWGxH1OOe0tpNz1yPTnzMBBEZl3N8Vv1hrlk7eY=;
        b=fNpYoRlRIm9q2OQPrp2Cmb4qCtTwPRsEbDDAecp1zbYua3KR1sQSkNy+9He95pBRBh
         NLyr6d8pR4j165GIv7APmY/FS1vVbiNfiH7ADWBOPViGebw/t+Zzqzi40lWhcRinxm02
         NeKd9TVXSl06q5b0VJffFE6Qb8+1tD1YcVj/dpjEkjoW77kwCdBzLOazzmRmSA7Ky8gc
         5mwWPpTzOFM+fUEzqKRNT0TFPX+aEtR5zTqK1guDt5BBquhCVytTC/+NWlarAggDYpV9
         uAgJFl3ozjG6ngGSP3vtlj85JBhwLjtr+zGjGpw9iMYlXotpLeiH3YTSqKT3EewsA1U2
         l/XQ==
X-Gm-Message-State: AOAM530UZoheOlg7oFx0XVmcOJUNMK/1OaaOKIf1jE/Ay3yI2Jx1FI2q
        n+sMB/IcKW4l+/VqtYv/+lg=
X-Google-Smtp-Source: ABdhPJwzVmCoWtk/cZUjfOEW6VN4qsVxVG/KIj5Bzr+YUe1hi5gnlL4e546ZGpDATbkNjxrdrG3x2w==
X-Received: by 2002:a17:902:dac3:b029:105:66fc:8ed7 with SMTP id q3-20020a170902dac3b029010566fc8ed7mr3030662plx.6.1623202360188;
        Tue, 08 Jun 2021 18:32:40 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:39 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v11 10/33] counter: stm32-lptimer-cnt: Add const qualifier for functions_list array
Date:   Wed,  9 Jun 2021 10:31:13 +0900
Message-Id: <08830119594acdb3bc9d36ae2e65b2eb26589ade.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
stm32_lptim_cnt_functions to match functions_list.

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 937439635d53..0f7d3f1ec1b6 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -134,7 +134,7 @@ enum stm32_lptim_cnt_function {
 	STM32_LPTIM_ENCODER_BOTH_EDGE,
 };
 
-static enum counter_count_function stm32_lptim_cnt_functions[] = {
+static const enum counter_count_function stm32_lptim_cnt_functions[] = {
 	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
-- 
2.32.0

