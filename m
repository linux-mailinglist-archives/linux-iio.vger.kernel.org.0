Return-Path: <linux-iio+bounces-4510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C838B220F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0D01F244FF
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B561494C9;
	Thu, 25 Apr 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wojlkd1m"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68612BF29
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049884; cv=none; b=HEbzlCK0QmaaN1MbzYmZXID4x7jz997HbQebKijDNtpUE2p6w8D2PTlyi2oE9bu7gQN7B2DdGEvj0Y7p3sW5D8dar2EyJmwuXNxPwL1TRcMYMStiff33cdD5b666l2ebHH3Qgx0ukPyoFYyFctYGV2E6DiBlWo3NcqUld9eFDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049884; c=relaxed/simple;
	bh=j+62I5iqQ9/fslQzF0VO7C46L1Fh0s3iGlBQHismm+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y/6zJk3eBXE3AoYl45RyxGHmp+dIu/AcqioaH+r94hSnyDvhEaTTZxnPlZMfjuTvzLg9PoUeXuXylkYTyQkKr4kCm1KjyLWf6jNSMRM7s74lG5fOoM+VlTvGJOApyaKYFHzyoropFskCyIKPM04x0zzyTWbMaplVrlOH0J0ycFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wojlkd1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714049881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=860UmIoTowO5dUY2FthyQfMIs45fBWmV5/EE1kfFeOg=;
	b=Wojlkd1mPFKaEdxSzzgTh3ikPvVuPI1FUVTHOd5o0aa1pf4DhQhpv5ADO08VD+v0qUz7N8
	FRPDLwyhmm5PEqxwjoj5tQsTfI2tAzRGufcfWlQ4szrMciZpu7V5fY3Blp/0asRPPFIDsn
	hjJ5wjOSP+IQmAXfrsk4hlhHWO2t0ME=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-5IEPLROmP0Owr4LCi_Jf7g-1; Thu,
 25 Apr 2024 08:57:58 -0400
X-MC-Unique: 5IEPLROmP0Owr4LCi_Jf7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA9CB38143A4;
	Thu, 25 Apr 2024 12:57:57 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D271112131D;
	Thu, 25 Apr 2024 12:57:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/4] iio: accel: Share ACPI ROTM parsing between drivers and add it to mxc4005
Date: Thu, 25 Apr 2024 14:57:50 +0200
Message-ID: <20240425125754.76010-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi All,

Here is v2 of the patch series to refactor the ACPI ROTM orientation matrix
handling in kxcjk-1013 + bmc150-accel to share the code instead of having
2 copies and then also use the shared implementation in the mxc4005 driver
since some MXC6655 ACPI firmware nodes also include this.

Changes in v2:
- Add comment about the Microsoft specification for the "ROTM" ACPI method

Changes in v3:
- Add the new iio_read_acpi_mount_matrix() helper to industrialio.ko instead
  of making it a static inline

Regards,

Hans


Hans de Goede (4):
  iio: core: Add iio_read_acpi_mount_matrix() helper function
  iio: accel: kxcjk-1013: Use new iio_read_acpi_mount_matrix() helper
  iio: bmc150-accel-core: Use iio_read_acpi_mount_matrix() helper
  iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method

 drivers/iio/Makefile                  |  1 +
 drivers/iio/accel/bmc150-accel-core.c | 44 +-------------
 drivers/iio/accel/kxcjk-1013.c        | 80 +------------------------
 drivers/iio/accel/mxc4005.c           | 22 +++++++
 drivers/iio/industrialio-acpi.c       | 85 +++++++++++++++++++++++++++
 include/linux/iio/iio.h               | 13 ++++
 6 files changed, 124 insertions(+), 121 deletions(-)
 create mode 100644 drivers/iio/industrialio-acpi.c

-- 
2.44.0


