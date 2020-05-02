Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376E21C2468
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBJww (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 05:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgEBJwv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2020 05:52:51 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE352C061A0C;
        Sat,  2 May 2020 02:52:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w14so5689461lfk.3;
        Sat, 02 May 2020 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOkyJnmYfVfejzs3i6q6WkuY41lkYRfXhXC0ZzOJ2wI=;
        b=eqRXwQKGIdy5CkDTdD53uPAtPgqe9hXLhW3/3gzC1pWE0kwhqQNj9GjBcfpQgSpffS
         GLzZYBNgEi6fHoMAZs7sWWtAWgbTCkqQicsjd60rCc4bQ3zi5nszG6oEV8ODOqE4+04n
         OzcfzzT6p8AGSUELKx+TCiC2ZXttcP22GT5Yk7P4VeHnj1Jvw8CSEgNQMJ02Y5Lg8/pI
         Nnki6wVlu9vkgwsiPyJSCqpYAdsYZhaBDCxsYmB9pCd5PXfcTW7wVpbzfPED742fefZ6
         m6u59sZqB5/Lqxy5OUzXyPP3axQyF4mYIO0h+nkElN64peVdiftUzD50ld6uTFpcXK+n
         53kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOkyJnmYfVfejzs3i6q6WkuY41lkYRfXhXC0ZzOJ2wI=;
        b=RgCEoN/wL0+0MfXuLv+aJI2gZKM2BAXHxhD9sCtmCX97S0xawuJOB/kAzd1U4B3G8w
         ksIQhngp0OPVqg7+hUkyUuwRoYM3r/rR9fNOB902SojnyOB5ybG8UKOBVNPh2AmGPwo9
         mvBqgWdPO1PpI/ZvOU99niZWXfBizrjCT7KnFDQchIfXHd3j42o8WiyHQ1tyJ2PgXVQf
         lmsIJRE21ozOLORTaBZnqhUtL0n6ZdvJP11wRBl0tMczkTHUgang5ZcqHX1BzZp2sFYr
         LtoL/9t49xpzhXv6SCWa/IPNATh/Lb+nNAU1mv3qSSqanNDCTckZSinXhjceEkWD5UeM
         W94Q==
X-Gm-Message-State: AGi0PuaS5uFF5yguchOlfTfa9AAuZhvpIhyt+oIzeX24eRVwaYthFRGt
        cCLe5IwISArjH+KCkYOND1zlBUTIVXE=
X-Google-Smtp-Source: APiQypLfhgd612maJVppXlLGxPw+NXjmjjar01cWPBkM5x2heXoGgt1OrsJ7cW7Lx2fN/sBMXRhcgw==
X-Received: by 2002:a05:6512:53a:: with SMTP id o26mr5230850lfc.111.1588413168444;
        Sat, 02 May 2020 02:52:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id g3sm3565276ljj.13.2020.05.02.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 02:52:47 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] iio: light: ltr501: Constify structs
Date:   Sat,  2 May 2020 11:52:37 +0200
Message-Id: <20200502095237.71429-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Constify some data structs that are never changed. In order to do so,
also update a couple of functions that now need to accept pointers to
const struct instead of struct. While at it, update a few more functions
to accept pointers to const struct instead of pointers.

This allows the compiler to put more data in the code segment instead of
the data segment, as seen by the output of the file command:

Before:
   text    data     bss     dec     hex filename
  27080    8144     192   35416    8a58 drivers/iio/light/ltr501.o

After:
   text    data     bss     dec     hex filename
  27688    7536     192   35416    8a58 drivers/iio/light/ltr501.o
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/light/ltr501.c | 39 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 0626927251bb..5a3fcb127cd2 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -101,12 +101,12 @@ struct ltr501_gain {
 	int uscale;
 };
 
