Return-Path: <linux-iio+bounces-5697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B998D8731
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3835284109
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369D137902;
	Mon,  3 Jun 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng1tRoRy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA3136E2A;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431794; cv=none; b=XAztUgY2maSvZ/5FthI5AtbazHw0xZxaN1TCZh0gYzKuAquVye0b5wXI1LO700cIkEv5PyaX8SM8VaRSmzLvvXviQXw41TwXhimWDDVFWVi3/RHLWhpAPPCqUqjMguH6n7UIIgkWszM7W52CirUTcPkiEOXOjinr3KBigbz9mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431794; c=relaxed/simple;
	bh=PU9CGgziLdFhXBzpFlmp5+t+whnb8pPpl3fL8FrJUo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvMUh83+P7EZZ/pu1tqxT6td2bb+7mvlw1tqfj3PJcU0m5swnrrJ0HCVlv2PJlYNJb6rSIC3uBdZ25U3PDSCg0x5ePexbo0IOAWE47tbiOq5Ngi8qPzGgVsxYegTipjKfw9loYki22xP8lDugNxNyV1brjBulasLpffN39tqEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng1tRoRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5093DC4AF54;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717431794;
	bh=PU9CGgziLdFhXBzpFlmp5+t+whnb8pPpl3fL8FrJUo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ng1tRoRyka2FVZyNJvgc3anQzqOgKLIDFNUkdNTF36qiJ7xopmPobAcVEez0wvfpW
	 co4Cjohy8y9f2RxLrR7WafYLdCfjUzb+THYxP+Slin/J5QFJUC7dZEJ1JGc+r49hal
	 MP90JF1SH3eGv4SHrYTDELosLXvgFcr355H6aYLNETA1e83K2xPc1UdZxe088wFm+0
	 vNtN3FmKyOXLstfA+4rKH54UIqOKOTqJbK53swurpN0gWtv9rCry4NDAIkLUZNvP2s
	 iYH94Kq4f4Md8zp0ql7hTfh0xJqpGYtK5tvbmlIo2Rk/gaXWGh9kYfLOy9VxFdj5Rl
	 DPvOCAHn5MFuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4AC25B75;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 03 Jun 2024 19:23:06 +0300
Subject: [PATCH v5 8/9] iio: adc: ad7173: document sampling frequency
 behaviour
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-ad4111-v5-8-9a9c54d9ac78@analog.com>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
In-Reply-To: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717431792; l=1618;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=2nPfloQlqJU5+9wFX+IL8WDN+iCUelg+ZAepCt2X+L0=;
 b=SsK8XFss3iJYziP1y5sS5l3QzebH9uY+AORf8T9s/7lhH8rpA6oEnNUH1DfBCn/Ic65KvcZWb
 jZ+cb59m+lmBUzYSlGSJ9TGhySH/gYyl04gwy6fYROu4F8rXClT5uUx
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

The ADCs supported by this driver feature a sequencer that read in a
loop all the enabled chanels. When setting the individual sampling
frequency for each channel and enabling multiple channels, the effective
of each channel will be lower than the actual set value. Document this
behaviour in a comment.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 5ade166814d7..fb18acc83f39 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -742,6 +742,21 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (info) {
+	/*
+	 * This attribute sets the sampling frequency for each channel individually.
+	 * There are no issues for raw or buffered reads of an individual channel.
+	 *
+	 * When multiple channels are enabled in buffered mode, the effective
+	 * sampling rate of a channel is lowered in correlation to the number
+	 * of channels enabled and the sampling rate of the other channels.
+	 *
+	 * Example: 3 channels enabled with rates CH1:6211sps CH2,CH3:10sps
+	 * While the reading of CH1 takes only 0.16ms, the reading of CH2 and CH3
+	 * will take 100ms each.
+	 *
+	 * This will cause the reading of CH1 to be actually done once every
+	 * 200.16ms, an effective rate of 4.99sps.
+	 */
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		freq = val * MILLI + val2 / MILLI;
 		for (i = st->info->odr_start_value; i < st->info->num_sinc5_data_rates - 1; i++)

-- 
2.43.0



