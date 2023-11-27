Return-Path: <linux-iio+bounces-432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 330197FA55D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DC8B21177
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735434CF1;
	Mon, 27 Nov 2023 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D10K4wck"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A9347B8;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E2A3C433C7;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701100540;
	bh=RWA1MfbZy5uNE7PjYByBpFm3u5YncygetXyBEHWWCN4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D10K4wck8HgZEu0MOGToCVvI0aPcK3kUZrsIy9W+wPuoKhmy1RoD5Gh03BOfyWsfE
	 wCi2KunoSJ131hUnohWux8QnFNtIAlqcHqyGoSv60cLSwIEOl9dIAK5eJrat25VcdW
	 aeh3G0UkKhe1z1/FLQTx5MaTm2pmJeZG4MyjZK1eBjkp3cr8iG0XLWj+gI/79MQ+MO
	 qB0ubELQInQZO/A0yP9vP8WgqTXrzDBn/CUlI4RjkHB9sTVop1GHnKxoTM2zx2hV14
	 7KvPVtFTgpD7a/WF1uCL9qXuZj4V7VdaxFIg7MK7csLhXF4IUF7c6+IWYIYbKtYRVG
	 mWRH9H7Y7579w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B7EC4167B;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: dac: ad5791: Add support for controlling RBUF via
 devicetree
Date: Mon, 27 Nov 2023 16:55:33 +0100
Message-Id: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPW7ZGUC/x2MWwqAIBAArxL73UJqKnWV6CN0rYVeaEUQ3T3pc
 xhmHkgUmRK0xQORLk68rRlEWYCbhnUkZJ8ZZCWVENLi4LVtBC6cNc2YjjME1MZ4p41UtbeQ0z1
 S4Pvfdv37ftsD9txmAAAA
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701100539; l=498;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=RWA1MfbZy5uNE7PjYByBpFm3u5YncygetXyBEHWWCN4=;
 b=wF+TtMOnTafwOdeXZXkSVWaELUOKjAQWoMawKQtO/YLrZrvolOEYGSbOsXMTVp5JuIYT5x3Yc
 fu2asyIZeiBCRjm09EUiSrOiK38CFnlNU3qeMULfX+xvJ8nbgWKVeXf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

Simple series to add support for an external amplifier to be connected
in again of two configuration.

---
Michael Hennerich (2):
      dt-bindings: adi,ad5791.yaml: Add support for controlling RBUF
      iio: dac: ad5791: Add support for controlling RBUF via devicetree

 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
 drivers/iio/dac/ad5791.c                                  | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

Thanks!
- Nuno Sá


