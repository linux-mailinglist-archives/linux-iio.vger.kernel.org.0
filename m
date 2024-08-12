Return-Path: <linux-iio+bounces-8413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0C94E84B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 10:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122B91F2494D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF1D167DB7;
	Mon, 12 Aug 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD+NAi09"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE84165F03;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450397; cv=none; b=NGE3qsdBaLc2s+8Mh5YlrT7/WhH3Yf2IJ/QE/cm7QJumlLGhAt0eCUGZNAVPv4jfwHsgroVVwzLSnvDyDxy4GTMNLGSn6mSqrosr+/rcBuW4QYmX4GXxB0Y+6HRaHhwOJ/OcTa2BXTmPkt+OUJYKaoDganSR3uY/eeaYkbYuKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450397; c=relaxed/simple;
	bh=l2cMsMW6WjSVkxY7LiRh1xYBXXYUhNx5oNMkZpw0QAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LxHFV+uSG1A/ZPEDpvmmpST9+RvzOkpqnIYRxIuysYTs3apN5fGXdWb0MwJFhgj1FkRWQiWk7pjObglVVhQjMd01ACfuT56l74bqs+RWcRJxLjgrdSxJNqr1LSJZAIlA3+ZVcYNbDyYzLhq6hcCdGR523EqAaDKTInWZurw+BJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD+NAi09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79B6AC32782;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723450396;
	bh=l2cMsMW6WjSVkxY7LiRh1xYBXXYUhNx5oNMkZpw0QAc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=vD+NAi095Gv177RzLA7qhHmLkQKUhEND5IZ8mch/fwpbjCxdRM+yU38jIoUbnhyTl
	 H3dQ0n9ezfm3de4n73UwDVDjHt37jQKURP3UfPl0H89TaPb64OBJSLLJJaCb8ddR0s
	 lbsrpXmWQaEjhOMD5RdwPZEmqP3PfoP5Tu05xrCL3H3USPQvw6HfHl0R4mqH9UExoU
	 JVFq5etSZnoLuLnA3UOsOhc40VEn9EE/JVMj4lL5yjvNe5MLGYRXQjmy67kr6oBV2B
	 2UnIJuWazxqjgzrEQ54LH39kDr84uSxmDzQfD/IFVKTnlPD92x7g2003b8KS5oP/X7
	 fn26jkigf25lQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E0C52D7C;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v3 0/3] Add support for AD4113
Date: Mon, 12 Aug 2024 11:13:13 +0300
Message-Id: <20240812-ad4113-v3-0-046e785dd253@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABnEuWYC/1WMwQ7CIBAFf8VwFrMsVFpP/ofxsKXQkmgxYIim6
 b9LazR6nJc3M7Fko7eJHTYTizb75MNYQG43zAw09pb7rjBDQAUaK06dEkLylmgvnWsaVBUr51u
 0zj/W0OlcePDpHuJz7WaxrO9EDfqTyIIDx07K2mlAo9sjjXQJ/c6EK1saGX+95uvh4pEGI0CQc
 OrPm+f5BVsPcCvVAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723450395; l=1967;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=l2cMsMW6WjSVkxY7LiRh1xYBXXYUhNx5oNMkZpw0QAc=;
 b=Qqh+HVkYK5/X4HNJyiP/mC68JLfIhLLtXLvFwceSn08y87V6PWDUqBFIVj3GQcWCdZoZkfmsh
 FlvUvCKSp/4Bf75fAjsV1tM5M0wH6AX1juyG6DVyPDGgNUJLipkgo93
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds support for the AD4113 ADC within the existing
AD7173 driver.

The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

The part is not released yet and the documentation is not public.
Register map is identical to AD4114 besides the lower width data
register and the GPIO register.

Particularities of this model:
- 16 bit data register
- no temperature sensor
- no current inputs
- input buffers
- internal reference
- external reference REF-/REF+
- no second external reference REF2-/REF2+
- no AVDD2 supply
- 2 GPIO pins with config bits starting at a higher position in register
- 8 VINx inputs with voltage divider
- 16 channel registers and 8 setup registers

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Changes in v3:
- lowercase chip ID
- add patch to correctly order chip IDs defines
- picked up RB and ACK tags
- Link to v2: https://lore.kernel.org/r/20240809-ad4113-v2-0-2a70c101a1f4@analog.com

Changes in v2:
- correctly set realbits and storagebits to 16 in iio_chan_spec
- describe bindings restrictions in commit message due to lack of
  sufficient diff context
- describe model differences better in cover letter
- Link to v1: https://lore.kernel.org/r/20240807-ad4113-v1-0-2d338f702c7b@analog.com

---
Dumitru Ceclan (3):
      dt-bindings: adc: ad7173: add support for ad4113
      iio: adc: ad7173: order chipID by value
      iio: adc: ad7173: add support for ad4113

 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  3 ++
 drivers/iio/adc/ad7173.c                           | 38 ++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)
---
base-commit: 1c61e13d7dc9003662bd7fd6064dfea67e64b014
change-id: 20240725-ad4113-baa63ff99245

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



