Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5743DE9B
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJ1KV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhJ1KVU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32017C061745;
        Thu, 28 Oct 2021 03:18:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r4so22141273edi.5;
        Thu, 28 Oct 2021 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkhuLzEUCNcvTjcsf4bVXjrayhI46SI8Gxb7tDI+o1Y=;
        b=E0DbQ62Z9GeOvr63mpZS+AvF/jrXvf28q2yJPZ9buY/dp/WD8PZ4KWFWhUkrKzVewN
         0VMBYxhqIjIPZ1YhA+BZQCKypLKXr/SHDXocu4ztENUqnr7Qecd+XpXERuna3mPN457c
         UEtJ8DYZkIpDy+XzZ2Z4tTPZDePEVqZtKz46rmYIHxZoxZL4Bw5xPqGd5It2B9AH6w89
         eSMvuQxlwqk4x2dyWccbi35Ob4J8+UJVrUUu9oKA0WjTuaNGnu6+Qeu7gylHdbVIuYaP
         dbghon7isMN4ny1R8xSGDALq4vnabj4Tj7194SncJeMeO7rjDuc1iDex7J3x4XQBLLQR
         pjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkhuLzEUCNcvTjcsf4bVXjrayhI46SI8Gxb7tDI+o1Y=;
        b=qm+/CE31jOVeQfDn5d5wpnG99SgPQiU292A16Tq5/Zlu/pAIb/4W/fifU7nCo7Cssx
         mOYrKNj2IAL76FTm9pDBwlp/INklBk9xsYlMX+cxYkjpEUiMf5tndKtUJTi8IEccOr7T
         FIoM2FIs7hA9r9ARwdAB405xyl4Hte2Jv2A46qB3qkrjax03pSY2mqSUihAXHpM8y7w7
         a5coej3SZTlEnA9L9F7vTm+SHhbgaPfrZWYNtLbHqQUOaq2PJE5+SNPFwL1c3CYDl4Hw
         KRJRJy6OP6tsNGYGlX85p18tc2w/USky1Vo3uDPfa9j3ZxR549wRXPTLK0ttnwzLSOii
         OqPQ==
X-Gm-Message-State: AOAM532nVfp8IdB6WzvpZrZVcetLKIq/debgyvkRk+QxHKIBJtfbKKXF
        gd+RK6cmQvdED8kNjMINLFs=
X-Google-Smtp-Source: ABdhPJzhttW7rWuSpD6zf5/jIjjHryUoTdHMucoHnKeg/DapBNEtUdZk6lwPOJ7gpuzVBVrKkzL48g==
X-Received: by 2002:a05:6402:270b:: with SMTP id y11mr5033341edd.387.1635416330910;
        Thu, 28 Oct 2021 03:18:50 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:50 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 02/10] iio: document linear acceleration modifiers
Date:   Thu, 28 Oct 2021 12:18:32 +0200
Message-Id: <20211028101840.24632-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces ABI documentation for new iio modifiers used for
reporting "linear acceleration" measures.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6ad47a67521c..5147a00bf24a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1957,3 +1957,11 @@ Description:
 		Specify the percent for light sensor relative to the channel
 		absolute value that a data field should change before an event
 		is generated. Units are a percentage of the prior reading.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) linear acceleration readings.
-- 
2.17.1

