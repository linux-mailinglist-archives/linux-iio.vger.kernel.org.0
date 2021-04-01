Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBF35185A
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhDARpo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234553AbhDARiA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EF9F613C8;
        Thu,  1 Apr 2021 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617297603;
        bh=usq0s/98Iuh/cp4Sl8sg8Td3LyTxRc7CTMxUIrR/zDg=;
        h=From:To:Cc:Subject:Date:From;
        b=PtLVsgwfbAOh1/JZXaqClCEHPcDiWupUkGYyyEDteEf3v2XPIq4vPlmjLO94Ej97k
         i0weT3e+ybdpdlMe2mo9TI2BXSjPBlvkAF1BYowbxMALRw1mSg42mWqTiBj3HJLDgT
         LDk8oUpL4rz89oeAwdGZwynMF91Qee06w/54veU02D0NtK3KjtI6aT5jVwA10/9Xiz
         N130D+tYE8IRtRtnvgrsXAuiMA5JxYHqDX0Js1WsRF7UNsKNw1TeWmWcqGqZiWhaCZ
         SJEsGT8NhjfebKo1Oi1zu2DGyx+JNa7fNrorHq029ASPZIoqt7nI4O95QTh/DlQw/j
         BN7Ly4xMneMJQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/3] iio:adc:ad7476: Fix, regulator support and binding doc.
Date:   Thu,  1 Apr 2021 18:17:56 +0100
Message-Id: <20210401171759.318140-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I was only actually aiming to add a missing binding document for this one,
but whilst testing it came across some other things that needed doing.

Jonathan Cameron (3):
  iio:adc:ad7476: Fix remove handling
  iio:adc:ad7476: Handle the different regulators used by various parts.
  dt-bindings:iio:adc:adi,ad7474: Add missing binding document

 .../bindings/iio/adc/adi,ad7476.yaml          | 139 ++++++++++++++++++
 drivers/iio/adc/ad7476.c                      |  99 +++++++++----
 2 files changed, 211 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml

-- 
2.31.1

