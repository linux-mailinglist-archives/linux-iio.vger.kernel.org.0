Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E658636A244
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhDXRFu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 13:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhDXRFt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 13:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2631D6124B;
        Sat, 24 Apr 2021 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619283911;
        bh=UblpVSGQK7iq3xv74TMbCNRLMpXO8q4ChN4j1sq/M1A=;
        h=From:To:Cc:Subject:Date:From;
        b=dpz1bmUPigjwESV+Rrqb4xob6ffM4v3pxRCBr9pQR/woCLgX2RovIlfycnoYEQ4RK
         XFALS5+x7YsNuprE6r2Y1otUi5dksBGSZzVdths1SdkxMSl/in/ygRw15ZEnQC2gaN
         BoHlizaA/2CcKF1G5WmfLB/mPbt0rFaIB3ZH46Qpgx5DWOyjsObPHpKLlfQItoi5Q2
         3WqDmpbfkXJWFUTMb0i5WkrY5olosp1jU/xuLXY6mpU+VWGtf6wyQ48mSOULSWyqmj
         Xn7KDY3CpYx2tLabNyx+o2goBc1JcxMh+W4YNPe5aFH1+64WvWDwno3ZX6LHqpaPqp
         Dx0/b4HN1vEHg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 0/2] iio:adc:ad7476: Regulator support and binding doc
Date:   Sat, 24 Apr 2021 18:03:44 +0100
Message-Id: <20210424170346.526242-1-jic23@kernel.org>
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

v3 incorporates Lars' suggestion to set the regulator pointer to null
as a way to indicate that we should definitely use the internal reference.

Jonathan Cameron (2):
  iio:adc:ad7476: Handle the different regulators used by various parts.
  dt-bindings:iio:adc:adi,ad7474: Add missing binding document

 .../bindings/iio/adc/adi,ad7476.yaml          | 174 ++++++++++++++++++
 drivers/iio/adc/ad7476.c                      | 116 ++++++++++--
 2 files changed, 275 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml

-- 
2.31.1

