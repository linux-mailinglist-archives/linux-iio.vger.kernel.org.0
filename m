Return-Path: <linux-iio+bounces-5152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396F8CAA3C
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15AA2825CE
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05057C8B;
	Tue, 21 May 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln6CGcZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9954762;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281187; cv=none; b=cssZ/JusrEpdhr13GbWkpYcFu1XJsDKTYcwK6XLLKBLR+rwkvVpdH96OEfNulPcdEDytnWzUsbS0lwkQ4J//Wl1msBQMw777oq/B02bk0RdPQgJd6so0ljQFLudwhDsQozyL3q9B5CKvk/demw+G6MIDKIvHHsBYhI+T2bb1LTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281187; c=relaxed/simple;
	bh=Sg1hOu3VEG/1Zs7niRX5/Vpq317beg+1Hh4A8ALk38o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Il+ZI1rIk8rEZylS4BRBFSfRWzjkPBYyJJyqPh6T92K1zWGkL/U9xsFh/yTOpe5qHbowowEF3rW9GNkqI/IonBZJ5+KZ4LglI5NZGv3vfHfvsk/gck8LGbwhvR5tn10culmCT9JGUqj//oiT0bozJvED+5NT8YezmLf4btRNtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln6CGcZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96BB6C2BD11;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716281186;
	bh=Sg1hOu3VEG/1Zs7niRX5/Vpq317beg+1Hh4A8ALk38o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ln6CGcZQzc1GKgQ4HlgoTu0kz0GaPTuTl+P5P4NdWM1lvTg4Tk3u7pP5oFqye1DzE
	 h8rE02EMWFkO6LMD+AMCp++Mm8HhmRtD7T49uKnjkS+IyeTEpLD8CjS4Wbk/MorLV7
	 Ap5b0hru2ivRrNteCdL8rD4lQn1TNyOTGVnFpTOggYJKYz613hE7gEVdsKzUxE1Lwx
	 KCH9LYqycSorzYboVD5VssJ/9j2m0gVv9kT9I5YgpdJI5Gp1gZ5feJd6xHvwJhSBTW
	 gCDTWH2MB0fVBzGsgGTwSmVLH9EaMFw8/42e08gvAPj1T1y3yMBHxvZswZmKJFbvLG
	 hFi/lJ0VjKU2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85770C25B75;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 21 May 2024 11:45:40 +0300
Subject: [PATCH 2/3] iio: adc: ad7173: Add ad7173_device_info names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-ad7173-fixes-v1-2-8161cc7f3ad1@analog.com>
References: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
In-Reply-To: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716281184; l=1300;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=jyW8M3kG3uqXuCNPYLLJGiYuxqeZCfGKeCCNwqrSJqE=;
 b=Qi+Gg8NzEB6txHrrc5xq9qpomyYuIB/fwhw5Ey4aBUrFryLQvyzR4wrPX4O/jhXotcFw9tZxk
 QNBYVr0Lf4NDH4iaPJ95sy4DRlrIsbBiaKPIB6IPtPCKSJI6LYV/rxo
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add missing names from the device info struct for 3 models to ensure
consistency with the rest of the models.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 850574437bda..58620be41ef5 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -220,6 +220,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
 	[ID_AD7172_4] = {
+		.name = "ad7172-4",
 		.id = AD7172_4_ID,
 		.num_inputs = 9,
 		.num_channels = 8,
@@ -262,6 +263,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7175_8] = {
+		.name = "ad7175-8",
 		.id = AD7175_8_ID,
 		.num_inputs = 17,
 		.num_channels = 16,
@@ -290,6 +292,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7177_2] = {
+		.name = "ad7177-2",
 		.id = AD7177_ID,
 		.num_inputs = 5,
 		.num_channels = 4,

-- 
2.43.0



