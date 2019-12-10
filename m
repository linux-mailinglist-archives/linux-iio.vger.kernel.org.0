Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF2118C09
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 16:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLJPI1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 10:08:27 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36515 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPI1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 10:08:27 -0500
Received: by mail-vs1-f66.google.com with SMTP id m5so13286817vsj.3;
        Tue, 10 Dec 2019 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CVsoTsLmHIMeYXGZBjzbdY2yQKqerlJG/7Je5TOkOsw=;
        b=iJ/ET51r4t0DwOuhqsfEPbrVzvff/H5jPgn1fxUNTuvG+VPPkYi/EqaVXwvh8Lr5Oy
         9u11kxOALIzWmZWJTFX2D4xIAiCAXmvmhO5DMqbzPqhSwz0WnSesjZMtUuC3EI98J6rZ
         rdRBfFYbhh/lKGyl5bUOw2D0uRnF0+ORx0nqRgNU5JyAC9xPCgFXklvT+FDPsdbk70XA
         3hl5FB/y1IkbDUv+sriKL3rHPa+netuEOBkiRRspUFkIDsvi5iF33yftOaER5JU0KNb6
         ncY0lM+Zahf05ZAoTxxpSqo6qY0bJlMkBFUMXh2fiUxsFsOLSLpzpzNE1vzYnP3liAO2
         l3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVsoTsLmHIMeYXGZBjzbdY2yQKqerlJG/7Je5TOkOsw=;
        b=g+vwpPrJ3IJyAeTs/3+/MAX2LyViw/gC24acZbPs31kcp88Rdz3/RpCiQ3yDwi7sO9
         kr491nns19PI1yNn6qWMwOo4VH4WQ8inurM18BInuyvLSOly7zOObJmYLwytOG6wV1Fq
         svM9EiNiCS7p2eilOUh1+bYwsllDhkpg7X8DeZJdwxk4WlIPRYmz1zQX69NmUWmp/+/5
         5oGj1L+ZjzWhoFDDiCgcGmUQ9gQTfgdkOaHJx7Up2kBxGKsLagELado0GHeb8F+gVMgQ
         dE7tAgI7bAdCQQdWlVc50bjSmuDGZNRdMCSvKyg5K/LLBEZua+7a1JfAspn8pUY9rKWn
         ES0A==
X-Gm-Message-State: APjAAAUYH/CDuw1UgRVxoZ6IPMWuDjbM+WNgSdQTrXqrkQGOuQN53+Yi
        xBvl7UBn3obsa1iUkGICnYpFu1IgzOWYsQ==
X-Google-Smtp-Source: APXvYqw54+YDUNQSEUf+75YUZhNpIQACsjv837pV81DzzUXJ6jCwGxTFe/WIpaaTbZ4xIBP2ph3hsw==
X-Received: by 2002:a67:80d3:: with SMTP id b202mr25100537vsd.142.1575990506285;
        Tue, 10 Dec 2019 07:08:26 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id k45sm1986139uae.9.2019.12.10.07.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:08:25 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2 3/4] iio: adc: ad7923: Add of_device_id table
Date:   Tue, 10 Dec 2019 12:08:10 -0300
Message-Id: <20191210150811.3429-4-djunho@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210150811.3429-1-djunho@gmail.com>
References: <20191210150811.3429-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Accomplish device tree compatibility to driver AD7923
by adding of_device_id table and making a subsequent call to
MODULE_DEVICE_TABLE.

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index e535cec9fc02..6d56fa0b9e30 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -348,9 +348,19 @@ static const struct spi_device_id ad7923_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad7923_id);
 
+static const struct of_device_id ad7923_of_match[] = {
+	{ .compatible = "adi,ad7904", },
+	{ .compatible = "adi,ad7914", },
+	{ .compatible = "adi,ad7923", },
+	{ .compatible = "adi,ad7924", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7923_of_match);
+
 static struct spi_driver ad7923_driver = {
 	.driver = {
 		.name	= "ad7923",
+		.of_match_table = ad7923_of_match,
 	},
 	.probe		= ad7923_probe,
 	.remove		= ad7923_remove,
-- 
2.24.0

