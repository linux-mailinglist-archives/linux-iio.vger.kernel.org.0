Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E64122E25
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfLQOKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 09:10:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfLQOKS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 09:10:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHE9wHn090167;
        Tue, 17 Dec 2019 08:09:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576591798;
        bh=+zSK3PAMPYp0FPu/i7ULX8Y3uMs+6Ix91i0wfKcwKWM=;
        h=From:To:CC:Subject:Date;
        b=Kd+9qADNY0fkKTLgqzNW0WxC6W4tFZuv+asl/e/1LEwYLKUUvfrwXEK7MvA/axQEF
         q4/mOy8i/TGrerJgLXlRg/ELq+4R9jm2mfx34WcHefBcYxkG/5L9QTuHPPtXLimLJX
         4qkXNKEvGSbeL+r1INLDmmi8MhhGAnsqH0k4c/QU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHE9wi4123748;
        Tue, 17 Dec 2019 08:09:58 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 08:09:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 08:09:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHE9vbC005793;
        Tue, 17 Dec 2019 08:09:57 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 0/2] Texas Instruments DAC8771
Date:   Tue, 17 Dec 2019 08:07:29 -0600
Message-ID: <20191217140731.30504-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello

Introduce the TI DAC8771.

The DAC8771 is a single channel, precision, fully integrated 16-bit digital to
analog converter (DAC) with adaptive power management, and is designed to
meet the requirements of industrial control applications.

Dan

Dan Murphy (2):
  dt-binding: iio: dac8771: Add TI DAC8771 binding
  iio: dac: Introduce the TI DAC8771 DAC driver

 .../bindings/iio/dac/ti,dac8771.yaml          |  89 ++++
 drivers/iio/dac/Kconfig                       |   7 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ti-dac8771.c                  | 499 ++++++++++++++++++
 4 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
 create mode 100644 drivers/iio/dac/ti-dac8771.c

-- 
2.23.0

