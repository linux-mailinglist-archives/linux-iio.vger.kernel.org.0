Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826AA22555
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfERWPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:15:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38958 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfERWPp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:15:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id z128so6656227qkb.6
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQnfKzjzaG+uZvRSHThCQoJsbxO/n61UBy9RgELTA98=;
        b=PAKVISkzwJ5T2He6DaDVTk62VAoDDmjsq4gRScVC9c6xB8c8oHFN6MMy/NS5xEIAsj
         2jtvRf/Zb2gsuZeXkmSWcko7r9zcgVJV8xA/gtafRw/a2d1zjpxQiZPAKGm01YbMa5hw
         7b+eEM67Z56GaIDemU1f1CZQO3+zcKAuj0Xy4CjI6POUNA0AcYV0jDeC3SL79o8QM2f2
         /CqPSp+0O8nK4xZscwD58mIvR8EPTG8J9WzW6ho27Da0UbEDX8oAy94zetH38s5g/QA3
         V4LYcOW7D0NP2gXniOPq9uDqcZZnMS2XgIfjsd2xDWnPK8kctViDPhmQ/q3zGeAc740W
         +C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQnfKzjzaG+uZvRSHThCQoJsbxO/n61UBy9RgELTA98=;
        b=rl8GUU3IqbSxmIIfn90kJv4EJC0IRElj7u9MDOs8V3ON2xaaiZGUW9B3kpGiPfd1cr
         XrGVLiI1FSiIj8Qh8u/14smCSl398I/QSetjCvmGl1y6/YmOtx31eXgqkDWT5SO81dNv
         y3apjbC0GEn1sUkeeLhCS4T+EVSOmSUqeZNABiyi4pCRNapQTU+66Gx6mp0zMyvWLJlr
         VMdP17CbSVImw3enl1CRiTx5r27gkqL3hUGi1j7cgE16YZFMdcA0g7iDkC3p9TGTtjeu
         mzr99yb9jdKHW0fJB61RjneyAfRi1OM5mkWr8wFxArw3OaTFOW1y6Eb02Kw6pt0Cg0Mf
         +frw==
X-Gm-Message-State: APjAAAWaAyGzKXmRpeK5x6kmO1z6PHiEgAyKE48B3PxjtqA3v3ezwkrv
        21Tals7QMaTuExqB/rWiN6/omLm3v6c=
X-Google-Smtp-Source: APXvYqxBkVhxgY/rgfa5p5eccTrAjRGD6+Szn4GI1H6Du8hcgi6IUavWG+vwlEajhjPzGxS5NJVM0Q==
X-Received: by 2002:ae9:f70d:: with SMTP id s13mr52473452qkg.213.1558217744110;
        Sat, 18 May 2019 15:15:44 -0700 (PDT)
Received: from tallys-pc.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s17sm7702970qke.60.2019.05.18.15.15.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 15:15:43 -0700 (PDT)
From:   Tallys Martins <tallysmartins@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.or, kernel-usp@googlegroups.com,
        Tallys Martins <tallysmartins@gmail.com>,
        Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Subject: [PATCH 1/2] staging: iio: ad2s1210: Destroy mutex at remove
Date:   Sat, 18 May 2019 19:15:57 -0300
Message-Id: <20190518221558.21799-1-tallysmartins@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ensure the mutex will be destroyed on drive removal.
Also adds mutex comment description.

Signed-off-by: Tallys Martins <tallysmartins@gmail.com>
Signed-off-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Co-developed-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index b6be0bc202f5..b91cf57c5e57 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -86,7 +86,7 @@ static const struct ad2s1210_gpio gpios[] = {
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
 struct ad2s1210_state {
-	struct mutex lock;
+	struct mutex lock; /* lock to protect the state on r/w operations */
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
 	unsigned int fclkin;
@@ -689,8 +689,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 static int ad2s1210_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad2s1210_state *ad2s1210_ad = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	mutex_destroy(&ad2s1210_ad->lock);
 
 	return 0;
 }
-- 
2.21.0

