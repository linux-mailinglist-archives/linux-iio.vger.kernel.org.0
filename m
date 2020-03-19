Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5736918BC5D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 17:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgCSQZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 12:25:12 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:51126 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgCSQZM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 12:25:12 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584635110;
        bh=kIJxpqwN6hPpaUz/oGTllpFArQPEmz6QRaxKY+QHDNs=;
        h=From:To:Cc:Subject:Date:From;
        b=NO1DqAjIpZ3fL1KOk7HY7iS5ClUORAmocz1vF6ox54/TFLa/Iocnh+2Azn53robuU
         MZuYeZUbjLj6CEPxtbGodNbKggA+baTv3tBdBHXUDSxKJ5utKJb/kZxGbQOrhcDhwG
         g6pulHF9Zrf5uP43x03b2jeD3Me+OTwXk2V3Ldx5pVvvuRo+LtPG1ZPzsjstPBedfj
         eNfG3re3llhx5XRS45LQUSdvzRDzYBOw4fCz+q+X5TbxBEh254xVyaJmdfOL5h/W1s
         2w9z7SJsld68LIe+YUQTUzjX+cRwIQhehoTygEwBYwWHdqEsDKzRqa6YKQiGmBc5j1
         /tQFaFyXiXiPg==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v3 0/2] Maxim MAX1241 driver
Date:   Thu, 19 Mar 2020 18:29:35 +0200
Message-Id: <20200319162937.34664-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A silly typo found its way into the previous version of this patch
series. Fortunately, Alexandru Ardelean spotted it. I'm a little
embarrassed to show my face in public right now -- thankfully I'm
staying home these days anyway.

Other than the Kconfig text (which claimed this module was named max1118
-- like I said, I wear my code monkey badge with pride...) nothing's
changed since the last version. For reference, the last version is here:

https://lore.kernel.org/linux-iio/20200318202837.512428-1-alazar@startmail.com/

Thanks!

Alex

Alexandru Lazar (2):
  iio: adc: Add MAX1241 driver
  dt-bindings: iio: adc: Add MAX1241 device tree bindings in
    documentation

 .../bindings/iio/adc/maxim,max1241.yaml       |  62 ++++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 206 ++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.25.2

