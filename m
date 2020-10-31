Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA52A1980
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgJaS0f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaS0e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:26:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D35206DB;
        Sat, 31 Oct 2020 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168794;
        bh=Q5P2VcDHe3OO53nD177T/297ZRpgdUbX5JupIBlS2Cc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ro3aCHZdbmx6YPm/kyxr/V4fXIDrOaa8k8A0+vOFljqWED54GfcUyXaSZ5ng4HyfV
         zjlqTUWeaHXtDpogjpQNIImh4FdN1i5E/b80826V3l0WaMfCQNJRakUhtVP5Ur44sP
         xJNwJ09Z606+U1DMWMc22j2JzMP2aN4l8HqK16+k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/3] dt-bindings:iio:adc: Convert generic ADC channel binding to yaml
Date:   Sat, 31 Oct 2020 18:24:20 +0000
Message-Id: <20201031182423.742798-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This channel binding is not yet that heavily used, though that will slowly
change now we have a standard binding.  There are more properties coming
for this binding in the near future.

This series converts the channel binding itself then leverages it to
reduce repitition and improve consistency in a couple of drivers.

One thing to note is that we have similar defintion for DACs but so
far there are no generic properties.

Jonathan Cameron (3):
  dt-bindings:iio:adc: convert adc.txt to yaml
  dt-bindings:iio:adc:adi,ad7124: Use the new adc.yaml channel binding
  dt-bindings:iio:adc:adi,ad7292: Use new adc.yaml binding for channels.

 .../devicetree/bindings/iio/adc/adc.txt       | 23 -----------
 .../devicetree/bindings/iio/adc/adc.yaml      | 38 +++++++++++++++++++
 .../bindings/iio/adc/adi,ad7124.yaml          | 14 +++----
 .../bindings/iio/adc/adi,ad7292.yaml          |  8 ++--
 4 files changed, 47 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.yaml

-- 
2.28.0

