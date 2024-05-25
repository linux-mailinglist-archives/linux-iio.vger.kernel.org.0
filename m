Return-Path: <linux-iio+bounces-5295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7058CF03D
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3EFB20FA2
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007EB86266;
	Sat, 25 May 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0NwvLr1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524385C77
	for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655981; cv=none; b=ghlrO3Vpi/ZZ5/963pcXtXxigbLDQjbibNi51r0foN/VlAbEtfFJIpyeOm9nIEt7ViXo+tps5ULtAV4NnQJbkPcWs2FGcUtBfhO7jzQ9tBuCC2PC5G3dZ3RAodvRGTfDSkC1nk1dXG26p++l85usSULoRfqQzYBxEqfECK4Milc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655981; c=relaxed/simple;
	bh=nCc+ZgKdq2Xkd7sSap+EgUmnoWspKqKkcZrDDjvie9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcQtnjjlb5kZwTV3exv6xJDulBIImCmkm+RwMifdyJ0hvg22mO/QaCowtEeqki03KSwov+DCiSB86PKF+qbCdU2igEEg9gMpXSTWIc0T/ZU+bp+lq1FwSQC0MOaf9N02C2SQ6L4szdO8qeOw0CxgQfaWN0dBmjvILxEWnxtrv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0NwvLr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB27C2BD11;
	Sat, 25 May 2024 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716655981;
	bh=nCc+ZgKdq2Xkd7sSap+EgUmnoWspKqKkcZrDDjvie9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j0NwvLr1Jf89lAXPMbsTHdAEsQFlPZuhjupWhyV5vMv5SUWjW9bXAGOWKk8d3cUkb
	 Ox1wYoNiuRJPBrYBYnUkRjDNN5H94QvwTlBGqsAxhveocJghqcACmOLDAAkucWXwhe
	 hyYWlZXyf1OI58hFhYfKAyXLkqz0nD5tlzwH+tpFHIWGp/IJrPIk4rKtqdVA7A7AUR
	 jfBACVdwDbxsoiv4Cz0yPp+7MD+w9FTCfLlyaH9eHQ/DU0T7QLxrNfEPrYrat002PA
	 KC7PnyZJGT5EjG4rnrHpQ2J5Tat+YFoBOx58eXUnk254+XeaXIBbGLFgeiEQpzFh78
	 iE/ELMc+CvPyw==
Date: Sat, 25 May 2024 17:52:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: add support of accel
 low-power mode
Message-ID: <20240525175250.0d066be2@jic23-huawei>
In-Reply-To: <20240517170933.471347-1-inv.git-commit@tdk.com>
References: <20240517170933.471347-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 17:09:33 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste,

I'm replying mostly so I don't forget the status of this series.
Discussion carried on in the v1 posting thread and we have ended up
with a different approach.

See
https://lore.kernel.org/linux-iio/20240525170711.30b32904@jic23-huawei/


