Return-Path: <linux-iio+bounces-27812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A5D23238
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F22A3020FE9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1517334C27;
	Thu, 15 Jan 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkywRJEY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294733344A;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465695; cv=none; b=fjThxLitrMTqGvmsLQs7ez5GjdiM7ioLxLOUR0ZSuBNDTzDmDTMb/6CJfOJAm0+y+GMlvamC93Ux0RNyLnz9hgvaGhgdJNk/phyyf/GCV9YnrenNrhbHr4BfezYoMkes51b0UVt5dKTNdDcsInC7tqpzzdHfS88lJY7HfxHgwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465695; c=relaxed/simple;
	bh=TD0CKqKvYK6A8K4BW0oFhjlCzyxkS+4b/3agMVvwxlQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B/rfOUUIcywvNAgHRBROUFUSxiPjwrMo0j77onJIvpPvpWgEx9661bslZ7wDFkrFh1olE35+wMnS9LDYLqyPnexWf+w+ea2jfnjO/CZ+XfXWiEDKzU09CRStv3TDdRpD0umdcaVtFEfx4hzaX8ieVK1PyR7gZvm5xJ7jJe6W0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkywRJEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97937C19423;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465694;
	bh=TD0CKqKvYK6A8K4BW0oFhjlCzyxkS+4b/3agMVvwxlQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nkywRJEYkcTHgeMgF9kkmIl0mhve8xBCQteUQCFsjAQ1yp2qzwScHFN3j55jAWQe+
	 WBdAnmq3JU1+AulKMwgsQjeO3atArLVahzOMcneAZ8VznK8xYGcr/fWy5J7Jiom+4f
	 rgbRGaVoyHK2NaQfeQnwUL2EwTt6sS8AS9npzFVsm2kgqj4UR291JcHKcTZfM1nGpe
	 RnkJXVgzq+H6joxIs/X8ERw2DU/jpAKhQDvovkwMsJ8c0xGqT+H9Kqxf4Y9Y/3eNxs
	 e17YiwXOBMxuHat9p7B1VnW5eX5k0/x50A8MctrSbgrJOGnSuO6vgroatiyRkX9T8S
	 QJmrHTdnFI+tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890ED3CCB9;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Subject: [PATCH v5 0/5] iio: proximity: Add interrupt support for RFD77402
Date: Thu, 15 Jan 2026 13:57:36 +0530
Message-Id: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPikaGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NT3aK0FHNzEwOj+DJTXdMUQzPTJKPUxJRECyWgjoKi1LTMCrBp0bG
 1tQAGhsn6XQAAAA==
X-Change-ID: 20260115-rfd77402_v5-5d165b2eada8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465693; l=2922;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=TD0CKqKvYK6A8K4BW0oFhjlCzyxkS+4b/3agMVvwxlQ=;
 b=DDRfls7lm9wPJ9qaKzpoJH66SkdxFA9mAHwXnWF6MXMusz+kzW1AzOnbXLCgKgT5S9qfTny2s
 M3QkoaaxdqrBSSodzVNxv5FAF5c1uyROux27KBZqRrOipZ0FUH3O7g6
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

This series improves the RFD77402 ToF driver by cleaning up include
ordering, improving resource lifetime handling, switching to kernel
polling helpers, and adding optional interrupt-driven operation.

Changes in v5:
- Add precursor patch to reorder includes before functional changes.
- Use devm_mutex_init() for proper lifetime management.
- Address maintainer feedback on polling helper usage.
- Remove dead code from interrupt_handler.
- Add blank line in rfd77402_wait_for_irq.
- Update measurement timeout comment.
- Add helper function for result polling.
- Fix comment format in rfd77402_init.
- Remove 'data->irq_en = false', as it already initialized by kzalloc.
- Improve documentation of private driver data.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Changelog:

v3 to v4:
- No code change.
Link to v3: https://lore.kernel.org/all/20251221083902.134098-1-raskar.shree97@gmail.com/

v2 to v3:
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
Link to v2: https://lore.kernel.org/all/20251130153712.6792-1-raskar.shree97@gmail.com/

v1 to v2:
- Fix commit message for dt-binding patch
- Update interrupt description in dt-binding
- Add 'vdd-supply' to 'required' property in dt-binding
- Add patch for moving polling implementation to helper
- Add helper rfd77402_wait_for_irq()
- Code refactoring
- Return failure if request IRQ fail
Link to v1: https://lore.kernel.org/all/20251126031440.30065-1-raskar.shree97@gmail.com/
---

---
Shrikant Raskar (5):
      iio: proximity: rfd77402: Reorder header includes
      iio: proximity: rfd77402: Use kernel helper for result polling
      iio: proximity: rfd77402: Add interrupt handling support
      iio: proximity: rfd77402: Use devm-managed mutex initialization
      iio: proximity: rfd77402: Document device private data structure

 drivers/iio/proximity/rfd77402.c | 157 +++++++++++++++++++++++++++++++++------
 1 file changed, 133 insertions(+), 24 deletions(-)
---
base-commit: 40e81d379e69d6db147865eee0c89e41634e0b60
change-id: 20260115-rfd77402_v5-5d165b2eada8

Best regards,
-- 
Shrikant Raskar <raskar.shree97@gmail.com>



