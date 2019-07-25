Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279AF758A4
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfGYUHO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 16:07:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33498 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGYUHM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jul 2019 16:07:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so46114631qtt.0;
        Thu, 25 Jul 2019 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUKV8WRNFyPUgh72J2ygKbXLGmL3yg1CtOIEnQ3ys8Q=;
        b=dQPZ9xr5JDDOjCF7rG8SZMnCbkMeZmnwNjiXYICC0ydBM86Vn5XGqOtYYCso904WEN
         rkO5Kdpek6TREvb1CUOFZ2xlofa3+1Dz/mXtCmwlJa9KxE/+tGsoBS+cEYvaeieZ0ads
         h2BxtBG3aKG/X0e5VCq5/QHGzKvn+MxRUkgdx/K110yQNIo4xVqFVdzxN3oeBzSAQlsa
         6ghaFVqSbThPwZ7n8t0iZ7XEmpORWy48ZIqewk/8vY1xZOfsmuwGe0wiJM4uQ3uxttgl
         NXPqQyjohfu4R4oo0q3rfiiTGLiimANHKOZDWgONTvM8UJVF05urU9S4VzISttcA2h9z
         J36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUKV8WRNFyPUgh72J2ygKbXLGmL3yg1CtOIEnQ3ys8Q=;
        b=a/dhKAqdG07UkXPX3qSzySPqncl6Uhp2NOJuVpsF1gZp2ggZKrRPUJI599fxLqzo0m
         mMXXF1dg52HoM5I3hlOKkWGlnSeuuL7BExvq7CKW0XFnbMNEJZuyRLxQu8CDSa+zV0Jp
         O6ogCPWnY6MXg9BAu+qgxYGiVcY0Gse2jrOVbRv+K6gtxcW5d2MAjEDpKAs1hRChoG+j
         cN2On5lBQXY/6NSasdnKzgkIcNkd7BzJsJU3xLE1iciRrbqfoWIdqpNdshCZgQSnT+lV
         rpUMZULnabKEcvvA577oumtq8YTd4TaqbDURzddJ2905lIYWrlMnWUFNxU9KpxePqSSg
         srvQ==
X-Gm-Message-State: APjAAAVeiCgpLLe1rVbyCLdqdwPkruROd0A6oA6NDIYSSquMlCLxay3M
        ph0iOl3XyPiLxTMJ+YY3mKY=
X-Google-Smtp-Source: APXvYqzTAnhUIkULBN0XJBcTBc0KkqTq7wvnRGk68Q1Vi1EEcYmBr1jGdDzUfom5Ei+A5SLsCSLrBQ==
X-Received: by 2002:a0c:d7cc:: with SMTP id g12mr31578289qvj.220.1564085231696;
        Thu, 25 Jul 2019 13:07:11 -0700 (PDT)
Received: from karz-laptop.vlan96.localdomain ([200.17.97.58])
        by smtp.gmail.com with ESMTPSA id g10sm21709514qkk.91.2019.07.25.13.07.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 13:07:11 -0700 (PDT)
From:   Kartik Kulkarni <kartik.koolks@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Kartik Kulkarni <kartik.koolks@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: [PATCH] staging:iio:adc:ad7280a: add of_match_table entry
Date:   Fri, 26 Jul 2019 01:36:49 +0530
Message-Id: <20190725200649.30592-1-kartik.koolks@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the of_device_id struct and the respective
of_match_device entry to complete device tree support.

Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>
Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/adc/ad7280a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 2d9c7551f314..ded0ba093a28 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -1027,9 +1027,16 @@ static const struct spi_device_id ad7280_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad7280_id);
 
+static const struct of_device_id ad7280_of_match[] = {
+	{ .compatible = "adi,ad7280a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7280_of_match);
+
 static struct spi_driver ad7280_driver = {
 	.driver = {
 		.name	= "ad7280a",
+		.of_match_table = ad7280_of_match,
 	},
 	.probe		= ad7280_probe,
 	.id_table	= ad7280_id,
-- 
2.20.1

