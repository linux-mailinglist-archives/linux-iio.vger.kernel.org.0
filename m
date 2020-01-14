Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30EB139F79
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 03:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgANCXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 21:23:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45078 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgANCXz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 21:23:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so12456447ljc.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 18:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FkXtnP1nKujUtQYdllawOHHEW0y3YiLf33Ds+wkLiVk=;
        b=EYqBjMUUX7ZShH3yYXGEhxrgofaS0SMDcf1Ffciq5bkp9B4+UiV8qmH29gGQ8AwfrE
         VKaGvMrYOuuxIKCJR8AeAA27r7HJysEER21xvhm0/WhHCtXQ09N3RC89I7cHLQ0Lf8X0
         q+5OKfPYkLQwZEquIpc8Li4COJ6S3iftFLqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FkXtnP1nKujUtQYdllawOHHEW0y3YiLf33Ds+wkLiVk=;
        b=LgCCgBR9Vq4F/PNqiMmXiARTtZwAFFiHH7KOtfPN/cbPqct8YtWYb+EiVmZTnjzV5/
         roUwdyCGNwRC4UzhFWVQFlydzMhnHqxzli6b3nayul0ZMNN94ucdWQH88lfILL1ZB9lO
         cD37NmB+fILB6E4dfNYfnobu7uC0thgdfmTiS6WbR5vjIOO05ruqdNIMyQkrgOisaL2H
         ShgGdW7P+cdbcO0awl9cXEq+ZO9TU9OSuexpfTtmJnTWabIF8BUHeyK0h09j7fPFI8v2
         n4XRSJCFYWCfm93hZk57T5Pf6Y/UUjAzZTNGDJ8iSRbR4xVjyh11i1asPRu1urBEAmll
         Lu1Q==
X-Gm-Message-State: APjAAAXgT39PLcN5Geyoef6fT2TjEnOkMNPnWgpccNA4T+9Tl0N/SjID
        VsDcY7b1znHUHkDfv5meyElCiVsnMvt5uQ==
X-Google-Smtp-Source: APXvYqyfwEMjrJZvEuipxljdy1pwpRlMX/WzM4q076xM69zEpndONF2pO5UGI1dg2gYOwsf0i3ykCA==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr12541682ljj.182.1578968633356;
        Mon, 13 Jan 2020 18:23:53 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id r26sm6388648lfm.82.2020.01.13.18.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 18:23:52 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 0/3] iio: chemical: atlas-sensor: add DO support
Date:   Tue, 14 Jan 2020 04:23:45 +0200
Message-Id: <20200114022348.8676-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset series improves docs, and adds support for the Dissolved
Oxygen sensor

Changes from v1:
* combined dt binding docs
* added making interrupt line is optional patchset
* broke out dt changes from DO-SM module patchset

Matt Ranostay (3):
  iio: chemical: atlas-sensor: allow probe without interrupt line
  iio: chemical: atlas-sensor: add DO-SM module support
  dt-bindings: iio: chemical: consolidate atlas-sensor docs

 .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 -----
 .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 -----
 .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 -----
 .../bindings/iio/chemical/atlas,sensor.txt    | 34 +++++++
 drivers/iio/chemical/atlas-sensor.c           | 91 +++++++++++++++----
 5 files changed, 106 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.txt

-- 
2.20.1

