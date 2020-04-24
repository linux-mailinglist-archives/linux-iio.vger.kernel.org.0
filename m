Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6E1B8229
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 00:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDXWos (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 18:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDXWor (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 18:44:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B612C09B049;
        Fri, 24 Apr 2020 15:44:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so4283080plp.9;
        Fri, 24 Apr 2020 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEeOet+/40RLPQ2HnToplB1/VKa6bs4EBDI8R+ygUJo=;
        b=fjSO5XRQlkI1TM8bFCjVp3PV3ZWTrx4nTWh1LjTf3NIu0jp3PkFGTJYi8fYbBlkD3H
         geHf1ch6FUO8dH8CLiFIRoz9i2YU3xzeFjMQdqRVI0Y43UkhrYA5DrNr0uEnw9Ar9oRC
         WklJ3LaRZZ4/02BWqgf8pnbY3BCcSCLvoE94GxI9V2a8isgFQA8Utn+52G4M2QAXFED2
         IFlbHaqCWUy3rPd5ZiiDfsR+Rs39mQK8ZPwurnf568rWwBdBwDGvnxf0BZWr/6jBWfzc
         jq5ZoYfTlIC4uLmTO7gZImNWP+jU0AdYXhY1J9re0vawiOlJP8s7nWLLnepJM3bit4z/
         EzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEeOet+/40RLPQ2HnToplB1/VKa6bs4EBDI8R+ygUJo=;
        b=Zi9mRrQ3eUB1MoJZRNtcO9eCQC+os7ER+HAV4jEnjIKkjcfDhYaHgMcA62fItIK6Jw
         XJTKqXxTm7Bpf/bqBniJPaePiLBVPdpoYy5XI4pSb+6eqOMzcTW2QeX7qflMsI1evfjl
         BIlHqDkFTIWlSWkpRHSMdfBW27Uoy+6cIW1OEgOqBmzZhDXa1Qt3XEPjeMcc3bleoSVj
         OWARYtKqm7+Svw7ewK5c+Tp3CiMEz8AOEf3VvRKGph6qREPf/YRcBZ75h/OFFj3UleTb
         5TKAjrHI+kvLA9Kb+lxsEMllUkH5R5dGWYhge2ixme5PuwRWUXPKBoevsCkFNytaiWdk
         /yGA==
X-Gm-Message-State: AGi0PuZZMcCQiI3D6H4FuydgAZlQ8uMFHvCw1R69HL+pJ/1nUFV3JJpA
        68rUKyM+hKgpgcQTcuqlZ/4=
X-Google-Smtp-Source: APiQypKFlXyN7qVKLFM4AphAq0veC6wby5t5GXEwXCV+9bPVFHaAzdzHbO+nU82oU6/4FA4ZJmdXzQ==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr8776998pjs.127.1587768285729;
        Fri, 24 Apr 2020 15:44:45 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:610b:e3c6:8c8d:27b8:7b5b:c4d9])
        by smtp.gmail.com with ESMTPSA id z5sm6613552pfn.142.2020.04.24.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:44:45 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, alexandru.Ardelean@analog.com,
        nish.malpani25@gmail.com
Subject: [PATCH 0/3] iio: accel: Abandon of_match_ptr macro
Date:   Sat, 25 Apr 2020 04:14:36 +0530
Message-Id: <20200424224439.5601-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset extends Jonathan's and Alexandru's work [1] on removing the instances of
of_match_ptr macro. Motivation to do so is two-fold:
  1. to have an option of probing from ACPI using PRP0001
  2. prevent people from copying to new driver code

[1] https://patchwork.kernel.org/cover/11497535/

Nishant Malpani (3):
  iio: accel: dmard06: Use mod_devicetable.h and drop of_match_ptr macro
  iio: accel: kxsd9-i2c: Use mod_devicetable.h and drop of_match_ptr
    macro
  iio: accel: mma8452: Drop of_match_ptr macro

 drivers/iio/accel/dmard06.c   | 3 ++-
 drivers/iio/accel/kxsd9-i2c.c | 7 ++-----
 drivers/iio/accel/mma8452.c   | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.20.1

