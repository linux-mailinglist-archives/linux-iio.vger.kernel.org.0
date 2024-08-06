Return-Path: <linux-iio+bounces-8284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD6B949583
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D229B30C8E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7830A4C62E;
	Tue,  6 Aug 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VePxo3u/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1C51C3E
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960125; cv=none; b=dnjpV0I+qq/hznkniNsSGsk8moisjvMAencQmQF5el/CJ1PCgFtt68gwvg23r0kZhxY9sbO4M1RvzFyfRbkgParjZCzNOUKj6W5n/SIQX6fN2pGqyY6dALGZtsznTxfmrBWbXDfWuDjcblGKWu9TXZ2J+MDYhUyTyUAs/JTAxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960125; c=relaxed/simple;
	bh=+qNd4iirvqBwuTzn8WZr+OzTjElYUaaNYvgLWAMvdhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0I2Ffu4Nx1uu8rUxaTdLfZWsitPAla2weKzVtjLBR936bU7HSoWg7igqo5qbwsr5o3Myv992hGjDZgugntaV3/MUN/qGnhzTwV1gwJRCR17doGXLQAP8C5PIrcoBRoJGr4SPDNSvs27oOTyp/B7YjkY67K3pND2+LBTri/AZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VePxo3u/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC0AC32786;
	Tue,  6 Aug 2024 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960124;
	bh=+qNd4iirvqBwuTzn8WZr+OzTjElYUaaNYvgLWAMvdhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VePxo3u/hvmgVao4xx8hvED27JhtQyPo3/pved57/l2LUxjrg5Ry/eXt1hGD84rGZ
	 5aV4tAuvESjcAlK7OuVE2lsNI4woYz1cpFkRacC2fMhP/2A3L3NCRJudn4QMxi9arf
	 2wfnx8sX/K5kTTjsM6URSBxJBxPEdYnuAr210GTgGqS1IzhyGgFY/HEQPvYdR7dbTa
	 ylekmPQAU5Lb62iwSN8erxB3QHV41o2qHKJjGwKXj++tMa14oIOieOJM3lF4aPn7qP
	 Bo9kRRL8/fq7qcBhXAYkq21Yseew6djWtPMxh1cS+ple0o7n2yzc0hvcEwTmsagoJx
	 fZnRo1a+grjXQ==
Date: Tue, 6 Aug 2024 17:01:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 0/2] docs: abi: document the debugfs interface for
 ad9467
Message-ID: <20240806170158.55aa3900@jic23-huawei>
In-Reply-To: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
References: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Aug 2024 15:10:38 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
>=20
> Here it goes the follow up for the ad9467 debugfs interface. While at
> it, I realized there was no entry in MAINTAINERS for this driver so the
> first patch is about that.
>=20
LGTM.

Applied to the togreg branch of iio.git and pushed out as testing.
If anyone else has comments or wants to give tags, then there is still time.

Thanks,

Jonathan

> ---
> Nuno Sa (2):
>       MAINTAINERS: add entry for ad9467
>       ABI: debugfs-iio-ad9467: document the debugfs interface
>=20
>  Documentation/ABI/testing/debugfs-iio-ad9467 | 39 ++++++++++++++++++++++=
++++++
>  MAINTAINERS                                  | 10 +++++++
>  2 files changed, 49 insertions(+)
> ---
> base-commit: 593737c18ae789dc6e4b493510a0c00977972e2e
> change-id: 20240806-dev-ad-debugfs-doc-90d6b64d01b8
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20
>=20


