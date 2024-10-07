Return-Path: <linux-iio+bounces-10307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFB9937EA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D12B219E9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996ED1DE4EA;
	Mon,  7 Oct 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bil7NmWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C501DE4CE;
	Mon,  7 Oct 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331610; cv=none; b=sbQh5cAjlfkumcVtIorzHTf24kqWkWVrPgJVOk3CZvVWokrenxLsAg70tePXa7TbUDiM7VuqMXgQOwDgq6Sl6Nv61vjSZ6viFBR/WbyV4gKx0yOAkVDvr2DEPyfPDf2pJ4kwrb8O6yMDdTHC3tRDWIO9kJW9wCfZG3oQ4RCPiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331610; c=relaxed/simple;
	bh=LYtELKiOpzUfG9+0ZRs5Jh75bdh50S6i3ahUMml/9as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eV9Dx5kp0Jox1HxkA7H3WOn9f7ICPsxzyxnORguICJNEzde377V2T1Dn47SD9sQiUha5aSv4N54bDrtpH9AtTW4S9LSEjEQ5Ndyr+c41RVeoUzZOeQsoOaGI0mDWDlezFnCdgfaL20GKPlRGELpVVuVA+EgBKH2WGPIEI4Dvt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bil7NmWF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so49917595e9.3;
        Mon, 07 Oct 2024 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728331607; x=1728936407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yGVIq88olRrQK84Hp/eLLFNEN9Ab2u6f+sEVdlm6Iw=;
        b=bil7NmWFBkaGrvdTCK8Qqhkdh3vu8NPeU28B+GQJkhNRTVlcEBmpYVMCMx9FQvdFq3
         KJ122d6DS0df9k7ehZANOnaQm/NfLlSY6DqrKexv8fG8wRSNHogCMq+7w+y2xbfIdoYp
         HphZ+yzRgYl0L84oSZ4sJ0cFZ49ywfSwVWx2KDGz0D1zPVBZDOXG1HVxQgSCYwxp8rFw
         GceODdZuCjFAv8ZZ33x9mGkz9/FZsN+kQexkw5devP27pklCnaY+dX7S1C7Jw7390HTW
         I1Z2sZx2Uty7JOW6oe+nT+Z6Hego32nLn+IeKfHqBjn7Uhob4pAg4aPcsXAzKjy36+Yr
         osbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728331607; x=1728936407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yGVIq88olRrQK84Hp/eLLFNEN9Ab2u6f+sEVdlm6Iw=;
        b=TmyqD7LFYOkZ+/lau2nkjdWmx8Kkuft9UBXkfr7niUFa14eqao5YbVTk/YoYSK/sq8
         qaYUpiA0ehlyQB1Ov8ZJ0bPyZ5WO/ZiwZnKSbMCWXS5/6lc4nkw3HsxKyTxdnAKmAhqk
         3sZXTo9RxyYlNAr6fHxGrdJgr/Wj93R2lj5vjFBbSOKdJ5J7CCIGCgn1c4j1K8ocHm6L
         AAeWUOaxaHh4DlfABlbKV6iMA9dHZrOCGmZuMW5YXr1Nu6i22qJF9c1Jn/TrqCa2dFtR
         m6skHj4i8DnT9eEgKfOZdXog/O5k4s2T1p/SfRRlLuPCPdZfI1rDGkG/s9co/otOluG1
         E3kg==
X-Forwarded-Encrypted: i=1; AJvYcCUSZGc/ZUvZUp9zVMd+vXDvkC6sjPBOX7I5RuMCGpcRjTdVGYXl5R2xS9fbtnrZNQmK3Ttool+EkFM=@vger.kernel.org, AJvYcCXU2YhrpBEUqZ3/jiErCc+HckfuHufp89XMtMU+Lbe2/s1jv/WYdzmngvUgmWYGAxatyItuNj44bsL6E2on@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfKuwMCXogCZZo5vaErMy+sgBgViK8NIre7/EpEaVrSDqeKc6
	jG3b4wUwZzOrEe63aP84EjDwvfhOUAa4UAhAOCl3P+ITd3ZH1rXl
X-Google-Smtp-Source: AGHT+IHz6e5Z4PQTUFWRETYz+7ht4SBNXQ1iPKXC+VfF4imzdtisGBAWOKxF3ulQoIwyUWKmliK9cA==
X-Received: by 2002:a05:600c:1f17:b0:42c:bf94:f9ad with SMTP id 5b1f17b1804b1-42f85aefc46mr113920345e9.34.1728331606971;
        Mon, 07 Oct 2024 13:06:46 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eda21esm85547155e9.46.2024.10.07.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:06:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Oct 2024 22:06:38 +0200
Subject: [PATCH v2 1/2] iio: frequency: {admv4420,adrf6780}: format Kconfig
 entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad2s1210-select-v2-1-7345d228040f@gmail.com>
References: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
In-Reply-To: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Cristian Pop <cristian.pop@analog.com>, 
 Mircea Caprioru <mircea.caprioru@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728331603; l=2010;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LYtELKiOpzUfG9+0ZRs5Jh75bdh50S6i3ahUMml/9as=;
 b=Sy781ghnUlBGhhUyTXeZ/5qtnFdwF39vucVNXrjQKZUuzSukOlcIM23FMhZSeEPn1JayhlBbu
 4Dsv5GdMQyxA6vjWKxGqJEV/40Nqwpfpj+NwIau6Nnsv0OTX5CEmqGF
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Format the entries of these drivers in the Kconfig, where spaces
instead of tabs were used.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/frequency/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 89ae09db5ca5..7b1a7ed163ce 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -92,25 +92,25 @@ config ADMV1014
 	  module will be called admv1014.
 
 config ADMV4420
-       tristate "Analog Devices ADMV4420 K Band Downconverter"
-       depends on SPI
-       help
-         Say yes here to build support for Analog Devices K Band
-         Downconverter with integrated Fractional-N PLL and VCO.
+	tristate "Analog Devices ADMV4420 K Band Downconverter"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices K Band
+	  Downconverter with integrated Fractional-N PLL and VCO.
 
-         To compile this driver as a module, choose M here: the
-         module will be called admv4420.
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv4420.
 
 config ADRF6780
-        tristate "Analog Devices ADRF6780 Microwave Upconverter"
-        depends on SPI
-        depends on COMMON_CLK
-        help
-          Say yes here to build support for Analog Devices ADRF6780
-          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
-
-          To compile this driver as a module, choose M here: the
-          module will be called adrf6780.
+	tristate "Analog Devices ADRF6780 Microwave Upconverter"
+	depends on SPI
+	depends on COMMON_CLK
+	help
+	  Say yes here to build support for Analog Devices ADRF6780
+	  5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adrf6780.
 
 endmenu
 endmenu

-- 
2.43.0


