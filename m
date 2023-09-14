Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D17A0111
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbjINKBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbjINKBO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 06:01:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64BC173C
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 03:01:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c7912416bso655399f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694685668; x=1695290468; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xl4ov4X3TOtQYaZtyT/v6ehzL6BXHeKcNhQz282WLLo=;
        b=I4bHO1FO/L+XISJ08DW9t4/WUO0zaBhuvnhTS1ffxVPPv/Nb84AYaAeM/2rT/ftjDU
         jfXfEnPgQ6At8W4942DvP0gpF7kbNSqUzDmWORMWZJOnYUy95Fzt3CvB1Sn2Dr990WF7
         W67rXiFwlmauKJDXP3GOGH9X9fTnvqVMAHDEbP6g5T/S+GzGtUooj4ryAyEKwpU5sq/p
         HZ8q84lZzEzJl1O0QkhixNAookvKCOMAtOnUHLMLQMtEROyhGd8CiUuTJUd8eFMn5ObG
         Nj6D/c9vD1CPmC9jacvMbIL8RcWKKx9H1bD8gCMkOg8hJKgtdDNKbPGphLItnWhc2RWl
         6Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685668; x=1695290468;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl4ov4X3TOtQYaZtyT/v6ehzL6BXHeKcNhQz282WLLo=;
        b=pW4E6xhWH4zuwwXtuzCc+oQO6mluOYnQvkiE2tifil7aIsOUEQ3/rZJNpau8/C7XDN
         jbsRwbyPHCKm4KGlfh7iegZKAOSKvFi0CYgHGxD8128tdrW2prULuSmhDLrVqGfNJC3/
         JzOm+tJRu4ffQe+bGUOoXJPurK4lmXIzWHSuK2fv5Hsre2REves40/EvxBO7WxKiUzh/
         tVAwFfHk2WHv0XspaeG+l1XGOl4aDNpnjEFcJdtTWYNAf7ixuGa1bMQ39Pr+JvoZLrq0
         lANu1GxYOa91NQiwkpkdkuWBFHXR/i4i8skM6CYKp3Ex/4Tt0tnplYT/1/iGCwgZxit/
         9qkA==
X-Gm-Message-State: AOJu0YxfcaSfcc+xR/yGgfukjvdCs2ft6dD0rC8w/FaHPg1gNcEXayay
        EkicZfDEUJ5yjQzJk0Hq2M16uQ==
X-Google-Smtp-Source: AGHT+IHbLz3Ugp4m4jAQiPKhFuCOW9cT+6w9HWNJfyWS7eN2D4nXhVulHVDTtocs2QKqEmSd6y9C+w==
X-Received: by 2002:a5d:4f88:0:b0:319:83e4:bbbf with SMTP id d8-20020a5d4f88000000b0031983e4bbbfmr4232819wru.20.1694685668070;
        Thu, 14 Sep 2023 03:01:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b0031ae2a7adb5sm1302452wrx.85.2023.09.14.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 03:01:06 -0700 (PDT)
Date:   Thu, 14 Sep 2023 13:01:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     marius.cristea@microchip.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: adding support for MCP3564 ADC
Message-ID: <5ba16a5c-71aa-4dc1-8be6-320750d10b73@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Marius Cristea,

The patch 33ec3e5fc1ea: "iio: adc: adding support for MCP3564 ADC"
from Aug 29, 2023 (linux-next), leads to the following Smatch static
checker warning:

	drivers/iio/adc/mcp3564.c:1426 mcp3564_probe()
	warn: address of NULL pointer 'indio_dev'

drivers/iio/adc/mcp3564.c
    1418 static int mcp3564_probe(struct spi_device *spi)
    1419 {
    1420         int ret;
    1421         struct iio_dev *indio_dev;
    1422         struct mcp3564_state *adc;
    1423 
    1424         indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
    1425         if (!indio_dev) {
--> 1426                 dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
                                       ^^^^^^^^^^^^^^^
This will crash and PTR_ERR(NULL) is useless.  Please could we just
delete this printk?  devm_iio_device_alloc() is going to print its own
error message.  (It doesn't print on every error path.  Like if we pass
something stupid instead of sizeof(*adc) then that looks like it might
not have a warning, but it's going to print a warning for everthing in
real life).

    1427                               "Can't allocate iio device\n");
    1428                 return -ENOMEM;
    1429         }
    1430 
    1431         adc = iio_priv(indio_dev);
    1432         adc->spi = spi;
    1433 

regards,
dan carpenter
