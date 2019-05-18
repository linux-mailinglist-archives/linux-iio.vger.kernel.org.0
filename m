Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC662256D
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfERWlx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:41:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39222 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfERWlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:41:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id z128so6673831qkb.6
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjafOF3we2ISgKmws+AAmSPCOfvoMlLfEcLpwFAOH20=;
        b=hZ4gxLpg6e+HdwfQ1NXXRXfPKNh09IvaB2r/AWlEKTZFEOStyNY7rBeDbJe6CnaQ3Q
         UaR1WbRUT9HhSIT2GZshGU5CmTP46jiP/ZpxgKvNwwznxCDNWAys9BL+DXLLH7trevO+
         g5ahNdjbPGvFwrZ4cOxY7e+VsQy6uTF5ET2N/T1jZje7SH/dHL3NeYwuCXx6JIdHYsmd
         LKwC4D/zcDzCvNO3pD79ItH1bdGXVBwM2G1vAeL9p6ll8P7YWDSCd3yw+olCwj0BPVgN
         ym7wqa2PpNPaeyfuUijgm1dMLd/0su+PQenVezSJnZJ3IDkmWojRSFFjNmHr5r3pT/mJ
         f6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjafOF3we2ISgKmws+AAmSPCOfvoMlLfEcLpwFAOH20=;
        b=BpKa+q57w+1SvXDjJSmmG9mO9UrKrYTj2H+Xp6Yuxowna1GLFsklcbOqcK5+nzgj5K
         pJlJBRxf3DYrzOE6E5frRWIXYtKgdkcc/0HrNcw8Sj3RgHM6nu/4a1OE0x2BtavZ4OJ0
         HaSxMMq6xwKChBiVUYTATUaxTkVxMoDQb36D3L5dGnCD2/rPM45+2qt0Q6cz+ZHXLVrx
         AV+OTaApo6xnKp1CysW3eq8rIj/7g8EYv0sIbn+jzZeEXhcGwltVfITcexSrDvIpn7yf
         TI2lcs4soCaEZdoi8QCQ9PA/6Sjig1HjkkLXQyz0VNVk2A0mMQ4DvXTJ4JCFLxOxRDMw
         n12A==
X-Gm-Message-State: APjAAAVpvNbtr53lb+JbbOyEys0sEHMdHVEyeGDU4JPHDwM4KbluQ7X7
        ppDRb2gdCSeaVCLl+1d4sW2T1g==
X-Google-Smtp-Source: APXvYqws6NF4t7YOPS1d8LkVgLg7sYRMajLfSLBfYLOL1vQBd5nqSp7jevx1MMGLFOVwau3R4HRHnQ==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr50951745qkd.65.1558219312472;
        Sat, 18 May 2019 15:41:52 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d32sm7348992qtk.0.2019.05.18.15.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:41:52 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Melissa Wen <melissa.srw@gmail.com>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id array
Date:   Sat, 18 May 2019 19:41:35 -0300
Message-Id: <20190518224136.16942-2-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
In-Reply-To: <20190518224136.16942-1-barbara.fernandes@usp.br>
References: <20190518224136.16942-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create structure of type of_device_id in order to register all devices
the driver is able to manage.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Co-developed-by: Melissa Wen <melissa.srw@gmail.com>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/cdc/ad7150.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 4b1c90e1b0ea..072094227e1b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -655,11 +655,21 @@ static const struct i2c_device_id ad7150_id[] = {
 	{}
 };
 
+static const struct of_device_id ad7150_of_i2c_match[] = {
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad7150_of_i2c_match);
+
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",
+		.of_match_table = ad7150_of_i2c_match
 	},
 	.probe = ad7150_probe,
 	.id_table = ad7150_id,
-- 
2.22.0.rc0.1.g337bb99195.dirty

