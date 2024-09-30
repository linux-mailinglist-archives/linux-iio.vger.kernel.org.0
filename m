Return-Path: <linux-iio+bounces-9946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E520C98AE56
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 22:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E91F21C22
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFABE1A3031;
	Mon, 30 Sep 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhQ+EhbS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2271A2C24;
	Mon, 30 Sep 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728004; cv=none; b=nUxExZG8zsTfit0PfgXrOtWm1+jxWs2+bXBa0piw5ZN6pilCTQj4orDBKeJHqAvMyUVN/muDWV7SzNPQ+w+PKoaQ/9xbOvr6um7w0AIDcEBl2bK98jZMig5qRLOf3R+oxRfdLXRW/vW4Rkuca1iz99l7/60E9G+suqTUVUtLPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728004; c=relaxed/simple;
	bh=cXlzay4p9yMzheiuw6KEtHfvbSVT+BuK1H52mSanMng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn5C8wjux3iLBcVHyUTPLR16m4fzMLIdJWze4Gi9qYdf5PBG2GkUH6XK0srCL5aWv6LDGJW4zwPBgY9JGNAibIw3vhVzmzuGMxa5MAXRoVTExKmSynf0+0c5tXEEt8zeJLv9pgG822KH3+q7qN6gOu+I7mu7kk7TAxXxtuup+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhQ+EhbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAB6C4CEC7;
	Mon, 30 Sep 2024 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727728004;
	bh=cXlzay4p9yMzheiuw6KEtHfvbSVT+BuK1H52mSanMng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhQ+EhbS7lrFU7KmJABqKLByY7s2wlPAjoUhF4/JqrYOXpgDV5wmKmh0E8TbJzzUs
	 fLh9EZfmqC8gYnKkv2kNOvepWxD519zwtEz6pVq2+76t5D1/+32NAfvPimVUuBkwlp
	 wapq9GcG+8dWcemaTci+9+IDBb4vo1LoV0C6eXSIcGOPK+7BsJrglUxbvEAWojJEWH
	 z2JDx0BeKhVZMOd5ZmaDkLztQbsrOMIPeyA4K/Yt4xlcCF9AW+tTMti83rdvj/mKwv
	 iVhoXibunw5JIL5JPxGZNxhNP0lfxxubSFDIgk8oJ3MFb9R24lzfGqpTGrGcl7SVWr
	 98Enef0YcLz8A==
Date: Mon, 30 Sep 2024 13:26:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: David Binderman <dcb314@hotmail.com>,
	"jagathjog1996@gmail.com" <jagathjog1996@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
Message-ID: <20240930202642.GA1497385@thelio-3990X>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
 <20240930151542.GA3556370@thelio-3990X>
 <0342111e-47f7-4981-a1f1-e694392fa741@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0342111e-47f7-4981-a1f1-e694392fa741@gmail.com>

Hi Javier,

On Mon, Sep 30, 2024 at 06:50:14PM +0200, Javier Carrasco wrote:
> But if that wasn't the case, and since you can't use sizeof(<type>),
> should it be marked with __maybe_unused / __attribute__((unused)) even
> though it's known in advance that it won't be used, or at least that its
> use will be to get its size?

Correct.

> Is it then just to silence the warning, or does it have other
> implications? Thanks again!

Yes, the use of the unused attribute would just be to silence the
warning; the variable would still not be emitted in the final binary.
clang's behavior matches GCC's (aside from the special warning):

https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute

If the variable needed to be emitted in the object file,
__attribute__((used)) would need to be used, which explicitly has code
generation implications:

https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-used-variable-attribute

A contrived example:

https://godbolt.org/z/oGGbqK98o

Cheers,
Nathan

