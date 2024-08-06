Return-Path: <linux-iio+bounces-8270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D48949051
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FF81C237A6
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D41D0DD4;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ria0XFa0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B741D0DCB
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949843; cv=none; b=nXGw/lOFhtpbo62OJD+3K7Jhx8U3eS5Gwve8zbON7SRC6IGEzC4bi3guSPu1uAWCDkupZ+IafL4Wss/DeRWjTAasn9WG12GLrvyzo9Ug3Ww+Syys0mIc4oACBKq5YeR+uvChQRqHH5PHMMUFn0Nw2v1cjH6J7BIj+Z5COkVdQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949843; c=relaxed/simple;
	bh=iw++Tw0yTPibuWJy8aCLmBVxJIQ0ExZhg41xhJEYIck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbsaVDglMgyzjrWdpLHQ+fYZ4x9HfuIMc3R3kZPzFGchj+pF0BUcRvp8kEOSv9PYerm3RunME+9sgYIipi3b2G/OzveUltXSDDrjP+hzCAIWLgexaap5YaJWnSii9A+cqDpVVPUCZEmUk0AsqaUuVAWGg6s0dgW96NB4lwD6An0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ria0XFa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A135C4AF0C;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722949843;
	bh=iw++Tw0yTPibuWJy8aCLmBVxJIQ0ExZhg41xhJEYIck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ria0XFa0WbPPZcRFnRMCRoy2JyjsBERVDCFwZZDFJldKopHs6H5jE+/Vz+ISINcuu
	 FqhuQCmlMkst27Dsb0cMCDblxEuaOfTwfQU/qbOXB3NQRxsmybAqpXbjmK9oFwHBK9
	 sFgQsIFYOizoeYfgrcXUUobwd+aylnrxaEgZFOyzrZOW4QvYEmwqBJr/LLtz1hEP54
	 hNvcMRmXdoGFrmEIEG5g4mhkNuFHhWVmO1/yvHOSgFvBZ/zyFPdJDvAIMFZBD+kHuf
	 JYNDgPRWkilhgIjWalKfaA2PyZGUIlAnZdYoFmIRYmYMXhuY6W4N+AWwmMPoXAyfHj
	 eOYt/FVoX6e+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A983C3DA64;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Aug 2024 15:10:39 +0200
Subject: [PATCH 1/2] MAINTAINERS: add entry for ad9467
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dev-ad-debugfs-doc-v1-1-153b882a3f01@analog.com>
References: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
In-Reply-To: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722949842; l=910;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0ISwLenbTtN0B41a+pby8UWaWMuEWdaKv5v9O1GxGtU=;
 b=okf3f9JUB/Ef6s9yeST9Y9jgl9t5QHFk85dbdtiOy69+nywBPFvGxXDcf2RCRo6708Tkk03Tw
 Wcy93qK/QPeCKBuKnx8OXD1+z1q1skXjw/eCwwQDcv1wKYg/1FFNDFg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Document the maintainers for the IIO ad9467 high speed ADC.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2708a9e9fc95..ff62a4c2ce9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,15 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD9467 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Nuno Sa <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+F:	drivers/iio/adc/ad9467.c
+
 ANALOG DEVICES INC AD9739a DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
 M:	Dragos Bogdan <dragos.bogdan@analog.com>

-- 
2.45.2



