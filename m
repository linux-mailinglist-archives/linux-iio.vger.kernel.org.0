Return-Path: <linux-iio+bounces-16415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF1A4FF15
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823017A6D2B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F9245029;
	Wed,  5 Mar 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQDM+46I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AF1EDA26;
	Wed,  5 Mar 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179383; cv=none; b=lBsNN58kBBsYnWwO9LI/uAiNHUHAoofEBG/ru5bN3Ok+HTwBed/vKCTKRWOtPftun1DgnVw4dMb8m+tv4wLsIvkV5syIatPhbebqrkRB2J9p2WeXeCHNpktfkA9QgFiH9ctJjc6pcIjU8c9W6f+BL28v5Afr6vjjvJsMqRAOLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179383; c=relaxed/simple;
	bh=qc1K/kIkRfZuvwIsAOsONSpdl4JDXrZ3Wf6+6uyvkFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0QczLbO8Zzydmgx9xnW/+26Jf/R+uzr+dhjN05y6MMFvNlaD1sym96Z3Fw5pfpeq53BZ4+l9/mzth8t1vB/wHXNB2yD69GHnld5lxrAyCFRFUniyd9iP8kYZJYeKTgN/29YBoCZXgqnGWPnkzPEIHUDuDu1iyL0Y410XFJcFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQDM+46I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76EAC4CEE2;
	Wed,  5 Mar 2025 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179382;
	bh=qc1K/kIkRfZuvwIsAOsONSpdl4JDXrZ3Wf6+6uyvkFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQDM+46I/jHwoZwUfheBotBKs8XkqR0ggvH9aYun6dbBltHA22JpEcc3sT6F/qNtk
	 Qv6eugZoNWmEqMbw9H+2hMUmlnxSbkJkRJ8JdiZ9cbf4kBKrjz6prB6hiloT3JRn6a
	 xXOKXh68BUbJXfuq6BKPphFJlVqqPcxqM3wwSd00VFkf+RFsdkA3hl3yiStiMgOOx7
	 hbXwbXMGykEfVWWyN2n1KZaZcvr7FSUny2r8JTjzVqrvR9gJFFisgMd6rZfwuHtUkV
	 tNXtrn+n7HEyjp1i9d02e/Hn9eKvRKrNK2GZF/Gj7PsreV/XvD4EDQbx1mKjLvU5ws
	 nrcNSehec1/Zg==
Date: Wed, 5 Mar 2025 12:56:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: Mark iio_dev as const in getter methods
Message-ID: <20250305125612.28ac7bc9@jic23-huawei>
In-Reply-To: <20250303-b4-iio-dev-const-v1-1-c2d9d5fe5ac1@analog.com>
References: <20250303-b4-iio-dev-const-v1-1-c2d9d5fe5ac1@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 15:46:25 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> get_current_scan_type read-only method allows to support multiple
> scan types per channel, which may also depend on a buffer enabled state.
> Mark iio_dev as const in iio_device_id, iio_device_get_current_mode,
> iio_buffer_enabled read-only methods so they can be used from other
> read-only methods.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Hi Jorge,

I'm not against this, but I would like to see this patch as part of
a series that uses it from a read-only method.

Until then this looks like noise unless there is other reasoning.

Thanks,

Jonathan


