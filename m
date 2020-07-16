Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F12224C3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgGPOBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgGPN7i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A979C08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so7147772wrp.10
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prTZ5JEswUnocIpjh51nEpoOPf62BiWU4kn635sFnW8=;
        b=Hd2yo7pmgR53H21ZDQwCTMsS7vmn+wCghqwTrr1p71Vg/do4U9Uh450Dtj7OneNCx5
         bzdI98Lv0aruEcPTEqDPmVbi7xwK6HgkSxaI3WC0iedr2lQQn487UTvM/sdLkDW30iKP
         d5cH1P5Nk/NPDup/jnmfyvKQaDacq/y5UMiZWdpUsEdSaXMc9BUpTHKvbnRDXnYlDOHU
         bofZ043dhHRiP1oIAhQWfWcisZdVSRwr4nZI3GxNDY1iB2r/hiL8emYHW8yojob2Mr8G
         HVe8nxbbvG5IfR8E+z3WnsFXmgZo+gni9zjsrrJ/VwANSAyydO42CpYlgfWJV8vfqiKi
         /dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prTZ5JEswUnocIpjh51nEpoOPf62BiWU4kn635sFnW8=;
        b=Uf7i7cSne+TYNgNgLdLbyiTiLi4eyk2PqjmSFRT7oOlRy0sM/12TFT/sxVO1yir0e3
         GxHobCQKlZuyCyIjZnQn8ZihY9N8JrapCRlLLoLP80bwoe/Q8b4qQDQsap45vH6DfC4o
         eD2s9FTPAuLqnR1+2FNlOBB4uTKIKtuci8+x7+WEJyeW63q9CvEb2lD/q1JeCUOWknS5
         12pMSZGgQdFU0vS+ILhtpHWiboH83SmY7XHhMD+9M7mL2MUI2H0twhASRzdiHpskeSP3
         qCO6bqPcQOundo81tsqzdG2ePDbHaE7Q06+rI8afort/GJs2pyJVRJRgFbSNbbFRml/A
         U7Gg==
X-Gm-Message-State: AOAM532k8k87s+R5rTbPzhAbcWaYOhyRvH/VpljyrnrauH+NPihhmP+U
        PpHsEqT81IfQzlJRXMxOC9KhAg==
X-Google-Smtp-Source: ABdhPJwX3IRYbokI3ZHKxGyWbM/Z7e1QEIkzkfGiBwVXjlu5nBA3i+bXqJiziE4LGWMiuzurDIAHbg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5143505wru.310.1594907976855;
        Thu, 16 Jul 2020 06:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 04/30] iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Thu, 16 Jul 2020 14:59:02 +0100
Message-Id: <20200716135928.1456727-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

No attempt has been made to document either of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7298.c:106: warning: Function parameter or member 'indio_dev' not described in 'ad7298_update_scan_mode'
 drivers/iio/adc/ad7298.c:106: warning: Function parameter or member 'active_scan_mask' not described in 'ad7298_update_scan_mode'
 drivers/iio/adc/ad7298.c:154: warning: Function parameter or member 'irq' not described in 'ad7298_trigger_handler'
 drivers/iio/adc/ad7298.c:154: warning: Function parameter or member 'p' not described in 'ad7298_trigger_handler'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7298.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index dc8d8c5f6ad36..006b6f63cf4e8 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -98,9 +98,9 @@ static const struct iio_chan_spec ad7298_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
-/**
+/*
  * ad7298_update_scan_mode() setup the spi transfer buffer for the new scan mask
- **/
+ */
 static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *active_scan_mask)
 {
@@ -144,12 +144,12 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-/**
+/*
  * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
  * timestamps within the ring.
- **/
+ */
 static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-- 
2.25.1

