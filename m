Return-Path: <linux-iio+bounces-11436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757079B2B18
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DF61F22077
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FB1990CF;
	Mon, 28 Oct 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX+Yh9aY"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF0190676
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106809; cv=none; b=vCMeqfLRjP6dCluMBOZxNZQ6tCNnM7RQkq0iydDlEh54fpYMcsf7HVHrgryLOfJ5rDyZ9rimrtlRzYNbMWdeyqS7rUqV7zRmxAw533MsH6dd5/A0+YbrocnpJEuQjSYLL+0U7XRtmH3TKds9PbA/afZNnF7Xvx2e6DMvTdFU6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106809; c=relaxed/simple;
	bh=G8mQbc6rB6Tph32tQsb7U/J0yIX1zGT8Ftv6HRDkbiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvObWeswCXbOBsYICcXmC6TNrzhCV5Zt4PyGvbIdUrHnTvA39j4/SyQkHdRyeEE6flDulr8nvQoTfX+agzwwDlzJiM9Kio3QOVKgFTPzrR78T2gW7U7CtIz26UnrD8JdkqFKTksFIFDU0hGMuIP1lkcBNqndHLCulLUgfZXTkmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX+Yh9aY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730106805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8mL9AnFpvR2FSeyCUCVsZyVlwtWLR5Tt1r0vRldbLhI=;
	b=PX+Yh9aY93BLzeXgUhfiNbLBECexVS8Tr3D6x/CbNTD7svQAX11A7vH0Ari5t9Wq0Exp5z
	XcLt8i6gUaGr87Im2vpUWy61xp22/OWyTnq435jlDIYznvl2bDcu/HjyQkv+kVSzbkPtZq
	mkCbGw17XmME3I4AcQgIbmM95Z6lmWI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-GsUGQcQ5NZ2pOP_8bhucaQ-1; Mon, 28 Oct 2024 05:13:23 -0400
X-MC-Unique: GsUGQcQ5NZ2pOP_8bhucaQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4317391101aso30135165e9.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 02:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730106802; x=1730711602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mL9AnFpvR2FSeyCUCVsZyVlwtWLR5Tt1r0vRldbLhI=;
        b=LmF4tu+DyK2br3OmFTqrJwMXGqiIDvUGesfP9IfhcHgsLYseP443SzwD7fn+aQMHda
         fcRfwBNnj9Snd1fuOVl7JliDRz9lsYH+Hefkox/EFeDrt3OrxAn2T7y7MfXkVXTGgo+S
         lwZCrvL+GhS54oqw7OE01UL1EahD0YnXkc+EhmqObspBxX2OyQKqbCklPeD9s4nLT+vp
         y2Lf/cQfkENKqVZY5cB1xD6EykAgsypIOXSAbiXEDYnZ7E8hm52T/nafCiCkR3kvgSEv
         MogLhaO1BPx41qmygkarZ9rljO08z6fh8Jw63ht7PfpI9sMriawb0YEw9Nv7UL3GZmmr
         tODw==
X-Gm-Message-State: AOJu0YxZx142TME9/yaAvnjEG1eNTavPijNHWDLETTAn8KEFxD3Xe5Rs
	pLQuDKrtKST3TmiYR/DwGCQ0JEUj4NH+yBVDlDV/I4fMsBFqFbo2g8vbP2FtueVetutaKRL4SRg
	kgH5cibObreMl7Qx4obp553oqVIiS5ECSKxE9qo4zo7kVPa459aShEM+DiA==
X-Received: by 2002:a05:600c:5110:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4319ad36874mr70631545e9.34.1730106802223;
        Mon, 28 Oct 2024 02:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLRTeEMPXMzQVxdxTiM2sxZawcWWohp2DQMruQZSAWoGfBb8mhKObRqq9Iqzltt0ErRbieg==
X-Received: by 2002:a05:600c:5110:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4319ad36874mr70631245e9.34.1730106801644;
        Mon, 28 Oct 2024 02:13:21 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a5921sm104543305e9.28.2024.10.28.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:13:21 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] counter: intel-qep: Replace deprecated PCI functions
Date: Mon, 28 Oct 2024 10:13:13 +0100
Message-ID: <20241028091312.17045-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/counter/intel-qep.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index af5942e66f7d..ee2bae27b728 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -408,13 +408,9 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	pci_set_master(pci);
 
-	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret)
-		return ret;
-
-	regs = pcim_iomap_table(pci)[0];
-	if (!regs)
-		return -ENOMEM;
+	regs = pcim_iomap_region(pci, 0, pci_name(pci));
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	qep->dev = dev;
 	qep->regs = regs;
-- 
2.47.0


