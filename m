Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA422518D7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHYMrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Aug 2020 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHYMr1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Aug 2020 08:47:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF54C061574;
        Tue, 25 Aug 2020 05:47:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q1so1191319pjd.1;
        Tue, 25 Aug 2020 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tm5BZU7E80L7QCy6SXNATG1Gat1yh7ptVqD6ebMDZV0=;
        b=I7ynOoI28qulQvQTMeRLoKrD6ChW8o+L9Uk8/AUsaM5+T06OiaQXJ5GaGHSIOFYLmp
         e8gpz1OOYGcbgQgvoIf48FCm+NTzQACXLSTtdQ/Et1kHFdCjqIEqUbrScZXaNJr05XaE
         KikbgN6bc4jx+i5NOs18ule41RFlvifIk/gb9oPgZHklC1JOGj0kL/0xBV8AuCPpfFnK
         HbbIHae3i5FneiEu+xytTkho85gWuew2OoP8hHyd4aR3e1b+DZYjbLRIR5BnS/ZBigei
         79IJyLnG526RRMhf4pwuxUGX1iAFMiSIJeaM8UtbvX0s2T1p7BOiJNq7E2uCJdkQpKid
         qf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tm5BZU7E80L7QCy6SXNATG1Gat1yh7ptVqD6ebMDZV0=;
        b=TkMH9KQhDKvT9tSF2qUFGB/FG8MJAWiPRbEod3DO8lyZrGhxvu+vg3PYowdPNdVVw3
         sj1fKInk9hRc+Aredm+gt6qCSStwy5QEmN/3sDTROzLZ1hQV6IKLTbi7jYF/J8qsX2U4
         xMTmr3sOdwLUYeHy0fe7C1a0ivjXE5agThiDmT63atpmCEbdj+x4ZmuPEag5C9eINnt7
         fFO1udH6a0JDq2fSzm7cvRmdGNei2QK1vcAmTBTl09F97zgxuTHW3K+fuouNRSyUE6l7
         TIZkccfxOWs7rstvq7aCquvUfzXZ+3agaQGJeJfDNF0rGDWMv4VIubdNTAuJpGGzuNFk
         oDNw==
X-Gm-Message-State: AOAM5329j34AXO6CfS6UDv8xYF7M71dUqy7ATroq67iuUX36pocUh/5m
        tX1MlXn4XTCVgrrfz1kDqq1LwEZw6GQ=
X-Google-Smtp-Source: ABdhPJwd/4iPAjwuwyX10EmFMpUKmVabcqnOV0Ki/8cvNFmrflhNYXzLoz/yexFGsPj1KBxltfpaXw==
X-Received: by 2002:a17:90b:a45:: with SMTP id gw5mr1473885pjb.80.1598359646759;
        Tue, 25 Aug 2020 05:47:26 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:619:dc6c:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id m7sm10864490pfm.31.2020.08.25.05.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:47:26 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 0/3] iio: gyro: adxrs290: Add triggered buffer & debugfs support
Date:   Tue, 25 Aug 2020 18:17:08 +0530
Message-Id: <20200825124711.11455-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
data capture. Additionally, add support for direct register access using the debugfs 
iio interface. 

The device-tree bindings documentation illustrates an example of using a GPIO irq
line to trigger a data capture.

Nishant Malpani (3):
  iio: gyro: adxrs290: Add triggered buffer support
  dt-bindings: iio: gyro: adxrs290: Add required interrupts property
  iio: gyro: adxrs290: Add debugfs register access support

 .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   8 +
 drivers/iio/gyro/Kconfig                      |   2 +
 drivers/iio/gyro/adxrs290.c                   | 291 +++++++++++++++++-
 3 files changed, 287 insertions(+), 14 deletions(-)

-- 
2.20.1

