Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F81957BD
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgC0NK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:10:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33084 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0NK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 09:10:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id j1so4502080pfe.0;
        Fri, 27 Mar 2020 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=KViQIRagSE5vWsB7ZI4K2nCzq1NtvcnA0oI0AGtFtWo=;
        b=kgXGh9wjh/uHFhjV7vcqGaaTAJIVW2/rw5thPMYEE+e4Ga6zKjSWASF51JILRBwtyN
         +pR4fyZe6KVWlAL0u03kxheh+4vulKtEQw1HqR04JJWABaoGJJv/mEmnzslsCJu1k93X
         ytc+gHgag4UCYo1Gy+xM449DDsT9n2speS3vlpbfc3Wd8uRZ9IkMXoHJLGIdX/bmqeY0
         Qe3eBM0tkWDXNH2Qgg4E15D+54UncaZk2HuiGi3gZgOn30PTiVvfh3snAhxw8LjZWZMp
         FitGhQwdw5LDYu2nSpPncIO7F+FBhvaWV/Ibl3obAlq011SWaIo1ErVf9liE6mXDS9g9
         6X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=KViQIRagSE5vWsB7ZI4K2nCzq1NtvcnA0oI0AGtFtWo=;
        b=ULTGy/dbvHB5GSUizEclZ8UwHV7X0b1i6UN3kvFMDD5eSrKYSlkELpuDJuw18wCEKi
         rvW7QwS7rrH7eMuH1i7TPDRdH1Y1zBFmzjDSmj+8niNoVy6fNweWNTIlmUq+1j1U/Y41
         OPJtzThZebTIxiIxjdDuEeAudIXUXvFmd40+7aiEi66oyGQNSflzT8grlldExQ3bi39s
         oo1NxobvuMLpZWdja5N8uoqYcGyozpBS/kxj9Kze+UpCUrC3EhfI+Fw5i6xO9g1CvE91
         l57FYXGqk5woDhp+OBHezG0nPMLUvHtkVLy5ko/Z+rMbnp7VXtrOaXAkXhRg1fNBquBU
         i9AQ==
X-Gm-Message-State: ANhLgQ0pcWpCCRMPHA8niNE4uc3zOw3IAx9g2JO0uuZxKlEnxA6OufvP
        +RcX9YqdPUC8biZknlVm6jFoIK8IYnY=
X-Google-Smtp-Source: ADFU+vtihaqniBbb4UWdvb8sN2yhD1p87rsvI1TM8mXLVHnnbphL6DTbblF1Iaw/cM0L3xZY5Ixfjw==
X-Received: by 2002:a62:76cb:: with SMTP id r194mr14632276pfc.302.1585314626326;
        Fri, 27 Mar 2020 06:10:26 -0700 (PDT)
Received: from SARKAR ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id r186sm4195723pfc.181.2020.03.27.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:10:25 -0700 (PDT)
Message-ID: <5e7dfb41.1c69fb81.cc4bb.042f@mx.google.com>
X-Google-Original-Message-ID: <20200327131023.GA28157@rohitsarkar5398@gmail.com>
Date:   Fri, 27 Mar 2020 18:40:23 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: inv_mpu6050: add debugfs register r/w interface
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The debugfs interface provides direct access to read and write device
registers if debugfs is enabled.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
Changelog v1->v2
* grab a lock to protect driver state
* add a comma at the end of structure member initialisation

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 7cb9ff3d3e94..381a3fb09858 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1248,12 +1248,31 @@ static const struct attribute_group inv_attribute_group = {
 	.attrs = inv_attributes
 };
 
+static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
+				  unsigned int reg,
+				  unsigned int writeval,
+				  unsigned int *readval)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&st->lock);
+	if (readval)
+		ret = regmap_read(st->map, reg, readval);
+	else
+		ret = regmap_write(st->map, reg, writeval);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info mpu_info = {
 	.read_raw = &inv_mpu6050_read_raw,
 	.write_raw = &inv_mpu6050_write_raw,
 	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
 	.validate_trigger = inv_mpu6050_validate_trigger,
+	.debugfs_reg_access = &inv_mpu6050_reg_access,
 };
 
 /**
-- 
2.23.0.385.gbc12974a89

