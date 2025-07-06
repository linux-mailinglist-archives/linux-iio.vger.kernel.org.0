Return-Path: <linux-iio+bounces-21374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966CFAFA40F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BB37AD177
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C61F8EEC;
	Sun,  6 Jul 2025 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDtEi4o+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBC2940D;
	Sun,  6 Jul 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751794637; cv=none; b=ihCIQGzsYtUOKUHsGbhQRhDewZMMdZGzFLbHQkdJLYJIbCckcpB+peUVRWVq2pzzdQvfWHJ6wRUsF79iRWOdskLStJsae1IyPo25lkNcgIEA+Ss5dVW/pWjVIFsMJoPfrN2i74/8FRGxbnCRrE2vVqBg6x0X35zZe4Y14LIM13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751794637; c=relaxed/simple;
	bh=Z80WypLVm0mkUvSjn/B1ni17b+YA55+YdZRkkt3U0i0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azjk7L5jm4WulHGWV+L2Fh4ycYniQIAeb75t8wc/+Bb/khXIo89Vv+eoZLGEsOArIRZZA/5+lv0oHz0Nt+MJYY/fzFmQf8evgTtCpndsOqpcKXmFbo0MUtLrhW/wGmfQDL5RUOU2wCyOYjvz6xhfCWUTuSfB8KCJhy1hiu/Ha/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDtEi4o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345B5C4CEED;
	Sun,  6 Jul 2025 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751794636;
	bh=Z80WypLVm0mkUvSjn/B1ni17b+YA55+YdZRkkt3U0i0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDtEi4o+hCd2Z3XtXwHjWBxvSZlEPgugCXcOHVdPkmQ6P5Qi/N23pfT24n32f7F+a
	 mIK6laxm6VMHoiW4+4eHmBXLsKf5I8uc/sBwWhNuUiSiIrGbzl72n7lKSy87Qs4V29
	 NxewsWZRmx+EIDfj54JcjnmDNOeekT/xmTXLc/kjVCnPr8WGiWS1J4g5wxDzV95tGp
	 ZDKQmqx9xokwn6+Ft5CM3Ml9gP/N7bgmwZe67/n2+VcLWLnpf51VqVZIqIzzN6D5N7
	 4MKiDqBTUclVz4M+soiVrJXgfzCTsziyRcCZyhsMomrR6J3AdD2yLzXqLfWEU+65dy
	 46E1kjKmyp7Yw==
Date: Sun, 6 Jul 2025 10:37:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio: accel: sca3000: use lock guards
Message-ID: <20250706103708.65de7569@jic23-huawei>
In-Reply-To: <CANZih_Tm2w5C58tg36LzEMoLrqWgSGaJZQ_nxoDVUXFMJnZBXQ@mail.gmail.com>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
	<20250618031638.26477-4-andrew.lopes@alumni.usp.br>
	<20250621185550.64aebefa@jic23-huawei>
	<CANZih_Tm2w5C58tg36LzEMoLrqWgSGaJZQ_nxoDVUXFMJnZBXQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > -     ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> > > +     return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,  
> > This adds a character to this line which means that either the indent of
> > the following lines was previously wrong, or it is now.
> > I think you need to add a space to the following lines.
> >
> > Check for other similar cases.
> >  
> > >                               ret &
> > >                               ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> > >                                 SCA3000_REG_INT_MASK_RING_HALF |
> > >                                 SCA3000_REG_INT_MASK_ALL_INTS));  
> 
> Hm, correct me if I'm mistaken but I couldn't find this extra
> character, I used the same number of tabs in both cases. Even in this
> email it shows as having the same number of white spaces.
return sca3000_write_reg(
is one character longer than 
ret = sca3000_write_reg(
and seeing as parameters on later lines should align just after this they all
need one additional space.

> 
> Thanks,
> Andrew


