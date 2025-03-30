Return-Path: <linux-iio+bounces-17368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C444A75B65
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD2F1663BF
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563E1CEADB;
	Sun, 30 Mar 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAcUFiOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F139461;
	Sun, 30 Mar 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743355754; cv=none; b=RlgpXGvJ7k1nAITInDID+j0i+jb049klJjd9fh7DTJPMjcx9/npR/4vzK8nJLxoiN9oZILIHbzG78picvgODALEXf2T/0ehx9Aja6caaADQvkkqrlQGvDlDpBDW/qtpcJlXwmjqwNexlR5Q4rNBky4NSV1YMS6DLPoociigmkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743355754; c=relaxed/simple;
	bh=QlfL3EJqXma1dFICSiaC3bpmFC0OBPofZXrzxTwHiIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWN07OeyawgxXh+btHQBAtejG74VegwpT1qLpP8UjxKArDF0iDPuEpTowy2dzjvbZ2PgB2CpNIOMwA+LMqH0B49u0/myTfSqT7sbXn/6bowIsQGdqQztv806XcKtXhMpITqqv4vibzVC/IdBftNpE8tYW706lcKw19UtdBTScDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAcUFiOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733A1C4CEDD;
	Sun, 30 Mar 2025 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743355754;
	bh=QlfL3EJqXma1dFICSiaC3bpmFC0OBPofZXrzxTwHiIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sAcUFiObsGSpx6qhCetYoU9OCu6Q7gZafPHcPzhRbtrGAE2H+7dWiOTPYJe3KA0WD
	 /vqPeuM47Wjue5tmAz28kRy01ytZfD/fdfkMNKDw258gy8pGbQMIoWSP0X0KCcZlfz
	 T3Wd7V4rnGdl2nsAG9PhFECNHPSjHqkiT2ZAlh2TeIZYNg6zGsfm+U7y5yMBb6mrBY
	 VFUnRt3lh6gD1/xB9wPM64BLncg4dFfhG+CtZQQMh4Y9a0KnqBgMHtqQtrVeQTjwWF
	 z+hQ2HsZAeKqYCY4jcHZKGmS4mG/1Jbh0GgK6kQfwrqx48ZXvRetRrW6fTJJ5ktkwD
	 1dU3QyVpci2Lg==
Date: Sun, 30 Mar 2025 18:29:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] iio: light: al3010: Abstract device reference
 in the probe function
Message-ID: <20250330182906.122aba0c@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-5-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-5-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:44 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Introduce a local variable reducing redundancy and improving readability.
> 
> No functional changes.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
Applied 5-6

