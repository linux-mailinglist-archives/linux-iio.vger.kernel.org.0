Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6965FF77C7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKPff (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38947 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKKPfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so13655805wmi.4
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gS+fX6HocMZQrA2Zetea25BkJrtv5feCZObhATZvhqo=;
        b=gt9tsZCOb9423YgCV6u0uUq0iI2XXmySZNNqH7xa2WYRTPondr4OjOuW/VY/MlSpQl
         18gTpp2lzavzC7pUrhrvQnzZjbDAPFuH3BmHeLQPuXZ5YPOJj51I/MsDbPePmVwqQIm5
         Rq0XveZuYQfKoHPHU3Cbb435g/41aapmmyC2AuChozeJKb0urz60C7fy8SFlPKuzKY2e
         XpyTvgXoBu5F25bO+ZV6RXnmNkI4dW+UZuDS0KyRzDuCWi3laxrD4zhAAm4/JJ/yk5E9
         2p/A7viuI0Z/ut+dR3zHxBCHeGNWNqDpGMqat530WgGhFDCIOX4It1UFte4ztJjWkdIv
         oRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gS+fX6HocMZQrA2Zetea25BkJrtv5feCZObhATZvhqo=;
        b=PZvaPOnd1PeFDPvnUPGU25XLCtFhgchidyWMFbF5ClKXKZbre/6Nzp6TucTgnLmQOb
         tEy/0kAUd6x1/pF8y02wHI6e1/8kX69AW3s687CnjOF7qFiLAA5iPyCTK7WMlSbicgGo
         ZLQHGj11+Fb5yOiNQhegyLdaS0jMRMTt+/wWxVdOPMdnz4jRXCBCTqEvOY4ASRu9jGqJ
         epJIUxJBcV2JjJpW5rxyAjzTpYidoXgSP75NxYYI4o0IkWH8bYQcyIknPGfSWif5fuWZ
         57NN+/PLpBDhDBJ8Ag1MrMG/RdhG8KKECwiWjDqMbfdE9zhea7ffCNssbuOyQvhVyLRt
         dN7g==
X-Gm-Message-State: APjAAAUM1kvISDTQXX+liIJ0nuIf4Z6SZDnqltMv5k3saq+qagt5TCAN
        6p/Z0ko6eVh8EI5PpC8XsZ8=
X-Google-Smtp-Source: APXvYqySaUlfhDLlyMxvizvbrw+9Dp+QFYy2JSx7mmyxJ38PUmqnEHYSZDcFrOqBAHX2v1PaSHDj/A==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr22120264wml.174.1573486532406;
        Mon, 11 Nov 2019 07:35:32 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:31 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v2 1/9] iio: max31856: add option for setting mains filter rejection frequency
Date:   Mon, 11 Nov 2019 16:35:09 +0100
Message-Id: <20191111153517.13862-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This sensor has an embedded notch filter for reducing interferences caused
by the power mains. This filter can be tuned to reject either 50Hz or 60Hz
(and harmonics).

Currently the said setting is left alone (the sensor defaults to 60Hz).
This patch introduces a IIO attribute that allows the user to set the said
filter to the desired frequency.

NOTE: this has been intentionally not tied to any DT property to allow
the configuration of this setting from userspace, e.g. with a GUI or by
reading a configuration file, or maybe reading a GPIO tied to a physical
switch or accessing some device that can autodetect the line frequency.

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/temperature/max31856.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 73ed550e3fc9..d97ba9ee1598 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -23,6 +23,7 @@
 #define MAX31856_CR0_1SHOT         BIT(6)
 #define MAX31856_CR0_OCFAULT       BIT(4)
 #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
+#define MAX31856_CR0_FILTER_50HZ   BIT(0)
 #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
 #define MAX31856_FAULT_OVUV        BIT(1)
 #define MAX31856_FAULT_OPEN        BIT(0)
@@ -63,6 +64,7 @@ static const struct iio_chan_spec max31856_channels[] = {
 struct max31856_data {
 	struct spi_device *spi;
 	u32 thermocouple_type;
+	bool filter_50hz;
 };
 
 static int max31856_read(struct max31856_data *data, u8 reg,
@@ -123,6 +125,11 @@ static int max31856_init(struct max31856_data *data)
 	reg_cr0_val &= ~MAX31856_CR0_1SHOT;
 	reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
 
+	if (data->filter_50hz)
+		reg_cr0_val |= MAX31856_CR0_FILTER_50HZ;
+	else
+		reg_cr0_val &= ~MAX31856_CR0_FILTER_50HZ;
+
 	return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
 }
 
@@ -249,12 +256,54 @@ static ssize_t show_fault_oc(struct device *dev,
 	return show_fault(dev, MAX31856_FAULT_OPEN, buf);
 }
 
+static ssize_t show_filter(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
+}
+
+static ssize_t set_filter(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf,
+			  size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	switch (freq) {
+	case 50:
+		data->filter_50hz = true;
+		break;
+	case 60:
+		data->filter_50hz = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	max31856_init(data);
+	return len;
+}
+
 static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
 static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
+static IIO_DEVICE_ATTR(in_temp_filter_notch_center_frequency, 0644,
+		       show_filter, set_filter, 0);
 
 static struct attribute *max31856_attributes[] = {
 	&iio_dev_attr_fault_ovuv.dev_attr.attr,
 	&iio_dev_attr_fault_oc.dev_attr.attr,
+	&iio_dev_attr_in_temp_filter_notch_center_frequency.dev_attr.attr,
 	NULL,
 };
 
@@ -280,6 +329,7 @@ static int max31856_probe(struct spi_device *spi)
 
 	data = iio_priv(indio_dev);
 	data->spi = spi;
+	data->filter_50hz = false;
 
 	spi_set_drvdata(spi, indio_dev);
 
-- 
2.17.1

