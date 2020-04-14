Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79D51A89D9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504146AbgDNSlg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504143AbgDNSlf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 14:41:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F4C061A0E
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 11:41:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o81so8656449wmo.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T5w85/Anw13tnbFJIsbgQbaUb8qEVJINnyZH/cS+SFA=;
        b=jsnljtSlvswR2ovcKd+fXLvdcJQndwCSqeK0GipEcGER4ywfKTkpnJNqj4mcZqIpMR
         2o5ibNYzD0C7iHDKnfXG7hhjArAkjF6s+im2cJuvtdrA3h+9ZlzV5cM/lJo33et812yJ
         IUESe4hIAw6xyL0FSzSgPhcYz4Zi9Gjv4z8Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5w85/Anw13tnbFJIsbgQbaUb8qEVJINnyZH/cS+SFA=;
        b=JSIY2mwSrgAr9aCsFX1T6grXKMS9cprHVXWxnZHU2m4Z5uH6VeSiqT4MIHrOPNAjCE
         IfOUG7gGtZuhP72h31rvKbwQuLXl9Sy+6zsx1Nzsx8Dw+5QZmRlZdBM0ZISLmLOOLXYd
         Q/vQDMedhalweLa+4QDuU4L4WhPkDKJLlYOdiMomX2yfXK9/GoEL/WBFe5zDXUvS9nYS
         MILaplC9cMMf2vdikgZkCtkIFVhYNFaxQMMUcWAARtDoGIBY2p/DKz0BhojXxd70hNuq
         IXTM2Ic+O9/efunAqauW8aDLdBctmUFDfYC+62rkRf6Pv8tNfWEwwRXE3pFby6Xpg6ux
         JSlQ==
X-Gm-Message-State: AGi0PuZTdxWOKwza1BDHV6Aj2DZpCSZ6UdC8puo41hFOyMv4JF/PrfYy
        7jXl0pjaZQvwtZ0J01T6OUdx/+NvnJKIsw==
X-Google-Smtp-Source: APiQypL+0lwar/HungBo6Fq2I5YAeBElDe10v88NDnRwHd8hW/C6LhUu7ylWSAU9d6M5gPmbyZufuQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr1108996wmi.64.1586889691181;
        Tue, 14 Apr 2020 11:41:31 -0700 (PDT)
Received: from server.home ([2a02:120b:2c74:f040:98c9:7cd5:92ab:c7f4])
        by smtp.gmail.com with ESMTPSA id d7sm20095555wrr.77.2020.04.14.11.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:41:30 -0700 (PDT)
From:   Lars Engebretsen <lars@engebretsen.ch>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic@kernel.org, Lars Engebretsen <lars@engebretsen.ch>
Subject: [PATCH] iio: core: remove extra semi-colon from devm_iio_device_register() macro
Date:   Tue, 14 Apr 2020 20:41:28 +0200
Message-Id: <20200414184128.22957-1-lars@engebretsen.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d63884a54939..76ba7c9fd3e0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -597,7 +597,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
  * 0 on success, negative error number on failure.
  */
 #define devm_iio_device_register(dev, indio_dev) \
-	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
+	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
-- 
2.17.1

