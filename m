Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5911351993
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhDARyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236462AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13D9761155;
        Thu,  1 Apr 2021 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298985;
        bh=7F89OoO2DJFxgS3Bk3MUOem8HAJsy7MMXYXeybjFq3w=;
        h=From:To:Cc:Subject:Date:From;
        b=RfNLCIWsIZNqG/8Br7UmoGGXXGtFkiGPTgJfgQj0NoUD9w15CFMrQeRq7CVjMPOhr
         98E1dID4IQbq5T3Y8xgTQydJSQrELyDs3JmW6vkXtpLRaJdp5KwEJ2D+wQkP3yu5yo
         9uLPIz5q9nUxYg+D5FRoAxRw9ZBQAYcRrFh27AG3G+PyIGbK4rAPiiaFh3gaS6BtKs
         iBiqEXg4dWPHKQ4UlHx0Y0p6hTxZvwBcQSlZqiQPttVHSZurNPwCS5VaB++tBZEj/Z
         qxfzeU12ILHpqUhz1SNJRdB9SpnJ1GRCxns8Yg8prtJUBVhjauGZHgKvi+X0WqZ32n
         O5RNiD6x6lkgA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/6] dt-bindings: Add some missing IIO related binding docs.
Date:   Thu,  1 Apr 2021 18:41:06 +0100
Message-Id: <20210401174112.320497-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

First of what will probably be one of several sets to slowly but surely
add yaml binding docs for all the defacto bindings hiding in IIO
drivers.  Ultimate I'd like to clear the backlog of these and so go
forward with full documenation, but there may be some cases we just decide
are too complex to bother.  The fsl,mma955x parts are ignored (for now) on
that basis (I think we have all the other accelerometers covered now)

Some of these date back to board file days and some were added by people
only interested in ACPI, but all can be instantiated from dt-bindings.
A few may simply have slipped through the net during review.

Testing done with hacked up qemu when anything was non trivial.

Jonathan Cameron (6):
  dt-bindings:iio:accel:adis16201 and adis16209 bindings
  dt-bindings:iio:accel:bosch,bma220 device tree binding documentation
  dt-bindings:iio:accel:fsl,mma7455 binding doc
  dt-bindings:trivial-devices: Add memsic,mxc4005/mxc6255/mxc6655
    entries
  dt-bindings:trivial-devices: Add sensortek,stk8312 and
    sensortek,s8ba50
  dt-bindings:iio:adc:adi,ad7298 document bindings

 .../bindings/iio/accel/adi,adis16201.yaml     | 55 +++++++++++++
 .../bindings/iio/accel/bosch,bma220.yaml      | 50 +++++++++++
 .../bindings/iio/accel/fsl,mma7455.yaml       | 82 +++++++++++++++++++
 .../bindings/iio/adc/adi,ad7298.yaml          | 48 +++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 10 +++
 5 files changed, 245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml

-- 
2.31.1

