Return-Path: <linux-iio+bounces-20653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD7AD9D00
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D146189CEA6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37F2D878B;
	Sat, 14 Jun 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZEBjW+n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420281E4BE;
	Sat, 14 Jun 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908606; cv=none; b=KHgpHrOqaUt6Wkm31v++92tvVhAfKuKek7SMPLi2MSTLeYaZKcRd3546wIvE2GX9dzhRBU9U2SNEiT+YwM9p1UM/ykxU6Ou0we3LULxNEjzSp+38KTfDIL//Tgtyc+bH2insEJChI0WgUma2iTtz+u5L+eD54p6n+AH0evHu1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908606; c=relaxed/simple;
	bh=OZBysvx36NkqVsseAjvk0VTzSWzmQ7V5W6h3V0gLPG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vnw4DmLVXvB0TIWDBkX0yjMbkYFJOo5HX0u9rDBzT1Dq9q+WEBq0YsdTPFBt0Iy+yx9uIDIyecrVdCajNIG4lrJL4eObQ+LD+ML1B9OBhALuBpoh+bUr1l8/3P3a8UHjWoNgtSUYEnRR7cc2nWPG+hRyTcv4DmKGObMBeXm4icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZEBjW+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36366C4CEEB;
	Sat, 14 Jun 2025 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908606;
	bh=OZBysvx36NkqVsseAjvk0VTzSWzmQ7V5W6h3V0gLPG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cZEBjW+nqtzJMQ+0YfDuh+dtQSesMsYZ0rkZt8hcgxXKkH6/I7Fs/HuJLFro10lDP
	 uOUUO3G/pztfYVGCLzy2FnaWHUqqOFAJRUXAaw06GFGnuSojAM1I6ktszNo3kGQx9v
	 QD44rbh8+8Et2cUHXoEOszg3ek/qgw3kh6bD/zY3XM66vrA8MtzbSoIxOyZQdkwKLF
	 I95L80V8IoxK2ExYvUwL/OnIDabw9LFNhSe+QCQbMhZt6rK5Tbc5MQG5trWrZ0jKUl
	 JroeGqU5Xir5XbrOjRXgfFqivmrmv4wmG4TVuMao6/UNpnss3Qd8sUYAeVtrXM4GRV
	 bZ3KTyDrLJaFg==
Date: Sat, 14 Jun 2025 14:43:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 02/11] iio: accel: adxl345: make data struct variable
 irq function local
Message-ID: <20250614144317.630c7066@jic23-huawei>
In-Reply-To: <20250610215933.84795-3-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:24 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Remove variable irq from the struct state and make it a function local
> variable, because it is not necessary to be kept struct-wise.
> 
> This is a refactoring change and should not impact functionality.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied as this one stands on its own as a good little cleanup.

Thanks,

Jonathan

