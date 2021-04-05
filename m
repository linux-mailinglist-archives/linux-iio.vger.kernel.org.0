Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16705354517
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhDEQZ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 12:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233795AbhDEQZ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 12:25:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B606139E;
        Mon,  5 Apr 2021 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617639921;
        bh=2aCwyu52RhdR4sivmHIsrUDf/dYEyegTzRw/4e6AG28=;
        h=From:To:Cc:Subject:Date:From;
        b=MMb2aiBtp8D0zOOaYvb0X1hl9dvplBf9DLSk868ZPU8i3SYw6b+Yai+2V93qQXQ+n
         Yrx3sSBxDbMZki/Sg38T96qQC1Pn6nbDJk2zZkFl1vhkPN0jKxdNtgjBzb9PlQnXZO
         1Lnqfu/PSSMfKR22srPcHVoU68i7JqdkqP21abE4TStfh5O5nu9CWq+C5eRpBhVG5y
         eG+b2Qk64LI2IdyCCBIdPhU9nPQsWK75N1FDn2lVk5FvFFBK4TnUPn9CJhFVmXP2Ov
         OfxnJW/7KunAScIAU3mNxgK/1ZIfeUF/bDhfGaPFi87KkGh3jt5+nXe7wVDhSyPpe9
         P7vqrJOMAG1kQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/2] iio:adc:ad7476: Regulator support and binding doc
Date:   Mon,  5 Apr 2021 17:23:23 +0100
Message-Id: <20210405162325.627977-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver supports a whole load of devices with a range of different
power supply connections.

Lars-Peter Clausen pointed out v1 did not handle the the ad7091r which
an internal voltage reference, but that can be over-driven on the vref_in /
vref_out pin.  The v2 handles that device properly.  I also realized that
I'd the binding was more restrictive for devices with internal references
than it needed to be (required vcc-supply) so I've relaxed that in
the updated bindings.  Also reorganized the big allOf block in the
binding doc to put all the constraints on reference voltage first.

Given substantial changes in patch 1, I dropped Lars' Reviewed-by.

Jonathan Cameron (2):
  iio:adc:ad7476: Handle the different regulators used by various parts.
  dt-bindings:iio:adc:adi,ad7474: Add missing binding document

 .../bindings/iio/adc/adi,ad7476.yaml          | 173 ++++++++++++++++++
 drivers/iio/adc/ad7476.c                      | 108 +++++++++--
 2 files changed, 266 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml

-- 
2.31.1

