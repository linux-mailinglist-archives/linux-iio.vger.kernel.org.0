Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA13754C3
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 15:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhEFNcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhEFNcr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 09:32:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07EC061574;
        Thu,  6 May 2021 06:31:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso4876014oti.2;
        Thu, 06 May 2021 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8vTm6LFqOcXYbhWLI03aqqmDAB5t4QuyZ3aOZMng/o=;
        b=MlWTQgLoMleT38daPfFFasX49qETqxKEwfRtaZstPxvxqrskQRJVkM/PfcoUm52soD
         uCXubnJ/Wh/5ccf5+zoZLz2bJrOXq3mQssl2YehCnUngAdqFz0movjpJuT1pPUyzlGSj
         gXK6NhtU55kGlsFAoUlEWOR67KClU0XXkoFz029RTk4IUw5GM7EXeL7bc6cvtAgxK1Uz
         NS4K4+enBwRzXtHr3BTDERDzs5JfYN08MYGhKUuNyLCqnXA2C2ftZrO1rysZEeJ7u6+h
         JwGu6If0iEeh7cI9hynMqfkGm6vcte/u3VlouILBjsi1RPqotYB5vtCl8GcrIGd+d0Gn
         MRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=P8vTm6LFqOcXYbhWLI03aqqmDAB5t4QuyZ3aOZMng/o=;
        b=d0RjTpcwFpNAKilV0o17Y9g33vpG3ZRml78qi2GGKRL3SomCFxbcN0LyjJNSWrLbYb
         hmBjvbTBTaS+6DMokA69SyA/znqI5Ourc38JqeGFW0NJ04ur9L8WQkBXSMBJ/xwajd2R
         H5fzyKixBft4Xd8gpxRPg7UBtgsNAjAifG5f6Su2smDpYxmX3Bw2B5TMdVYj7ecvHFJF
         o+fNyYoL4HnxSSjpfp8eWKXvAL0QTyZvXtVeKmERHgAfDWdBH2qnQTLYcJOVDjIm/5d5
         YvWx+aF/zaSlbBZ2KxGCNCCy1xbTrlKNPcCZIX+qNscpDkj9W1noWxjaSmTTOcrtNNAp
         wt4w==
X-Gm-Message-State: AOAM533637T4B40FbWIMdlAoUwbmUqQrLfmjimr4z6CMG3WDF7RJloPS
        EYCtQXU9YWsZcfUgKnQ8f/c+zDKnJSc=
X-Google-Smtp-Source: ABdhPJxAmftdjBKI8QMXjEz6LkVd3q9l9N0DMepklvWPnSdSfSu/udWSsKtkxcxKEMtDPHG+IrwzCA==
X-Received: by 2002:a9d:4115:: with SMTP id o21mr3588897ote.52.1620307909043;
        Thu, 06 May 2021 06:31:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65sm558061otj.17.2021.05.06.06.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:31:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio: bme680_spi: Remove ACPI support
Date:   Thu,  6 May 2021 06:31:45 -0700
Message-Id: <20210506133145.2266604-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BME0680 is not an official ACPI ID, so let's remove it before someone
starts using it.

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/chemical/bme680_spi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index 6f56ad48cc40..cc579a7ac5ce 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
  */
-#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
@@ -145,12 +144,6 @@ static const struct spi_device_id bme680_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, bme680_spi_id);
 
-static const struct acpi_device_id bme680_acpi_match[] = {
-	{"BME0680", 0},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
-
 static const struct of_device_id bme680_of_spi_match[] = {
 	{ .compatible = "bosch,bme680", },
 	{},
@@ -160,7 +153,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
 static struct spi_driver bme680_spi_driver = {
 	.driver = {
 		.name			= "bme680_spi",
-		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
 		.of_match_table		= bme680_of_spi_match,
 	},
 	.probe = bme680_spi_probe,
-- 
2.25.1

