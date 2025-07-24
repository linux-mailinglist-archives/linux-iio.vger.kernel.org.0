Return-Path: <linux-iio+bounces-21942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DBB10833
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60034170BC5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BD26A0AF;
	Thu, 24 Jul 2025 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnRU2U1j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C6257AC1;
	Thu, 24 Jul 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354471; cv=none; b=iH2aLnYiQ3jCzLKmx2yrPsbew9rdiY4mZNwxuBHcZoWriefEYIY258myC+YiSHq1Haj2mGkyhKMsy6wY40VpJjBidtxCL/rFN5IrKFy3r9hJszrKcHnzgc8WBTQBEEnMFTBRCKNRvyH6A9ORJT9945WrksAEUx/O+w1oiAbY8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354471; c=relaxed/simple;
	bh=4RdXIdmLsaeopwpeoDbSFlgXg17AAtM2RAAGXJn3DSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KLZgRN9NVUgA/+JyOR2A4VmHw1thYXS2diX93+dWESek+Bun4+SqKwLZ8gCm7lP5muJq0Z1bY6LbbUlEE2WifI/40mmp8FFjW6I8NBQSfUv0b4f66fhKKAL9Uhm5mOBhJZfRgiAINDyAIvahF63UfelLexjHB9dXREP+spQi9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnRU2U1j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e346ab53d8so88732485a.0;
        Thu, 24 Jul 2025 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753354468; x=1753959268; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzXPL95AqlAtYTn/fXkedrulBndfItyVNrhL5nKMLOg=;
        b=fnRU2U1jVEwIYczvjImje1Ex17qQK03Fgx1pbF9xQ1LvG8VjX6PKRrOPuxPO9x+zMa
         GuBREqLBp2XFijRmeTqwtayNNtJ0F+ZkQn63CIdFkMLkQt/KsazMePKoytbP9p1/7IGP
         qH9vsSExmeS+0JnMyuPJG5TYrwWsmj10N8V9aQ7R9UyRBC1hjx7dO4sOrDDtsm3MEkel
         JNvVaHYbIrskUjFmXHFnECA/3y3l8ZtNrlPQstFebx+BTMAPud+u/PsdlofPDDJ5kCPu
         QGK+t9zXWQ/NNWk874RNWFdsWUWM1UnGdsJuhk3CN9AmivSJR6uNP2o0dtTy74/H1XCb
         Jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354468; x=1753959268;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzXPL95AqlAtYTn/fXkedrulBndfItyVNrhL5nKMLOg=;
        b=Jo+ElQsCZ/owtBJHJgZzbmQ10m3hqYMoQR5SivkztwX9Lmt9p5pGp2VzJ8NTsXcqKn
         mC28cK0HYFiBuJGQq1joY7vAgNFPefHJSfe5gjETHV31HE//2nbChYdsERDNxHB+GaCJ
         MBJc4SesBahugsyHzTSVS+Xlarhaw6c3Xhv3QBgFMfTUAl4ItKOyy8pObopCYytuhcuI
         UFUVmuuPPw9+bWp/TaJ6voHqjctEELkBgvuWMRkbVzoMNbzENkxnOHiMQPUjCzhEKmnC
         n8R1bOJSw51bhEHYA8Pksl3vNZ5uZdtKIaWiyYO0ehC4DUZhgDz/pPsZeSPNILe7c5x5
         je8w==
X-Forwarded-Encrypted: i=1; AJvYcCVK7+K6Jfyv+tdWGHrzOx2EzKUcCaHzq5tfoyQ+Ra6mhLfGmqBK81v9BVcFENftzlaDZ4xw9NbbT26inGsk@vger.kernel.org, AJvYcCVMcLCHkAadZBQrmE9LF5tAo3wXeu9NYepyZ3PgpqXYS2vZ1EJoOIgoTDEW5KbJfqZjRVoOB/2P7ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweih2MEL9QAjUkNW48rRdly5fxMWwz2AtSnCophDNyDBa6cCH5
	PMkQDBxp7ttZn6iNHkQimOShJMFC8uXAaINLRwuSqrWNuh2T+L3/hOCV
X-Gm-Gg: ASbGncsxHpMK81vXpPOZwPZ9UE1lVWEDrr2yltOY326tkSjrPL/KYxi7Ia1lhdPj1z0
	2L91JOy1Xcj8P9ITPdQqHMFaesPFX5sQPqP1BNwnwvO8pRv8gUeifiO5sHvMzjfe/KY67GD+deM
	rHBYnHb4kQaGmwgiIVn1grP+nCXBRu8WuIFrEcmka6OySWYNEhC2vKmPvOSffLu90YeaDGBbXJq
	OkOj9herBXYhqSCG51O2DR9zkU04ugi5H/0Em9ff4v68T7LyUG3xOJIafoaMwYUYtG/b+b3qOVG
	q5XclHheMhtMAlGnsRuozcQf6/MpPsu6dTgzSsvhGjDwh2nt6Ac6Jd/X33UPX0vTsYHaZ++YmhS
	AMJPO025dvJZWtiWn6Dx7
