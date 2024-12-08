Return-Path: <linux-iio+bounces-13254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A959E875D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8FF2811E9
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D618A93E;
	Sun,  8 Dec 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKVVxM+p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E714373F;
	Sun,  8 Dec 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733683774; cv=none; b=HUWmsE0qz850bTJF334Cs0ozULOGwijZFZXIMe5TmdTUdY6AdhzEIs1Yv5+wvHbtfeVDjtyASZneQd2cP0Yafr3qe/wVjQv4I/cz6wPp8F0TeSiXC549mZ/iIlzy4k53CMNq1hRj0RI+zswbFDuQt1au3o31XxqVUco+6XdiEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733683774; c=relaxed/simple;
	bh=SsPWEaiB4FBzjCZeopei6utjf5lWdB3fzihd3SoS36M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoKZT73IpqisU9lNAoCls7aUg7uBaiO4TopHF/hzM3nSYFOnKi6IwbdyDifTXeujtX48kgzBBR3ElM3CPdiBz+9lIv6xlxA1AnlJESCcm99BTmmK+sxOjNfn7ZEmE+ZFToye/hNdY3SLJ1xnSsyQ1PVTgKuKxdavLEmm1sq9tpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKVVxM+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F164C4CED2;
	Sun,  8 Dec 2024 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733683774;
	bh=SsPWEaiB4FBzjCZeopei6utjf5lWdB3fzihd3SoS36M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PKVVxM+pQh4rRq/eb4+C3X32cF3sEoWjkwBrkVa9ISOnkj3e7MJ8qP2lcZkKOw2le
	 qzRYU69fHa3/VL5rW3dm2ad3aGpx1m4dRGf3d1gOS1R3rpJFtQ9kl3wlOwKnF1tt8b
	 4kHcX+bs4vMtKki/arVM86JRBje+/6ax0jMzKNUigE6czvZ6OG1N5kk3WG13bDJXi4
	 L8wON9msnFk50fee5QXmkkeLzPVurE950Pa5z3QjY8dxkeDRTomH6XiZBlaFmXZtHZ
	 /YzOn4vyl+fKKbfCjFcnLun246lwkksHEPYb3GIWybYFQNHgFK7AoTWFu3nbCztGVn
	 3fEaXF8mZkT2Q==
Date: Sun, 8 Dec 2024 18:49:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 0/4] Timestamp and PulSAR support for ad4000
Message-ID: <20241208184925.49452b9b@jic23-huawei>
In-Reply-To: <cover.1733147443.git.marcelo.schmitt@analog.com>
References: <cover.1733147443.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 11:06:27 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Complement the ad4000 driver with a timestamp channel, a minor adjust in
> transfer timing, and support for single-channel PulSAR devices.
Applied to the togreg branch of iio.git and pushed out as testing for all the normal
reasons.

Thanks,

Jonathan

