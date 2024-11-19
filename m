Return-Path: <linux-iio+bounces-12416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86A9D2F94
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 21:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575971F23C06
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030C1D4336;
	Tue, 19 Nov 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiaSzuu/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE51D415B;
	Tue, 19 Nov 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048623; cv=none; b=OpzTR6lNTEhMZTYofjoAppRd0GLRkqcFv2Z6tVyep3h1ulHSDGN3je5062zUrsF7O+NMtFIof2cBA+Gc9XlyAGhnQ9oXIf/xu4IqciJI74XCaIlES9Ez7AJIbMRtX0/nKGYKgkpL8dKOggzYjnUffDIXYDqe+4c4pbMF767RV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048623; c=relaxed/simple;
	bh=5ZtJ47OwVXBSoFV+aJ4Xr6HwqQoievLKVIyNMZI/poc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W12hG/a0LywdSNUOWrbZqkBHJjiQF/XuHX+aZ6TQFBsi9hV08G4jux7+rkSA2aM432QReV6Fvld0pE+MzUYLw3PAUJ2PGe7M2garSR3/DTJKFFDDSQge9ZuLEC4p03d/bVNoyxLKra0vKY2CRRnbsW7rp0eHgo/Th7Dvomt+4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiaSzuu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C62ADC4CED0;
	Tue, 19 Nov 2024 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048622;
	bh=5ZtJ47OwVXBSoFV+aJ4Xr6HwqQoievLKVIyNMZI/poc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=CiaSzuu/fm24QmtXA5MBu4UjvyaGi85oPhg90u/upQ/9nlpJyehwuSUQyS+2tJd43
	 T7ZtyBrNOchDQsegE4rCFts0N8UmydAdPdOiac3JrFkVzkdfLPwUa6rvstNZ952jhu
	 a6xkvfExipqrzcrl9c/hWaowQU6PKGfsBoIv2nl+kjgi9vlehDMhuoU7z+nuZA4z/X
	 +XLlSiMf989mrQZqaXqvPFvetT0FCVk5OHqC6vtXVSwUGKEiuQKiaPunKaHhyePaCV
	 HYB+HTPTU4tsRhcPF/6FTupC89dJWFTc+YVl7o4Njp0hWm+R8zxxxv3tSJWD6qV9aZ
	 APrvmOZZ8U9Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA250D6C29A;
	Tue, 19 Nov 2024 20:37:02 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Subject: [PATCH 0/2] Add support for Avago/Broadcom APDS9160
Date: Tue, 19 Nov 2024 15:36:55 -0500
Message-Id: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOf2PGcC/x3MQQqAIBBA0avIrBMaK6muEi1Ex5qNxQgRiHdPW
 r7F/wUyCVOGVRUQejjzlRqwU+BPlw7SHJrB9GZExEW7O+QFba+D8EOiZ+vjRLMNNEzQqlso8vs
 ft73WD10JX6xhAAAA
X-Change-ID: 20241119-apds9160-driver-86cf5e86de35
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732048621; l=926;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=5ZtJ47OwVXBSoFV+aJ4Xr6HwqQoievLKVIyNMZI/poc=;
 b=+ma2BrFzBD30dJSA+R6419ctgdetUJPQudiqX55DnAVS9N7flyeN+0wL/u1JvSjUCbi8q+pqj
 6PrWSEvetk0C9U/p4dynYYXUO38MIYK7wBAMY8+O/QG3h/CX6/bITkh
X-Developer-Key: i=mgonellabolduc@dimonoff.com; a=ed25519;
 pk=p4tvPfGPfXRyChsgHc6s7HwB6YBl2JqqcP3BXtoDitE=
X-Endpoint-Received: by B4 Relay for mgonellabolduc@dimonoff.com/20241119
 with auth_id=279
X-Original-From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Reply-To: mgonellabolduc@dimonoff.com

APDS9160 is an ALS and proximity sensor.
https://www.broadcom.com/products/optical-sensors/integrated-ambient-light-and-proximity-sensors/apds-9160-003

Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
---
Mikael Gonella-Bolduc (2):
      dt-bindings: iio: light: Add APDS9160 binding
      iio: light: Add APDS9160 ALS & Proximity sensor driver

 .../bindings/iio/light/avago,apds9160.yaml         |   50 +
 MAINTAINERS                                        |    7 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9160.c                       | 1420 ++++++++++++++++++++
 5 files changed, 1491 insertions(+)
---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20241119-apds9160-driver-86cf5e86de35

Best regards,
-- 
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>



