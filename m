Return-Path: <linux-iio+bounces-19908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B3AC35C4
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15B21668B4
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3A1F4CB2;
	Sun, 25 May 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Com0hKfR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935913A265;
	Sun, 25 May 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748192325; cv=none; b=DV7OD0r+/4ScDBZswDJgbwPbUVJvkhdznLmtMf4yL277IBVLwhs+PQNcEPbm8br31/0EJNvzhx0dIRtkedt+wpfx05vjBBvyD3Z3CaOmcVuUfg0oBnkxxVEJZzUqwn4NHgnLOM0bD1rqMmoc3cQd8byuzHlpO30vlAAdQIV28Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748192325; c=relaxed/simple;
	bh=rsAkpn2NY7v+BYRACCGWX2DrEOUk4ixEVMiT1FFW9pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJL0HVN8ZbwsFEcacHoHCIDNiLm/msBUQstsJfRR0DM8bUtaTe9aXHf5Uz22jHu16QoCONP8RwwA9ZeIyUBCRdCtW80KD9h6jwnezNBi4osbqCoWMbG6VfKmsv0GdIPI84RWyCs3ZBzdPImcBb8vwcl9YwrIcMxeOo5H98siUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Com0hKfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49B5C4CEEA;
	Sun, 25 May 2025 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748192324;
	bh=rsAkpn2NY7v+BYRACCGWX2DrEOUk4ixEVMiT1FFW9pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Com0hKfRNwWLK+tBV1PjsfEeRT8SE3gP/cA/pZOcK4Od9mQS73Pm6GEu+okVnDC6+
	 kP2qSuzaBN7Av6UXrJGK3yeQqiUfSfMZIr3WNf3so04CSBQiUskKzCnPLTzHBug3lY
	 Q+PumcQRLbFuCM2O5qqlSK5EwjhrVbby7/tTG4T4FNPEg2FOaNxw7b8eYr32kW1pwI
	 JhOiQeu1mDiVHAzeSCJGkjanT/6OVVN00zIlPDHWqPv3V4Y4JQI35K1cI5EfWOxs57
	 rjF59ciwJdDaK8ZKXx1x+J3M0BAI69GaHBRBPaUp9A/tOSp7vhexkl+beaWKvHo5ao
	 tpcQrILHwcQIQ==
Date: Sun, 25 May 2025 17:58:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 2/7] iio: accel: adxl345: add g-range configuration
Message-ID: <20250525175838.6b319a49@jic23-huawei>
In-Reply-To: <20250510224405.17910-3-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
	<20250510224405.17910-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 22:44:00 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce a mechanism to be able to configure and work with the available
> g-ranges keeping the precision of 13 digits.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.
(I'm doing these 1 at a time as it's been a long day so I might
wuss out on anything that is hard and come back to it later!)


