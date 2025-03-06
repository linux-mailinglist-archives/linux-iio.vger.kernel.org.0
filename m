Return-Path: <linux-iio+bounces-16455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F4A54336
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 08:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4DE18911C3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2381A705C;
	Thu,  6 Mar 2025 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFfLBx3N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3B1A38E1;
	Thu,  6 Mar 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244754; cv=none; b=dA25xwkLB/1VkXDEhtWdcfuCyCz/RxSpKnYihFYba1NvlAaqa+LM26maBsnQYRCbHPoykYh26soN87DBT4T2md/APThyDVBrJKfRW8+UxmQoq06Vezf5VSj2fWTHu4oCRHMsl8InSyJdpzcXSL3hW2qBRbNanqbmULtlKpr65oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244754; c=relaxed/simple;
	bh=El74G6/NI0u0FdRCimXmohZXkOMOrBaMbRBx6pb9WWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=btCiWDkUOMcWYPY5QYldf1+44P9JvAXyLdXMV+u+zUhLE/jveHJeq0Ddv/S+uCMPJfKV5/y7A8075WxBalVsuP8zsky7zLib6CbBaPZ704SAND3I1RdtoRu5nJXJ+kVznVx4RTETRaspIOWhHE6kb36+dXlloF/C2yGySKiDdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFfLBx3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CA4C4CEE4;
	Thu,  6 Mar 2025 07:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741244753;
	bh=El74G6/NI0u0FdRCimXmohZXkOMOrBaMbRBx6pb9WWY=;
	h=From:Subject:Date:To:Cc:From;
	b=DFfLBx3NgfryZifDyoUEj913Py+XsgKqdaYhDhgmNRfM1L7AVrl7X6DAxSuLuWtqP
	 q/X+nPVpQvVppmgSLhkH/r7OfPfeHaVbVnbnHi26Ll7OEpxNh9tjOwU3cWFFYZRky8
	 WSaWangG70YS3ALg6G04e9ebvxkZKWTOpmHNM6OQXCjfLWtUKcChmznmmCaIqTEuB9
	 3qEMN6u1aHw+yywmbWQd+sRDcaX1MMdRliUv1RtxpVTEkNoU83gkRG8V+eczGzN3fr
	 hV9v//r9lc+6B87OocbFVygZe62ARX+NyS5fE7XIFvh0agUQDf3azkUb84oUOFmncw
	 lvG/3jHjOOPEw==
From: William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 0/2] counter: Introduce the compare component
Date: Thu, 06 Mar 2025 16:05:42 +0900
Message-Id: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZJyWcC/yXMMQqAMAxA0atIZgttRRGvIg61Rs1gKqmKULy7R
 afPW36CiEIYoSsSCF4UKXCGKQvwq+MFFU3ZYLWtdaUbRXxImE6Pyodtd/I3MPKhjJmtdR7bdjS
 QD7vgTPd374fneQG4+V/kbQAAAA==
X-Change-ID: 20250306-introduce-compare-component-11f22ace88b1
To: csokas.bence@prolan.hu, Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 William Breathitt Gray <wbg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=wbg@kernel.org;
 h=from:subject:message-id; bh=El74G6/NI0u0FdRCimXmohZXkOMOrBaMbRBx6pb9WWY=;
 b=owGbwMvMwCW21SPs1D4hZW3G02pJDOknPQMExE5tV31i2jGxe7kHk/5q6fR/Ni/P1tno/Eme3
 ZCu9PNNRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjARw+sM//TvJyhZxTBUSFSc
 4oi4Ff0z5RZf8crN2f9+/g6oYN0w4zMjw6rmnOCHEQ3zc28wXpz0aPLBXe8y5jk4lEsu2XJUPmg
 rIxcA
X-Developer-Key: i=wbg@kernel.org; a=openpgp;
 fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B

In previous drivers, we have exposed compare operations as part of a
larger set of functionalities; such as preseting a Count channel,
defining ceiling and floor boundaries, etc. However, we've lacked a
standard way to expose the compare operation in its strict sense as a
threshold comparison.

The need has become apparent in the microchip-tcb-capture module, which
requires a way to configure the threshold value provided by the RC
register for compare operations. To that end, a new compare component is
introduced with a helper macro COUNTER_COMP_COMPARE() to create such.

Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
William Breathitt Gray (2):
      counter: Introduce the compare component
      counter: microchip-tcb-capture: Add support for RC Compare

 Documentation/ABI/testing/sysfs-bus-counter |  9 ++++++++
 drivers/counter/microchip-tcb-capture.c     | 33 +++++++++++++++++++++++++++++
 include/linux/counter.h                     |  3 +++
 3 files changed, 45 insertions(+)
---
base-commit: c2a756660324fceca26780a50950e6d91dfdc210
change-id: 20250306-introduce-compare-component-11f22ace88b1

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>


