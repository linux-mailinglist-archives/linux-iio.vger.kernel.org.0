Return-Path: <linux-iio+bounces-512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1BB7FF7F0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A612A2817AB
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242E56757;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtrU19xY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E95645D;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C69C433CA;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=UUFQFRvb1jh1J5SJLOCbZilXMNLl0hLuc7JaAaDPPtc=;
	h=From:To:Cc:Subject:Date:From;
	b=BtrU19xYVX3pBdckOdxDyK8GaLlTk1wYxcTqfXvUhjW9VzRBZtRS2tfNAdgYFsMLC
	 PYCwKyLTIdnc8Op8EmKrvFr9qvgoHJE/V2rO0eM84kpIA33vagLfzAoetHuPL6SPV1
	 SYYL43iE5P3R/ssgzzN8B1TRWMU4qjanMS+xh2RYVIXDeQrrvGkYkKqAlZuCG4AX8k
	 uWjPbG3bAoVk3k7CAnOckVheVck8psHKCn8x1r56iNI5uJce7EFMY9Ni+StnXeJFOv
	 MO7OvFK2ydYj0kawDp6WbEDesPEe4TmTbmdOE8RljXlX4uZt+518W2o4K/rv+1/z0O
	 pHMtqQSgU208w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfF-0003Ce-1w;
	Thu, 30 Nov 2023 18:17:26 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Date: Thu, 30 Nov 2023 18:16:22 +0100
Message-ID: <20231130171628.12257-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reviewing the various SPMI PMIC bindings, I noticed that several
examples were incorrect and misleading and could also use some cleanup.

This series addresses the iio/adc ones.

Johan


Johan Hovold (6):
  dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
  dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
  dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
  dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
  dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
  dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples

 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml    | 10 ++++++----
 .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml   |  4 ++--
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml    |  9 +++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.41.0


