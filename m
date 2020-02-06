Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8569A153EAF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 07:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBFGYO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 01:24:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42477 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgBFGYO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 01:24:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so2516714pfz.9
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 22:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOuYaaepSOyBdqeNIvS/TztPdsSgKYr7vUBOqbQDLTw=;
        b=q0zYkXkaLKgcOqLdXVDSJWDUuB1yR+zjACq2rBMzr9G5D/avYTg4JC/RyTJZel2SA2
         IDERP6uIzCPeFmzQ0lcsAFTq1oh0VBlAGy7mOrID45St0HyOImvGQsjTaNI3n0pPeraI
         aaaOItI4pX/cDVQ8GVHA2MY92yswacVzg4eHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOuYaaepSOyBdqeNIvS/TztPdsSgKYr7vUBOqbQDLTw=;
        b=QeHNcDp46k6DkxdeX1UwiM4zvKghHiQv0BR0QBEsc2cRm3NbREUxAwgfioMNDOFE7U
         BABlJsQg99RPnbpGfScWaRMSbpCkod3At6vkTuTUZYXLQcHfYFTpCBY4IcT4mboK/tmv
         gW7Yf9DMYBdjihF2ZtzVqGyxtqczvmjvQtEQdp0MlgIVn/nBjfoux3fmZsNKFJj8ybau
         gm+BFOdDacvbxC6JBqD0NOGN/y+fZcp1tvu1A9vJnFm5b8EaRmsrYHe3ANnRVBJADKVn
         BUNS8dPI6Ly6C5Q3EAp93oU0SarRnh2c5CSB+QXdvIy8GzyC5b+cQ/KZ6slJ5zylfeOv
         BJYg==
X-Gm-Message-State: APjAAAUFlZcETaMW/Kbb/hH5drEioFKbU9pMaWFcqD2ixHBHzZqenWWX
        gIMd7H35NYqRKdC9SjaReu0doUXjwn846m8x
X-Google-Smtp-Source: APXvYqzGTA0svFK9od3GkEU3dZc5pm3BzPZTHDxcF1CheBHYHmj3eWUSM//S/z9h4c7nBrCHGuOBug==
X-Received: by 2002:a63:d249:: with SMTP id t9mr1976179pgi.263.1580970251719;
        Wed, 05 Feb 2020 22:24:11 -0800 (PST)
Received: from virtualbox.hsd1.wa.comcast.net (c-67-171-239-254.hsd1.wa.comcast.net. [67.171.239.254])
        by smtp.gmail.com with ESMTPSA id z127sm1771323pgb.64.2020.02.05.22.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 22:24:11 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v4 0/3] iio: chemical: atlas-sensor: add DO support
Date:   Wed,  5 Feb 2020 22:13:29 -0800
Message-Id: <20200206061332.20427-1-matt.ranostay@konsulko.com>
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

Change from v3:
* fix up issues reported with dt-schema

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

