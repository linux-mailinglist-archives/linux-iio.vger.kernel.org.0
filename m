Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E3F1527FA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 10:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBEJEa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 04:04:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40506 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBEJEa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 04:04:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so918527lfi.7
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdYS5NxgR6y1CKJqUfGAcA+LkYc13wnDqiTW8OcCXeA=;
        b=rbaM0BeTd6YCP/xuqK9SPsr7J2104dqiGcCD/vcllAk3mlqYtm5p/N9+kzGkI8VGqG
         PKobRQyJ0N/gQDEDv221jl7wm79xyn/kGUZ11Rnekpfmsj9UWwj/zKxf+LH5XQrLSn42
         2zzguvmh3/aBj7gLOMAIauPiQyDU4iGJgj2/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdYS5NxgR6y1CKJqUfGAcA+LkYc13wnDqiTW8OcCXeA=;
        b=gEde1r62FDI214edY+0zJiyz2k10q46vG5CysVXEbuqIDKtkkTUmouIku4jDzYT9h0
         SzZnq7WA2YkFIk4+WVYsnM9P/3d5ij5K9vf8C1HlckelSNoQOmH/15hth1blZi4DyUA+
         /bcV4sr82gL+/uI0iaYe93m3OzdLjjvJxxsA9iWrxrkhewYmqMbOeOtm+cYqeb7vzofh
         cNkX3wPRzsbKc/sHnAfEZPbSXxmBrfYqU8qAp654VluEgMN4bjbiP1OmM62h/dgbHbgX
         lXFULRGvKPpBeVAWfyWBLnDWGt28fmmoI6+QAbIJ8TXGbVJfCYn93Idc7GzOO1UoSNb+
         ZTjg==
X-Gm-Message-State: APjAAAWvy+VWgJpRuxGx81C9Jcg+MmxASQpGPPLsFk5T+xznUseBOAPg
        ecbTH4I/b2pWCZlGNmvVh9rX0HGj6C0=
X-Google-Smtp-Source: APXvYqwyd3DHQAe68+yzabUBgtZf0ZcJsQjgO2pwZFHNwQHVS8v8GqC/dENwswTKRYbeiij2UqB50A==
X-Received: by 2002:a19:c3ce:: with SMTP id t197mr17210163lff.174.1580893465870;
        Wed, 05 Feb 2020 01:04:25 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id k25sm12684009lji.42.2020.02.05.01.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:04:25 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 0/3] iio: chemical: atlas-sensor: add DO support
Date:   Wed,  5 Feb 2020 11:04:18 +0200
Message-Id: <20200205090421.18339-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes from v1:
* combined dt binding docs
* added making interrupt line is optional patchset
* broke out dt changes from DO-SM module patchset

Change from v2:
* switch docs to YAML format

Matt Ranostay (3):
  iio: chemical: atlas-sensor: allow probe without interrupt line
  iio: chemical: atlas-sensor: add DO-SM module support
  dt-bindings: iio: chemical: consolidate atlas-sensor docs

 .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 -----
 .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 -----
 .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 -----
 .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++
 drivers/iio/chemical/atlas-sensor.c           | 91 +++++++++++++++----
 5 files changed, 125 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml

-- 
2.20.1

