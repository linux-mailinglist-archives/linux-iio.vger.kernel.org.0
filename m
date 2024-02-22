Return-Path: <linux-iio+bounces-2920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1B860595
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 23:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9C8B23DA4
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DDB137908;
	Thu, 22 Feb 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wk8sM5Jr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A573F37
	for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640624; cv=none; b=ElFOuPXl42pwrmoRiKOME2YezjlJhAWyDef8o8OrkbzZjb9edIvH2PfQsLQ6YY8Iv23/0CQ75H5fHV7JqVg49DA7/MDp4VgqhpvrKh6duX3+ZKDYlE0/iKMf6a5AP4WiqrxcX0kPERkleW7LHHHVW36bidsm/xvkG/bHXVriyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640624; c=relaxed/simple;
	bh=0xRi+wRovLEtle3IAhjBAqJ3i0Q5IwxvEzplbN5MjGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=juEkYIIj1miDq+ioDgo3Rd2olAlMiY60BIIfnAVRA7ctkZmHkW66ALQapY8TYHw80DDsaDQZet3sooFpPdUMAdT01L/IfDlwYOH9wDA9ZvKK5OTt9JF7X9Jd2ttuvKacgDRGHUXBcmG25cMH1sAcXztErwbNAK2pwNvIe0Yo9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wk8sM5Jr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc49b00bdbso1282975ad.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708640622; x=1709245422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+5ilM19CFuUy0zgxwZQpQ+MBc9LAqwOhihVDIFuqNw=;
        b=Wk8sM5Jr5RVyv1CJ8e2xQ7BJ05jg8DtIk2sQRodjsmsowBM38MTt9Ik6ECevL8beVg
         CxDVqSaPBAl0NpcyJI092dcwpNPngExtl8mRPRMIv+wCZ6leaMpld2aW1BD2rUi2KQpu
         LuBWqlxFSzqTpjHIUZ+R6pNOHGE8H6M/i6id8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640622; x=1709245422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+5ilM19CFuUy0zgxwZQpQ+MBc9LAqwOhihVDIFuqNw=;
        b=hqQafKi9zsLO0P1Ooiny+QaagggcrcfMXe6MLG9JPZ2/Q0ihXCmnqV71QhbC5D7fUB
         /7avNK+UDzLyG3E/1/Skh1d1y+P75SFIKgf7u/7UDLvzzqleakPnOUDh6cvL0/HmwCwr
         BhnL10FNltFaW+ljwBrEUd+NuFNrOOMf9I0HYDFHBTzCDlAyCybH8EzShuup+/Uc+LHY
         zI1GaDCpTYasTfxPlQOLNPIJUmoAPIE9WvRyISkbBYrjIFaRD4ppiHZGo/lr2PkJusb4
         AHQwaRfOarOVl0dgU13wcIw8fQn4SqnUlpqArNqykrMg/aDrZO7pDktwEcqMop3Q7XKq
         ksQA==
X-Forwarded-Encrypted: i=1; AJvYcCXPoyRL84D0YdHKYtRbtEz+4AOQENSAV03eNdlYGh/2469ZUkQh5gEBMs7ghl8jcsCLvLBXiY0eIaGULKukWUVw3rU40gQsaOJW
X-Gm-Message-State: AOJu0YwlpP1lbYYyJAk1JhhC3YJBMDU8kPsF5EPislX6rXRWZTy0pj+T
	To6YzSJIfCvwWdIsSVHH2WTLCpgfLa7Odcz7FYRditelOJnVBADB38g5uYSrHQ==
X-Google-Smtp-Source: AGHT+IHTlMT87C9FVzzBUlliIz9cjmezsgccL1stCQ33LCcAcJX6p5zAFxvPwu7ziBvSPYuZmtGtZw==
X-Received: by 2002:a17:902:e5cb:b0:1db:d13e:26fb with SMTP id u11-20020a170902e5cb00b001dbd13e26fbmr266381plf.5.1708640622569;
        Thu, 22 Feb 2024 14:23:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c98c00b001d8aadaa7easm10458002plc.96.2024.02.22.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:23:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] [RFC] iio: pressure: dlhl60d: Check mask_width for IRQs
