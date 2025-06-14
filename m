Return-Path: <linux-iio+bounces-20633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A742AD9C5B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F073B69CA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8124C664;
	Sat, 14 Jun 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="debgul3I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC91C84CD;
	Sat, 14 Jun 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749899315; cv=none; b=QLbsNRcb+ZBWVcJG9oJfagdvBhDSBHAfBT68KiPii9cZuNO9Rl+Zau6PBa0ixK6Vk/fCVLaPcUA9uXkcpxteFYfeVdGBz7s27I1TlR21IG3Qt/Ndw3K4jKpQtpbesfEuMtFDs8BMZFRXDeCQD7Sjff7Md1XHBRfzz3PDH8n8LK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749899315; c=relaxed/simple;
	bh=e8lIQX1RhoFgT10N8YKrRLRbZf5gcBZWZ3yjEM3FJv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVzg7JPmANSUY+TC1bYo5lF3IaGE23XGYX2pQknLOfpPLXIxShM67gaoExoJZgibH/cK3/1MHfXnX6mjYCJA2OAHiEeuDDJDZCBLbnq6ouOqneNAghUo/NS8lp6+bgFVxCmKJU2afEb7sGBk6HpIpwSUh/5HewetUj+DxK9yDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=debgul3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9A3C4CEEF;
	Sat, 14 Jun 2025 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749899314;
	bh=e8lIQX1RhoFgT10N8YKrRLRbZf5gcBZWZ3yjEM3FJv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=debgul3IwFpyHn2BjIjKMwWjvW1oBXqpauRenlMl4eIJudR51MoBbrO0P1AiRN+lg
	 5VdStoRc+i2HkmEk7y+nyWc2cr10gliBU1V/haXN2va5wtU1XCReinIzNv2PeB/IUS
	 /tDAkVi7TZaMtdti9FYizgOHFQCA6eJMU8cbc9dpSiB0BCwMEWawKGY05lBCKGMzLI
	 bewyVLyapd2SMgZbn/NC+OXd/NWulf7ICfVWYxetNaBTRLWiUr64FAXWK85NvF4p6+
	 bQTQ9LQYPdp38bP2ANyXMOv2VUamYDqBCH+Exuf2n326kFJ6mBty0g0gL+B6ihgWyW
	 jQB/iKEqtuxLA==
Date: Sat, 14 Jun 2025 12:08:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Use dev_fwnode()
Message-ID: <20250614120827.54b2e77a@jic23-huawei>
In-Reply-To: <46208c8d-8370-4b9e-bca1-7ede7ee9b078@baylibre.com>
References: <0ec0fd5e-8fbe-43c4-8aad-f36d2872f280@baylibre.com>
	<20250612084627.217341-1-jirislaby@kernel.org>
	<46208c8d-8370-4b9e-bca1-7ede7ee9b078@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 12:00:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/12/25 3:46 AM, Jiri Slaby (SUSE) wrote:
> > irq_domain_create_simple() takes fwnode as the first argument. It can be
> > extracted from the struct device using dev_fwnode() helper instead of
> > using of_node with of_fwnode_handle().
> >=20
> > So use the dev_fwnode() helper.
> >=20
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Cc: linux-iio@vger.kernel.org
> >=20
> > --- =20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20
>=20
Applied. Thanks

