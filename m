Return-Path: <linux-iio+bounces-22090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818AB13875
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8616CF5F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130225333F;
	Mon, 28 Jul 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="cJ5ozXf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F661187346
	for <linux-iio@vger.kernel.org>; Mon, 28 Jul 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696787; cv=none; b=fc67ganaX8Qbh3yoImV8W1zIUPzZ9mU/OyeOeyZ4MY11pmgPPTazbuBQzPgoDd5G96AcyikxYlUAde4N+8x+LVtW7YC1yxr8esTizC9f6bUYHcOGIQ1+IvmGWBaNIVPRQrQJVr4P2Bzy7mx/nXSoqRRshSGs8B5o5PwHtVk7g/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696787; c=relaxed/simple;
	bh=CpIgJcNBH57ZIxVFm8Q8IGWglEPgaFmOCVA6ku4RpsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UqnwMCVSIEd2GtQHwmKip0WkYJOPhs38u3WUHTUWBzIuLY8b8lWf1A353OOsJmpFjEex4/Y8BDRPlVIZiz5GrU5bgOnskEZa6q7l2P8imhZs3mbC7xipMO46d1bG0stx3R7hKcttlJb/xtB4jbkRkXx6hw7C4ujW6uEMnuEQlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=cJ5ozXf6; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 970EB1014A8B
	for <linux-iio@vger.kernel.org>; Mon, 28 Jul 2025 15:29:37 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 970EB1014A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753696777; bh=CpIgJcNBH57ZIxVFm8Q8IGWglEPgaFmOCVA6ku4RpsY=;
	h=Date:From:To:Cc:Subject:From;
	b=cJ5ozXf6nkIu3soufTZknNlwQDIx6pw0dWLGh7hZYGqo3MXJg7CtDNz5b4qWRpjg3
	 6yZpOcoZno5SkBXg4Gyhu/7SBQEQWhhSkcIbZJ09P7k1lr0//nYKfk/GIi1DXteBbY
	 OFT1K7v6R0qN2WiWkk3abJFelFRMglI/ySE9caCw=
Received: (qmail 17700 invoked by uid 510); 28 Jul 2025 15:29:37 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(-6.0/7.0):. Processed in 2.540206 secs; 28 Jul 2025 15:29:37 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 28 Jul 2025 15:29:34 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 3386336003B;
	Mon, 28 Jul 2025 15:29:34 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id E1EAC1E81273;
	Mon, 28 Jul 2025 15:29:33 +0530 (IST)
Date: Mon, 28 Jul 2025 15:29:28 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, marcelo.schmitt1@gmail.com,
	gshahrouzi@gmail.com, hridesh699@gmail.com, akhilesh@ee.iitb.ac.in
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] staging: iio: ad5933: Fix implicit fall-through in switch()
Message-ID: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add default case in switch() codeblock in ad5933_read_raw().
Convert implicit error return due to switch fallthrough to explicit return
to make intent clear. Follow kernel switch fall-thorugh guidelines at
Documentation/process/deprecated.rst

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
Checked build for 6.16.0 kernel with ad5933
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 85a4223295cd..6547a259b8a0 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -533,9 +533,10 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 		*val = 1000;
 		*val2 = 5;
 		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
 	}
 
-	return -EINVAL;
 out:
 	iio_device_release_direct(indio_dev);
 	return ret;
-- 
2.34.1


