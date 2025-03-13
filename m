Return-Path: <linux-iio+bounces-16751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65BAA5E93E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079A0179906
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0D35944;
	Thu, 13 Mar 2025 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rPLX3SjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD636FC5
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828577; cv=none; b=pgnO3Ndy8fXwuJwMAqlg/srC37e1o9m3TVJPMH64aQdjFbBedHdCfuSLPxUVMxgZsUNO6eGhjE3K2+L1ph0eoVsRFMUGxseag+4QK2UzkqFaVqIBPo2Ez5VH4pRKYR0fLx79r8oAhmFGIzV+EMxfJDV5SsWVUovYPb0R2BXTDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828577; c=relaxed/simple;
	bh=Nsm1P9IXqK79RS5iTQ15GAMUIKO5XFHcSqUCqmzn8qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXsmwIg5Ykdhxc8de4AbjvQU0KNizPFYDh9Pss7Xb/+8HRLXddfQ1HvSxeFthnE2RxbviJlEhHQadYfWrfkdWhZ/HxsjFTwLxwqXRwlYamXzvndYIcnY2HcVuhx/5UhS7KGYbcPA+v83K978hk7CAgMDG1hsB/IDa6+wMVezPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rPLX3SjK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-600038877ebso214960eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828574; x=1742433374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrZTqZUxbK1LjORtr8ZS2MLu+W9jtz5kAVFYAftauks=;
        b=rPLX3SjKAEDFPf5Uiyyr5MJr0mlerAxD2u0vscXa+xBZmiOdrRmEA0c7wZUL8F5mDz
         H4xuTJkxS0M/8EAMwZfDuquclHOM5KyrK51ughKMsKNFlIyA/v4P3MH2qTpvBLwrvO9L
         bmhUt6bvC0l5VhjIUuiXb67xGbfWINh5R5g7uMsvVSKi6xoIDdbUS6um7og/kcSdLA8n
         Ncw9HVRupI8cCLycUaJsb2smkb9isY80x6NCBL+0n2UuYSeZAY3+eq3+c77hDQ6pWJ8X
         C2c7J4NRcBnwQaEarJZvJWROekAEIhTzQnlMjaWyMi8AZdrw2VQaippWLu/FdS2mcwx+
         NvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828574; x=1742433374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrZTqZUxbK1LjORtr8ZS2MLu+W9jtz5kAVFYAftauks=;
        b=AFQH4ybk8wrnIurf8f6JSolVm8L+eMN1QjuTebagAB1PHxuQqzMQXpDWrqfY58uCrE
         FgT210aGUxZTu/SHKtBwvyjDIFciLBshhAm/BSaM3BlLvsOwID1TMI15F0zH3YULpEbx
         8bFshjsXhIsNUh1rkT+02cNaZuYklZV2es+lQBIAXuGMs37hCGXVCQeAOClJ6yV3yBNO
         iGOW2MlSqpkseU/CIwW+2BtwfrVt+j2NjtTMPWzk/BS8sQa9V0/ivbqU5GcN7ynqzvO5
         VmzUkAM7sGprInYsn043LCEv01ceqK9QlzvsFbhzhfG8udQvLqrMiBE45T1sbyywOYCh
         ac+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBpSnpl/zci9NM1vY52OI2zcs6kcBjvLQtDNWwj4FsWxPr4waQue+K1ooEWBjjRQ+DvAdBqYNPlVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFGQkdSsuhMpmVtB8ulcN34MPrj/STPLUBIDo7J7WLcSeOLMg
	ZtwhhcbW6LKmIY2yAFQNlXJp9XkrXnr2alNfmTRgaxlbUbz4HbCl/jwlX+YutHkozpgZJMSInoo
	Bt+8=
