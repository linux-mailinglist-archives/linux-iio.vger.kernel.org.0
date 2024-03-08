Return-Path: <linux-iio+bounces-3393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4358876A9D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA8283006
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F944CDE0;
	Fri,  8 Mar 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="UX6C2S2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117317745
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921716; cv=none; b=TwVat0w/lrqqxRlVWraINUHDbsmPTGPK7QI+4OEobydy3iGUjSN8K7/+7OjNMheIM51nuxLT0TETeMre2zXdOBqIKdu7huQCjADGQNmNq7W3qppWaRP/v8BEgS2Et+Fstxi+76CaWeZqvrOvAR+v/gfjIwJCfFUVneN/TlaRFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921716; c=relaxed/simple;
	bh=g3xjSLgmd3Evg75fMc9juTz8ZVCFuU9rq5hxP5UTfrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PZgjbyvgAJJhJFXFa+RJe/xOKaUf/GgvkO7Qsgq7LFz/9eINtPRLoSw3flYYySaX/GEFngWlX2tBPbXrfqyJZv6AMf0oOydxH8FMJlTvBFJE4SEx8diGFow+0kJtRPinD4YmrJaq51G88Xd35fPeAPWHY84t+PPNLfp6et3omSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=UX6C2S2/; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LL1F1p2caMdQccWlSQSfOfff92EMNUmD9Edryl3GSCs=; b=UX6C2S2/myepw9slz+wQppbT/D
	nT3+jFjml3UaNwoTJxCBmKac6Zxng3Szhbrj1W90d24nSqE2DI5xwx1pIUNQK/g+PyAJJjqnWzzFA
	Jpk/ZN4yidA2v5cBypNXJ84SspKGyol2bU/LCzduq7pYcFfTSiAtKVIQnkWtVn0VQum+3FmiunKxP
	HZPjsNx5M7dJdDvMf7qNj5eAcwGLG75EDRRJsQovnNQU7rGUKZlJ/pL0QWgKNfPxqwfe6WWBgr51H
	3Tz4IKz1oovnmlF/OAiiTIDjdpAOJ45B34nGylON3wbGsUxC5XKv90B9WAgAlK1K+ndjkzROYBAtc
	l/52YHOA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1riekQ-00EQw2-Jn; Fri, 08 Mar 2024 18:15:10 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1riekQ-000000083Dl-0fSu;
	Fri, 08 Mar 2024 18:15:10 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@kernel.org,
	Michael.Hennerich@analog.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] iio: dac: ad5755: fix unised of_match table
Date: Fri,  8 Mar 2024 18:14:11 +0000
Message-Id: <20240308181411.1916460-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

If the ad5755 is not being built as a module, then we get an unused warning
about the ad5755_of_match[] array as this is only used by the macro
MODULE_DEVICE_TABLE. Fix this by adding an #ifdef MODULE around it to
silence:

drivers/iio/dac/ad5755.c:866:34: warning: ‘ad5755_of_match’ defined but not used [-Wunused-const-variable=]
  866 | static const struct of_device_id ad5755_of_match[] = {

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/iio/dac/ad5755.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 404865e35460..fb99c8472788 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -863,6 +863,7 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
+#ifndef MODULE
 static const struct of_device_id ad5755_of_match[] = {
 	{ .compatible = "adi,ad5755" },
 	{ .compatible = "adi,ad5755-1" },
@@ -872,6 +873,7 @@ static const struct of_device_id ad5755_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5755_of_match);
+#endif
 
 static struct spi_driver ad5755_driver = {
 	.driver = {
-- 
2.37.2.352.g3c44437643