-static struct ltr501_gain ltr501_als_gain_tbl[] = {
+static const struct ltr501_gain ltr501_als_gain_tbl[] = {
 	{1, 0},
 	{0, 5000},
 };
 
-static struct ltr501_gain ltr559_als_gain_tbl[] = {
+static const struct ltr501_gain ltr559_als_gain_tbl[] = {
 	{1, 0},
 	{0, 500000},
 	{0, 250000},
@@ -117,14 +117,14 @@ static struct ltr501_gain ltr559_als_gain_tbl[] = {
 	{0, 10000},
 };
 
-static struct ltr501_gain ltr501_ps_gain_tbl[] = {
+static const struct ltr501_gain ltr501_ps_gain_tbl[] = {
 	{1, 0},
 	{0, 250000},
 	{0, 125000},
 	{0, 62500},
 };
 
-static struct ltr501_gain ltr559_ps_gain_tbl[] = {
+static const struct ltr501_gain ltr559_ps_gain_tbl[] = {
 	{0, 62500}, /* x16 gain */
 	{0, 31250}, /* x32 gain */
 	{0, 15625}, /* bits X1 are for x64 gain */
@@ -133,9 +133,9 @@ static struct ltr501_gain ltr559_ps_gain_tbl[] = {
 
 struct ltr501_chip_info {
 	u8 partid;
-	struct ltr501_gain *als_gain;
+	const struct ltr501_gain *als_gain;
 	int als_gain_tbl_size;
-	struct ltr501_gain *ps_gain;
+	const struct ltr501_gain *ps_gain;
 	int ps_gain_tbl_size;
 	u8 als_mode_active;
 	u8 als_gain_mask;
@@ -192,7 +192,7 @@ static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
 	return -EINVAL;
 }
 
-static int ltr501_als_read_samp_freq(struct ltr501_data *data,
+static int ltr501_als_read_samp_freq(const struct ltr501_data *data,
 				     int *val, int *val2)
 {
 	int ret, i;
@@ -210,7 +210,7 @@ static int ltr501_als_read_samp_freq(struct ltr501_data *data,
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int ltr501_ps_read_samp_freq(struct ltr501_data *data,
+static int ltr501_ps_read_samp_freq(const struct ltr501_data *data,
 				    int *val, int *val2)
 {
 	int ret, i;
@@ -266,7 +266,7 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 	return ret;
 }
 
-static int ltr501_als_read_samp_period(struct ltr501_data *data, int *val)
+static int ltr501_als_read_samp_period(const struct ltr501_data *data, int *val)
 {
 	int ret, i;
 
@@ -282,7 +282,7 @@ static int ltr501_als_read_samp_period(struct ltr501_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
-static int ltr501_ps_read_samp_period(struct ltr501_data *data, int *val)
+static int ltr501_ps_read_samp_period(const struct ltr501_data *data, int *val)
 {
 	int ret, i;
 
@@ -321,7 +321,7 @@ static unsigned long ltr501_calculate_lux(u16 vis_data, u16 ir_data)
 	return lux / 1000;
 }
 
-static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
+static int ltr501_drdy(const struct ltr501_data *data, u8 drdy_mask)
 {
 	int tries = 100;
 	int ret, status;
@@ -373,7 +373,8 @@ static int ltr501_set_it_time(struct ltr501_data *data, int it)
 }
 
 /* read int time in micro seconds */
-static int ltr501_read_it_time(struct ltr501_data *data, int *val, int *val2)
+static int ltr501_read_it_time(const struct ltr501_data *data,
+			       int *val, int *val2)
 {
 	int ret, index;
 
@@ -391,7 +392,7 @@ static int ltr501_read_it_time(struct ltr501_data *data, int *val, int *val2)
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
+static int ltr501_read_als(const struct ltr501_data *data, __le16 buf[2])
 {
 	int ret;
 
@@ -403,7 +404,7 @@ static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
 				buf, 2 * sizeof(__le16));
 }
 
-static int ltr501_read_ps(struct ltr501_data *data)
+static int ltr501_read_ps(const struct ltr501_data *data)
 {
 	int ret, status;
 
@@ -419,7 +420,7 @@ static int ltr501_read_ps(struct ltr501_data *data)
 	return status;
 }
 
-static int ltr501_read_intr_prst(struct ltr501_data *data,
+static int ltr501_read_intr_prst(const struct ltr501_data *data,
 				 enum iio_chan_type type,
 				 int *val2)
 {
@@ -716,7 +717,7 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int ltr501_get_gain_index(struct ltr501_gain *gain, int size,
+static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
 				 int val, int val2)
 {
 	int i;
@@ -848,14 +849,14 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int ltr501_read_thresh(struct iio_dev *indio_dev,
+static int ltr501_read_thresh(const struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan,
 			      enum iio_event_type type,
 			      enum iio_event_direction dir,
 			      enum iio_event_info info,
 			      int *val, int *val2)
 {
-	struct ltr501_data *data = iio_priv(indio_dev);
+	const struct ltr501_data *data = iio_priv(indio_dev);
 	int ret, thresh_data;
 
 	switch (chan->type) {
@@ -1359,7 +1360,7 @@ static bool ltr501_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config ltr501_regmap_config = {
+static const struct regmap_config ltr501_regmap_config = {
 	.name =  LTR501_REGMAP_NAME,
 	.reg_bits = 8,
 	.val_bits = 8,
-- 
2.26.2

