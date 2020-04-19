Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D01AF764
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgDSF7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 01:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSF7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 01:59:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2068C061A0C
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 22:59:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j14so5205677lfg.9
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yOnz2uKD00AZj5kR4HjV5+sVMxqPTx6XgvRuNgu89Y=;
        b=F1jy0CpRiBmzOn61IRTnL1kEiXcbr7V9627EABrnZ+bL8GI3l+D32TPoPyyR0l7CpU
         tHA/rbEOCIv9rAbRHK9J+90qu0thR9ViJX1rYm5axZZMvDAVKcpSZGxI9sXvai+f78/5
         npm5ZoVokLLg0jpt1OX639WXcnbuOQnpAg0Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yOnz2uKD00AZj5kR4HjV5+sVMxqPTx6XgvRuNgu89Y=;
        b=f1jgpCfomIo2Lt+vmHJ8m3G/l252bbCm4YcJrbfgk+FlKBKwDQQD18Vx8njyzvjpl3
         3QDvGW6pdcXOz/1osSl/wiG6nV/TB3lxMQkUs5vUv+wlyQejFVMhmNnSErAy6wzpckZ+
         BF+coiY/2U4w3HDfkBjFA3QObqb2KmWpcErjkyOvJMFd6PyM2Z7/U2uzb+ly4S+qbbGo
         Pw++jvXcF4BVQk1jXXPGqjqa30US0lG/P3KueD3yNxiyuHOyVq/bcfyLNWn0BobYl+S9
         htZDMpzYOF1OZsfnUi1uIOPPNmzEg1/pyLDVwz2gB1EsxtL0dLuizP1mp2hrPllwz9sc
         O0qA==
X-Gm-Message-State: AGi0PuY9FGUVL+eog2NvVFygdoEDhA0HTUsaBjZpz8MbI4LCQ0RzXcE3
        4nQ5AMUw1UxN8yhMsFIziiWVg6xJMWQ=
X-Google-Smtp-Source: APiQypKtGjGOULHIGwx+i5GJ+YbLyiz6ECTtWxQ5ifcyPCus4ZCm5ayZ29lXHBy3zqmmZlzhs/qNTg==
X-Received: by 2002:a19:7008:: with SMTP id h8mr6647493lfc.43.1587275953129;
        Sat, 18 Apr 2020 22:59:13 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 4sm12407715ljf.79.2020.04.18.22.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:59:12 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 0/2] iio: chemical: atlas-sensor: add RTD-SM module support
Date:   Sun, 19 Apr 2020 08:59:05 +0300
Message-Id: <20200419055907.23411-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Atlas Scientific RTD-SM module support which reports
back temperature data down to a millicelius resoluton

Matt Ranostay (2):
  dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
  iio: chemical: atlas-sensor: add RTD-SM module support

 .../bindings/iio/chemical/atlas,sensor.yaml   |  2 ++
 drivers/iio/chemical/atlas-sensor.c           | 32 +++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.20.1

