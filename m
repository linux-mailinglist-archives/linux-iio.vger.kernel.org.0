Return-Path: <linux-iio+bounces-15723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B03A39977
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 11:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5513BE4D1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BB923C8AB;
	Tue, 18 Feb 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwe1u26+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD212343C5
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874691; cv=none; b=qbELMpdbRg13vIpimcqYcHCczjWGZJeUWPm7uFm7NSepxDfB1LAJLL2fF7nzuifJ27gS+vLJ/q/ZU7sGyOqYPjof9++iHt99er6zg/OEQI/EDAhJRm92PNTL+6o0dUQUDILQqx+EFGWNsEiS4O+RAzt9DTlgsKeYpO6nBTnmR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874691; c=relaxed/simple;
	bh=CKIe0qJhJkr78+nRNyahW/0Imlybj2XSKCQoyCG9RZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JNkHtELAOVAYLAdqORPVTU17rYzAKXWfV4ESMrmIL26mO7kLGlpw5C/WUSA40RdsEBpT7lV1LfSE29mKviLoHOMk0DUrS67w6mm6Xswr5cP5ohjgnyZo1REw5ciDgUOUOGq+Tf/sDw4ehTqwUYnIOH1EuPd1Ygd03xpQyJprIKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwe1u26+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA1C4C4CEE2;
	Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874690;
	bh=CKIe0qJhJkr78+nRNyahW/0Imlybj2XSKCQoyCG9RZc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cwe1u26+dC0W6/FkbwZuNI2HptzLvMvjQE/KkpqaEz/IbJ7J4O3T/CYPBWV3BsOD8
	 6Y10FL8uDQULbgzMIIrj+P9agvFm+EaX3A4ZKljm00YbVpVXQHPwRPIEFN/GuZwLwg
	 EzfCy/sRMRkYyBsa/Q+7CRAKeIPKbN4zx3IrjNbxWMaVkYQHxcZ3kNnX+n3jnIHWjK
	 n7M6/20LeMQawbSz4lzQBJPtsq/TgScJBEWk9JihekeKvBmaQJU9Fmozla7JhY6wl/
	 thFmBMzQeQKRcM84CPvS1MvHH98jez6msGK892ArARPNlHmeJOP7kdVjHqykriXjAu
	 g9m5MTYHcdOGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA37C02198;
	Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: small fixes and improvements
Date: Tue, 18 Feb 2025 10:31:24 +0000
Message-Id: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH1htGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3ZTUMt3MzHzd3MziZN0UcwsTI9NESxNLC1MloJaCotS0zAqwcdG
 xtbUAlvOjl14AAAA=
X-Change-ID: 20250218-dev-iio-misc-d78425a94985
To: linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739874693; l=740;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CKIe0qJhJkr78+nRNyahW/0Imlybj2XSKCQoyCG9RZc=;
 b=Vb07n5T0DAHyzXu/0cREM7Qcxs5PCgVjlG+WK3HA87N0ZIZvEXZ5+0KSvxwhveP3p+Z1A0ey4
 tl01yWRDNA/BRKCnm9/SgJoZRxoFlbckc6xRvPUHx3MiKBOzAgkycpM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

The first patch is a fix for the backend code dealing with
direct_register_access. We need to properly terminate the received
string before passing it to sscanf().

The second patch is about using the simple_write_to_buffer() which makes
the direct_register_access write side more symmetric with the read side.

---
Nuno Sá (2):
      iio: backend: make sure to NULL terminate stack buffer
      iio: core: make use of simple_write_to_buffer()

 drivers/iio/industrialio-backend.c | 4 +++-
 drivers/iio/industrialio-core.c    | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: c0f115a8d97599623294c8e9ec28530e19c1e85b
change-id: 20250218-dev-iio-misc-d78425a94985
--

Thanks!
- Nuno Sá



