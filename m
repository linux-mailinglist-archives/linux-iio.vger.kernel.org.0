Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D665928A70E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgJKKsI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 06:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKKsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2020 06:48:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41B4C0613CE
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 03:48:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so11236448pgf.12
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=deTcVWZjgqYO/HLfkfRk5fdNNDOh0Ncp8EdEY6lKOFw=;
        b=F3y03MstqCtOnJNCSDX1Zb7+EGV+MRYU/fh+rlts6ArMyKQo9C7ZbmClsYK2wlmiJP
         +S0wf1JjLNejeNexAGgz6gpHjBR92TbU8uUaUlDG3+Q7zFHs/GoO2MwlNbAQDKvq1v9B
         Xlgb92TdVpSm8U7tKeTkGKWLOyrcTfSYs2HOlyQzVFIHlxaVRxkijfwTVgPsdvE1xcWQ
         nQEdK0eQm1iGrjkVbcTWQab6L25lwxBQyaeIXf7iSdjsN7O1kk1ZUYDU4HcZfMoSx/qQ
         MBn17MjCpZ2gsJaLRVSAHZxVa+uPY5VU3++UQG/VSQvWdLRlrN64FW6qPgWHpPrpbGnP
         h8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=deTcVWZjgqYO/HLfkfRk5fdNNDOh0Ncp8EdEY6lKOFw=;
        b=NK3prHeLDCJLF5vIpAIKBqQIFEve9Qcbks/yyUwNgRJCp4aA+CtGvxBB71LDKax074
         WKvAeN9zbNo7Pq99Virrq9JqYP9cyy0oQVou+ao0zpHlFiNkioq0Q7yWoPjZ4xgfmB5b
         eamGWVTrMAclpuYcmggz+dfhqXi09SkNwZ0ytdhBaat1X6wyMuXUeiTYwqlk8+6CGhXi
         dQ1zTXuG6tFZy+fFo0tLuXlztFpYvN7vIk4sDyIi/J8ODLv2+fX5MU9PUyvjXuYyRrj8
         KQvDbuvJ5mr8N5tU45VRfovBMC78AEOga8aa910XMaUgRe7CKaS0xPEiYVDaA1F5LMn8
         H49w==
X-Gm-Message-State: AOAM530KXcAgF0KJXbJz5mdEivRQujiCPtZ5DhTuQvcmvgU6HjO3/VHP
        emhQpfitdAEPFgWFN5Q3B9U=
X-Google-Smtp-Source: ABdhPJwXoPbipmzbzqDfFEGezKhOme9brJFVn4NLM1T2y8Zuk2nC6qFAlB0BJrxhHv59lldPhuZphA==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id d20-20020aa78e540000b0290142250134d2mr19031913pfr.43.1602413285617;
        Sun, 11 Oct 2020 03:48:05 -0700 (PDT)
Received: from ubuntu204 ([103.108.75.206])
        by smtp.gmail.com with ESMTPSA id z8sm16872683pfk.49.2020.10.11.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:48:05 -0700 (PDT)
Date:   Sun, 11 Oct 2020 16:18:00 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: adis16240: add blank line before struct
 definition
Message-ID: <20201011104800.GA29412@ubuntu204>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a blank line before starting structure definition as per coding
style guidelines. Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 5064adce5f58..8d3afc6dc755 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -426,6 +426,7 @@ static int adis16240_probe(struct spi_device *spi)
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
+
 static const struct of_device_id adis16240_of_match[] = {
 	{ .compatible = "adi,adis16240" },
 	{ },
-- 
2.25.1

