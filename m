Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7704E39DF2D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFGOuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:50:37 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:37499 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhFGOug (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:50:36 -0400
Received: by mail-qv1-f44.google.com with SMTP id x6so4049825qvx.4;
        Mon, 07 Jun 2021 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gubJ+cy2hdbRa3vWvYjt/ZgxNm2KDsWHFNK3TFpu6TE=;
        b=Ba0y4dXO0ZlX0R79AwTNFf4VL40TBHmo0rZHxi7VM4KkshLBIK7VmTKzXfi4GtcABS
         Opy3GZPDgY+wEACFZmLBQzOUT3P0F/Y+3FFbpnjHGQCzwwVnO5ezpDCdyXPAPURY5Aqq
         RSeNGCGEsDMqqbqe9UVvOdcMZ1pUg4wI+vgedm8+ODE64+wcatYlREEVnVDlJECswXb0
         f9XaRR4thvzLp1P3chkRFrNhPwlIlSauukm5t4noq8761vm4o+6fuJ45k+8kbWrblz67
         hSVR6ghKvgC+GYaTfasccVJO+DW426arXx6ZDr+koY+90o+nboCZZSHB1PDDIDTM6hsj
         K//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gubJ+cy2hdbRa3vWvYjt/ZgxNm2KDsWHFNK3TFpu6TE=;
        b=uO+1SeimgW8Wchl3CxV82y9kEn6wnuDvJ/xWOcz9MEQpZX7LFZ2bWJmLHFdQIX8rI8
         DLZujIlAWo9ZcFGtx2GNScbMvC+uw142QFWmuB/CYa4RPg10n6JNrx/rjFsPVZoCkzvO
         tTnwA5RlX9bJsFqNY+YV70w2Xz1gDOl+yQU4r9VbR+p0FoXpgSUEBMyiExya6YAz6nnX
         BPYVvUfWAdKAtf2jhGUHgO+VP6BS6mdSyvuUki4/8ybvWU8VOZZGtTSRkxyxSzvbwXtc
         vRp+gs3y++Bn8YZb+1Gl5Otc/0jTB5Edf3rgkv9mMLeZdcr96caXgz/gCDaeDXdu67g+
         bjFg==
X-Gm-Message-State: AOAM530cryzJTRPpmunhfrHm/4OzjVW98aeDIZBcDwim7pd34VwB8gzp
        vOBJreOJCPzmtoILl5qMv856RQ8lWqL+rw==
X-Google-Smtp-Source: ABdhPJy5GXVXbU2UrrCiTiUgAj10SvN+w/xaUgEctESrQfSpR8FnglH211vXifHu4bg5eL9BPsrElw==
X-Received: by 2002:ad4:5def:: with SMTP id jn15mr8288408qvb.22.1623077251135;
        Mon, 07 Jun 2021 07:47:31 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:30 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 3/8] iio: inkern: error out on unsupported offset type
Date:   Mon,  7 Jun 2021 10:47:13 -0400
Message-Id: <20210607144718.1724413-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

iio_convert_raw_to_processed_unlocked() assumes the offset is an
integer.
Make that clear to the consumer by returning an error on unsupported
offset types without breaking valid implicit truncations.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b69027690ed5..0b5667f22b1d 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -578,13 +578,37 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
-	int scale_type, scale_val, scale_val2, offset;
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
 	s64 raw64 = raw;
-	int ret;
 
-	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
-	if (ret >= 0)
-		raw64 += offset;
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+			if (offset_val2 > 1000)
+				return -EINVAL;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			if (offset_val2 > 1000000)
+				return -EINVAL;
+		case IIO_VAL_FRACTIONAL:
+			if (offset_val2 != 1)
+				return -EINVAL;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			if (offset_val2)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		raw64 += offset_val;
+	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
-- 
2.30.1.489.g328c10930387

