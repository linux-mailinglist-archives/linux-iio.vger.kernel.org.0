Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415C51551C4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 06:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgBGFTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 00:19:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35483 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBGFTR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 00:19:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id z18so679493lfe.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 21:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQdRNsVprXKJUeGqwra2VZH/BcymlQ/PWXvlNHTiJdw=;
        b=dQO8cLa/dlL/WgrCe6LBikt/ifAVeEakNkig8cZe4MvD39YN3jQV6MXy60hZxCp7SZ
         lVEW26Xast4m4DIk4tY8nn0H5JAbzW3YiulFuhDGQestWcxouS3hRPjrh0ShILe7XpKY
         s1nMJLjDYpdEH8TCwmwxSo7ifLBDyTiCV0x9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQdRNsVprXKJUeGqwra2VZH/BcymlQ/PWXvlNHTiJdw=;
        b=oN0xMALxDSvrkxDHqMHd8KfqHdDaQslQnsT7utWolaASk2fge5hMfhHOiIKDdf+ba1
         MALfXBKcimSOJ6hNz7OK0DEzoNfn8xYLZhQANQJsVr7RaBYZvU/oMufZn6JGoU4eqEIJ
         Et8OMWwd5wq0Ye8fkTbRCO3hflttPhYjYC1xRMBgw8q9Oums+yLFPhzaWrncClsEBhTB
         jNczmxFejwHAbWLsM4R0BKo1McYYOya+boPmVBwKEpLf7rWz7FqQBZ6Xqpy7/YjNwgtC
         j4XTd6hkXjqIw2+RSIe8H1PqP9Wu3+E1JU3XkAYUVqK1pr9oDUXahsIWoiGriuWqB5XU
         Hifw==
X-Gm-Message-State: APjAAAVHEPOjlK38VwcUSWWOrFU5pz1pks43BP8cKYHoea1txnWqWl6u
        CG/7CFoYEf7voJ3egmc6LnxEe71I6hOdNGF8
X-Google-Smtp-Source: APXvYqwl0uVcOT7ZJWUGnwXW9wFz5XqxkNLGxbbcBAQpzABxsjgPzCl/d3JKPjDjyqDNFOaa6LBRVw==
X-Received: by 2002:a19:c697:: with SMTP id w145mr3602367lff.54.1581052754410;
        Thu, 06 Feb 2020 21:19:14 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-167.vpn.ipredator.se. [46.246.49.167])
        by smtp.gmail.com with ESMTPSA id y11sm622069lfc.27.2020.02.06.21.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:19:13 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v5 0/3] iio: chemical: atlas-sensor: add DO support
Date:   Thu,  6 Feb 2020 21:18:10 -0800
Message-Id: <20200207051813.9708-1-matt.ranostay@konsulko.com>
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

Change from v4:
* fix logic issue in optional interrupt patchset

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