X-Gm-Gg: ASbGncsC7Na3H9VwWjd4MKnD045MV/NSWY5BOjz4f5UjpGOtkImgvrm3ki2qBPgM19C
	bCEn/4aaax/ciPxJX0DZtMaYka9u/flufzWnyoLMQdFYTovejrfRJU5d1e2bKQsPw9KG7kzg/hw
	KhcqwARUjvyyxW2Q+qcfqQ50MXAbQ2ViL2jNM/oLEpH5dsJwafXfKxB/ZqZLVEdMqtdc20FwYV0
	UZWtyBS0BZnZHnEOc6flgNSRWhhmG0Jo3U2QqzAOFHZFOOPzFpbHXikeZJpS2i5AXm4GPjWibNU
	8wKdC0j9b23knU9IPqfJFPp29NFp5JALgoOFL4H4MIBHIbkHbrUKLhi+ITmuJImYeUE0GAwbOLn
	e
X-Google-Smtp-Source: AGHT+IHAfNO0rPuYnHkGm0gbnqyBvXFhbZTEPez6E/tb7cDSLbvx7f4sbMN/yzXFdcc0JNs+adii7g==
X-Received: by 2002:a05:6820:3090:b0:5fc:fb1a:2b92 with SMTP id 006d021491bc7-6004ab2f30emr12512731eaf.6.1741828573934;
        Wed, 12 Mar 2025 18:16:13 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:39 -0500
Subject: [PATCH 01/11] iio: adc: ad7606_spi: check error in
 ad7606B_sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-1-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Nsm1P9IXqK79RS5iTQ15GAMUIKO5XFHcSqUCqmzn8qc=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHa/kXO9pooqHCPQs1sIidUhMs3fZytFn7t9
 gsVcWOBrC2JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMc7Q//VBTc8uLhwPNd8mhtlYZcmXiY1rBXmfgk1ZSPvX7
 rNQBIGJNniHB54qa4WZSMgICcpZQ4u2kodME6zw8CaB/qz2QVai4pTerzUO8B35cu2eCC1lbv7b
 rr/hupj6y2ocg8yiz+o0f98Or2P5XGpCG8rEJbKTOSyXEvQOip8emP5sx4OcRUT/UPh+ZmXkrrQ
 +HeDF1PwSfBfriOugQgPUWhQEwX/qHMgBQgEFto+mNG1TrRQqOouxkor5sbdwr5C9GLqZyGEjru
 OoBYxt81rHNRrDL2KYgu4wdSaD67wEsWBeoAUlMAgiUFVa7t+1PB3COSaHC+Sxx/EmGGHKxZGuu
 3v6ZoxbzgoR88Gp0lTWa3o860Nwkd7tCxYrWCWhXXSlETW/m4dT5kCqY096W3clsMdtoh7yEByw
 4HAAt3OomdgwW4h4OBqpZ48QT6T4oK0kABAVSNWwebG1jwuzriqdCU2bCCSFSlZUgh2s3Wn+Mpd
 Sc+5lItWP5Tdx9wINeOy6G6vnAr4zXUAZDlNODvCUG6szR7D37jjK8rsHuyCsWXV5saJ3xDbp3j
 3WlpNCFoD5zTPl9iXjqVMgyYTCuXW9vbA6HXexeIbu+LngyvJ7/J8VKq7I8XgLYFj6OEGMl+qfm
 jVuGcp0wxRm+ROa9K+MucJtYU/AI4RDpgVFCOqw5YtZk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add missing error check in ad7606B_sw_mode_config().

Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 885bf0b68e7775c5f4a12dfb827f502d5f782e8c..c028e08efe2c82cd97249f98eec50a9a9c06471f 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -174,11 +174,13 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
 
 	/* Configure device spi to output on a single channel */
-	st->bops->reg_write(st,
-			    AD7606_CONFIGURATION_REGISTER,
-			    AD7606_SINGLE_DOUT);
+	ret = st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
+				  AD7606_SINGLE_DOUT);
+	if (ret)
+		return ret;
 
 	/*
 	 * Scale can be configured individually for each channel

-- 
2.43.0


