Return-Path: <linux-iio+bounces-11481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B09B347A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7443E2811C9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7D1DE3D1;
	Mon, 28 Oct 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b+vT8B6q"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE638185B68;
	Mon, 28 Oct 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128150; cv=none; b=Utv0PZmp9hZWmGEXj1scwyVcayjAB38MscGKBAP+pI298Wb0LQlOFwH3Dn1OhKZPZCXwTI0rmjYa6TwhIVOUS0sS8vnscCHrrif+aC5oGouK5CfxZWFiw9RJgiLYmAk+JH5IjQVbg/QSEHMdZP40Cde3RIwdRH4IPSCidqtD9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128150; c=relaxed/simple;
	bh=neoFJQoBplIOMB2Oli0Va+P0LfEckZZNG2EuEzQElTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4VAyQk4egwO10WoO5EhgqD04voYkmHHziPYuPKQ07Gw3AGHZp/RmkZm72XA0w/ydXzkIEaVwU3RCbYoAjrpBDbAfeJwqI99+tSnWOmFJWrxgqCkG2Vdet1CfhUssvbHuvTPMRPijw0kELmL3ufoDZMlMBKsra0nUawOXrCD+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b+vT8B6q; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8JL1091957;
	Mon, 28 Oct 2024 10:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128099;
	bh=PcG6NepwaS5v72y5EW4BrZy3aZfCt9DWG2OfGvOadBQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=b+vT8B6q2raKBHSXuY35w2rCwScPCPJi5zOj91ho3/XcT4GZlyJkCGMufrCEjMs4O
	 ZDNJvlPRfsafg3PhRB1HPR0cetK/SZA5vYZWCack5ewd3SJTq1KR4Q1msiGhrRmR95
	 cWHYyyaCryvomCR6UxZpkfMAU6SoZ3sVg8kNfCVg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8Jsq057726;
	Mon, 28 Oct 2024 10:08:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:08:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:08:18 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tcs129665;
	Mon, 28 Oct 2024 10:08:15 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: William Breathitt Gray <wbg@kernel.org>, Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, David Lechner
	<david@lechnology.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Enable eQEP DT support for Sitara K3 platforms
Date: Mon, 28 Oct 2024 20:35:24 +0530
Message-ID: <173012710989.558239.256253831200168385.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240924220700.886313-1-jm@ti.com>
References: <20240924220700.886313-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Judith Mendez,

On Tue, 24 Sep 2024 17:06:55 -0500, Judith Mendez wrote:
> Git rebased the series since due to merge conflicts, part of the
> series was not merged. Also dropped the patches that were already
> merged.
> 
> This patch series adds eQEP DT nodes for K3 Sitara devices:
> - AM62x
> - AM62ax
> - AM62px
> - AM64x
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am62-main: Add eQEP nodes
      commit: 79e668d0d938ca05f340bd1faf37262f31c7a029
[2/5] arm64: dts: ti: k3-am62a-main: Add eQEP nodes
      commit: 36370ccf93bd0bd2be0c529ef7c0b687988ad3c0
[3/5] arm64: dts: ti: k3-am62p-main: Add eQEP nodes
      commit: 0f4a318ee64c647e2cbf7d802b8d06b03aef31e5
[4/5] arm64: dts: ti: k3-am64-main: Add eQEP nodes
      commit: 78b918b58e4b13ad53373882b01945106d196ff9
[5/5] arm64: dts: ti: k3-am64x-sk: Enable eQEP
      commit: 25da98eb3997d21e128ab75d426923a0dc23c4e4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


