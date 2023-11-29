Return-Path: <linux-iio+bounces-487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E77FD776
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60111C20A11
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043991E500;
	Wed, 29 Nov 2023 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE0chdJm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B31DFC5;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C255C433C8;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701263128;
	bh=HLyE4DFjg0ktNNqTQcSgMBS1cvWJrNgCeheSB7P/8TQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KE0chdJmgDp9ZigoQJ2TFryVWuKukqKZ+ErZf3IlziXg4q1Fygxeml2W51PY5vhNk
	 yuCnB9zFNePZFBOD52L+sTWZwktBWS8J14btR21OdEDJ7qRj7i4NNn8W/QRCHjfovR
	 /ToLiJxeURcX78hnzX7CzAlw93M1cy/Rj5Ms4wBoDnygLL71iwzWs54sLl8YB7X3Oh
	 a8WKmHMZx/5WBz2+3uJlFUq3ltruxsrjdEMiK5aZYEBUaUZORC+O+xUSi2G7YY8wq5
	 eFHGcZVP4whr8rvslydOu9jao+HM2H2sMjqoIf6yNwjmyBJbciADGGDEMKORrrXOi7
	 ay4wnOU8fVu6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D9C4167B;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/2] iio: dac: ad5791: Add support for controlling RBUF
 via devicetree
Date: Wed, 29 Nov 2023 14:03:51 +0100
Message-Id: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALc2Z2UC/x2MWwqAIBAArxL73UJqKnWV6CN0rYVeaEUQ3T3pc
 xhmHkgUmRK0xQORLk68rRlUWYCbhnUkZJ8ZZCWVENLi4LVtBC6cNc2YjjME1MZ4p41UtbeQ0z1
 S4Pvfdv37ftApwfxmAAAA
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701263126; l=643;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HLyE4DFjg0ktNNqTQcSgMBS1cvWJrNgCeheSB7P/8TQ=;
 b=PF3K4AADVjxejkG643HZzUFSIwKaoOI72SmpbsCHZ9FEy1h0Skr/l+9fOlpTR9zx4Vaz13QbG
 PZFXzSINkszA8wZBxEu81tfcBgnTULS/6bKKReAut2P4wvzU6Nk16zy
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

Simple series to add support for an external amplifier to be connected
in again of two configuration.

v2:
 * removed .yaml suffix from commit title;
 * Don't use commit/patch in commit message.

v3:
 * Be more imperative in the commit message.

---
Michael Hennerich (2):
      dt-bindings: adi,ad5791: Add support for controlling RBUF
      iio: dac: ad5791: Add support for controlling RBUF via devicetree

 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
 drivers/iio/dac/ad5791.c                                  | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

Thanks!
- Nuno Sá


