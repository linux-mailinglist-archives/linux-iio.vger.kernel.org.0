Return-Path: <linux-iio+bounces-10009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0D98DF4A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C558E1C24E8C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8BF1D097D;
	Wed,  2 Oct 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pSizprll"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA723CE
	for <linux-iio@vger.kernel.org>; Wed,  2 Oct 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883340; cv=none; b=eRvyfDgPVTzsrp7OXuXszX34ORVHd64fMO8PRqlGN59Cy2/jffwlRVsv9K38EkjK5dEp4fy/q2/DZ//KyyCTnISJPlsGFh5eIOjA8VY43zwhHIFvcm53eOqF2QxQetxBtDWk/JULp36zcVzPNsWekr8xEk8deLgLTeg1XyIuwX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883340; c=relaxed/simple;
	bh=ZmQbkjt0dwRBTiJ5F+tn6h9Y/T/iiqNOmiqwPkGxJv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G5XrIpun9jQCfr0wv7jekx4uWRNZm0ZcfrDbJs7b2LGOsdiGOVKzVe40HL0E5rMUWBtyNkLVrQGNgZkKOgAapipqSXd8iMPQXJbzELjIxUYK7p5WUSyOwIRJSc14hVpDBGApVui5nU5Nl6TcXIfntQa3jJTIZD3uvPfgYhDJVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pSizprll; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e03a5ed4d7so3531246b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2024 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727883336; x=1728488136; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nA+qJrMX1oUj2p/KqaGZktUgE9J6VRK2nMM2aw8DfRU=;
        b=pSizprllnLLHi6sfXygFl2EoFkt7EVohTpL6DCqSXVguykJ2WiDLYonUyHvCstl6BO
         JpTrhyqxvr/0Yh3SEXtpCdvpwp2VvjK6zBkvw+sXYJjAUD6SeKu6Ha11MmeL5JvYklbL
         lLQHPTDKwrX00YPMUQZreh9FdN/xQSMlATyzZ4bYF7yzEgVsuVSTQTrQARjj0XzZ4lLE
         N+G9aiS3nxA6argZEp8QbKXWWHnorWE/2o0AgQG/vMG1UCVVKr9iRMsyYAubt/IDi0Lz
         psX8HUw/oJI0OEsv60aDRRLcURlXz3YffgGEL1XyXfF8SwWv+nMX2XhoJ139+SrZW7Sg
         vciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883336; x=1728488136;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nA+qJrMX1oUj2p/KqaGZktUgE9J6VRK2nMM2aw8DfRU=;
        b=EbVEvcMAsGsocIRYn0ztoDEPVM+e9u76941wg/XA2u0vr9BuQ0yQu3vABgBwNqiQS5
         AyXqlIiE2GwK4nX5mCCMMAjh0xkMeUweayMfowq0Yf7Wrj36o0SkuwIwOem7JvBh/Du7
         PQXsASTNeduzyZRgMaBTQZbBSU3+7iil9ccB+tu9Dq4/gLE28IlCjMTRJcpGM95/GOf8
         opPkC2EgjnJi59EcgtTnycJbK9Y5tUaOkvQKbnJrD95lRPNmIyFPA1wB7NB1T92vijaF
         uV0QH3CxLaaPpl8/is3g98GbXGqpSfUX/hYuE32DKbcpCmEip8QG4Rsovpe56ihK1bLj
         Xubw==
X-Gm-Message-State: AOJu0YwHC2/eVG79tpJoC/x9CXRaQ5igOGgvss1NXRRxEALQN3xf3ZI+
	OtsNnxQ8sL+Mt8l/v3a9Bsig0cBiKPMXpN7iru2E3UhSe0SoB2lUa+v2pBJ3ySg=
X-Google-Smtp-Source: AGHT+IFjiXZs6ehOgz36GeHt631t9+6wDKPW5GAj1p27x6boymlERd2LC467pGMbfcrrgp049dNAlA==
X-Received: by 2002:a05:6808:2014:b0:3db:16a3:748a with SMTP id 5614622812f47-3e3b4169ed0mr2844926b6e.32.1727883336604;
        Wed, 02 Oct 2024 08:35:36 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e393597da1sm3721768b6e.25.2024.10.02.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:35:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Oct 2024 10:34:56 -0500
Subject: [PATCH] iio: core: make iio_device_claim_direct_mode()
 __must_check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-iio-must-check-claim-direct-v1-1-ab94ce728731@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAB9o/WYC/x3MTQqDMBAG0KvIrB1IopXoVcRFGKf1o/WHxBZBv
 Luhy7d5JyWN0ERdcVLUHxLWJcOWBckUlpcyxmxyxtXWGMfAyvM37SyTypvlEzDziKiyszat98G
 2j6rxlIct6hPHf++H67oBry6AF20AAAA=
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Williams <dan.j.williams@intel.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add __must_check attribute to iio_device_claim_direct_mode().

Since we have now DEFINE_GUARD(iio_claim_direct, ...,
iio_device_claim_direct_mode, ...), it is possible to write:

    guard(iio_claim_direct)(indio_dev);

This would be a bug, since the return value is not checked. Adding
__must_check to iio_device_claim_direct_mode() makes the compiler emit
a warning for the above code.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This comes from the suggestion at the end of [1]. It seems like a
reasonable thing to do regardless if the other series works out or not,
so submitting it separately.

[1]: https://lore.kernel.org/all/66fcac2dbde60_964f229426@dwillia2-xfh.jf.intel.com.notmuch/
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 18779b631e90..2dc6470d20a4 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -659,7 +659,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
-int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
+__must_check int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
 
 /*

---
base-commit: 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
change-id: 20241002-iio-must-check-claim-direct-e6988a195368

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


