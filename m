Return-Path: <linux-iio+bounces-7090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608B91D63B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 04:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1741F218B4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD646F9F8;
	Mon,  1 Jul 2024 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKOkjOtV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74574DF71;
	Mon,  1 Jul 2024 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801551; cv=none; b=l4LJuinidFmrQs56jLvm21zCf+ExVDVaDwLNXbPEn4DnVk7SDyxTkmuWWIt2JPTNdGJyx9SSTnF5YDh6X9nYJfbIZis23YQjAnQuR7njrfBaehogs+3DWfUoxH46xH7G5FagUUzo50ojZPx8ETg6tAvgZWtf46IwmzWywBhbh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801551; c=relaxed/simple;
	bh=tlgKBfaW0WVREdlHv1BoSTz4zEu/M+a8UwiX2tziU/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5z6AnqDgjc19reGQXoozeMBA48jMVMrDxedXiNStOwX67nBpJ0wvqzVLdXnRcxJKbPBwx6IKkva3z/MPOdRhV5MX60aY/jLz8ojzc98Cz3llgv+Aap7okc5zFJP/zBtmkWBPuyxOxXQi5QePH4yGDaxqnfYkaYq7umEtKeuSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKOkjOtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E38EC2BD10;
	Mon,  1 Jul 2024 02:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719801551;
	bh=tlgKBfaW0WVREdlHv1BoSTz4zEu/M+a8UwiX2tziU/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKOkjOtVheiUf92NWqiywYZDo/JbHwjccCIoMXuBdjdf3Ro85lQzwtnqq9uSypdLr
	 /SLjJoxZ4wSkXzXjBirg4MTSH28GAZaJPx3uCjlz8SxYCsiWcGSTzkXC9chEmNgLlO
	 9Gl/NzD+Yug2wD8Dz3K6IIEMsU9rKvvyd77iObxEYFekng2QE3uSBkkkK49muwKMvf
	 Zz/ci2NCzcJ0aSK+mc32Oj5hbgGW5C2LNFeal6Y6NczNUBxK9GsqdFFsyqhVpTUEYR
	 3u5XnroJGoa38s6X3956wOwz+fXjebnQIRdSqnsPdaS5ZLZ6jXNcfooihp9QNHBvIK
	 3vExEQ0c5y+Tw==
From: William Breathitt Gray <wbg@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Judith Mendez <jm@ti.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	David Lechner <david@lechnology.com>
Subject: Re: [PATCH v5 0/8] Enable eQEP DT support for Sitara K3 platforms
Date: Mon,  1 Jul 2024 11:38:54 +0900
Message-ID: <171980147646.3245330.16378344874755104998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612135538.2447938-1-jm@ti.com>
References: <20240612135538.2447938-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=wbg@kernel.org; h=from:subject:message-id; bh=r0Xdr2Jl+T4FPxaViclE8LBuTxOkELxFVAFU6X1B2oU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDGlNYtM42MsflTcwRzsF7SyWval1/TXHugARW8YVvaKep X+PnxHoKGVhEONikBVTZOk1P3v3wSVVjR8v5m+DmcPKBDKEgYtTACZyJ4uRYdkxCVXBc2szmZ0e /J8b9UTpbu+OpU+0mh+w3jWZeH3pdwNGhk6erfmPNnJPflkb06weaZfzYeGT4kSmWxZGCYX962b y8gIA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Wed, 12 Jun 2024 08:55:30 -0500, Judith Mendez wrote:
> This patch series adds eQEP DT nodes for K3 Sitara devices:
> - AM62x
> - AM62ax
> - AM62px
> - AM64x
> 
> The series also allows the eQEP driver to be built for K3
> architecture.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: counter: Add new ti,am62-eqep compatible
      commit: 151ebcf0797b1a3ba53c8843dc21748c80e098c7
[2/8] counter/ti-eqep: Add new ti-am62-eqep compatible
      commit: 210457b651acd61fced405cf7fef12a482932ca1
[3/8] arm64: dts: ti: k3-am62-main: Add eQEP nodes
      commit: e2e1fce199b0db4fd4eba99ff6ef779826a55731
[4/8] arm64: dts: ti: k3-am62a-main: Add eQEP nodes
      commit: ba5a251b1d539a82970823dd510ee25be06d6ca7
[5/8] arm64: dts: ti: k3-am62p-main: Add eQEP nodes
      commit: 131eaf47c4c5ad444e3a0547960daacd3a40f82d
[6/8] arm64: dts: ti: k3-am64-main: Add eQEP nodes
      commit: afdfe6439a6d28a3062d576705b203da0857699f
[7/8] arm64: dts: ti: k3-am64x-sk: Enable eQEP
      commit: 7fb9d8854fcf23b7882a34a4cf247a7f60d02fef
[8/8] counter: ti-eqep: Allow eQEP driver to be built for K3 devices
      commit: 474bbfc637c719daebffb5cabcf914dd749cf393

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