X-Google-Smtp-Source: AGHT+IEvRArPM3wFcwqBm8cMkU32Kt3+wVNw9tkHKPsVxnSlySu7VMtSzKD7z6rM5eO84e4iS6XOzQ==
X-Received: by 2002:a05:620a:b96:b0:7d3:90b3:28f with SMTP id af79cd13be357-7e62a13afcfmr652451085a.5.1753354468472;
        Thu, 24 Jul 2025 03:54:28 -0700 (PDT)
Received: from pc ([165.51.88.28])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e50d07sm102033185a.100.2025.07.24.03.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:54:28 -0700 (PDT)
Date: Thu, 24 Jul 2025 11:54:23 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] iio: adc: ad7280a: Remove unused macros
Message-ID: <aIIQ3xxCNfpTouxQ@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is to fix the following warnings when compiling the ad7280a driver using
LLVM=1 and W=2:

drivers/iio/adc/ad7280a.c:60:13: warning: macro is not used [-Wunused-macros]
   60 | #define     AD7280A_CTRL_HB_CONV_AVG_4                          2
      |             ^
drivers/iio/adc/ad7280a.c:97:9: warning: macro is not used [-Wunused-macros]
   97 | #define AD7280A_CB4_TIMER_REG                   0x18 /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:120:9: warning: macro is not used [-Wunused-macros]
  120 | #define AD7280A_TRANS_READ_CRC_MSK              GENMASK(9, 2)
      |         ^
drivers/iio/adc/ad7280a.c:33:9: warning: macro is not used [-Wunused-macros]
   33 | #define AD7280A_CELL_VOLTAGE_5_REG              0x4  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:99:9: warning: macro is not used [-Wunused-macros]
   99 | #define AD7280A_CB6_TIMER_REG                   0x1A /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:30:9: warning: macro is not used [-Wunused-macros]
   30 | #define AD7280A_CELL_VOLTAGE_2_REG              0x1  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:52:13: warning: macro is not used [-Wunused-macros]
   52 | #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL                    2
      |             ^
drivers/iio/adc/ad7280a.c:58:13: warning: macro is not used [-Wunused-macros]
   58 | #define     AD7280A_CTRL_HB_CONV_AVG_DIS                        0
      |             ^
drivers/iio/adc/ad7280a.c:59:13: warning: macro is not used [-Wunused-macros]
   59 | #define     AD7280A_CTRL_HB_CONV_AVG_2                          1
      |             ^
drivers/iio/adc/ad7280a.c:46:13: warning: macro is not used [-Wunused-macros]
   46 | #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5           1
      |             ^
drivers/iio/adc/ad7280a.c:37:9: warning: macro is not used [-Wunused-macros]
   37 | #define AD7280A_AUX_ADC_3_REG                   0x8  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:39:9: warning: macro is not used [-Wunused-macros]
   39 | #define AD7280A_AUX_ADC_5_REG                   0xA  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:32:9: warning: macro is not used [-Wunused-macros]
   32 | #define AD7280A_CELL_VOLTAGE_4_REG              0x3  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:41:9: warning: macro is not used [-Wunused-macros]
   41 | #define AD7280A_SELF_TEST_REG                   0xC  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:96:9: warning: macro is not used [-Wunused-macros]
   96 | #define AD7280A_CB3_TIMER_REG                   0x17 /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:98:9: warning: macro is not used [-Wunused-macros]
   98 | #define AD7280A_CB5_TIMER_REG                   0x19 /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:85:13: warning: macro is not used [-Wunused-macros]
   85 | #define     AD7280A_ALERT_REMOVE_AUX3_AUX5              BIT(1)
      |             ^
drivers/iio/adc/ad7280a.c:138:9: warning: macro is not used [-Wunused-macros]
  138 | #define AD7280A_DEVADDR_ALL             0x1F
      |         ^
drivers/iio/adc/ad7280a.c:100:9: warning: macro is not used [-Wunused-macros]
  100 | #define AD7280A_PD_TIMER_REG                    0x1B /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:74:11: warning: macro is not used [-Wunused-macros]
   74 | #define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK              BIT(1)
      |           ^
drivers/iio/adc/ad7280a.c:61:13: warning: macro is not used [-Wunused-macros]
   61 | #define     AD7280A_CTRL_HB_CONV_AVG_8                          3
      |             ^
drivers/iio/adc/ad7280a.c:31:9: warning: macro is not used [-Wunused-macros]
   31 | #define AD7280A_CELL_VOLTAGE_3_REG              0x2  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:51:13: warning: macro is not used [-Wunused-macros]
   51 | #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5           1
      |             ^
drivers/iio/adc/ad7280a.c:47:13: warning: macro is not used [-Wunused-macros]
   47 | #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL                    2
      |             ^
drivers/iio/adc/ad7280a.c:84:13: warning: macro is not used [-Wunused-macros]
   84 | #define     AD7280A_ALERT_REMOVE_AUX5                   BIT(0)
      |             ^
