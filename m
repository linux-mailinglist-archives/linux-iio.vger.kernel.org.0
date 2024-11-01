Return-Path: <linux-iio+bounces-11817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5889B991F
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 21:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522C0B212A3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EE1D279D;
	Fri,  1 Nov 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HtK6sa/+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CFC1ABEA1;
	Fri,  1 Nov 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491500; cv=none; b=qCmGaV+I3Mw0tthC2/paEoSBtjoHGoEYF3sdoFE9F3eup+P3oja8kGTMtUA/z5u2WisAmK7qsVN6vXhOqg61B77kbxc5kIxHKJwPRrfH7t2yHKB45H/+L8yNIZW6xAyJFZhlwTqz5CxaoavBEufdcTlTQwihh9T2UsKPNtVk0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491500; c=relaxed/simple;
	bh=TDCz2IFyobauErgroV0/Ct6uaoVY6H3RhijYY6znx84=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BMpIW1zzJ72sLR41hH3mYsGCw4TPSk8b6RgZD3ZsuIiqO9FDv+PI2rp/SjZZO75zt9YOza3fATInW4KvBHoPQoYBWXwydUdHujOYcZasNawciC88Fv4vuOnNoXuD/wygYXKZU10J1vrCa1SynRqAWeTsoQVEIGNVFhyd9EXQSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HtK6sa/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C46C4CECD;
	Fri,  1 Nov 2024 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730491500;
	bh=TDCz2IFyobauErgroV0/Ct6uaoVY6H3RhijYY6znx84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HtK6sa/+rv/hAdROZskaw/aCM+Hqs/O6wfw6N6Yvdq/IfPS3cMRJzRpZRpTGCdljj
	 ob2gy6JbKjN2I8kCcbWY7nGWS9GNzotB5NyMpGcLrfbu7ZX+7jiuqdIUpxTNZBUXeC
	 p5ca1DBKhAL4/hvfT6tumQ7UoysVpoO8zoUHved0=
Date: Fri, 1 Nov 2024 13:04:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, bartosz.golaszewski@linaro.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] util_macros.h: fix/rework find_closest() macros
Message-Id: <20241101130459.eb29f2ded5da3c4c850cc577@linux-foundation.org>
In-Reply-To: <CA+GgBR_tCVVo75+eOxtxEtFdCMkAWFiHjm8eAfPYt+sLBGjBFw@mail.gmail.com>
References: <20241031063707.795842-1-aardelean@baylibre.com>
	<20241031185906.064d733825c176addd48a733@linux-foundation.org>
	<CA+GgBR_tCVVo75+eOxtxEtFdCMkAWFiHjm8eAfPYt+sLBGjBFw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 11:07:04 +0200 Alexandru Ardelean <aardelean@baylibre.com> wrote:

> I can also do a V2.

That would be best, thanks.  

