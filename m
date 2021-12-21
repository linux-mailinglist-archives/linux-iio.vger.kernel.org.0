Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02A47BB96
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 09:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhLUIRH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 03:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhLUIRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 03:17:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AAC061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:06 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k64so11008806pfd.11
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7kJ3Guk6CkoMGPYbVRMKVCUcJxvX/ENOwv4Q6yq5ro=;
        b=CVv2503hCvOAUAtcN9cY1D1zAWmGAImpmgvEN4T+FG208A95Iz6tgi6HByjMQ6wFCO
         aBnlgMQ4GRtw9sy6txFj6N6WD/1IJTZ7u0nTWY1q7VFV0hwkp620e8gQvdGDFkLSFwW5
         OcBWoRzt+8AxvlrOthHjmnTD+va2JJEGtXuOM3XHSemfLqk9AdJ3xaZO/qD4/6KRJtXO
         dIw3By2Az6Dms/U4oLl2NfO7WjJei7Pz9iV110bm2Jrqnr1ABKBSIhg1dVPamvnBcK8v
         loVq9XKgsQ2NoapRoKYJpepnuWFjcfcNeIOXvJtazxbhUGQ/7POHvO3usZrcgU73fMy5
         sv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7kJ3Guk6CkoMGPYbVRMKVCUcJxvX/ENOwv4Q6yq5ro=;
        b=vIKcfKHAW6rxTnL1Qh/TmezEQv963mU0+0GcQtewVATYSNBq+bndYIJ2fIgM1w96SX
         DZj6pC6ZcSkZb5JhRSBcgWiZJz/rsbrnsfzuzj+x1MRLg3A4BKKxI8hmXrbv0NZxrtsf
         ShoCe/MI3J7py+J2v9S717rHbYISaBFro5sig+dVqn8ed5wpJnkISfgRDRziwZYE71Mk
         9P+6Nv74/dhisdErVjOgNzVyQVJLzOUmPBh4iQfjuP+wocEn8r3CPUlbEHDgYV9vVB8N
         0at/6RZ+pIyRYqJUvYBYL0MTIRUAW1Bps8kUeHatUwaNaSM8uwvpWKJdrtw5DDuVpZqx
         CDrw==
X-Gm-Message-State: AOAM533ujYvcVxMsX8drIM9ywXGaJNKDk180D55EnOz0opWrYIVj6WQ8
        DSW4XDhDWAs48KvEW/fa50w=
X-Google-Smtp-Source: ABdhPJzCYFhA1d5/3TTIhm3jwGoyCmtBbDu25Jr5ok9BJDXwDLPd69D2EL/qkC8Hmez0wz98thF0EA==
X-Received: by 2002:aa7:842b:0:b0:4ba:881b:278c with SMTP id q11-20020aa7842b000000b004ba881b278cmr2038192pfn.30.1640074626227;
        Tue, 21 Dec 2021 00:17:06 -0800 (PST)
Received: from localhost.localdomain ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id b6sm21196890pfm.170.2021.12.21.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:17:05 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/3] Counter subsystem changes for the 5.17 cycle
Date:   Tue, 21 Dec 2021 17:16:45 +0900
Message-Id: <cover.1640072890.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are only a few changes for the 5.17 cycle: a fix for missing
colons in the comments of struct counter_comp, a minor improvement in
the access of private data in the ti-eqep driver, and bug fix for the
interrupt enablement code of the 104-quad-8 driver. Due to the small
number of patches, the respective changes are submitted here as a patch
series.

Uwe Kleine-König (1):
  counter: ti-eqep: Use container_of instead of struct
    counter_device::priv

William Breathitt Gray (1):
  counter: 104-quad-8: Fix persistent enabled events bug

Yanteng Si (1):
  counter: Add the necessary colons and indents to the comments of
    counter_compi

 drivers/counter/104-quad-8.c | 82 +++++++++++++++++-------------------
 drivers/counter/ti-eqep.c    | 23 ++++++----
 include/linux/counter.h      | 40 +++++++++---------
 3 files changed, 73 insertions(+), 72 deletions(-)


base-commit: 1b18af40c1db195619e611faaeae624d6319b1f1
-- 
2.33.1

