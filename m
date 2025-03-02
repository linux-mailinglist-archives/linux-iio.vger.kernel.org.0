Return-Path: <linux-iio+bounces-16234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CEA4B133
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CC216B389
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 11:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712D1DE4C5;
	Sun,  2 Mar 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z33nBS68"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582E1B6CFE;
	Sun,  2 Mar 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740915407; cv=none; b=VrL4LDfL9bL7xbyWSPdg56x3WjLYMbcXJhpZcNc9KhaE0mmj1R5zHzwpOqoJeX3Sd00b4yC+3jWFqCo8S/YWBxNQVd/H0R1NLWuwc3NguoFTaHPncNj0Dd0qLYUyONAV08sOsx9lwfDxRB0Bo44lClqurrKskthxpucRXjjDc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740915407; c=relaxed/simple;
	bh=N/t6nIOjfwJxu+JdAQ+GXJrl/wdTnr17Z2zDsji+J/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fu6IkgURW20ygupUOkVyJOci5eBJ5+NKVuZoAwfa4DE3+RfI0fWQYyBCZPUUTRi62lYyMkxB8MtTrhOuhBVr3UsBkCCQmui3A1ciP5lyAOESRbN7Kaf0B7tCxmwmS67APQupivmVTpAZ9a/32zmH40RRB6aYv/3fT/gJy3f+2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z33nBS68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6476CC4CED6;
	Sun,  2 Mar 2025 11:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740915407;
	bh=N/t6nIOjfwJxu+JdAQ+GXJrl/wdTnr17Z2zDsji+J/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z33nBS683Ii/D5fJB4F1ANyQJmZdXhyX1IkfXaiEmYwY72cxFFPGEi4GVpX+X1YWZ
	 PFGGKsL+HBVq/IY+oEWCTp15g/W5+dYoKIDKwUHyEw8qdO7TWE3GkTOxR9ip23mpV2
	 BjfWtQIqPZKp6qbTKm7ZoHhCA89JQU8KR17M65JDHQ7yqebB4MBuwyhb9I+S6wXRPp
	 MhTPUB3bYZf3xxk3ZS5AyH3bzuXAdV0+MMjy2SA9kQi09YS3WZNS+Ld0dxtFncZUiK
	 MGStLGr8tcoe+6SvNAp/TBGfYo1s4FwuO0OJbMm/PAzjWENM3pZsn7RnIgFiiaAOY3
	 negAttrADzCkw==
Date: Sun, 2 Mar 2025 11:36:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 03/15] iio: accel: adxl345: reorganize irq handler
Message-ID: <20250302113635.07ff85d4@jic23-huawei>
In-Reply-To: <20250220104234.40958-4-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:22 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Reorganize the IRQ handler. Move the overrun handling to the bottom.
> Overrun leads to reset the interrupt register. This also happens at
> evaluation of a particular interrupt event. First evaluate an event
> if possible, then fall back to overrun handling. Additionally simplify
> fetching the interrupt status function.
> 
> Both is in preparation to build interrupt handling up for the handling
> of different detected events, implemented in follow up patches.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

In the interests of reducing size of patch set I've applied 1-3 to
the to greg branch of iio.git.  Pushed out as testing for all
the normal reasons.

Thanks,

Jonathan

