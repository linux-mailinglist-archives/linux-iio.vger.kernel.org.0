Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA85F161F9C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 04:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgBRDmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 22:42:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRDmu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Feb 2020 22:42:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so22137459wrt.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2020 19:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSDomM5608eYqXSuVYVM8UixZROetCut0Xp4yN9n0dg=;
        b=BMPAULv7xcDARoe8huMi9sv3LpqvbVFwIya6bu45cyUeRhT6BtPz10gCKnl6BN22eS
         3tBLvfqYdf0ZLApEdbU6XDiIAbFXsCfTPcp8vgeTwQogZJ5sDRGJrO2D+7bNjvRYSrmU
         Ydmu9As9XOfTVIuVN1wi4L7gfFP1jJF0ZhTEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSDomM5608eYqXSuVYVM8UixZROetCut0Xp4yN9n0dg=;
        b=ZanYd3/JpFwg4xqA11BsLRqfsO/5LtfzISaDLwvjcdO7N3omOpEJ9I1eBa0yZ2y8FQ
         QXZ+MnvaGTYFoNzjYQEWuTr205E8klZUV1lic4f8NjGUlGHTQ+aBf5cE3jpt2SGXb6Rb
         YniHyBGUuNh9ijw7PxIja1UK63VqpSGUMx+A147E4zBuWLEiMhqM9cWp1S8wpOXJOlfk
         cC/8lgyB3oaPcN0Dmyx+fmTNZZ6ZsTfWjl7MqKMZ1SNKN4sibkW/vbyOXSZIpmw29Pja
         +s50Mkl8yz7mk6QWIpcior3hPGyefo/rL3y8rsiB29vU4rbkOcNAHs7oUvayWNgYB+Fh
         /zcw==
X-Gm-Message-State: APjAAAUrX/fOZTJAuqhkCrlOPwE9AhSktYmjIhA0I8wtnULaJ/Gwphja
        Ea8Q7WAGhj/iXKlcQfa8dFXiF9D6PlToHtXo
X-Google-Smtp-Source: APXvYqw7BCpAFHVIGZ/CbxravrPreF4cFNJGRmFSCs7AnJR44kpyxSOv/hhuvaq+BC9EpFLsuJIgDw==
X-Received: by 2002:adf:f886:: with SMTP id u6mr26321564wrp.409.1581997368766;
        Mon, 17 Feb 2020 19:42:48 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-213.vpn.ipredator.se. [46.246.49.213])
        by smtp.gmail.com with ESMTPSA id s22sm1816901wmh.4.2020.02.17.19.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:42:48 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v7 0/3] iio: chemical: atlas-sensor: add DO support
Date:   Mon, 17 Feb 2020 19:42:36 -0800
Message-Id: <20200218034239.135619-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.0
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

Changes from v2:
* switch docs to YAML format

Changes from v3:
* fix up issues reported with dt-schema

Changes from v4:
* fix logic issue in optional interrupt patchset

Changes from v5:
* Update license on yaml conversion to GPLv2.0+ and BSD clause

Changes from v6:
* Don't set interrupt bits in buffer pre/postenable if no interrupt line
  is registered

Matt Ranostay (3):
  iio: chemical: atlas-sensor: allow probe without interrupt line
  iio: chemical: atlas-sensor: add DO-SM module support
  dt-bindings: iio: chemical: consolidate atlas-sensor docs

 .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 ----
 .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 ----
 .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 ----
 .../bindings/iio/chemical/atlas,sensor.yaml   | 53 ++++++++++
 drivers/iio/chemical/atlas-sensor.c           | 97 +++++++++++++++----
 5 files changed, 131 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml

-- 
2.25.0

