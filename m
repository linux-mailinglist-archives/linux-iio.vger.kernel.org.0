Return-Path: <linux-iio+bounces-9283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73B9702D0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763441F225E0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE615DBDD;
	Sat,  7 Sep 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUo05fSQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B828FC;
	Sat,  7 Sep 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725720621; cv=none; b=pKUZY+DradkwdWseKse4oOpnKpEvub11Q8ceo4cARjgyg5f+ezqamXkJJDI91Sg4olMKDudc4MxBAepb8ZhTZfhVbCdGJMKOfexsEVqzR8wTAjWsN48lBPwXhzwjS+0EVtQHElLG7WAZoTCETpbVxA6Fs55EVPF7bBJem6uRV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725720621; c=relaxed/simple;
	bh=D9LKBED8nFxxp/zFuU3ZPegohgW7em+VxTBYnkLTcr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7wFgAmNRduL+RXljrkNtj5wXrvihdRibuuFd08yp4nhlXDCpmSitKThQkrdMJx7YGt4wMeJrKPD6+shWzrgrsjJTwuZd1nGO16JBf26+rSyPJ19oUjTuZrnUjFYLZZclFavk/XtQAPKxKubEbZhC+4L3W2F4RAf88a+OOAKTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUo05fSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FBAC4CEC2;
	Sat,  7 Sep 2024 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725720621;
	bh=D9LKBED8nFxxp/zFuU3ZPegohgW7em+VxTBYnkLTcr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUo05fSQ9Oke/loC0abAk0esBzGTmaVcpZ95KyydbPFLDHx4nDmfWtAIcWEpp2wAH
	 6L7sC4Tvq5Ig0pbrTrvCQumuyDdYL55NnxIc3hngpm9qTZKx+hMaBd7cAL0zqO8C1f
	 VZiZXOftrFurUJF+LyBO89zBZwHS1glY1fAMMOecJieDjkT27JAgBUS1YyKaAGjTM/
	 ovr0AiJiCMwSSkwnCgFm6SQw0pdleu0rI1Y4lPDo+KwJgqDulPqYa5jU4J6x1x8TQh
	 FOU6cdfzEpx/VbEavdfVzBIhCgtoP/l3dvfnW7AYs7XumLw1jZW23xuj2ESI2QMpDa
	 PSMVoJji1UNUw==
Date: Sat, 7 Sep 2024 15:50:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v5 0/9] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20240907155012.53766e2a@jic23-huawei>
In-Reply-To: <20240907065043.771364-1-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Sep 2024 09:50:33 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

4 versions in a week is a bit too fast.
I'm very good at ignoring emails but even for me that took a few clicks ;)

Unless it's 'final' tweaks on code that has had lots of review keep the
cadence down 2 or less postings in a week.  On the plus side I thought
I had even more to review than actually true this weekend based on numbers
of emails in the relevant folder :)

Jonathan