drivers/iio/adc/ad7280a.c:103:9: warning: macro is not used [-Wunused-macros]
  103 | #define AD7280A_CNVST_CTRL_REG                  0x1D /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:55:13: warning: macro is not used [-Wunused-macros]
   55 | #define     AD7280A_CTRL_HB_CONV_START_CNVST                    0
      |             ^
drivers/iio/adc/ad7280a.c:36:9: warning: macro is not used [-Wunused-macros]
   36 | #define AD7280A_AUX_ADC_2_REG                   0x7  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:119:9: warning: macro is not used [-Wunused-macros]
  119 | #define AD7280A_TRANS_READ_WRITE_ACK_MSK        BIT(10)
      |         ^
drivers/iio/adc/ad7280a.c:38:9: warning: macro is not used [-Wunused-macros]
   38 | #define AD7280A_AUX_ADC_4_REG                   0x9  /* D11 to D0, Read only */
      |         ^
drivers/iio/adc/ad7280a.c:95:9: warning: macro is not used [-Wunused-macros]
   95 | #define AD7280A_CB2_TIMER_REG                   0x16 /* D7 to D0, Read/write */
      |         ^
drivers/iio/adc/ad7280a.c:48:13: warning: macro is not used [-Wunused-macros]
   48 | #define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST                3
      |             ^

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/adc/ad7280a.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index dda2986ccda0..cf2d70c959b3 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -27,38 +27,19 @@
 /* Registers */
 
 #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_2_REG		0x1  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_3_REG		0x2  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_4_REG		0x3  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_5_REG		0x4  /* D11 to D0, Read only */
 #define AD7280A_CELL_VOLTAGE_6_REG		0x5  /* D11 to D0, Read only */
 #define AD7280A_AUX_ADC_1_REG			0x6  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_2_REG			0x7  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_3_REG			0x8  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_4_REG			0x9  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_5_REG			0xA  /* D11 to D0, Read only */
 #define AD7280A_AUX_ADC_6_REG			0xB  /* D11 to D0, Read only */
-#define AD7280A_SELF_TEST_REG			0xC  /* D11 to D0, Read only */
 
 #define AD7280A_CTRL_HB_REG			0xD  /* D15 to D8, Read/write */
 #define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
 #define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
-#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5		1
-#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
-#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
 #define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
 #define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
-#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5		1
-#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL			2
 #define     AD7280A_CTRL_HB_CONV_RREAD_NO		        3
 #define   AD7280A_CTRL_HB_CONV_START_MSK		BIT(3)
-#define     AD7280A_CTRL_HB_CONV_START_CNVST			0
 #define     AD7280A_CTRL_HB_CONV_START_CS			1
 #define   AD7280A_CTRL_HB_CONV_AVG_MSK			GENMASK(2, 1)
-#define     AD7280A_CTRL_HB_CONV_AVG_DIS			0
-#define     AD7280A_CTRL_HB_CONV_AVG_2				1
-#define     AD7280A_CTRL_HB_CONV_AVG_4			        2
-#define     AD7280A_CTRL_HB_CONV_AVG_8			        3
 #define   AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
 
 #define AD7280A_CTRL_LB_REG			0xE  /* D7 to D0, Read/write */
@@ -71,7 +52,6 @@
 #define   AD7280A_CTRL_LB_MUST_SET			BIT(4)
 #define   AD7280A_CTRL_LB_THERMISTOR_MSK		BIT(3)
 #define   AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK		BIT(2)
-#define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK		BIT(1)
 #define   AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK		BIT(0)
 
 #define AD7280A_CELL_OVERVOLTAGE_REG		0xF  /* D7 to D0, Read/write */
@@ -81,8 +61,6 @@
 
 #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
 #define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
-#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
-#define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)
 #define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
 #define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
 #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
@@ -92,15 +70,8 @@
 #define  AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK		GENMASK(7, 2)
 #define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
 #define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
-#define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
-#define AD7280A_CB3_TIMER_REG			0x17 /* D7 to D0, Read/write */
-#define AD7280A_CB4_TIMER_REG			0x18 /* D7 to D0, Read/write */
-#define AD7280A_CB5_TIMER_REG			0x19 /* D7 to D0, Read/write */
-#define AD7280A_CB6_TIMER_REG			0x1A /* D7 to D0, Read/write */
-#define AD7280A_PD_TIMER_REG			0x1B /* D7 to D0, Read/write */
 #define AD7280A_READ_REG			0x1C /* D7 to D0, Read/write */
 #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
-#define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
 
 /* Transfer fields */
 #define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
@@ -116,8 +87,6 @@
 #define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
 #define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
 #define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
-#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
-#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
 
 /* Magic value used to indicate this special case */
 #define AD7280A_ALL_CELLS				(0xAD << 16)
@@ -135,7 +104,6 @@
 					     (c) - AD7280A_CELLS_PER_DEV)
 
 #define AD7280A_DEVADDR_MASTER		0
-#define AD7280A_DEVADDR_ALL		0x1F
 
 static const unsigned short ad7280a_n_avg[4] = {1, 2, 4, 8};
 static const unsigned short ad7280a_t_acq_ns[4] = {470, 1030, 1510, 1945};
-- 
2.43.0


