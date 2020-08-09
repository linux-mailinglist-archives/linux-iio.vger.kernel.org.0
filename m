Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2993023FDC9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHILUA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHILT7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:19:59 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EA02065D;
        Sun,  9 Aug 2020 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596971999;
        bh=qezfHXu7d4uZ1zFJ3qL4F+s7KmzK69YZvv4gZhRXFH0=;
        h=From:To:Cc:Subject:Date:From;
        b=ARlSaoqxJWSu33zkHWOJAXZUqdlH0M/qik7tElZnbNt00JH8aQwz9DABJP8hHeh8N
         uMOM+rio/zAcH6O7JCzjBNqPpJ6hKGGghJFIFC2CovPciPqK3JTRf4MGKzLXlvKTtr
         obC6mY90o5b+fOirkw72xrXsWlz05sL47gZCRzDE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/13] dt-bindings: yaml conversions of some simple ADC bindings.
Date:   Sun,  9 Aug 2020 12:17:40 +0100
Message-Id: <20200809111753.156236-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This set coverts over some of the low hanging fruit from amongst the IIO
ADC bindings.  Mostly they are very straight forward bindings.

One quirk is that I found I had one old binding doc in my local
checked out copy that never made it into mainline. I've created
a special patch for that so we don't lose the history.  It reflects
the tags from the original patch that I seem to have messed up applying.

I've added the #io-channel-cells property to  most of them, so that
additionalProperties: false works if they are used as providers
of channels to consumers.  For ADCs it is fairly likely they
will be providing measurement services to another device in DT.

I have put the Maintainer as the original author of the old bindings
/ driver. Hopefully everyone is fine with that. If not, let me know
and I'll put my own details in there as I'll end up reviewing pretty
much anything that touches these anyway.

All comments welcome.

Jonathan Cameron (12):
  dt-bindings: iio: adc: microchip,mcp3201 yaml conversion.
  dt-bindings: trivial-devices: Add mcp342x ADCs and drop separate
    binding doc.
  dt-bindings: iio: adc: ti,adc108s102 yaml conversion
  dt-bindings: iio: adc: lltc,ltc2497 yaml conversion.
  dt-bindings: iio: adc: ti,adc161s626 yaml conversion.
  dt-bindings: iio: adc: ti,adc0832 yaml conversion.
  dt-bindings: iio: adc: ti,adc084s021 yaml conversion
  dt-bindings: iio: adc: ti,adc12138 yaml conversion.
  dt-bindings: iio: adc: ti,adc128s052 yaml conversion.
  dt-bindings: iio: adc: ti,ads7950 binding conversion
  dt-bindings: iio: adc: ti,ads8344 yaml conversion
  dt-bindings: iio: adc: ti,tlc4541 binding conversion

Phil Reid (1):
  dt-bindings: iio: adc: tlc4541 - recover accidentally dropped binding
    doc

 .../bindings/iio/adc/lltc,ltc2497.yaml        | 44 +++++++++
 .../devicetree/bindings/iio/adc/ltc2497.txt   | 13 ---
 .../devicetree/bindings/iio/adc/mcp320x.txt   | 57 ------------
 .../devicetree/bindings/iio/adc/mcp3422.txt   | 19 ----
 .../bindings/iio/adc/microchip,mcp3201.yaml   | 93 +++++++++++++++++++
 .../bindings/iio/adc/ti,adc0832.yaml          | 56 +++++++++++
 .../bindings/iio/adc/ti,adc084s021.yaml       | 58 ++++++++++++
 .../bindings/iio/adc/ti,adc108s102.yaml       | 47 ++++++++++
 .../bindings/iio/adc/ti,adc12138.yaml         | 85 +++++++++++++++++
 .../bindings/iio/adc/ti,adc128s052.yaml       | 59 ++++++++++++
 .../bindings/iio/adc/ti,adc161s626.yaml       | 51 ++++++++++
 .../bindings/iio/adc/ti,ads7950.yaml          | 64 +++++++++++++
 .../bindings/iio/adc/ti,ads8344.yaml          | 51 ++++++++++
 .../bindings/iio/adc/ti,tlc4541.yaml          | 52 +++++++++++
 .../bindings/iio/adc/ti-adc0832.txt           | 19 ----
 .../bindings/iio/adc/ti-adc084s021.txt        | 19 ----
 .../bindings/iio/adc/ti-adc108s102.txt        | 18 ----
 .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
 .../bindings/iio/adc/ti-adc128s052.txt        | 25 -----
 .../bindings/iio/adc/ti-adc161s626.txt        | 18 ----
 .../bindings/iio/adc/ti-ads7950.txt           | 23 -----
 .../bindings/iio/adc/ti-ads8344.txt           | 19 ----
 .../devicetree/bindings/trivial-devices.yaml  | 16 ++++
 23 files changed, 676 insertions(+), 267 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ltc2497.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp320x.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3422.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt

-- 
2.28.0

