Return-Path: <linux-iio+bounces-4305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDD28A8952
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5922B28236B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A426171081;
	Wed, 17 Apr 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYwz43u5"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E57F17106F
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372396; cv=none; b=GKqcN4jJVWlTlodbdyOTIEMNv+Anz6XZm76bv4aLM52zZUBWvzsbUwYMNSSvnUQxE9q9LVrLk43vq+J7zx7cZmv2dADQloZZaYY1rWaghrBdSzNzeOo7OQEcxDYy9bpFNS+UQ0mVZfd1iQougcY1TegGPhUeSliX++4SVl8sSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372396; c=relaxed/simple;
	bh=e3kGjdPOL7UZFkhtSC4SvTBzoyYnO74XWAHZqa11BlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Een0chfbPDgWdqqHfktbGqAlaWrzKqBGXtSHtWrAFn+cAH799E6UUDBUYBokwLzuELILYneUxIuGS2tl2uxWxysNK9V6kNTGP5lgdM3y0jnhOlrRRHSRnf/Nh7UzaLRNDNd6vwhHqpHqF3pNucO0qAWq5zkbMFrIJG8Evl2jwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYwz43u5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713372393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BuIzFWKrmazQfUzlgtbrlQ8ILaUEf4eq4a3/0/luv20=;
	b=TYwz43u5dxd6NljApZ5S1KqKeJ7Zb36e8xJAGbvQzfb89G2vVSiSSjOU2Zu/AFFlXN0D9o
	gtJwQYyhjBBPsFYSUXxBpyBgMt9AS44PsgOX79tZcCctrat/VJN2Uz6Eot+bV8zIrWZG/a
	BjXn7Mh2tLmzT6oMaXMlT9gsDNNSl9o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-G96oRCPUOZ20zO5mvB-okw-1; Wed,
 17 Apr 2024 12:46:28 -0400
X-MC-Unique: G96oRCPUOZ20zO5mvB-okw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952941C068C3;
	Wed, 17 Apr 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA0E2166B32;
	Wed, 17 Apr 2024 16:46:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers and add it to mxc4005
Date: Wed, 17 Apr 2024 18:46:12 +0200
Message-ID: <20240417164616.74651-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi All,

Here is a patch series to refactor the ACPI ROTM orientation matrix
handling in kxcjk-1013 + bmc150-accel to share the code instead of
having 2 copies and then also use the shared implementation in
the mxc4005 driver since some MXC6655 ACPI firmware nodes also
include this.

Note the mxc4005 support is untested, I will ask the report of:
https://bugzilla.kernel.org/show_bug.cgi?id=218578 to test.

Regards,

Hans


Hans de Goede (4):
  iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
  iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
  iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
  iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method

 drivers/iio/accel/acpi-helpers.h      | 76 +++++++++++++++++++++++++
 drivers/iio/accel/bmc150-accel-core.c | 45 +--------------
 drivers/iio/accel/kxcjk-1013.c        | 82 +--------------------------
 drivers/iio/accel/mxc4005.c           | 24 ++++++++
 4 files changed, 106 insertions(+), 121 deletions(-)
 create mode 100644 drivers/iio/accel/acpi-helpers.h

-- 
2.44.0


