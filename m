Return-Path: <linux-iio+bounces-14031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BDFA0636F
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A47167253
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B42036E0;
	Wed,  8 Jan 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gp5+FlpH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD4202F6D
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357443; cv=none; b=p7ySxjhQbVExWui2f76l59sIM+GtUPCewbQ9cfmevFBfbKnodHvABnIK6ScXi5fO8Dpe2G72noyj6DXQA4MDM7hW1P+C9djQ2ZQLHzIvkT7JzHYvFx0DM83SXVlXQhPAY9aiEHVbluK0WxXDAcL23y9DbOw/+vK3+w5sNZOmdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357443; c=relaxed/simple;
	bh=DnAjjx0PkSOieNJ5OJb2nk2Cce0Mvn+naUnXYCUW1PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inyVwfR7cY8vWOHmgdjjeJHYkoVcPqLNJoj6vBLqoQ7jQiQM20vAScOXbWdJnyCM/kBqgr7XzBCYqHq1IgeB0zcwfmMd/Z0H8DMecvTv2PIzG6VtuTE6oIFlt6LCuSquf+zSHsz3kI8iO66hjs2h79dRaRg9ieA/mp41m+hK1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gp5+FlpH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso758565e9.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357440; x=1736962240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qABqYAhj0TrQzJxH7XVarpnbO7+OveXqYM2s3icznC4=;
        b=Gp5+FlpHJFNF4Iv1xZSRQrMCGxxP96zqrOhsI2nCDVQV/F2fhUcjpqib8XK0zowHCv
         jnfVioIcJ3MwAb5+dpn2F64Wj++/TmguihzKtLDRrrrgXGK1NT0kd7ad8gC2CRwEBkvK
         91rSF/Ur53zPbINWSTxJhRi7CFc/qzsVE21DAllAbn+CZpPkhGdhohnG1EkcWzCUJ9m1
         3rSXqdG3+6csNurp9ONIVEGPNiiC7EZJQd60qgA+wxzUEQMOReA2sbW8VUOgTzHzsuGI
         XuFNUXokkf2xrln0OzfMbzR55Awtcc7tvn/MmRd/+9DHyio+aqpIdX7aAUgurcKKeo2p
         1tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357440; x=1736962240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qABqYAhj0TrQzJxH7XVarpnbO7+OveXqYM2s3icznC4=;
        b=mwECWmDZRzBBkE4LSGPIwy0noneV5oONnejc7OZma8c9gRadafoGZn03dASsfNR++q
         WlLSv09Nrwc1x99u6isEyHsvm31FUdlTliD7l5EUK3XXZP1FiK+OIjboFnnqZWpjGAcM
         ijBWhVKm3MzndnV+s8yznQqxScMyCV02AzRgKqU7gD+v3t/Nhkavq6rfSJHbairn+m9k
         PD/GXbN+vpZd7QxuG/Db4orEtBBXwWF1TQExz23TChUaeixOH7yuYLCMfb4O0Bb0DuY9
         d/zamUEyqYADnrwFH6Grgi30cEYkP3Nd/Y0l+ZCTMtzDkGHIm9EGD6/xVhzt/6pCHwYQ
         IQzA==
X-Forwarded-Encrypted: i=1; AJvYcCXDPbJiQDyaOCKiUprxf5JfFg+c1400k4inaw+LSLYap66mlnBMaJitAiQFiK5QI5FLxadi8MPbnLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5H2/CZqZH2RZEtW4C9bM8+WWTd0h9oiSirsRMFedVmqrpDKE
	jDH9VZmur3idFYNy6HCFSi5zSSgztHNFi2hIDVFcFjyi3QHRxIPWtujsusb1GCU=
X-Gm-Gg: ASbGnct8QugdXw9tHaTbqMv4VCTon8WYC58jgF5s/71Bt/CY2hPuMgGDbfDUR6iKwnl
	MO3Qjno/PNHzzkgg8ITdzVRtM21QD7yaG5gINRp5e4yJVCcOHEE7duPSbjumQPpneuHCrj/8PU1
	7kprcb6HGg2K5vOrbrc2uxPsdUfafK8vOcdgrS0+1pQkI9+qRzuJJs0fwCkvihXo0kZNspmtQls
	Wwwh9dkz0k8vJvy6ke5YO961i/FZYY2nHdewEg4akkQT15TuvAY6TjeVzE=
X-Google-Smtp-Source: AGHT+IF3nilwMU43g5/fpaBvcw4VZUw4Fkdm9sOic07GjpPunCK+W3hkn/+CE4mn9czZhiryv71U9w==
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr16540885e9.5.1736357438725;
        Wed, 08 Jan 2025 09:30:38 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:38 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:20 +0100
Subject: [PATCH v2 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-6-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Use "instruction" mode over initial configuration and all other
non-streaming operations.

DAC boots in streaming mode as default, and the driver is not
changing this mode.

Instruction r/w is still working becouse instruction is processed
from the DAC after chip select is deasserted, this works until
loop mode is 0 or greater than the instruction size.

All initial operations should be more safely done in instruction
mode, a mode provided for this.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 27949f207d42..991b11702273 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -132,6 +132,13 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	/* Primary region access, set streaming mode (now in SPI + SDR). */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST, 0, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
 				      loop_len, 1);
 	if (ret)
@@ -198,6 +205,14 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/* Back to single instruction mode, disabling loop. */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST,
+					   AD3552R_MASK_SINGLE_INST, 1);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -308,6 +323,13 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST |
+				      AD3552R_MASK_SHORT_INSTRUCTION, 1);
+	if (ret)
+		return ret;
+
 	ret = ad3552r_hs_scratch_pad_test(st);
 	if (ret)
 		return ret;

-- 
2.47.0


