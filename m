Return-Path: <linux-iio+bounces-3944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D581892CA8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3781C21469
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661753BBE3;
	Sat, 30 Mar 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVATFS1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A53BBD8
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824816; cv=none; b=GbU3V6LM7FQJO3yWZy3dT0HcXlPAo3l4FKQ5Sa0U40hSuggu/B8Z6fDWxyfPateVx+OMI5O+2UlAkfJD/WSMfLo29hkxUSQFlcxNi+JgtMXY+xyeH2oKpSxylV8ONvAdL0bu2iXb3XdTsh2aDBH/LnsDe5xkYDBxvZZPRIVdaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824816; c=relaxed/simple;
	bh=PSB86HBqhFM/Jq33fgYAZAnTAFpcofY1CqBhWw+Va8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPDqEEMcSFMFXKuigEWfB9obQ1ke3/TgFhLegI7AGxZNTRMiSoKWSumCC7onDL83C0jRIjc2b0Z1NPDqtqFL6Mku6+Q8qyS4LYPpkgr4hIYQkr+QAh3FzjqdgpI4eQDjfcOM83i25spFnTqHaddeobJ9X16IhMotafad+QrJqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVATFS1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A2CC43390;
	Sat, 30 Mar 2024 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824815;
	bh=PSB86HBqhFM/Jq33fgYAZAnTAFpcofY1CqBhWw+Va8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVATFS1Q+iIuiZK2V/CYsMnJh1zPLPVNiaZTOwyC6+ymdgVl448jBvymVyvEd96p4
	 5AJNVKIviuwSvdZYRTYL09wyZM1iL2EiV0h51TL4xQmn6yaa+ypME6b8HeheipJCOx
	 PHe4kFws3Q0NfiSp0ThfM5ze37RZKI5320xoVxforPrRPoLXoXr5XXwV/5PEPRnNgx
	 oJ0uRueSk4oshtl4NpxtWTlIy5gaGyFgKbbz4dcu43QsPt8Yz0LMcUlryO81Hz4kcc
	 9PZqYwOU5lLdnNXEqWqb7C0yraYYNGcZOAfcNFUBrgYGHMdn9MrKQXRSoACFyfibSs
	 QeU79dPgrkY1Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 3/8] iio: adc: stm32: Fixing err code to not indicate success
Date: Sat, 30 Mar 2024 18:53:00 +0000
Message-ID: <20240330185305.1319844-4-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330185305.1319844-1-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This path would result in returning 0 / success on an error path.

Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Fixes: 95bc818404b2 ("iio: adc: stm32-adc: add support of generic channels binding")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b5d3c9cea5c4..283c20757106 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2234,6 +2234,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
 				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
 					vin[0], vin[1]);
+				ret = -EINVAL;
 				goto err;
 			}
 		} else if (ret != -EINVAL) {
-- 
2.44.0


