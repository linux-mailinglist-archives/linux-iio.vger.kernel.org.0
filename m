Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30158156D20
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 01:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBJALN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Feb 2020 19:11:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43297 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBJALN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Feb 2020 19:11:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so5073988ljm.10
        for <linux-iio@vger.kernel.org>; Sun, 09 Feb 2020 16:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ks72LqIqly76h/Rdk1ytCLMvXiVx7asbK5q2IthHrw=;
        b=ShmWGID3cChkRiKBYC87s6goZ6ahF1glExmovILibwPuhwEEUHdFWoZHiM40tRtvwx
         +ReJBUdW/N20xjaXDhyzbEVQTxZrRMh/lvq69Md6SJjPon7dPmtusoaezjJIEgx9kahN
         Go2aooQx3G2FYTFU8l1QQIbI/d5uBdfiEApP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ks72LqIqly76h/Rdk1ytCLMvXiVx7asbK5q2IthHrw=;
        b=THwUgNUwn1ES2URxhCfwgsFg7jEn/ojDvCet0ntst9vdEixKrYik5zf7ZkiI4Ih4+M
         zUEOHQdugqPxX3ic69fy/JlXvEDFEsb8h8vzTJoEmSGqEYjBLh93Byzj59VS4ChmA5mY
         +4+jDoNWIUVE8UGokp3Ju0mBmDNneJQmjiJ7HX3zi6sOOE2N2LuWnRQTUciTNofZ8ubG
         f79hnPzog0UIeQBjJJceuhLK8qTwi2oehpPCKRQnJRqI376Z5vH7z9r0+GcSY+v2PY8n
         7cPggYQVF3u+wD5P2RmozurGWZ9AOUoefLnrzPkYPRV52MGzy0KwBwu8UnEG1xIbteFQ
         X+oA==
X-Gm-Message-State: APjAAAVXUCUH5DkzTJdsXCAlhYh+9hX2X9lDDIiSL6Bp1G87h3qjkn4g
        fOgtkWYIDLX10zWeovf6pMXRgDfDUYDMDS1v
X-Google-Smtp-Source: APXvYqxYFJscEvwoXsjrNmwGEhAg62ZvR5zoM5BWA6udYcZcZLmr/7IR+6EMUT9C67KqibDYLVfkGw==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr6077202ljc.195.1581293470773;
        Sun, 09 Feb 2020 16:11:10 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-135.vpn.ipredator.se. [46.246.49.135])
        by smtp.gmail.com with ESMTPSA id f5sm4424962lfh.32.2020.02.09.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:11:09 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v6 0/3] iio: chemical: atlas-sensor: add DO support
Date:   Sun,  9 Feb 2020 16:10:55 -0800
Message-Id: <20200210001058.7515-1-matt.ranostay@konsulko.com>
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

Changes from v2:
* switch docs to YAML format

Changes from v3:
* fix up issues reported with dt-schema

Changes from v4:
* fix logic issue in optional interrupt patchset

Changes from v5:
* Update license on yaml conversion to GPLv2.0+ and BSD clause

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

