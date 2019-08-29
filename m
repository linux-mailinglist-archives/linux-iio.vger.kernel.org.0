Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328E8A10D1
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 07:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfH2F3s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 01:29:48 -0400
Received: from dd5802.kasserver.com ([85.13.130.187]:43223 "EHLO
        dd5802.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfH2F3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 01:29:48 -0400
Received: from smtp.tau-tec.tu (unknown [46.237.195.240])
        by dd5802.kasserver.com (Postfix) with ESMTPSA id 5A69A36822BE;
        Thu, 29 Aug 2019 07:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tau-tec.de;
        s=kas201903211716; t=1567056585;
        bh=nk5asZgV2a6BjRjRqA3Ts8DDfh3O5Trt18E05wfl+nQ=;
        h=To:From:Subject:Cc:Date:From;
        b=pjdVjCFeJzbJhoF1qGmLwzSdjWXcFSkiLBz30cC79/2Z17vKOQsR0ioVGlIRjQrUI
         JjBk5cUOqicy+xUNqpiAprD69M+bITXLT7U7AZ3jyFd60ubH/jJwU1z1PdxTnWFYAa
         kB209dtZ9sYVmdOal/S2YCgjX+cgCJmuTpEJjFmobMVJcDKo7vHyTcEp5yIsq82AhI
         xMNsHwxts9qVyZG9cBy4L3VMi5wEKif8Cx8oh0uQQSke24IU1yeCfUd38b3gGa2eN8
         U7DF6l2h4+Le9tRNFWUbCS6VGLF3qp9sf29AigOndHcvyDSKhr+ed7OOKZsKyFWVWE
         xSBAbRF6QyouA==
Received: from localhost (localhost [127.0.0.1])
        by smtp.tau-tec.tu (Postfix) with ESMTP id 719BE44E44;
        Thu, 29 Aug 2019 07:29:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at tau-tec.de
Received: from smtp.tau-tec.tu ([127.0.0.1])
        by localhost (clearos.tau-tec.tu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zlNZSttKlfTu; Thu, 29 Aug 2019 07:29:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by smtp.tau-tec.tu (Postfix) with ESMTP id 9FA1D45F8B;
        Thu, 29 Aug 2019 07:29:42 +0200 (CEST)
Received: from [10.20.254.205] (dyn-ip-205.tau-tec.tu [10.20.254.205])
        by smtp.tau-tec.tu (Postfix) with ESMTPSA id 8964044E44;
        Thu, 29 Aug 2019 07:29:42 +0200 (CEST)
To:     Jonathan Cameron <jic23@kernel.org>
From:   Pascal Bouwmann <bouwmann@tau-tec.de>
Subject: [PATCH v1 1/1] iio: fix center temperature of bmc150-accel-core
Organization: =?UTF-8?Q?tau-tec_GmbH=2c_T=c3=bcbingen=2c_Germany?=
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Message-ID: <bcb0af95-94d4-eb15-0918-8d35b376da8e@tau-tec.de>
Date:   Thu, 29 Aug 2019 07:29:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The center temperature of the supported devices stored in the constant
BMC150_ACCEL_TEMP_CENTER_VAL is not 24 degrees but 23 degrees.

Signed-off-by: Pascal Bouwmann <bouwmann@tau-tec.de>
---
In the datasheet of the BMC150 device the center temperature is given
wrongly.
See https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/
center-temperature-of-bmc150-device/td-p/9328

diff --git a/drivers/iio/accel/bmc150-accel-core.c 
b/drivers/iio/accel/bmc150-accel-core.c
index 807299dd45eb..7e86a5b7ec4e 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -125,7 +125,7 @@
  #define BMC150_ACCEL_SLEEP_1_SEC        0x0F

  #define BMC150_ACCEL_REG_TEMP            0x08
-#define BMC150_ACCEL_TEMP_CENTER_VAL        24
+#define BMC150_ACCEL_TEMP_CENTER_VAL        23

  #define BMC150_ACCEL_AXIS_TO_REG(axis)    (BMC150_ACCEL_REG_XOUT_L + 
(axis * 2))
  #define BMC150_AUTO_SUSPEND_DELAY_MS        2000

-- 
Mit freundlichen Grüßen / Best regards

Pascal Bouwmann

+------------------------------------------------------------+
|tau-tec GmbH                Managing Director: Michael Ruder|
|                           HRB 722286, Amtsgericht Stuttgart|
+------------------------------------------------------------+
|Hintere Grabenstr. 30           Phone:     +49 7071 70841-0 |
|D-72070 Tübingen                Fax:       +49 7071 70841-11|
|Germany                         Mobile:      +49 179 1206915|
+------------------------------------------------------------+
|Email: bouwmann@tau-tec.de      WWW:   http://www.tau-tec.de|
+------------------------------------------------------------+

