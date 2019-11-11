Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF71F77CA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKPfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55151 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfKKPfi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id z26so13790370wmi.4
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/FQlNKVcxb71DgL7lhZKnTFvgXDTr4/CG+zCoXM2wAk=;
        b=RyqjkVHFb0vxcP5YXMvMLGjBn0GUvaYygxcfbTD9vCbWSEMb/krEhjefgV5bR/svG+
         46obvSFbPTqLy8KAGxM5IbtRAVBf53UNqHnhoPT9Q0hD9oNulvcozBNy0eW8w6Klnjbf
         tWICT80ey1QSdFiMBw2Wy9ZyXzu0jHndxuKCVZOVHs3F45H0A0qElEopyw3A4BCN1ouw
         PJFxvvzElGOJQPmB3iyJYwmeIEilWb/TDLEe3re3WyZS0rx+JDx0tV5T4W+rPW6ZFH9j
         x2On46M4mPYG0EROC1bWFD2EZIbEQ4I6pj7+e5Z4GlsHrjTP+ncbBhWtGBn8rBnOVzTa
         aI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/FQlNKVcxb71DgL7lhZKnTFvgXDTr4/CG+zCoXM2wAk=;
        b=dKDMfXUHIXmZ1ME/H08LmweqeeDqObEjL4zFPvqsL/S8RGSLN95xIOteAyucl1FV8O
         Cg8RkhQiYpuxuGMO9xq8uGQYcbHI7jso5UsC3dmXtT9XKr9kIABaQeYfK/uwHwaGYrPV
         XTItMt0pVvfWrPYTPgDrcdWZ5fgXQpwXrjCiUP0VezuYYzcFHhAycyjjmXOlqt6RJs4b
         huBtFs8QuJmJbzNotHpPvBy5YEghl0wMSEWKMVaaV/y0aAVa6WdauetFSFHU2XdL911w
         Oh8M+bFU09UF4960ODGMwawfsr92GWakOeKd18FC/IWoi2S3PHJXFQN8VZtCH5j/ynAs
         YTRg==
X-Gm-Message-State: APjAAAWPWvUOOFeNabEaEvBV4MKNZp4SurLCLolAM0jxLEWPKan4W0mR
        xjRGPfqQRkNAV+8ZDv3oLtM=
X-Google-Smtp-Source: APXvYqzAjHd8YK2Lgh3vAVZcAxvQhw/ikvHfe7vifAFcDYM6urooyukzOWFQb3xlSkyOTbDTs3HACA==
X-Received: by 2002:a1c:6542:: with SMTP id z63mr21432814wmb.29.1573486536926;
        Mon, 11 Nov 2019 07:35:36 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:36 -0800 (PST)
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
Subject: [v2 5/9] iio: core: add thermocouple_type standard attribute
Date:   Mon, 11 Nov 2019 16:35:13 +0100
Message-Id: <20191111153517.13862-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We have a couple of thermocouple IIO drivers, supporting several chips.
Some of them support only one specific thermocouple type (e.g. "K", "J"),
one of them can be configured to work with several different thermocouple
types.

In certain applications thermocouples could be externally connected to the
chip by the user.

This patch introduces a new IIO standard attribute to report the supported
thermocouple type and, where applicable, to allow it to be dynamically set
using sysfs.

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
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 958b5c48a86f..fa2c3b321bfd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -161,6 +161,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 };
 
 /**
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 8e0026da38c9..e6fd3645963c 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -58,6 +58,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.17.1

