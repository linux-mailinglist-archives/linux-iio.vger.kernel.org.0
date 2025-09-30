Return-Path: <linux-iio+bounces-24590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F7BADE9B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A97380A9A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE0308F31;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riMJYDST"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA933081B7
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=AvNAnHpT9DCHS5ZQoSCdy/CdYwgAFkxrm4YTztVYQnthte/57IBLUEBPEPyxwB67Lnq/SuEY1BJo4swyv4Re+e9roqwb9C/gMohwKSdWxxDp8KRfgM2yhSkj2HgTQZKoa4pDtAXbCJRt6ir552+c7If2+VqGAXKOjH/Gm9Aua2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=y8ttHeKvDMmeyYg+h7xAT6ORFoQvuL+2vvytshvtqf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZygRx7hwdHTAD94PKw1vIu2Cfzqy1CK3dVP9Geli07l4dmIQxjQvqsGSkJWUtATNLwseaJXzeixFyhKn9dx/eg1/q1yO8OdQuHGWPIKN47iZ3OGMP+7Eb8cgN6gbcL97eRvD7NXWzzE4UFwDC7Tw85ZtqUfFIpclBvuUEQNHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riMJYDST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17EFCC116C6;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=y8ttHeKvDMmeyYg+h7xAT6ORFoQvuL+2vvytshvtqf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=riMJYDSTEj8YSqugJ7eiTMjuq5Quku73gnunbuBslJnkDYON4kQOhU1ZDPfaFVSPu
	 iaiNRO9AIl97D078ji4pwGkOyLn02t++BwT5npq0Pv244CzJguo1VFDeWePXYGjCVs
	 1knij9QrIGFi+ak2dl5MuQOq/cK5Lpmh+2qiy4OQ4qiDBI0pQKkdAX0YlOkXSXWqEt
	 B6414IPQluRByeN83212iqR38PjeI/QogT92v27l+GIzI3ZN9PRs82gn9OecnZvxDu
	 zTa4EByWb3g0XraSL/ygbQW9SgHM6qN3n9iuphkde4QOn2vBSdsw5RjHpDAZwLwdiy
	 SO3FiY5vg9+jQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E09CAC5B8;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:10 +0100
Subject: [PATCH 1/9] iio: adc: ad4030: replace sprintf() with sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-1-5d65d096a952@analog.com>
References: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
In-Reply-To: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sal@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=936;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8oSpf8r5jwGofADc7uyuWm6zvYPITgJxkrmhRQeFNVw=;
 b=YvsETcKc0FyfwIW9q42+ruD7MI2LXA8AQsvBfAfIKPHq0U5ERtdYkzgKTFO97ieoaonc2C9mT
 rv6RbuR/aOuDK+pxAyySV9lQNy4dV9Evd/WfWrV8PGhEVjB6GqOCCM6
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the ad4030_read_label() function to use sysfs_emit() for generating
labels.

Signed-off-by: Nuno Sá <nuno.sal@analog.com>
---
 drivers/iio/adc/ad4030.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bc2f9a2247081e166680232aa6d4aebc5f41b89..4393160c7c77981729d8e43bbf1aa573616e4d40 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -852,8 +852,8 @@ static int ad4030_read_label(struct iio_dev *indio_dev,
 			     char *label)
 {
 	if (chan->differential)
-		return sprintf(label, "differential%lu\n", chan->address);
-	return sprintf(label, "common-mode%lu\n", chan->address);
+		return sysfs_emit(label, "differential%lu\n", chan->address);
+	return sysfs_emit(label, "common-mode%lu\n", chan->address);
 }
 
 static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,

-- 
2.51.0



