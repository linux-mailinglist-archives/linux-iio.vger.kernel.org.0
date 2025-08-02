Return-Path: <linux-iio+bounces-22192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06414B18E42
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFDBAA4A79
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2020221F39;
	Sat,  2 Aug 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMX+YtaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05A8836;
	Sat,  2 Aug 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135262; cv=none; b=cxhHVVmUZWqZovez2+dmKbe1zA+T8t6LsSShqBPH+G/oV8fVFVGcOPYPlxUoEynETybYVBRw/9P+/WJu4FrkN2Y+UYiXIjAcgiL98kkyEmXT+9PAbQqDHenbjnVx+H13x+zx+RH5vDRldWdQ2/rdmBpL6TsM7jlJk/LbnBMWTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135262; c=relaxed/simple;
	bh=zzzAQPMwO9BR1TtOxPqsjQ7wprn272j86+HwfenD4Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBxee+aoux85rDeFD88QxwH4sgKTctd3KoOAsFQ9KvY57gnp+B+urD1HuQuEsLAERYNq7Cv+44PHTqDb6NE2fE+EYd3aZtj2nKgaNFYcST092SJmUuiz6+gtiMIZyNE+9YLstcyLWPaJ4mt5nbP7ATEeyIwUi2jNfG4o4I7qtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMX+YtaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7B2C4CEEF;
	Sat,  2 Aug 2025 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754135262;
	bh=zzzAQPMwO9BR1TtOxPqsjQ7wprn272j86+HwfenD4Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMX+YtaYfj6FbNCorVBF/oaqrAvDOa5UT+ebBqOMSOdn5wsG06sFUfOgDZB6qWnbW
	 BpyODTesLOUmYzjyuMp4ng+gj02AIbk22llZEj9ewZU7F+341oU7jnJZZIvEmewqJm
	 eKMvlHO1LbUjF3kW5tJneL7A857vFf+aOL4GppNgWFbCZT3SxPEpScbKK3uxqmMj19
	 eMKrTjyi7WRz16qlFi+uRaGSwl6mnhPw/mF73vYgvzlbQNJ46bY/3ujArh50FqdOVI
	 c0H4f3EXob3rdIgBdve+h5ohQ6WE05ZWQ1xgROkj+51G7RufyeLFMVFBkmOWTqhTXl
	 gApAVtzSYd/tQ==
Date: Sat, 2 Aug 2025 12:47:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v12 0/7] iio: accel: adxl345: add interrupt based sensor
 events
Message-ID: <20250802124732.1cd4c5ce@jic23-huawei>
In-Reply-To: <20250727210014.27766-1-l.rubusch@gmail.com>
References: <20250727210014.27766-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 21:00:07 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add several interrupt based sensor detection events:
> - refactoring and fixes
> - activity/inactivity linked and auto-sleep
> - AC-coupled activity/inactivity
> - Extend inactivity for inactivity under 1s (using free-fall register)
> - documentation
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Applied to the testing branch of iio.git.  I'll rebase on rc1 once
available.

Thanks,

Jonathan

