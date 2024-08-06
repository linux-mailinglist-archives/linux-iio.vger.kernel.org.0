Return-Path: <linux-iio+bounces-8276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293D9491A3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0563281D03
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB991D2F74;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlQtzQrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45C1D27A4
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951307; cv=none; b=lXNtfGEhv/ltnpdq2DqSrRZPAz+DuezYIPrnQpF0oLYbCQXsfKHt91aCxWr2LoCqjFbstIsdQPs3vfd+c/jzOBbEZ5QHd8eKnHRUpAM5fhfD+35wbColMNXwbgpFPMndTzrBFuuGHyAOTX4yiw5USgCFVf0TSW/klL6AxRLtBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951307; c=relaxed/simple;
	bh=8SypoNiLFSu62aShOWnLsR4i8ZjNvFo3W5/Z+1+KZkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJIQnwvydhQet+kM9EEXWPLmUtKymMJzhiuNj+w9431w/hAnO/fPfdT4XtNyIQMDpxajJxqheTDlPxOUIk2QXBODt0FK846Fh+YnTgigGBg/JLOGzI16NAXwCX085itX9BlPcqPlk1uwtiU8nPV9ts86/qmZwUv2UdnUda4nJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlQtzQrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51824C4AF09;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951307;
	bh=8SypoNiLFSu62aShOWnLsR4i8ZjNvFo3W5/Z+1+KZkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jlQtzQrn6oMTyMkNAuOO9P7iWh3iF5gnQcRybuyPVB8AmWzTIPHSAQeH+lpNpqCcf
	 SsIx3dE39vrgR8IBrEnOgsboxMGtZONqGeVNuZ6zjVhyqt1e1cfWATATsSLGORKhs0
	 CrOFMl4dOmh3N/d0gszmlXc+E5dnAnr/k9uAxdK4oj6oIsq11fLheyrjJoRxlRzCcd
	 nGxIWIQdebcgtb4S8n/uHUlMr43AxopHRs9/cvdPL60LpC+Y96XA3WKVBFJRCetpCm
	 pTpnYbG10DfLx+u191J2wmzuz/wNOQQYMIdAH/OT0z167isYoEhBg5hqhnLweCRUZG
	 QeCDagTmv/VPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D06C3DA64;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Aug 2024 15:35:06 +0200
Subject: [PATCH 1/2] iio: dac: adi-axi-dac: support debugfs
 direct_reg_access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dev-backend-dac-direct-reg-access-v1-1-b84a6e8ee8a0@analog.com>
References: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
In-Reply-To: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722951306; l=1361;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=70Psr3VQuqq94rjCoV8WjU8cuWr16U1+KQK+zWEHn9Q=;
 b=ie12noL1qXL6arhMwxrBoobBneNtNwBnKN+DjS9lTltlbrETvPkfDxfdlhTIRMH17epJ+PF5E
 MhQ57UpZhvaD+z9UYp/a36QAzezqyMBTLZ5EFKOwxWWXKgJv5t+ERi4
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make it possible to read/write registers on the backend using the
debugfs interface for it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 9655705b158b..0cb00f3bec04 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -507,6 +507,17 @@ static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 	return 0;
 }
 
+static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
@@ -517,6 +528,7 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
 	.ext_info_get = axi_dac_ext_info_get,
 	.data_source_set = axi_dac_data_source_set,
 	.set_sample_rate = axi_dac_set_sample_rate,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
 };
 
 static const struct iio_backend_info axi_dac_generic = {

-- 
2.45.2



