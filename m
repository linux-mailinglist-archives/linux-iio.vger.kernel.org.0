Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5101E30E1
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391688AbgEZVCz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391665AbgEZVCy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B37C061A0F;
        Tue, 26 May 2020 14:02:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so25954627lje.9;
        Tue, 26 May 2020 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJ9vqboLv1s3AzR5VuRjQV2GDS3hq4+tFKIoSAGXZY0=;
        b=ejXK9v03Nc2FhTlrQtlJ0OcmI0RiaIIzXrEIAGOK/09oz1IyyAoVv5Z6cha1vUJIBf
         rdFNtuTkug8NQ2gyahCUoMcHhw2YfU4uvu4YUuXg6Fy0T3PF+qxq84suIm6e30MkBLkj
         6J8vy4zY8FbvM1jMzqlAmXOg5qRZTD+p0e6suhzMh7Xj0lDb3baZ26Oi2hUgTYw/r/dB
         dEJZ0OsO4lgcKgPo1mNE8dty4U6mZUi+fIJvqsUP5QfpLbXV6Xi1K5IJ1iL7sFLw1TWX
         4C+8+MIFQ17WhAeMhbxONBRErKKFya3uz/tbD2qrTyPpoBUSqNfLRNTBa5Oj+oknezJR
         7c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJ9vqboLv1s3AzR5VuRjQV2GDS3hq4+tFKIoSAGXZY0=;
        b=QV1M4bhPl70GqQY76issW/5oSXYDb78DitFlLlQL2z+wawz2CvGKWS4gdEjbrle67w
         /+PFSlu2cOv3oFZW+SQE7qtN8DmoUYa8yA/jkg2i1ZTZFxgcfRXGJ1ws2KIazDz+GhVY
         yfRmSgwdRumpYATTLLRylVS/Gby1O0NOebGaFUKE/0KUy7LrQW9mzZqNKbJuE8y+rRdy
         vbKS4hV8+yFMnnkCAFgE3kn7pIso9WIOcVCvPIIVAnfzXsO+cKggLiHxLnFb32lmS2sc
         O+KUZsacSOKxk8UO4vrJpZ4HP4olSN+p55U1o0UrgLR6hlpKi4rSUusV33Df48TKivDH
         snlA==
X-Gm-Message-State: AOAM532JE7U8rmoyiadZ2I01Qg2W8uOkNAdfRSgXJWqs6Q6wQyBEMJYr
        83Qosp53849BjtHYFflF1aM=
X-Google-Smtp-Source: ABdhPJzqMOk4Dg3vbpPI9zz8oNtLsSnTq7AQyBFcmQinJ9H9qNJL+t6f7stdh0AzaWXeb/Z+ltvAww==
X-Received: by 2002:a2e:7007:: with SMTP id l7mr1350421ljc.74.1590526971255;
        Tue, 26 May 2020 14:02:51 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:49 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-pm@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 4/6] iio: dac: ad5686: Constify static struct iio_chan_spec
Date:   Tue, 26 May 2020 23:02:21 +0200
Message-Id: <20200526210223.1672-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These are never modified and can be made const to allow the compiler to
put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   6642   12608      64   19314    4b72 drivers/iio/dac/ad5686.o

After:
   text    data     bss     dec     hex filename
  16946    2304      64   19314    4b72 drivers/iio/dac/ad5686.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/dac/ad5686.c | 8 ++++----
 drivers/iio/dac/ad5686.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 8dd67da0a7da..6de48f618c95 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -206,12 +206,12 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 }
 
 #define DECLARE_AD5693_CHANNELS(name, bits, _shift)		\
-static struct iio_chan_spec name[] = {				\
+static const struct iio_chan_spec name[] = {			\
 		AD5868_CHANNEL(0, 0, bits, _shift),		\
 }
 
 #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
-static struct iio_chan_spec name[] = {				\
+static const struct iio_chan_spec name[] = {			\
 		AD5868_CHANNEL(0, 1, bits, _shift),		\
 		AD5868_CHANNEL(1, 2, bits, _shift),		\
 		AD5868_CHANNEL(2, 4, bits, _shift),		\
@@ -219,7 +219,7 @@ static struct iio_chan_spec name[] = {				\
 }
 
 #define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
-static struct iio_chan_spec name[] = {				\
+static const struct iio_chan_spec name[] = {			\
 		AD5868_CHANNEL(0, 0, bits, _shift),		\
 		AD5868_CHANNEL(1, 1, bits, _shift),		\
 		AD5868_CHANNEL(2, 2, bits, _shift),		\
@@ -231,7 +231,7 @@ static struct iio_chan_spec name[] = {				\
 }
 
 #define DECLARE_AD5679_CHANNELS(name, bits, _shift)		\
-static struct iio_chan_spec name[] = {				\
+static const struct iio_chan_spec name[] = {			\
 		AD5868_CHANNEL(0, 0, bits, _shift),		\
 		AD5868_CHANNEL(1, 1, bits, _shift),		\
 		AD5868_CHANNEL(2, 2, bits, _shift),		\
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 52009b5eef88..a15f2970577e 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -104,7 +104,7 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
 struct ad5686_chip_info {
 	u16				int_vref_mv;
 	unsigned int			num_channels;
-	struct iio_chan_spec		*channels;
+	const struct iio_chan_spec	*channels;
 	enum ad5686_regmap_type		regmap_type;
 };
 
-- 
2.26.2

