Return-Path: <linux-iio+bounces-10509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B499B52C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364AE283191
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75F186E46;
	Sat, 12 Oct 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol9ojoNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA28F64;
	Sat, 12 Oct 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740781; cv=none; b=o2itQ52SJ/zAJMy4zfn+YNUaeT853vCOaPh7EGimLXCAxto2g/i9AG+zAeijYB8B0KkPHNY6xrGRMpVV41Ew23slfXFd0OlOmtN99i26gV5hPZ3Rxgye+vF2/sW595Up56+6YNGppwO+5Wx5/kiNv4UUqhz/m7iAjgKoMiv41Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740781; c=relaxed/simple;
	bh=jTsv8YKlHSOCus13aRodVHcfbrIBjeheam1+sqZlji8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPRq275VMn8itRHQo0DUeLmseEs+ytwzZ49g9mwrcFoBCbFq9MKHhR9+PEOt60j4g0h/mCYDYFQnMpHt/TC57l7fMl9HuIh0J/igOkS0tbZQdMZXiNXLRmiNBP1GCaSyL37h6TJEexvCfvq1f69CEWgogE67CZ7ULs8ILqMHtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol9ojoNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31342C4CEC6;
	Sat, 12 Oct 2024 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740780;
	bh=jTsv8YKlHSOCus13aRodVHcfbrIBjeheam1+sqZlji8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ol9ojoNRTPv7G4xQPmelzM6DJ4+Qq8+l6wHA/5p7M1e6edbbKBwgNWmtpWOwjsr/w
	 JVLI9K2wx9T9gs/mViNcZuIPmfX99ZJxlGxW+eerjPxKl1XK8HLKoVNJCjhhqc9RTE
	 5wpfhfs66CUIMhzsJbZpoepr3Clu1qr2ao+KacK0JoWMBe+jyJo/8SOt/7Txp/8gAU
	 wjNFxLIjbTZ028xUI5yTiZoXFiMEHYBvMQDTiW83IS2pONSpqOTIQNBYDaxWPAEnZy
	 O8Xr0xvh839Bv2aZBThniFVVrF5OOvY0oyK77TzL4DHG/wc2h+1hNV1v/B4L8DwzFb
	 iv4yNBmmcayaQ==
Date: Sat, 12 Oct 2024 14:46:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dletchner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 02/10] iio: dac: adi-axi-dac: update register names
Message-ID: <20241012144612.63ece11f@jic23-huawei>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Oct 2024 17:43:34 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Non functional, readability change.
> 
> Update register names so that register bitfields can be more easily
> linked to the register name.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing.

I'm having one of those weeks where I look at what we have in flight
and decide to pick up anything that is ready to reduce what will go
to another version.

Thanks,

Jonathan

