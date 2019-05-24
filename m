Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5328F9A
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 05:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfEXDaU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 23:30:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45506 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbfEXDaU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 23:30:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so5279363qkk.12;
        Thu, 23 May 2019 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5ogzMgSI1LHQZbh7k+OtVLJIYf80nqxH6S28QxnxWE=;
        b=B3yVbgyNYA/vqcsMtVi6rCVf7YrUe3la1OWaMr3caaHP/s2qBHu/9nCYBY/ra2LpHM
         LlE1CYwJdUGoKwENlpkVVs8B0l0BqgRcsuyMiHyQ6u52OBvDgGW1Ewf85jS69X2aSk4d
         PgfgeLwcLHZK+qfmKCC4saI3LTvs536L5I/ab8Z9fXlKVaEIu/oTnfs0+dNzixcW6Frl
         WBB9ZNK0AXpXcC7OfezcJwE3HIV2QIp+6t5QJ1uuQpimITmnOG0FaQwFYhWGi9BG8/84
         Aj7l9ITD3j34yMct9E6TTZ53Ru/318YKZeommAPFu2dxx7XDaRHFNKtX17uixfdqVM96
         cXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5ogzMgSI1LHQZbh7k+OtVLJIYf80nqxH6S28QxnxWE=;
        b=l5ipUDas6CJtHlwihgRsyjOOmJ256BHrxY1wCLZd5azf8qFsvdE7462fjarUk/GVwu
         cHbaZGoHhoMC0043AMWQxmKTM9+8GCAQR7UG3UTHNf7RPzn1hvzvJic+Sek8VxtUR6az
         fuyO85Zfq2X5PJu1RlxOMWQgB8v/E+Wa6NiQu3PtWn/VJU0I4ZGjfde+ZOX9mwkoqbFD
         m57qZHvb9B+coVwh+KLHCF+kBtNp0b/24AuCrpYvwX3Jx4BYOKwm+yzKqYcIkiM9GCVb
         Lv0f5JpVxTHcBLZNeGbhDJx+8wt+br5x4Ygbn24em1m34wdDSrdVa7VXCDEWEXulbqPt
         VCBg==
X-Gm-Message-State: APjAAAWufHadA+ut0mxfrhKLMJ4oxgp1Yl5pZfll1VuRHw90twwa1ioH
        ZPedBVNbFg7x/xFrPSPwMzE6CkvpY4Q=
X-Google-Smtp-Source: APXvYqygk6InWh8SXVRBn3HCF6Sqkafkvf4vOGQEaLwb6cuV+q9UmUxtlOHy2sBKoGs5ARkFn1fJrw==
X-Received: by 2002:a0c:af51:: with SMTP id j17mr58005662qvc.34.1558668619835;
        Thu, 23 May 2019 20:30:19 -0700 (PDT)
Received: from localhost.localdomain ([179.113.74.110])
        by smtp.gmail.com with ESMTPSA id n190sm623956qkb.83.2019.05.23.20.30.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 20:30:19 -0700 (PDT)
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH] staging: iio: adis16240: add of_match_table entry
Date:   Fri, 24 May 2019 00:29:50 -0300
Message-Id: <20190524032950.2398-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds of_match_table entry in device driver in order to
enable spi fallback probing.

Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 8c6d23604eca..b80c8529784b 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -444,6 +444,7 @@ MODULE_DEVICE_TABLE(of, adis16240_of_match);
 static struct spi_driver adis16240_driver = {
 	.driver = {
 		.name = "adis16240",
+		.of_match_table = adis16240_of_match,
 	},
 	.probe = adis16240_probe,
 	.remove = adis16240_remove,
-- 
2.20.1

