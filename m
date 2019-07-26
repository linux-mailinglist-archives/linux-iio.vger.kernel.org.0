Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66004767B2
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfGZNjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 09:39:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39653 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGZNjX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 09:39:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so20557579pfn.6;
        Fri, 26 Jul 2019 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNGhruycsyv5RSKSp20/ldguafK8d3xLwWMPR2HsvM8=;
        b=jqsYhuceW2piqs8ASXdwGSF4xGboc9ocRa6HL+DJjVoU6V5Pu/ArnBmTRUfpzOF3I8
         gAweiGYu/Ok0TlZO0Qsljlf1+O/InzJHj9VOWdOkl5ouJ+QAhas3QCN5j8DivKmsnvbk
         utSD+urISxYcfP0kbAjntt5/n0nMYh5q8ci1OdIq0E9nXzKSrrMHDaz1zt/0bj2iMXeo
         pmXX6WIPtlFXekLf6Kq7ULjA7+4/YpB00401xnOnT3jXHHxlsN+0CorfGpxVMd6v+H6c
         aRI3gGEIy9ithV9sGpeO0KlDdqOiybO68fIyZFaAFG0yOJisFzwPVapyBRBs4TwfbyJ0
         LGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNGhruycsyv5RSKSp20/ldguafK8d3xLwWMPR2HsvM8=;
        b=nO5H8lRwxLadUCsjqt2n/7rbpZ5B3MM7pW+Wdc2tfXuvYTzJ6KeBR0sKxHJu8/TDbU
         mPt8jPVKuNmAFicLekxNx2b3MSkhjMfOYqGlWnlk/S5Q2fPKIaFOeFrag/VLA6RV4M/W
         1mGCTJi92jvU22mU/xFRUfY/opbOHicKTaSoaRX/xbwRnkteGwp2qmmgcTlBml1aA7ql
         Dbus2mkRbAyf1eZB0PVpxMNHM4QE+ny1dFWNaW502OU/Uhr3jDYjd+U9srzeCcNgqrON
         VRsUznt5hZWc0rkVxS1Byqva/QEfgJF5+o4M6YNhTo5MPGfWUe6rFdMMKEr3NYVTU6A+
         imgA==
X-Gm-Message-State: APjAAAVUqp7fNCNsHPkH3FpZUuLqtMVjdX6Tsoupn6PPE6ZT7+baRGuu
        0gWckhuioe1WsdL28QTGMco=
X-Google-Smtp-Source: APXvYqxg+0fR9lhjI/RM8PgcWo+2OIFPdzif9TcjsARMqm99xclTP52e1x5skFhgpBA/gsg784Qo3Q==
X-Received: by 2002:a17:90a:bd93:: with SMTP id z19mr99355752pjr.49.1564148363212;
        Fri, 26 Jul 2019 06:39:23 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id u7sm47336442pgr.94.2019.07.26.06.39.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 06:39:22 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
Date:   Fri, 26 Jul 2019 21:39:16 +0800
Message-Id: <20190726133916.26186-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_counter_register.
Then we can remove redundant unregistration API
usage to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Use devm_add_action_or_reset to keep
    resource release order.
  - remove() function is redundant now,
    delete it.

 drivers/counter/ftm-quaddec.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 68a9b7393457..4046aa9f9234 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -100,16 +100,18 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
 	ftm_set_write_protection(ftm);
 }
 
-static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
+static void ftm_quaddec_disable(void *ftm)
 {
-	ftm_clear_write_protection(ftm);
-	ftm_write(ftm, FTM_MODE, 0);
-	ftm_write(ftm, FTM_QDCTRL, 0);
+	struct ftm_quaddec *ftm_qua = ftm;
+
+	ftm_clear_write_protection(ftm_qua);
+	ftm_write(ftm_qua, FTM_MODE, 0);
+	ftm_write(ftm_qua, FTM_QDCTRL, 0);
 	/*
 	 * This is enough to disable the counter. No clock has been
 	 * selected by writing to FTM_SC in init()
 	 */
-	ftm_set_write_protection(ftm);
+	ftm_set_write_protection(ftm_qua);
 }
 
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
@@ -317,20 +319,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 
 	ftm_quaddec_init(ftm);
 
-	ret = counter_register(&ftm->counter);
+	ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
 	if (ret)
-		ftm_quaddec_disable(ftm);
-
-	return ret;
-}
+		return ret;
 
-static int ftm_quaddec_remove(struct platform_device *pdev)
-{
-	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
-
-	counter_unregister(&ftm->counter);
-
-	ftm_quaddec_disable(ftm);
+	ret = devm_counter_register(&pdev->dev, &ftm->counter);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -346,7 +341,6 @@ static struct platform_driver ftm_quaddec_driver = {
 		.of_match_table = ftm_quaddec_match,
 	},
 	.probe = ftm_quaddec_probe,
-	.remove = ftm_quaddec_remove,
 };
 
 module_platform_driver(ftm_quaddec_driver);
-- 
2.20.1

