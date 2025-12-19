Return-Path: <linux-iio+bounces-27214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 770E0CD0881
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B4E1300CAC0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DBB344056;
	Fri, 19 Dec 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZhl4p7E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8334321E
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158053; cv=none; b=sVbEneUtax8UdnRyiP6Bf3OMk3qlY3bJN5jE2vmybOgdOxX0o1jwhQNgsBDQjyhg4qnHPkQhy9Npk2P/AoIseKBXvWEDwpc45MIKq+BN/3+vnUXgenZ9nVG6pkAgObrpH8opKtooQNeeKkO/Vw6xsY59I6wUpE7ZV06JqEsgAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158053; c=relaxed/simple;
	bh=kDT4GASbwzi4yQXRWZBEF6knm2Xzp3O0z7UDIsKWgPg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=teZGyZXtfKw03I+BtBM8da6DZHFbcTNltWFF+JZhignqPNjO29O+1aPX38rBoCkWP3PK5iy3DJ865Rh0euul/8zhQ03rPl06b/xXHiSkPca9ppOWM8T8MjceGxOckEAqKOvaBEoUdk7TPzoh2j0LUubuLLfvu3ZPSKCwI/Yaflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZhl4p7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB293C4CEF1;
	Fri, 19 Dec 2025 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=kDT4GASbwzi4yQXRWZBEF6knm2Xzp3O0z7UDIsKWgPg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LZhl4p7Ek/YlOYlwVt/4m44eecTstaTLES/+Kbq1YB2FIRiSiz1fhXOrhKW38MDuv
	 i0I0AB0LJSKAgDO8nKeHywKPthKkhfLgRJqbDKmGs2rWWTj0j5jZZ2Y8T85odmbwPC
	 aOsYbjV5jPlBC8ZOdcmJPrrH2OgGx+nBftMFKS1WVwZK91uagazYdfIalwTBpidNsL
	 oRBz86Vmnd/hR4ig5nKb4hbmaUX+6+dxr6rkICw0d9b8IlvM/knCJevn/k1kFwo0TT
	 RZmLUmS8CO5kNGhMUnJxVdlP+tBDHvLUoKMYhlbDQkI8zfCiiyS4XVlOWePIGnJykW
	 yrjHgvreMzW1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD561D78770;
	Fri, 19 Dec 2025 15:27:31 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/6] iio: buffer-dma: Minor cleanups and improvements
Date: Fri, 19 Dec 2025 15:28:11 +0000
Message-Id: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAtvRWkC/22NQQ6CMBBFr0Jm7ZjpUAVceQ/DokCBSYSSVhsN4
 e5W3Lp8L/nvrxCsFxvgkq3gbZQgbk7Ahwza0cyDRekSAxOflCKNIg67yTTPHmVavIsBKe8qzVz
 qpjxDGi7e9vLao7c68Sjh4fx7/4jqa385pvxfLiokJKsrKlpb5MxXM5u7G46tm6Detu0DoKqoV
 7UAAAA=
X-Change-ID: 20251104-iio-dmabuf-improvs-03d942284b86
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=1574;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=kDT4GASbwzi4yQXRWZBEF6knm2Xzp3O0z7UDIsKWgPg=;
 b=Dgkk/W415qIeM6iV3WycUKrnzASz1vjIQ31Fm5DCxgOUU5e7T7Fyx7wAgn1GfJDGj2AlgMZub
 kY9rS+7F5wjDLVkJ97zZZlQzbLVmXwg/kByzt/Vm9qkljFa1cy5XnI9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Small series with some minor improvements for IIO DMA buffers:
 * Use lockdep instead of WARN() + mutex API;
 * Use cleanup.h;
 * Turn iio_dma_buffer_init() void;
 * And I could not resist in cleaning up coding style.

Also note that in some of the coding style cleanups I deliberately went
above the 80 col limit as I think it otherwise hurts readability. If not
the case for everyone, I can change it.

---
Changes in v2:
- Patch 1
  * Updated the commit subject and message (given that lockdep also WARNs()) 
- Patch 2
  * Slight change on the 80 column limit when allocating the block
    (Jonathan expressed preference on that form).
- Patch 4
  * Updated mutex/spinlock comments according Andy feedback.
- Link to v1: https://lore.kernel.org/r/20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com

---
Nuno Sá (6):
      iio: buffer-dma: Use lockdep for locking annotations
      iio: buffer-dma: Use the cleanup.h API
      iio: buffer-dma: Turn iio_dma_buffer_init() void
      iio: buffer-dma: Fix coding style complains
      iio: buffer-dmaengine: Use the cleanup.h API
      iio: buffer-dmaengine: Fix coding style complains

 drivers/iio/buffer/industrialio-buffer-dma.c       | 187 +++++++++------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  22 +--
 include/linux/iio/buffer-dma.h                     |  20 ++-
 3 files changed, 97 insertions(+), 132 deletions(-)
---
base-commit: c5411c8b9ed1caf53604bb1a5be3f487988efc98
change-id: 20251104-iio-dmabuf-improvs-03d942284b86
--

Thanks!
- Nuno Sá



