Return-Path: <linux-iio+bounces-14821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F08A249C4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962F81884ACC
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E821C1F2F;
	Sat,  1 Feb 2025 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqHAHaGl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA119004A;
	Sat,  1 Feb 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738423491; cv=none; b=F/FzkRzF/AV+oONVx232db5A7K2YOVwhaWVa60aUM7AKZZzDGEZmwX6pfWc2QOpb/yxdBjE/31yLQqcSMEPfXrptdReAwrpuryKrczbtgV+L0ccQU5kdz42oMMI8IHrIyrp6CuTcXxz/Sfgzd2Rbzb3XvgMsaeetlc5TAmjYR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738423491; c=relaxed/simple;
	bh=UaWZsCI+aukrpetehpQvix73yXlKutXTDhOU4oERyWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA6FLKX74n+FZ+8HlM9G8XwQTMmsGiksLMVpmIlNzoMqLphmBrjNvo4btgylNmos3pSBUMtGESuG7cC2hFoP9FUvQNSV9ijMhaX6kKckntyg3oydOwsDIWHVyAEYxEmS1dEMS2GD6BfZA12i0WwqnkHqPXyDmSmHC7RW0smWRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqHAHaGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE83C4CED3;
	Sat,  1 Feb 2025 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738423491;
	bh=UaWZsCI+aukrpetehpQvix73yXlKutXTDhOU4oERyWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqHAHaGlp4p73jhVUdUA5+/WShsheUoBWzil/fWZGTtGQjZDqvyRWj5Yq1IBO1IYz
	 CoVCc8cVBRKoz4kADYeel/y3IjIh9uw+wqSUgz33rfG4YNoaMffJxiZpijvx06xgj/
	 +Vk4C7x1ZkxKiL/tyvjp6MsSl5A2Vp09yElEEU5Lx2hl5YUuTQMoJP8KIIztSkzxgv
	 +5OVHgBf/kU7Qw2VWb5Hm6Qh2dWUpTbUCyV/Hoj8MTmzDOgi6qezhYnxvPv1h8oAsT
	 i6uy0W0mlsAu9hWK9i9nUZOfQPfkw8aDNorz+ozuebUQLVcfHP85DoCCbpxtghHyM7
	 XeV3LUylm70kA==
Date: Sat, 1 Feb 2025 15:24:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] docs: iio: add documentation for adis16550
 driver
Message-ID: <20250201152440.7924cff1@jic23-huawei>
In-Reply-To: <20250129082053.19077-7-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
	<20250129082053.19077-7-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 10:20:46 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Add documentation for adis16550 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>

> ++----------------------------------+-------------------------------------------+
> +
> ++----------------------------+--------------------------------------------------------------------------------+
> +| Miscellaneous device files | Description                                                                    |
> ++----------------------------+--------------------------------------------------------------------------------+
> +| name                       | Name of the IIO device.                                                        |
> ++----------------------------+--------------------------------------------------------------------------------+
> +| sampling_frequency         | Currently selected sample rate.                                                |
> ++----------------------------+--------------------------------------------------------------------------------+
> +| write_lock_enable          | Lock the device from further configuration. Only a reset will remove the lock. |

I'm not seeing this one and that's a good thing, but shouldn't be in the docs.


