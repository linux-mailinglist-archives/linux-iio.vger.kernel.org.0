Return-Path: <linux-iio+bounces-17358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D418A75B05
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022F41660E7
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0E1D8DF6;
	Sun, 30 Mar 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsLSbQ48"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE98F5B;
	Sun, 30 Mar 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743353247; cv=none; b=hpr0R/WC0uvTAGGC0JdMuEFevrmOojpnNkEaiCO2H0FAlJl78EU4W4cF7dVTMaq/c8CyfbcyhY1q5/Lxba9C2MpRkMjjO2/+74jfkr2p1K2ltsYo6St0Crq4766R6nOh6BWByZm2XvpJRKRFEBmKeegkCmTBSYpI4dmWhmGR8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743353247; c=relaxed/simple;
	bh=+Y5fHgr4w65Wlc0zclDdRFUB77o659I40TwIYlCXzMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POQWWXrFHe/kN8HyDaSjUW78bjqfd3318E4Llj6uxME+cpHhKRaN5gNMB1/3AhkvMFH8MDbZ4jYvT7Ip/cl9GEE2VDY8XlpO5k1SJYSIoa/IQwU9Pl20sAeFEIEnlDDE/bQ0pxWfoR3C8D8fvIVdCq+WkTaF4PAPiK0tM3PbsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsLSbQ48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6A1C4CEDD;
	Sun, 30 Mar 2025 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743353247;
	bh=+Y5fHgr4w65Wlc0zclDdRFUB77o659I40TwIYlCXzMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsLSbQ48pMtJWmpd/A9XoL7zJM/Wrm+GZdTZXJ7WTh9W/9tMwDFC9SOelr035rBv1
	 0tQZgiFmqUowlwaHgGnTZ1jFB55DOMuKVUX5X4YoEoHWcGXGBt7eavoUWlC75BPbtl
	 4+RhgB0RaCtLlCtl2ocaMAlKsbIrZZffxUS41EtNZn2dm7VPZyrAXcOEoV++6dneKo
	 FV2mKnWmfvpBoVEZFTea1Y6g08dX0qfVXU6RMwoEn6McxXtdd1qVqzxIaosy9hgvmb
	 FF8sNsFFx1IK5Yc+NKvOS14/LbQE/XdK08ANVenQE0vx4g7xQlFVEDXv2hadZIHUby
	 hR57o1QWmAcyg==
Date: Sun, 30 Mar 2025 17:47:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3] iio: dac: ad3552r-hs: add debugfs reg access
Message-ID: <20250330174720.1e3e42d9@jic23-huawei>
In-Reply-To: <993d3226-f733-4093-8a7b-cc51007700c9@baylibre.com>
References: <20250319-wip-bl-ad3552r-fixes-v3-1-9975b38c0082@baylibre.com>
	<993d3226-f733-4093-8a7b-cc51007700c9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 10:54:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/19/25 10:45 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Add debugfs register access.
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > --- =20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20

Applied.

