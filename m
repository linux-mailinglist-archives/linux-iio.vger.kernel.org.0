Return-Path: <linux-iio+bounces-27458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA737CED275
	for <lists+linux-iio@lfdr.de>; Thu, 01 Jan 2026 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0836300BBAD
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jan 2026 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB122EDD57;
	Thu,  1 Jan 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NripT5A5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15172580DE;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767284293; cv=none; b=uKuPB+sTXMpJ6cWEU46mS8XPtA0XPZhPOkreZqZ646MYdIoOQ6gxwRjT0TdntGhl5xvrQKu45Slh4kCE67eK0VVt76Id1/4K6URa66F09zZtYIXbnauF1jchEmA68P1wOb3ccvYPpeUSNzq8evgwh1lJjZrubPusSkTyEjTvjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767284293; c=relaxed/simple;
	bh=uKMD+YVerNdxBNPgulQjVdLKZtk3V9JT3BlPXYGr/IM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aPe5Vu4XrE9JMsjqtFVmJx3DQ8h+weFJDG9ww3JHPdzVbLTIUNLdK3d6uIL5WuQFPA9RxVwprI27/S2Mt5esHHHD3RMCsmwWh83GR4AJf8CP2hVCv2kHiOPA0D7Rn3FAvJYbNjbk8WBwcrkZ3s/eKLwekDYbpQGHTbe44W+gZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NripT5A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57868C4CEF7;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767284292;
	bh=uKMD+YVerNdxBNPgulQjVdLKZtk3V9JT3BlPXYGr/IM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NripT5A5OiQXwG901sjdHBgdv/lMgAjxc074gYhOOKj+MfH1oAyLO2v1LjUc5StsL
	 yj9HHQkIV9zV2EJ8KSmrITE/MklozaD2TmQfzKX+jmNXQuUFydczV4293U20fMOniK
	 K4vZ2HlWplvsE7qLxMFuz+Yvp+rtmtX8e0rzSsPmuj5flsSLAsR8QlqoYwEf8E0VL3
	 3jjAGtRzyBaANAHb9CacEdBoRgUIvEFoBBtTpn2FGBDYQEG3mPQn4vnIW4J4+kzxSm
	 NMNr+PCSJqNuTrDcN2iYfj5IwwQpn/W8UuPjK+3wmBZPT5BZQt+LlTlJMr1g33X6Et
	 SC2E/B23maQhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43003EED615;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Subject: [PATCH v4 0/4] iio: proximity: Add interrupt support for RFD77402
Date: Thu, 01 Jan 2026 21:47:37 +0530
Message-Id: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGeVmkC/x3MTQqAIBBA4avErBMmlYSuEhGaY82mnxEiCO+et
 PwW772QSZgyDM0LQjdnPvYK2zawbH5fSXGsBo26xw47FaySFJ2zqGeWS5kYfR980sYh1OoUSvz
 8x3Eq5QNLQss4YQAAAA==
X-Change-ID: 20260101-b4-rfd77402_irq-3dda6baf2370
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: raskar.shree97@gmail.com, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767284290; l=2057;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=uKMD+YVerNdxBNPgulQjVdLKZtk3V9JT3BlPXYGr/IM=;
 b=QeBOXo7QsqTkrTgk2V4poG9kBTJvzCdU4jyE/bmrqDdzRTYLWqw/gnH3IbgI2UydC8unw7f3Q
 Dv/AMHop7ULBrKzR938Qp6AvVvcA06b0/BSEMhAHe7IYkeds5umHHst
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

This patch series adds:
 - Add RF Digital vendor prefix
 - YAML binding for RFD77402
 - Add OF device ID for enumeration via DT
 - Use kernel helper for result polling
 - Interrupt handling support

These changes enable DT-based configuration and event-driven
operation for the RFD77402 Time-of-Flight sensor.

Changelog:
- Resend the patch series as v4 since not all patches were delivered
in v3 due to SMTP daily sending limits.
- Add 'Reviewed-by' tag to dt-binding patch.
- Update commit message in OF device ID patch.
- Update commit message in the third patch.
- Replace rfd77402_result_polling() with read_poll_timeout().
- Add 'struct rfd77402_data' details in kernel-doc format.
- Arrange includes in order.
- Add comment for completion timeout value.
- Remove blank lines.
- Indent the comments to code.
- Convert mutex_init() to devm_mutex_init().
- Remove 'IRQF_TRIGGER_FALLING' flag from devm_request_threaded_irq().
- Drop the duplicate message.
- Replace 'dev_info' with 'dev_dbg()'.
- Update 'dev_id' to 'pdata' in rfd77402_interrupt_handler().
- Drop 'interrupt mode' comment
- Use 'if(ret)' instead of 'if(ret < 0) for consistency.
- Use 'return i2c_smbus_write_byte_data()' in 'rfd77402_config_irq'.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Shrikant Raskar (4):
      dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
      iio: proximity: rfd77402: Add OF device ID for enumeration via DT
      iio: proximity: rfd77402: Use kernel helper for result polling
      iio: proximity: rfd77402: Add interrupt handling support

 .../bindings/iio/proximity/rfdigital,rfd77402.yaml |  53 ++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/iio/proximity/rfd77402.c                   | 149 ++++++++++++++++++---
 3 files changed, 183 insertions(+), 21 deletions(-)
---
base-commit: d8ba32c5a460837a5f0b9619dac99fafb6faef07
change-id: 20260101-b4-rfd77402_irq-3dda6baf2370

Best regards,
-- 
Shrikant Raskar <raskar.shree97@gmail.com>



