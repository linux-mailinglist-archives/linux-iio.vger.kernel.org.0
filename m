Return-Path: <linux-iio+bounces-7892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C693C6A8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9811F245FD
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137719DF62;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRyF0mi1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0319D8B6;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921967; cv=none; b=WT2DypSTA7d6OWaZ96xnhaNOVvmH4RWB107iaYYxA7BZ9LNc1aEOp4LTBg/ZmOB8GXPO+EeeZGlkuvD09cq2uHM60Mwpihmeu1MG/rmFmmZruDX0xNt1rnf4oekhflvVcSEQD1jrvOHNj410tpy+CKXwIYQhP+X7KRoNC4C89xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921967; c=relaxed/simple;
	bh=ePv4OXqlEMgDTFPhZe1AViEKXOvO26Hib4+/bwTwazQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwpafrcvSf9AREenbSqUXqIFRzNDfQFMd8iB1LnA2s/lmksbAE/57jvpPRRjeL0wUs7Sb5Tb/Yu3GklbJp5FDRLHOV2YAJCMaJ4MaOhzOHTsVM9Cm0n0QpzXUOZFwmavODrEmLx0R1hpct3ezGAcouGdjV1eThs0uV/iVlD0ZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRyF0mi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21827C4AF13;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921967;
	bh=ePv4OXqlEMgDTFPhZe1AViEKXOvO26Hib4+/bwTwazQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VRyF0mi1GgtlIqD3xepwJPvntR2IvnINa5pHGYnjATCuMKZSOK9pHcGRTJPnDbAN+
	 1ApiIbQNu9xWrjYrJsNVMNtEkY9vp25D4ZNuxW89PS4pg+uXHw1NGXq6sUBJdsVZ+S
	 pXLn4hdntoCfxU9nJrjmGhykPgIpdOTmVQKv/1YOHZlM+6sWGNjIxtmCSr6QjEQgiM
	 Saxdq8WKonNS/XstUb7KlPXmavuGyrT7z+5GrRGidRo0birZdVONrGvqxJ7qk5j9oV
	 gUSefKNk7xut2eCc97zTdGqIkZc0KAmM1gDa79pcvD7bB/ghGMBS7YVGAAUtee+3Mz
	 7kRHXqHcqhoXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF6C3DA64;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Date: Thu, 25 Jul 2024 17:37:29 +0200
Subject: [PATCH v4 3/3] MAINTAINERS: Add Sensirion SDP500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-mainline_sdp500-v4-3-ea2f5b189958@gmail.com>
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
In-Reply-To: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721921965; l=814;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=FLAhfhEw/kb4vXK4acn1ghnoUaHh0QtVdAQd8Si6n7c=;
 b=7xkmAXxsLkwjB25+M1dMumspAWOT0w4Bp+r4IJoF6imXvAJz+2ITqfoT4n42VhNPx2dQUiQwi
 iwOwy3PALbWC5KwMQKLo70ieNwZQJU1dOiJgLNFQZ4qijpAd4+CJGBm
X-Developer-Key: i=pd.pstoykov@gmail.com; a=ed25519;
 pk=oxcGqcVV5O6wqlTh+39SbOwfbpD763i5x4TavUAHiCg=
X-Endpoint-Received: by B4 Relay for pd.pstoykov@gmail.com/20240702 with
 auth_id=179
X-Original-From: Petar Stoykov <pd.pstoykov@gmail.com>
Reply-To: pd.pstoykov@gmail.com

From: Petar Stoykov <pd.pstoykov@gmail.com>

Add myself as a maintainer for Sensirion SDP500 pressure sensor driver

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40c754b4c39c..fae39d65d676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19533,6 +19533,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 F:	drivers/iio/chemical/scd4x.c
 
+SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
+M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
+F:	drivers/iio/pressure/sdp500.c
+
 SENSIRION SGP40 GAS SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 S:	Maintained

-- 
2.39.2



