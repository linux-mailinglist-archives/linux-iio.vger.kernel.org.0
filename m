Return-Path: <linux-iio+bounces-3394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878E876ADF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 19:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C689B218D6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5751AACC;
	Fri,  8 Mar 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="jnqB7nns"
X-Original-To: linux-iio@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9627FF
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923171; cv=none; b=ikAsu2M7x8iLznI9NHwyiu/tb8LiWr/TY+sIhUVvV+MFjXaEP/ZnXyL8Lv7X6PDz2TSOyzqac/rI6TZmyUznmh5W9al2GX9oBsJU3nc1a+hmWMUwC+BZ7HPWuGVzIJAQG8eNoLGuJ4iyXnOZIO2V/5hAuLxqiIj+k84vq1UO0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923171; c=relaxed/simple;
	bh=PQ1TNOZFq/eOyQFhKGGOA1Qzpad+91xWQh/caLPYfqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tVjwoMpOXXecQajidOiHu2HljKhgDLLGeoVAhklrEljNI3aVmZNb+k7MP+2VNjHCrcw3rJZ8lxe+S4H4ILts+WZnj72mE/hTBQJhMPGeV9X6Sl6DBkzKGdk2ADp5639PIXoU6V+No8Ng9EQxj4NCfMl8sm+AJom1YUmboOStpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=jnqB7nns; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wNl/3ur8Y8wmLjhjv/15EjPUngGezX9B8+tGJNpesWU=; b=jnqB7nnsDhlK/pWvXM+IWxC/Us
	09TPUj99fpoC90P2Sb4Fwx8wb7eEg/hTvySSwxDZgSVvxkPW+f8Az62MvzqksLyJrRzf72BrUdGz7
	9MhF6M7CALl96xoLOr/E/jRLpvxXAzBflH26VByLqXnTsiG7Al4U8/R7DIt9T6WCPusSOcjsDH7xf
	u/BqfgNt68dA4qjHXIapOurh1pltTzJL5JA99Tzs8onY4MJn4bnNMzfjPzS257T9kEactHyGTKxsr
	/1Mi9NBmuPAi3LNDpAYDP+uIZ/8WRFT/cDkBNdx64XeM/GU2qtJ2EtFmocEBdDCZzE7MKvr/QfJf3
	eXglZ9Rg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1riedf-00EQm4-3T; Fri, 08 Mar 2024 18:08:11 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1riede-000000082LV-2jBZ;
	Fri, 08 Mar 2024 18:08:10 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] iio: proximity: isl29501: fix unused of_device_id table
Date: Fri,  8 Mar 2024 18:07:18 +0000
Message-Id: <20240308180718.1913090-1-ben.dooks@codethink.co.uk>
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

Under certain build conditions, the following warning is being generated
from the isl29501 driver due to OF being configured but the driver being
built in.

drivers/iio/proximity/isl29501.c:999:34: warning: ‘isl29501_i2c_matches’ defined but not used [-Wunused-const-variable=]
  999 | static const struct of_device_id isl29501_i2c_matches[] = {

The isl29501_i2c_matches[] is only passed to MODULE_DEVICE_TABLE() and thus is
not referenced if the driver is built into the kernel. Fix by adding a check
for MODULE around the #if block.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/iio/proximity/isl29501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index bcebacaf3dab..d509227f47b7 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -995,7 +995,7 @@ static const struct i2c_device_id isl29501_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, isl29501_id);
 
-#if defined(CONFIG_OF)
+#if defined(CONFIG_OF) && defined(MODULE)
 static const struct of_device_id isl29501_i2c_matches[] = {
 	{ .compatible = "renesas,isl29501" },
 	{ }
-- 
2.37.2.352.g3c44437643


