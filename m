Return-Path: <linux-iio+bounces-25005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F63CBD097F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E30394E62F9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E732EFD90;
	Sun, 12 Oct 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmDxeRrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60B22097;
	Sun, 12 Oct 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292711; cv=none; b=mvenRQfViJi0vPrdElMr0lTtx+C8AouwbUxZrWmLHnsk27qDncJsJA/RpDw1sq6B6zdD0y61gqQmS8sCEerttqIbpMr+JIlBdLSdlspZRl1Gt44IjgVn7QBNtbJy21aOfk6bCJOKyPiKrVZTJ8Rb9bajNuhMWbqVjSOkYSmlVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292711; c=relaxed/simple;
	bh=XuhI7i7gKyOGAzUP5PZD3iwC5AvA1i7de/DeKrWuZDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF4R5BhsMjrN9GYaqeuDTGqhdihhrry3RgcLCthJ3t/a3lGTgampMaD3aLOld47U5SVBasfrUa5bWaIZXMNkO+PI8gBaouq3XQUy1ccnDeZfSMVYDofH6WnJ9TpsXOFnw43qrAAm1D8i2HKUfqMjyV69x7O9FKZnganqSoFOUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmDxeRrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7007AC4CEE7;
	Sun, 12 Oct 2025 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760292711;
	bh=XuhI7i7gKyOGAzUP5PZD3iwC5AvA1i7de/DeKrWuZDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nmDxeRrn8pIuTm8WNR+efg/Ii0nF5OYP8VDyH130Cwky18NzuauL2oVYaXDILtYeS
	 ZV9fHUw2i2w+1Cm772dHIRRgGQcbaz7JlTDswOfJdE8t02USHozjKnfmLNxd8yopYc
	 4gKfBhRgi//Z/hwjMn/vLviD05I76/mr15gP+woHYBO/k+YE8nUaxPod7+kBoo9+Cd
	 QMtpYJDlm0rqMs2GYnudNeOVDuGPzZpSPAnbfRYNfMVWIMwnP53WopMZtacbxzMwSG
	 4SFsfqDUJaKFNEfHn0MuQk3RRf67wQ4xS5CMKjcaVQlc3zoNIY03I9wCq5SOqafZnr
	 WjCU+qE0O+QYA==
Date: Sun, 12 Oct 2025 19:11:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] iio: adc: ad4080: add support for AD4081 and
 AD4084
Message-ID: <20251012191141.427110d8@jic23-huawei>
In-Reply-To: <20251007111525.25711-1-antoniu.miclaus@analog.com>
References: <20251007111525.25711-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Oct 2025 11:15:19 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4081 (16-bit, 4 LVDS CNV clock max) and AD4084
> (18-bit, 6 LVDS CNV clock max) ADC variants to the existing AD4080
> driver.
> 
> Changes:
>  - Update device tree bindings to include AD4081 and AD4084
>  - Add chip_info entries for AD4081 and AD4084 with appropriate
>    resolution and LVDS CNV clock count
>  - Modify channel definitions to accommodate different resolutions
>  - Ensure backward compatibility with existing AD4080 functionality
> 
> Antoniu Miclaus (6):
>   iio: adc: ad4080: fix chip identification
>   iio: adc: ad4080: prepare driver for multi-part support
>   dt-bindings: iio: adc: adi,ad4080: add support for AD4084
>   iio: adc: ad4080: add support for AD4084
>   dt-bindings: iio: adc: adi,ad4080: add support for AD4081
>   iio: adc: ad4080: add support for AD4081
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  2 +
>  drivers/iio/adc/ad4080.c                      | 80 ++++++++++++++-----
>  2 files changed, 60 insertions(+), 22 deletions(-)
> 

Series applied to the testing branch of iio.git.  I marked patch 1
for stable. See that patch discussion for why I did things this way.

thanks

Jonathan

