Return-Path: <linux-iio+bounces-3810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47088C0EC
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 12:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFA5B20F3B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AC57883;
	Tue, 26 Mar 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWu03oJZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FC5677D
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453038; cv=none; b=iCBXNflIyOAE/ud9ajfwJoUBm/BrewoqqZeQLiSAFhFyZIE1a56xFMxFuGFtjwu0SW9zU8aVXg6MdYX47e6OD99MERr/dns9DysPQrgXy+rfXDxu8IkyR0E8iy+tMBHJ3BMKDAVs7ogiqW4exDG7UYAvOF1h1YR4oKnYRvAOqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453038; c=relaxed/simple;
	bh=xYlLzvzaEfpnqA8iYygivf+9N4Fm3ooqxtxiQM5dkUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTNhmI31IJKxPgj5f0RymiW07SaQSk+q0eRAfxsNxmMN+0S0kMwTF11/YCQ17ZBgUMVy7asnfMciO2PxHgfIfRpeDRLmzEQRb+MxJUTBRIF1H38GZFjUSinFNgUiT09yc6L4dPR86LnITkgFqARNOsFNSlNcnFW9Gv4crcH5fxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWu03oJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711453035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mtZK0BCQPIblnJ0ybtAJqd34C7MZ3GI1gf+rMD4FsEs=;
	b=XWu03oJZvd+c41SMRk4yjVC2Sa9NbDeQx0wIGms06DiudJRcDaqvqBp2xslXBpdRedYKJv
	t+/fF6QxZBsMv3JoASmgZEvfUnMwSNrlY9QCPT1j8Ewq27W+ch9gE3X22MVNwxuHWs+WqT
	8v9Akvwpv5y6VxQW39bNpHgfvDkJr9U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-c_Wq2WSiPrWQtMuvYU1zzw-1; Tue,
 26 Mar 2024 07:37:11 -0400
X-MC-Unique: c_Wq2WSiPrWQtMuvYU1zzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65481382C464;
	Tue, 26 Mar 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61602492BD3;
	Tue, 26 Mar 2024 11:37:10 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Christian Oder <me@myself5.de>,
	Nikita Mikhailevich <ermyril@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [RFC 0/2] iio: accel: mxc4005: IRQ fixes + reset chip on probe()
Date: Tue, 26 Mar 2024 12:36:58 +0100
Message-ID: <20240326113700.56725-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi All,

As reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=218578

The MXC6655 found on several Chuwi tablets models works sometimes instead
of all the time. The problem seems to be that the power-sequencing done
on the board causes the chip to not reliably reset leaving it in a random
state at boot (and after suspend/resume).

The second patch in this set fixes this by using the sw-reset feature to
explicitly reset the chip on probe() and resume().

While working on this I also noticed an issue with the interrupt mask
handling, this is fixed in the first patch of the set.

This is marked as a RFC for now because this is untested atm. I'll
provide a test kernel to the reporter of:
https://bugzilla.kernel.org/show_bug.cgi?id=218578
so that this can be tested.

Regards,

Hans


Hans de Goede (2):
  iio: accel: mxc4005: Interrupt handling fixes
  iio: accel: mxc4005: Reset chip on probe() and resume()

 drivers/iio/accel/mxc4005.c | 82 +++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

-- 
2.44.0


