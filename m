Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC25E997
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2019 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfD2R7p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Apr 2019 13:59:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45926 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2R7p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Apr 2019 13:59:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id d5so6471817qko.12;
        Mon, 29 Apr 2019 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=yL+SmVseEfdaIJChh77smjXMJCyTOeRPG4sdYAGm78c=;
        b=S8Wpy22pQ6+hHsvpX2spQhaJkQhcdRhV1lH5EphIHaicUTdZPYoN+iogQNM0dyiXFD
         8oh0bD1NbBysGrV6tXX47TnTl0LQ/OQGgnNdWhWgVEt3W5rYcDR0+JeWI3aPxahnumrX
         VLeYIY0L9YsEKF8XT28Igf9rH27Wcs/AtZyES9YYsu2NR28HCKJuogcp9Pz1CgMLDPL8
         a3O+37wpF5W1NfRNwLn1Syjw39rnQ7K2bzoTcF+W5OJJxVdiLHVejUrL0LX6bBwz5rw7
         6UAjZNwhMmK2E/h7CJre3B+89hXFtXGNhp21E6gTXQ4+Es9VBO0/vmFlDjmJfeLPUKyg
         Drkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=yL+SmVseEfdaIJChh77smjXMJCyTOeRPG4sdYAGm78c=;
        b=PlEMOP987grOglqHkKUgX43bLN2u2fenOxPswVGA08YUvoz6xBRir5YQ3kCP5l5/Mt
         0v59wPCdhFgqXtrkMd78MScY4/5SVyf/f9hEBkvcyo67SIxGbUwqyoyCrsNkUwDkjaE4
         2fePv6CUlDJ9BTT0RTZeaXJ8iYA2vKqqMY8cMOvFVijVChH6rSgpOzNTgoQDD/PDiKtf
         ks5VEYsbNVv/uTkJw3NXRunR1raWVwW8UuyX9GNUAuwz5tsfXiVcDw9YDOsft4VjwXHN
         4VMjbNBBW/xs4gZdYvPq7vTL2p+hO+93srmxHxJi7c6w9NkEYYAn2mSOwOoosDxRvBoV
         p1hA==
X-Gm-Message-State: APjAAAWeG6mELZ2GSW9zZb+vfQNMX/TYui7khQyAK1AqQEWX97HnvkV0
        VX2WvGErwL0P/uzv4xLxbJo=
X-Google-Smtp-Source: APXvYqwqAQNE+Ut09opIpLJIGSCDS7bx5geJX+Lthjy6net0ioLipxgWRdOsP0mj9ccj7uDDu0D9ug==
X-Received: by 2002:ae9:c20b:: with SMTP id j11mr45839310qkg.357.1556560784513;
        Mon, 29 Apr 2019 10:59:44 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y18sm7542950qkf.7.2019.04.29.10.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:59:44 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:59:40 -0300
From:   =?utf-8?B?Sm/Do28=?= Seckler <joaoseckler@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: adt7316: match parenthesis alignment
Message-ID: <20190429175939.2jvt4qwrtbmpvhl6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch solves the following checkpatch.pl message:
CHECK: Alignment should match open parenthesis.
This makes the file more compliant with the preferred coding style for
the Linux kernel.

Signed-off-by: João Seckler <joaoseckler@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index b6a65ee8d558..37ce563cb0e1 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2154,7 +2154,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		chip->dac_bits = 8;
 
 	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac",
-						GPIOD_OUT_LOW);
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(chip->ldac_pin)) {
 		ret = PTR_ERR(chip->ldac_pin);
 		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);
-- 
2.11.0

