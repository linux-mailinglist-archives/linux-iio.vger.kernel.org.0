Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02BF2A1998
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgJaSbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:31 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9104E206E5;
        Sat, 31 Oct 2020 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169090;
        bh=OUl6SIEfSLy9lHD097fI3p3cgUVlBQeW0h4O6cl1ETc=;
        h=From:To:Cc:Subject:Date:From;
        b=fxJp/UKQt+lEL82eDCVfXfb9K4vS8qhLKsdKEQM3vFhkSUiGF9QAyHHRzBREOJFt6
         PGT/yV3bUG4RTITIcO9/TJTPCE9UT/95bLZRmOMK0cGT1N8ybr/bFALneqwkxxCG5V
         QJrCeKp2WDBSNn0n3L5qat6bqP6L85HgIGeHjGYM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/7] dt-bindings:iio: Move to trivial-devices.yaml from txt files.
Date:   Sat, 31 Oct 2020 18:29:15 +0000
Message-Id: <20201031182922.743153-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Rather than convert this group of bindings to yaml, let us just add
them to trivial-devices.yaml.

It is more than possible that we may need to give some of these their own
files at somepoint in the future (for example due to additional of
channel provider bindings for the potentiometers) but for now there seems
to be little advantage to keeping them separate.

Jonathan Cameron (7):
  dt-bindings:iio:chemical:sensirion,sgp30: Move to
    trivial-bindings.yaml
  dt-bindings:iio:chemical:bosch,bme180: Move to trivial devices
  dt-bindings:iio:potentiometer:maxim,ds1803 move to trivial devices.
  dt-bindings:iio:potentiometer:maxim,max5481 move to trivial devices
  dt-bindings:iio:light:renesas,isl29501: Move to trivial devices.
  dt-bindings:iio:magnetometer:memsic,mmc35240: move to
    trivial-devices.yaml
  dt-bindings:iio:accel:domintech,dmard06: Move to trivial-devices.yaml

 .../devicetree/bindings/iio/accel/dmard06.txt | 19 ------------
 .../bindings/iio/chemical/bme680.txt          | 11 -------
 .../bindings/iio/chemical/sensirion,sgp30.txt | 15 ----------
 .../bindings/iio/light/renesas,isl29501.txt   | 13 --------
 .../bindings/iio/magnetometer/mmc35240.txt    | 13 --------
 .../bindings/iio/potentiometer/ds1803.txt     | 21 -------------
 .../bindings/iio/potentiometer/max5481.txt    | 23 --------------
 .../devicetree/bindings/trivial-devices.yaml  | 30 +++++++++++++++++++
 8 files changed, 30 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt

-- 
2.28.0

