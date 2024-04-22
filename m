Return-Path: <linux-iio+bounces-4423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7E8ACA26
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 12:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD60DB20AD0
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E413C695;
	Mon, 22 Apr 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZcpGuLN"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCC52F96
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780147; cv=none; b=ut+GTumriBnx/9R5rIH1QP65xjseySkFnJVTncpUrXYjCmywftGhgnR7mPKhmJIOpsfFBo6gFtyM85UjHcd/0fVL+bQ+A3fSn4Htakutpp4OyRng63w6BfLfyiTkYvCGuKlWT3HmTui0Z39W71gA/wa7Z9kOoyZO2W163vYXan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780147; c=relaxed/simple;
	bh=8sOJmMJD2vQcj0/LPz0esuDxDFtO03WqDjdBe5eORY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e4Kj1lLA+39WSo/XDgFxZDfa32XZp1q2yOk4NCUP3aV7JJDyTLN7RBAzfT7nA3HUFENvgLkjPpq2KT4RKjhrjXXalQ7ON7t7ytUoW0y+l5A9GvBVqzAbW+CIa8m6eny7YFYQoqwHTtziJO0o804xFytYv+4PEnsCEY5Ii/lLvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZcpGuLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M7WtTk/6/zyFIKqMmnKnMfF2rx1NzfGA5mIv03dRJRI=;
	b=IZcpGuLN+kebMdqx0z9uP1twqxmwg2G9q2DGf+SUfIYdqoZK9vr+yujIZiaayNYpbnk5Vz
	8C5KzE4DnOqe7CEl3QRfeZjj4kz7wd4l+LP3S81zeEiR3b8kSAhdbMaj+BytdNe8ax4hcX
	Rbx1H0iDATHkmg/hUZn+LkJsB2aJD/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-YETLEgKIPHe0CrluzktLtQ-1; Mon, 22 Apr 2024 06:02:22 -0400
X-MC-Unique: YETLEgKIPHe0CrluzktLtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97852812C59;
	Mon, 22 Apr 2024 10:02:21 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66BE743FB1;
	Mon, 22 Apr 2024 10:02:19 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/4] iio: accel: Share ACPI ROTM parsing between drivers and add it to mxc4005
Date: Mon, 22 Apr 2024 12:02:14 +0200
Message-ID: <20240422100218.7693-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi All,

Here is v2 of the patch series to refactor the ACPI ROTM orientation matrix
handling in kxcjk-1013 + bmc150-accel to share the code instead of having
2 copies and then also use the shared implementation in the mxc4005 driver
since some MXC6655 ACPI firmware nodes also include this.

Changes in v2:
- Add comment about the Microsoft specification for the "ROTM" ACPI method

Regards,

Hans


Hans de Goede (4):
  iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
  iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
  iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
  iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method

 drivers/iio/accel/acpi-helpers.h      | 83 +++++++++++++++++++++++++++
 drivers/iio/accel/bmc150-accel-core.c | 45 +--------------
 drivers/iio/accel/kxcjk-1013.c        | 82 +-------------------------
 drivers/iio/accel/mxc4005.c           | 24 ++++++++
 4 files changed, 113 insertions(+), 121 deletions(-)
 create mode 100644 drivers/iio/accel/acpi-helpers.h

-- 
2.44.0


