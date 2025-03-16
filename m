Return-Path: <linux-iio+bounces-16894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCDA6353F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31AF1890CF2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387BC1A0BCA;
	Sun, 16 Mar 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khfaJIo6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE2189905;
	Sun, 16 Mar 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123660; cv=none; b=unFmoghHYMlLmuXONTdWZ4AOeo8JcbE3bmFzdLUm4vniO08JukTvsrc2F9D1RUewmg/Rc4RbJa+iH2u+wx/2EDt2zs7oTyU/CuaP2GZgx47GkNKXpJotQrDc5t/at8jHw20Isu6Ze+O14YzIuLFwxx7i9D6AHJQC309DgUorS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123660; c=relaxed/simple;
	bh=RSNp3IPSyvgL4V446VwR7VwxIh7ZawfQRi3rGCvs5fU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tv3u4mT4M++znmETvClP7VdJxVpnqva9ehRJm60A7ZnhgurRIxeUp28qpcNxIJzVOVSpa383zmK5zn4q2Hg77HBzanqEK3QelUrtA4i4AXIrndEUS6EtrFaVbRDCjeSmGqB5m/h3uyU9xBV3sMVz3Nhwk8Oki7M0I4XeHPbLMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khfaJIo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDA1C4CEDD;
	Sun, 16 Mar 2025 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123658;
	bh=RSNp3IPSyvgL4V446VwR7VwxIh7ZawfQRi3rGCvs5fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khfaJIo6AD0bGnW9YfzJuo5Eyd1mzJ0hO4Mo7KzVesIhGNyLw1vSjYlj1zQ5sIQPG
	 reiUGkhMyH1R+tdWYsbwcb/E8pg7isBil2G6UimF+8r3do+k1SuTAMiJBQQzaEDGqg
	 fLtW9cjQMWnceyuXFDzVUOHXGyr37+6ol4ZvBC9trh2LfBUKSx54vvnpAid2P3UJkQ
	 fWScaZgmmld0WufReXkDE4rH5+tVygDZlo5LpjSvt1Q9f62bEbsCcoQQFugKRtxMZX
	 8szJIKiMoo/oKUsJITBMaECN+FqFMBG/DX5rNWrGScoBtQN3tpKnLDkguiyZCAexcA
	 m1IB6oOEfFOvw==
Date: Sun, 16 Mar 2025 11:14:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
Message-ID: <20250316111401.07da20dc@jic23-huawei>
In-Reply-To: <20250313165049.48305-5-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:39 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Move the fifo handling into a separate function. This is a preparation
> for a generic handling of the interrupt status register results.
> 
> The interrupt status register is read into a variable int_stat. It carries
> status for various sensor events, handling of which is added in follow up
> patches. Evaluation of the int_stat variable is common for sensor events,
> such as tap detection, freefall, activity,... and for fifo events, such as
> data ready, overrun, watermark,... Also, dealing with in case error
> returns shall be common to all events. Thus migrate fifo read-out and push
> fifo content to iio channels into this function to be built up with
> additional event handling.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied

