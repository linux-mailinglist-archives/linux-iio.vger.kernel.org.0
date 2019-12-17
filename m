Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4619B122992
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfLQLMJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:12:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44291 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLQLMI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:12:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so5470983pgl.11;
        Tue, 17 Dec 2019 03:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IA63TGuvmpsUwo2vleoz36+x8xqbZ3/90CJ5cyT26rE=;
        b=ov2Q68fE4IPuyR5otK9oGd1ob0KD3NBMeg3ueAQ2G7Imjtmj/SZgK/g9SyTI6GU/5k
         yyuzeiGwvVA7fajsCKeFg+wSdXZgEfbZ+r3C84y1lnHDtLpV+m/luBPK9GnwD+QUz6Qa
         vD7PyXU3QxWXFzIKg+kuM4TkJWHjmSOTPeCpIL9IFm8gYcHq/vFIsCkxy+RE2SguFnoo
         t/ZG6/TXWfe19YB9rDADSOo8cnkOEqfsbCb37gN6qELnqVgkAPA3jR7eOG8CHma/peRL
         513k37sbD+qEMuDiYlKXolfF7hv5irZHWiXBuIj6DjO2QBXLKnpaG+EJAIHqqRpPccIP
         Irzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IA63TGuvmpsUwo2vleoz36+x8xqbZ3/90CJ5cyT26rE=;
        b=e1zSfcGKxHkWyQVCTbIBiDgdmh8Y3nwA20weip1SxVie44ryYp4tqMdFkN0NLjuacw
         PpsahcfWiUhwPW8MWBrCUHt7aLm+51I/gye+d90YNF+2f6DfLlQ1w4YLyUOlVQFG8zhl
         6JrL5cI6LdQEghC7Aycl03YckQPxNyqMODKtvXEo9NEIFGuRyvkkBE/bQDrnroBqHoK0
         oioVxIzXL2w0bjx7rQVBrIcR8ux6hyzKAEtJdJLw4IaIW1ElSDIaSLsR8YWw7IU/b4Hc
         BJWnWTWw7SGwJTU1vIUqCHEPHzUQaIonbYaQSaGqq5oAdpUKxdlmx2nH63UrJWvWXL5G
         NunA==
X-Gm-Message-State: APjAAAVnD1gxk1cooHJK8fj39CjUDm4wepQcAy/xA8tyVU5c+mPGdJz9
        OrO7d+TuycI4jIuJy1CSt28=
X-Google-Smtp-Source: APXvYqx3B52CUga00ZeCK8d+KiYISZhQGFTvXYBAVPqUZLT/tLWcL0ydJgiHqoIIgC25awsDJeezLg==
X-Received: by 2002:a65:4344:: with SMTP id k4mr23959422pgq.193.1576581127562;
        Tue, 17 Dec 2019 03:12:07 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id 81sm25855190pfx.73.2019.12.17.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:12:06 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: [PATCH v3 1/4] iio: adc: ad7923: Remove the unused defines
Date:   Tue, 17 Dec 2019 08:11:55 -0300
Message-Id: <20191217111158.30888-2-djunho@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217111158.30888-1-djunho@gmail.com>
References: <20191217111158.30888-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Removes the unused define AD7923_CHANNEL_x from the code.

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 3212eb4c0f25..969c06b7d2b7 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -29,10 +29,6 @@
 #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
 #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
 #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
-#define AD7923_CHANNEL_0	(0)		/* analog input 0 */
-#define AD7923_CHANNEL_1	(1)		/* analog input 1 */
-#define AD7923_CHANNEL_2	(2)		/* analog input 2 */
-#define AD7923_CHANNEL_3	(3)		/* analog input 3 */
 #define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction */
 #define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt write cycle */
 #define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */
-- 
2.24.1

