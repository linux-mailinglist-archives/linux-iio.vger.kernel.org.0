Return-Path: <linux-iio+bounces-5754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699188FB23D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0945F1F21A0D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A231465A8;
	Tue,  4 Jun 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dr+rYusL"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74329146A92;
	Tue,  4 Jun 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504223; cv=none; b=HLx10/qk68hA4aQwDI244mVTfc/8YmBC0eDkZLt7FYyC6/MnZN8dDZ/oQ/IJ3NVCHgqOso5MlLR8S0lDRwZJ1NpU1juHUyaugFe+LKC+4pPjHy1NlkVPhJEf85CmGq+JgdovNIjs2A2JoN4jv31uDDhPchBeqbLJCi+2DU50odI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504223; c=relaxed/simple;
	bh=fKt22plDiq37Whi44C+GK1htAfZF0xNWBNbbUorI/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6S05YZabpfMQJSgd0qVyJc2e3r2X439gmM0El0862/FSWXdvW1NvkFwfxnGVpQ/vgJtvAVsyJAllVRf7UXY5IADGXqHMOEWqp232SnoQe0PZLxOrq5yVZDIHCRtrkVN31HEB0modzfv6RkzSjrOWCUQXAlfOA4ElxMen1yAfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dr+rYusL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504219;
	bh=fKt22plDiq37Whi44C+GK1htAfZF0xNWBNbbUorI/T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dr+rYusLTtwGNRBZguQ9EKPGnhZ+NuVPaiSMHOrJpK4YD64f3Q8l3vuuwXW9d8q5o
	 6RINkfBJMkI804Ou/Xx1be0VIhtVKk4mz+m0IhCep/uLczfgFh0K15z6nPqXt8SLZ3
	 eXZA7LZ57VV3N3ZQz5o6hSibqOTS6XIYRFjTMp7MfeG/MiVmXkHL5YQ+HGkifqmadS
	 wKnWFw3pXdlK8bZv1dgFH+ZAtBNsklJ/aLXXqVoE2zSfMKbSH54eYAAlrJ1v6DWHzy
	 yJJ5HDBkvfgSmir6aXWG1AJMgB6bbwvrjHNkMCGdbFD3KLj6ODAcZ4BX07o8m6YWAt
	 8B2RftNyVDnFA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3A78B37821F2;
	Tue,  4 Jun 2024 12:30:18 +0000 (UTC)
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
	andy.shevchenko@gmail.com,
	kernel@collabora.com
Subject: [PATCH v2 3/5] math.h: Add unsigned 8 bits fractional numbers type
Date: Tue,  4 Jun 2024 14:30:06 +0200
Message-ID: <20240604123008.327424-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some users may be requiring only rather small numbers as both
numerator and denominator: add signed and unsigned 8 bits
structs {s8,u8}_fract.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/linux/math.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index dd4152711de7..f5f18dc3616b 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -112,6 +112,8 @@ struct type##_fract {					\
 	__##type numerator;				\
 	__##type denominator;				\
 };
+__STRUCT_FRACT(s8)
+__STRUCT_FRACT(u8)
 __STRUCT_FRACT(s16)
 __STRUCT_FRACT(u16)
 __STRUCT_FRACT(s32)
-- 
2.45.1


