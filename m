Return-Path: <linux-iio+bounces-8272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511CC949053
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C693283726
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56B1D0DDE;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY1jWFIh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DB1D0DCF
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949843; cv=none; b=Jh829twmke0EqD9B1cGUoH9ocpakxrhrhBp2uiZKk7jyTAQWYsHjEsMV+4ZV2XVwQCwyq8TW1fsi6slTpyA4wZUoETYQHOtdQFo0LkpV03hqadmxg5oU2i2LoJO0nqql1/1q/nwyyUHSn21VM2g/ad3lVLHjSRy9kcundjFzoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949843; c=relaxed/simple;
	bh=nfxPSXplyGVnflmFeS9tVUFmre4uy9WUcl/Fa2uMweA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LS6u9BJZsrb0bm7pXjhJOZl1LU6o8rQzSbAS/nOVRpFNsiubZbDvnKRqhueERi9AiTc28rWlZg7Orr5wNF1Z+qRUDrgvE+cMdNjLOBbCSDJlPeJARrHxaTrZkwffSMy5RtxfY8EW7GZ862loJzj7yadFNIBg8k9KAL3Xnq3OzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY1jWFIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D4CC32786;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722949843;
	bh=nfxPSXplyGVnflmFeS9tVUFmre4uy9WUcl/Fa2uMweA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QY1jWFIhOmFWaTN6S4MwXFAGsmDOi0Qg7Z72WF0u9oi7iOCM9S6bB1wlNNtowbVqk
	 zotiwCCCWZcgc0vtGpY/KLHQTKi+sAbsEEMiG+VVDkQ28TsZE/A6vWw5xqSz42UMWp
	 ZLmTrzJYPNOFqZBI6RmBPj8Cpe6YdTcGv4dmbNp/HcILKJm+ipUDG7uK8g1Ip89+E8
	 kUMPYmo4x1iL9OVJfjGmdVT2IGesV2WQNT4vBjoGqb112zQkA9NTeoFeWpw1Gy2pdr
	 br4dbuNy+50szkLFHLUa80VSguwR2GltEuNbH3k8m1gwIV7dP1cSgVJgp2SAIVdcFa
	 YEcxYijjU9WSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F4C49EA1;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] docs: abi: document the debugfs interface for ad9467
Date: Tue, 06 Aug 2024 15:10:38 +0200
Message-Id: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM4gsmYC/x2MMQqAMAwAvyKZDUQppfoVcbAmapYqLYpQ+neL0
 3HDXYYkUSXB2GSI8mjSM1Tp2gbWYwm7oHJ16Kk35Mgiy4MLV/h73xLyueJAbL01TJ13UMMryqb
 vP53mUj6GgSxQZAAAAA==
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722949842; l=632;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=nfxPSXplyGVnflmFeS9tVUFmre4uy9WUcl/Fa2uMweA=;
 b=gDJqGvofzuYYb/rEiY9j5AE1QKY6/SGLwL4w+8qKL6ynC5lFJw91Yq6X36c4oiCjErN4GUf7F
 Q5tdVrMQLG0BLWzYnEzd2twibzsMXUAn35pTxlIub0jYCR5pZIM4gGj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes the follow up for the ad9467 debugfs interface. While at
it, I realized there was no entry in MAINTAINERS for this driver so the
first patch is about that.

---
Nuno Sa (2):
      MAINTAINERS: add entry for ad9467
      ABI: debugfs-iio-ad9467: document the debugfs interface

 Documentation/ABI/testing/debugfs-iio-ad9467 | 39 ++++++++++++++++++++++++++++
 MAINTAINERS                                  | 10 +++++++
 2 files changed, 49 insertions(+)
---
base-commit: 593737c18ae789dc6e4b493510a0c00977972e2e
change-id: 20240806-dev-ad-debugfs-doc-90d6b64d01b8
--

Thanks!
- Nuno Sá



