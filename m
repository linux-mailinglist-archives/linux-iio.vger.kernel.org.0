Return-Path: <linux-iio+bounces-5489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48368D48A6
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513EAB23D2D
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34FB176AC2;
	Thu, 30 May 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oLQ+2E+c"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167E1761AA;
	Thu, 30 May 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061671; cv=none; b=jEXfU4nqjdFQWOhbQvhUajK5Anx0h0AqIbXkn9x21ymY7zU7THXKbSTQHsbI/Nk0vnfUSBo9awumviGVEsjQ58rcHNbyzcTwZL10u6oMAC0pYG+pJyLZNn91V+vcRjAN9UHsrqU0J16DX/K5ffc3eoR0Ecure1b+M4rA/DnPXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061671; c=relaxed/simple;
	bh=JeJtrJYP14haTBAvSSoeGgTEideRd3CraAXWHiFMcnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi/QFRaQLmUjxKSI/+IQ//GDlL6Ru5Z0JMEPH/I44QJHOODR4KpREpuoU89DKuPvYbGWPBCYZatxgA7/I1E1qvAOa0apUnR4bXFbyVhD/mz+pt5tDFr03+3makDZaFLuP3NsLW35oK+scgDWJcvcO6yOCNUjP5ungUiaNG2q20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oLQ+2E+c; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717061668;
	bh=JeJtrJYP14haTBAvSSoeGgTEideRd3CraAXWHiFMcnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLQ+2E+cQBx2k6JhXRhzsUjR6utDpVOzpOFCPfimc3nrmaeu+SHjrs1eOCHiQqC90
	 3FAPBPC6jcERo1CMU/KAqZaKz3RnKLcAp55KVrUtIW11u+l5aUzIA4ziQAVci0YEy+
	 e6CV5aQDJV7EHbZdrNaTV88onPAXsn4vuu64DT5GHEIvGE5ebajcKsVUnfOBYJj0tS
	 ZlO8j00zOZKCltDB57V8G2RCeXXzXTwYm4g+F2BgI5CLkfh/yJFRzAp0BzloZQaebr
	 nfnqSlsEqOq+xofabVMlLoklVdfNjbkcutOBJmN+RXmbKzenCtGcGITzHIP67mA9HE
	 RCuG9HH5bpt+A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EFF0837821AF;
	Thu, 30 May 2024 09:34:26 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	marius.cristea@microchip.com,
	marcelo.schmitt@analog.com,
	fr0st61te@gmail.com,
	mitrutzceclan@gmail.com,
	mike.looijmans@topic.nl,
	marcus.folkesson@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 3/4] mfd: mt6397-core: Add support for AUXADCs on MT6357/58/59 PMICs
Date: Thu, 30 May 2024 11:34:09 +0200
Message-ID: <20240530093410.112716-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the relevant AUXADC driver entries to the MFD cells of the
MT6357, MT6358, MT6359 PMICs to support their Auxiliary ADCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mfd/mt6397-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 4fd4a2da5ad7..c2939e785818 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -135,6 +135,9 @@ static const struct mfd_cell mt6323_devs[] = {
 
 static const struct mfd_cell mt6357_devs[] = {
 	{
+		.name = "mt6359-auxadc",
+		.of_compatible = "mediatek,mt6357-auxadc"
+	}, {
 		.name = "mt6357-regulator",
 	}, {
 		.name = "mt6357-rtc",
@@ -175,6 +178,9 @@ static const struct mfd_cell mt6331_mt6332_devs[] = {
 
 static const struct mfd_cell mt6358_devs[] = {
 	{
+		.name = "mt6359-auxadc",
+		.of_compatible = "mediatek,mt6358-auxadc"
+	}, {
 		.name = "mt6358-regulator",
 		.of_compatible = "mediatek,mt6358-regulator"
 	}, {
@@ -194,6 +200,10 @@ static const struct mfd_cell mt6358_devs[] = {
 };
 
 static const struct mfd_cell mt6359_devs[] = {
+	{
+		.name = "mt6359-auxadc",
+		.of_compatible = "mediatek,mt6359-auxadc"
+	},
 	{ .name = "mt6359-regulator", },
 	{
 		.name = "mt6359-rtc",
-- 
2.45.1


