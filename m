Return-Path: <linux-iio+bounces-2214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C681D84A4E4
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 21:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84EF1C24F9B
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 20:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0216D538;
	Mon,  5 Feb 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUT5Fz/x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4F16CEA7;
	Mon,  5 Feb 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159843; cv=none; b=GpUA4v5iclaUHtlxWXkQvOXsWW+jtKuFdqEz/lJ2a9G7BhWW2xztB4/n9a6xdObTP2FOWiKHWO3QCsAyxeShLewBFP/R+FeAHuLJS/kqdAyWezDL0RpGswdCX01bKweyHBCvkE7YXBKrBGpJbtGyBRhqjqcmfx8zZQ93WgKv+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159843; c=relaxed/simple;
	bh=JHJpfUqaJyRZ4AI78rBIr1ZJeKJ3VKOnvFJCzFqVgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAVR2nnCaKsNd+o9MAMFDXba5Crr5J1UiMCqbAxcQC+Tkc7vjHwqukv22e7ARkH7COEBIkNH3ASIHMhUgjRQDAmACN6hDY3JGkPNRlINgzTfgj2yRjcJkOAKdIwXh6lYunc7hBwjfu0yCWFM5CDyY5Rn92HU/YjKqKcCsY9l0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUT5Fz/x reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C89C32778;
	Mon,  5 Feb 2024 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159843;
	bh=JHJpfUqaJyRZ4AI78rBIr1ZJeKJ3VKOnvFJCzFqVgZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUT5Fz/xP80MfMbvWo028JaSgiJ51PMbr3tDmKxMrk23EvBVssm2YntZkIX2Cl+GT
	 Tc89Ue8L/BD3BI25JAkoHeHQokmxlCUOSJw/XHykKVmh5asrhgu9DmzENzjpprHUc/
	 1DBcR+0LxfKM00OKJHgXbskQHOgxM96mEXjFZga8=
Date: Mon, 5 Feb 2024 04:50:47 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: make counter_bus_type const
Message-ID: <2024020541-reveler-urgency-30a0@gregkh>
References: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>

On Sun, Feb 04, 2024 at 01:02:30PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the counter_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

