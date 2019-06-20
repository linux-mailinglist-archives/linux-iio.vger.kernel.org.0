Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D4B4DAB5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 21:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFTTwn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 15:52:43 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46053 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFTTwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 15:52:42 -0400
Received: by mail-lj1-f169.google.com with SMTP id m23so3790285lje.12;
        Thu, 20 Jun 2019 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jPVewSar8T2QzL1z/r0OOHuzJ0trwFnLC9MCWGa1vs=;
        b=HCkiA6z+oejJbFwTn2zO7KTdCxxeqCN5WgMmyXSH52t5e53vTKZQzVJZM448wcgQ+g
         +3t0YFX4jXb0QEgo73S/gJhrZNCfUxUZQmuAm1mzeboWsnFgZmDpMBGRkA6/iMt3n/5Y
         pQoC7A+gL1mtbhFcnVmlhEf6UOzawOHgSPc0CjBqdOMu0kgdCL9y+dd42z06LyLqguzY
         ljeJZgqEJKGgjneTkd+VV5M0bvHMU6IYn0lvuZqcHhJkZmQd45Q45fX5qWiUigvEJRiq
         YFaYukJULB5eG0Sq2bx/fjB/bWmS4zz2u9Ss0O81JICL8S0kwCdM9X9l10NoV9FJkQIA
         P3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jPVewSar8T2QzL1z/r0OOHuzJ0trwFnLC9MCWGa1vs=;
        b=ZcaBOEe8eFF75d+Dim1lZhtHdolrIv3VApMWQKtl9qEo85Zy4oN6FYt5la8886z0td
         sH3ldqW84SynbyFg3uXixhC3lEONRh8K1d7Q3bCw4hOj0IEQ3DehYMJ8dowOUSiU37hE
         dvHbE55FODHP7dRDUsamKMN3g24sULG7sDQucuUFDueLUs3qrqYAcd1gczEqfqEmCDHy
         emNJULkBIjcEmMl2xdBjCfGkQTf6h9Luqq76DIclQW0dEA8Ca3gT6x4ELVClCNQl6RJr
         bwQLnOuISf20LpPz88YQRtupI49BPnHdl7Zul2bP6WAByJfbe51WZ4M9kwEEN6J3Sj+D
         LV7g==
X-Gm-Message-State: APjAAAUntR1XC40spAAg59ZHTYyD9p/wGQAKRtPR3LCyUOWQ+r6maayw
        I4G9i/E3YBO5EAO1Sp5nQeu7Pifl3ps=
X-Google-Smtp-Source: APXvYqyOBDJ1mfktM5ZIXg7fMuMaD/cpePzLvjnjPImatSmFSyNnQv1PPL98nzJlUTj8C5XmvMQvxg==
X-Received: by 2002:a2e:5d46:: with SMTP id r67mr40555145ljb.187.1561060360511;
        Thu, 20 Jun 2019 12:52:40 -0700 (PDT)
Received: from localhost.localdomain (89-64-59-58.dynamic.chello.pl. [89.64.59.58])
        by smtp.gmail.com with ESMTPSA id t17sm74645ljj.55.2019.06.20.12.52.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 12:52:39 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/2] iio: chemical: sps30: convert bindings to yaml
Date:   Thu, 20 Jun 2019 21:50:09 +0200
Message-Id: <20190620195011.30942-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert sensirion sps30 particulate matter sensor bindings to yaml
format and while at it add myself as a driver maintainer.

Tomasz Duszynski (2):
  dt-bindings: iio: chemical: sps30: convert bindings to yaml
  MAINTAINERS: add entry for sensirion sps30 driver

 .../bindings/iio/chemical/sensirion,sps30.txt | 12 ------
 .../iio/chemical/sensirion,sps30.yaml         | 39 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 3 files changed, 45 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml

--
2.22.0

