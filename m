Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31B22224AF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgGPOA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgGPN7w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA7C08C5E1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so10406978wmi.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrH3kHLe+dExzck//Xs9WC4y12BnMG39PRZDgQtY4y0=;
        b=e6LcB+3pAZokM37jcPJ93LQeC/I0DhPbBDogTHulpprvOqEfVf//SPgEydAg3NXncF
         kwIfObXF5wnxkCMdvqg6xSHqaIZ0Emf8L/Q5YPPSB9SrpdsGo7hfFc5zvsOJBodpl7it
         LNub4EOvVQ6m6R5nmNVMx85hf00jH6o1yhlnfGpvhQz/ycvC+k64ZjN2OerS8I2h5RD9
         IVM6pfM0ncc1lKjy07LgeJ25/vLSijE51CBZdL4AbM8l1+SYpyBJUD58O14yEOSAKwGF
         /lw9NT7IcLZeqFGH7cceRbcVE/KeiLXdtBGAm+yoDaSItjNPWxnBZ04yBjVJXDorQHPK
         RdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrH3kHLe+dExzck//Xs9WC4y12BnMG39PRZDgQtY4y0=;
        b=RdmvWvlBLFwRuIqJ1p3+/0Me0pnYNOqjYQPqV+6SkBnHFxeTPZb14mXfzywpxaWV01
         ahy9TC9kdqYzmdOkthN7kQj48aCxnzxEye7kZZKrM1IF3AZeRlohJTmSaziPyQiPQaif
         LdVFZKKV3r5q5SWdUv5JcEjVh6ul8y15/jXGXO3m4VrHT6dBNnSOMgHnLjZK1So0nUwG
         y9TtqppYG3vj7BLAnFGVGw81cTWHu0o5ff8G6kNAtxmHTJCtoia753K1ryW9Z74cQ7GB
         QrMsLRhBuNFZ9pNjevp0zoWBONSHJbW1McqqJGp+8MwFyihNGtcnRblhmGRyLsdMnqcq
         iGJA==
X-Gm-Message-State: AOAM530zfiUytiBJ3wT6fOmBwMYFE9rFxoI5n3qADuuMQ4pZn0pUj6pX
        mHXEH5mlSvax30xZvmQBSibVdA==
X-Google-Smtp-Source: ABdhPJxuAnC+YGPWsxb+HKSvBTdc0WVR0l7V3uIrjXGnax3Yqf58atXa+3JP5r7A1VqoflQxuZgvPQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr4456320wmh.130.1594907991365;
        Thu, 16 Jul 2020 06:59:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 16/30] iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
Date:   Thu, 16 Jul 2020 14:59:14 +0100
Message-Id: <20200716135928.1456727-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is the only use of function related kerneldoc in the sourcefile
and no descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7887.c:119: warning: Function parameter or member 'irq' not described in 'ad7887_trigger_handler'
 drivers/iio/adc/ad7887.c:119: warning: Function parameter or member 'p' not described in 'ad7887_trigger_handler'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7887.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index c6a3428e950a9..bbaa0a3daea3c 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -109,7 +109,7 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
 }
 
-/**
+/*
  * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
-- 
2.25.1

