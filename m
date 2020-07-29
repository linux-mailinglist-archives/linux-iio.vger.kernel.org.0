Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F572316CA
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgG2Adb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgG2Adb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 20:33:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA0C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 17:33:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so12011274pfu.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlCxbIrWBhhWRU9uwjI+LO77lVNGAasnY8h/ahIaD9U=;
        b=dJe4buGtemAcApCKi0Z1BaIlZ8D4Di04AbjMQWiP+FlKXJmx14l6BqgxNk8o8J9mdM
         khwpQYdQorW7M8cQ1oxH9EidTa4qcoc1K66oMgA3VzXLX369I8TlCiS6MAgH0aD82xbh
         kie1RaKZn9mEoXu99rgOTjtn5uZ7l/xdYbIReqsL9+U+ncXF9A95JWL4+FEekNU6PZ/U
         wGrQzB5wgvBCJLR2oGUvHg5aK+1Q0+g+SFcoU/KRx8cGyGabq/EnXPRsd5W/kWpVSIc3
         pcfeDRVkh2Oemmtr+XCFU5ZDtTBKJPD1nkG8H/f1eULHaSRmjlW/0zIMGAuxoZLdPSvp
         uoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlCxbIrWBhhWRU9uwjI+LO77lVNGAasnY8h/ahIaD9U=;
        b=VVkA+TRwSo9U2SqCRQ4dHPMJTBzBIOplQZ9rfZmM4h0BXuNGCtW+RgF6DSgsmjHwVH
         3dWr+JEWoVns1uu9zPFdSNOMgfItxNpgAn51kxPpWtcwlx1fNKd3CjN5hD6fXsgXknXX
         E+ap8q60/yeC0Tunf1FtBrcX2DZ71YCQq379sIcBj7fEkMmdWn4+0oNtK5/wF7VeJByq
         RitYhKShH4OOI+G9NFBtlh2AhWi3Qz6T9uPqD/1/bUoaprNAPA5SuIUYA8V9jRCf/XxA
         fZAKI4hGyGooHbAZqtdHiU3093mJ/zR+F9CJKCyXkU+PZ4eug4Jiu1tbLxODV/BxEkuS
         76PA==
X-Gm-Message-State: AOAM533LvO1+DllBjuza7WW63R3UlBM3vukAll42wS8Egg1Xhj5/hzoe
        y5SrmvnxUCtq4R8AYePrmAqz/w==
X-Google-Smtp-Source: ABdhPJw1MOImB0wnsOR3dpdVzysFulP6PJlBib1doSUT8k7yf9HKXGLyoLMtZWz0HzeqDF7r06QEkA==
X-Received: by 2002:a62:d417:: with SMTP id a23mr28011275pfh.56.1595982810378;
        Tue, 28 Jul 2020 17:33:30 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id m17sm202547pfo.182.2020.07.28.17.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:33:29 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH] Staging : iio : Fixed a punctuation and a spelling mistake.
Date:   Wed, 29 Jul 2020 06:02:43 +0530
Message-Id: <20200729003243.32097-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added a missing comma and changed 'it it useful' to 'it is useful'.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
---
 drivers/staging/iio/Documentation/overview.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index ebdc64f451d7..00409d5dab4e 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -9,7 +9,7 @@ The aim is to fill the gap between the somewhat similar hwmon and
 input subsystems.  Hwmon is very much directed at low sample rate
 sensors used in applications such as fan speed control and temperature
 measurement.  Input is, as its name suggests focused on input
-devices. In some cases there is considerable overlap between these and
+devices. In some cases, there is considerable overlap between these and
 IIO.
 
 A typical device falling into this category would be connected via SPI
@@ -38,7 +38,7 @@ series and Analog Devices ADXL345 accelerometers.  Each buffer supports
 polling to establish when data is available.
 
 * Trigger and software buffer support. In many data analysis
-applications it it useful to be able to capture data based on some
+applications it is useful to be able to capture data based on some
 external signal (trigger).  These triggers might be a data ready
 signal, a gpio line connected to some external system or an on
 processor periodic interrupt.  A single trigger may initialize data
-- 
2.25.1