Date: Thu, 22 Feb 2024 14:23:39 -0800
Message-Id: <20240222222335.work.759-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0xRi+wRovLEtle3IAhjBAqJ3i0Q5IwxvEzplbN5MjGY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18lq4o+31/1R0DWW8xWF6Y+7BP30IH/M1esol
 O1U6dy83cuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfJagAKCRCJcvTf3G3A
 JtaRD/9phV+1oaxweCDWM7RyA5yYZNO0eEqTdKf4RB6phXBkx9kEI7rGUVfbyrXtZ0NC+Nx1rNv
 YPwLgODU6hZ6heWm1tX+r26uJ4XR7UM/wqORisZmp8e9X4iicnJtPPF9BpC8YsWfbDf5EFw09ip
 N+4mhNwKHfW6hvAG4l0ujSvKtJnIGTaKy8JowAz0VRswGgw/xGbQatKmvPuABoOxt3HMXXBP3Qm
 gSzJQ09JSv2A74EpZAcRKvX1qg8a3bAdPrHyQFHmZNt1sqW54K2KWU+w2umluFntRwtv9AfItiv
 81zNznm5WHoKMz83Y8VyHE5bBcUpRp06+1+KfnAZ6JdexzUsQ3Sw7t1rqTfUsRLjreMaplHPbf1
 Xbv4YatUXU3FeQ0kuvAH3z66vmuGvG9j4GvjxjvJ1tgJ/aFAD6gsayqP1j07Op5om1MCgspydfv
 ATbWJR60pbqyr37CFhZ7LDB3ko/cKUq+FBUFl8Ot4iN0ffVMOtLLHNTY0Os0A/L2ZyM9MLilnLF
 4M5PfHPjKrAeU869+gMxnFWfA/vTdZ3ti4rVtvLwYPzpCbTxcRmOTNY7zo9bA8HEUqHelVjo0Bv
 f0RfC+TisOs7I5itK9ke182+3YIAUbVYWtkOFQluiu5dsJCzihtVr6/0MVdORj1rVJ+Jq4pW1CP
 x2bqQQk KFcoGfpA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clang tripped over a FORTIFY warning in this code, and while it seems it
may be a false positive in Clang due to loop unwinding, the code in
question seems to make a lot of assumptions. Comments added, and the
Clang warning[1] has been worked around by growing the array size.
Also there was an uninitialized 4th byte in the __be32 array that was
being sent through to iio_push_to_buffers().

Link: https://github.com/ClangBuiltLinux/linux/issues/2000 [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/pressure/dlhl60d.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 28c8269ba65d..9bbecd0bfe88 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -250,20 +250,27 @@ static irqreturn_t dlh_trigger_handler(int irq, void *private)
 	struct dlh_state *st = iio_priv(indio_dev);
 	int ret;
 	unsigned int chn, i = 0;
-	__be32 tmp_buf[2];
+	/* This was only an array pair of 4 bytes. */
+	__be32 tmp_buf[4] = { };
 
 	ret = dlh_start_capture_and_read(st);
 	if (ret)
 		goto out;
 
+	/* Nothing was checking masklength vs ARRAY_SIZE(tmp_buf)? */
+	if (WARN_ON_ONCE(indio_dev->masklength > ARRAY_SIZE(tmp_buf)))
+		goto out;
+
 	for_each_set_bit(chn, indio_dev->active_scan_mask,
 		indio_dev->masklength) {
-		memcpy(tmp_buf + i,
+		/* This is copying 3 bytes. What about the 4th? */
+		memcpy(&tmp_buf[i],
 			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
 			DLH_NUM_DATA_BYTES);
 		i++;
 	}
 
+	/* How do we know the iio buffer_list has only 2 items? */
 	iio_push_to_buffers(indio_dev, tmp_buf);
 
 out:
-- 
2.34.1


