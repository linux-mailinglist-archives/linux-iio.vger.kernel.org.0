Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC68C22574
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfERWnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:43:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44326 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfERWnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:43:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so12136234qtk.11
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eO6mO59GQBmOS/DlZnxdkxlS21xeFUZXbaBYNCMZMIU=;
        b=iMQQQuPNdWSowS10fp7KXUOV7QV+ye+/Y7mbyrwE1CNpcnTqZ93Szn0szcUOu6qGfS
         c31HNJcdPRoLO7kn3rIyHmb00NxIlheW/2It7nOouMH+HO5Munr8g9d8HAMwPDMkpCI4
         /uyZ6cZXCo81Ogh4QNWIbI+if76+zx8AECxsVAE+zWbx+ZVnco/swyc0EB4gSH8yWHR0
         9he7583KcqHFZwQCLCMn8iihXRLVY7S0o65DZV1DFw4/lVY9VNkZQ6xcH7lsoeg/Gyge
         wgCo8LoTTGhxNIz9R9T2eXXwP67UsVMA2ZdchQDMeInvBnRA2ZgL8r2GEZ9v4NRTF7AJ
         K9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eO6mO59GQBmOS/DlZnxdkxlS21xeFUZXbaBYNCMZMIU=;
        b=cgSlpaeQYI2lEXahhV4mWe5wiNetb4A5FxDfNLbINtE9IX2ho/8vCTJw5qdQ4DMoU/
         /5U2Tjsmif/8M60n2GUu0E5bZmh/8Lre5ZbzN3SpL75O2geruJI3xYrtSrdoslttaNmh
         OGWX1o9LOi+pqtWwbOAyQJv0gYK14Hlj4TwQ3kudFEn1VG+ihbyH5iESj/ebErJMAq9W
         XMgFHGT//kvylYzpeBIp6zBWahDvqYv3+bOgY2Bf2jEzqQIebdJxlGAeDeqdGsNXI0s/
         0JaDgkWETcccG4NwVWLxB3B/j2I58iZQTaTrgxcXrd9tA/RlsQNESEeu/SzSIx1regNy
         xOSg==
X-Gm-Message-State: APjAAAUxcnkVi83ljT65kAIyrv6Jh9HnJ+KE4xTjfFj5eMjVdZD49pj7
        mJjEhiWivg+WFDYO4VRWsVwLWw==
X-Google-Smtp-Source: APXvYqxuURr2hxU2QOxPsPBOesZOTga1YQIBXTqdf8EFG4ggK8/H7A4p9X0nZ2l1g7DLSX/yEpxirQ==
X-Received: by 2002:aed:2b44:: with SMTP id p62mr27078963qtd.308.1558219421796;
        Sat, 18 May 2019 15:43:41 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j62sm4834234qte.89.2019.05.18.15.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:43:41 -0700 (PDT)
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
        Wilson Sales <spoonm@spoonm.org>
Subject: [RESEND PATCH] staging: iio: adt7316: create of_device_id array
Date:   Sat, 18 May 2019 19:43:33 -0300
Message-Id: <20190518224333.18067-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
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
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/addac/adt7316-spi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 8294b9c1e3c2..9968775f1d23 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -127,9 +127,22 @@ static const struct spi_device_id adt7316_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
 
+static const struct of_device_id adt7316_of_spi_match[] = {
+	{ .compatible = "adi,adt7316" },
+	{ .compatible = "adi,adt7317" },
+	{ .compatible = "adi,adt7318" },
+	{ .compatible = "adi,adt7516" },
+	{ .compatible = "adi,adt7517" },
+	{ .compatible = "adi,adt7519" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, adt7316_of_spi_match);
+
 static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
+		.of_match_table = adt7316_of_spi_match,
 		.pm = ADT7316_PM_OPS,
 	},
 	.probe = adt7316_spi_probe,
-- 
2.22.0.rc0.1.g337bb99195.dirty

