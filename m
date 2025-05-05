Return-Path: <linux-iio+bounces-19177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBAAAA72F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 02:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0E3A8644
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 00:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A0C3316DC;
	Mon,  5 May 2025 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWK1KCaT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E23316CF;
	Mon,  5 May 2025 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484548; cv=none; b=YuWYjNJuysXPTf3LqbvxLF4lGNvso10FSccbGEDhoYHxybWlTlHSqX8/OXE/YavYBTDlkx0wSeFLo8hRRSYFccnyKZINTqU+E6Amw/Iby/xsJJRCqZ80iW5bM8WQIfZ09CWKYtGTB7cLw+y9+9N1aPpmilUIcF3mHjH2fPiCM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484548; c=relaxed/simple;
	bh=EMHKccNZGM7s2RxOonGhG6i2hxJavbEK+Tj7c9dgsrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdZ7p0jveE+YPJ8z7LrXMdg8hOQ9Tg+oKyxc0XBX5k1VdJ5EmahxmhojTGtEgYZb5DjKSoayGuIGyRDUCTSjzN9Pzxd/y4NfL6B1Nw4Ev7vIG4LM7h8YVveoNLMaZEytpYqTgEt6jtW62AzeXuKQUATNBO5OYOZMGdWyPM9neno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWK1KCaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D043C4CEED;
	Mon,  5 May 2025 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484548;
	bh=EMHKccNZGM7s2RxOonGhG6i2hxJavbEK+Tj7c9dgsrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWK1KCaTZrAbcaNkhHJuAlCVxrI5xl4UxK8xAql4Gdzuas2eo5kGRYJdghyxC+mq5
	 bp8ye/Jhoc3AMeMqxhT6Kq8Ni6gagV75T8iRAOWBAgyCgQCbZTQczNFcP226ZluDWl
	 qQpzRjuRnZo7IKbmyP598eHfWW4L2tSFZ41/lOeCbRPxsnq7BiJW5c1Zl9PLCv51Y3
	 oSkW5LNqw/WITTUDCLyVls73vMpFFT4RPh0l3A5DnXypzoanvUYyV3zwcznCWwQACY
	 2wOMtEcknhw/mqTduy84C2ex86t6tfEuSHNX5T2vbPtmCwJSac77opJzgIVhbjA99X
	 ejCYBsiGdOVDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 530/642] iio: dac: ad3552r-hs: use instruction mode for configuration
Date: Mon,  5 May 2025 18:12:26 -0400
Message-Id: <20250505221419.2672473-530-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

[ Upstream commit 21889245fb538123ac9968eea0018f878b44c8c8 ]

Use "instruction" mode over initial configuration and all other
non-streaming operations.

DAC boots in streaming mode as default, and the driver is not
changing this mode.

Instruction r/w is still working because instruction is processed
from the DAC after chip select is deasserted, this works until
loop mode is 0 or greater than the instruction size.

All initial operations should be more safely done in instruction
mode, a mode provided for this.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-6-979402e33545@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad3552r-hs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 8974df6256708..67957fc21696a 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -137,13 +137,20 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/* Primary region access, set streaming mode (now in SPI + SDR). */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST, 0, 1);
+	if (ret)
+		return ret;
+
 	/* Inform DAC chip to switch into DDR mode */
 	ret = ad3552r_qspi_update_reg_bits(st,
 					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
 					   AD3552R_MASK_SPI_CONFIG_DDR,
 					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
 	if (ret)
-		return ret;
+		goto exit_err_ddr;
 
 	/* Inform DAC IP to go for DDR mode from now on */
 	ret = iio_backend_ddr_enable(st->back);
@@ -174,6 +181,11 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 
 	iio_backend_ddr_disable(st->back);
 
+exit_err_ddr:
+	ad3552r_qspi_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				     AD3552R_MASK_SINGLE_INST,
+				     AD3552R_MASK_SINGLE_INST, 1);
+
 	return ret;
 }
 
@@ -198,6 +210,14 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/* Back to single instruction mode, disabling loop. */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST,
+					   AD3552R_MASK_SINGLE_INST, 1);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -308,6 +328,13 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST |
+				      AD3552R_MASK_SHORT_INSTRUCTION, 1);
+	if (ret)
+		return ret;
+
 	ret = ad3552r_hs_scratch_pad_test(st);
 	if (ret)
 		return ret;
-- 
2.39.5


