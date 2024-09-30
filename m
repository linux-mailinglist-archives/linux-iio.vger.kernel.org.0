Return-Path: <linux-iio+bounces-9939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4398A848
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 17:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF78B28388C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCA13634C;
	Mon, 30 Sep 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGJvZJHK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58059EDE;
	Mon, 30 Sep 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709345; cv=none; b=oNAh/PLusAhwUBRk0P77JW/Eds+VphUJ+lI4KL3OHPT3uYCjw0pWKaWM1ArY8GI047pIXSmmLB4p/RVBHZAV7Z0ljDWtcHnqp+Sfft56CrSldIRJtIjO1/OrdobjalRkiss+WULCK3UVCizdDMstBtU5pwHpyX+XRPApgX+fwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709345; c=relaxed/simple;
	bh=w0yyS20q2TVjxg8+kExHK47R1q2HMjXRO09zKbEDNck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h42op26edJiOu4UkDJpfr+FccYV4xn8PPyZn5kMHglJk3Ycjhzk+zBIMxH2QNNMGtzr/SQ7Lpi1uSqm/mk3dmucHtqVz/m7d9BI8OD9USOIQiRw+dgIqch8kMFjw68H/N1y9OIxnw0Xdle7bipoehxcQcCRiq80FEju/yxHChxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGJvZJHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5ACC4CEC7;
	Mon, 30 Sep 2024 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727709344;
	bh=w0yyS20q2TVjxg8+kExHK47R1q2HMjXRO09zKbEDNck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGJvZJHK45fB4P8YCvVWw+LaTPUlx5PCliGBqncwxF54xI77tPU5IgX5mjqrI4VeI
	 K1MPz/Gkgu+0JZNx44ONB9aDCm9ldVu2Ps7YlL57cwWpljMHkWj/ke406OEIpEhF8i
	 R4g02fdB0hG27Kz5knJHb9fYIPdSIQFzdhrFVDXo9fjfH8ITwMeVlo0Jl+/QXnybOZ
	 tzLvBkPu/9rRJVPmhgFa2/eQHKYrUwbA5N7u+KkzHze+ZI4fvSSifLoXMzZ+oCuVdw
	 we9HcvFW+Vifki8vlspLVrZZamfi8RfdRkyj2C1C4y7SFRvkquppjxOaYJgszWqCNj
	 OKNWGSysCzOpg==
Date: Mon, 30 Sep 2024 08:15:42 -0700
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
Message-ID: <20240930151542.GA3556370@thelio-3990X>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>

On Mon, Sep 30, 2024 at 03:58:06PM +0200, Javier Carrasco wrote:
> On 30/09/2024 15:49, David Binderman wrote:
> > Hello there,
> > 
> > I just tried to build linux-6.12-rc1 with clang. It said:
> > 
> > drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
> > 
> > A grep for the identifier shows the following strange results::
> > 
> > inux-6.12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/bmi323_core.c
> > static const unsigned int bmi323_ext_reg_savestate[] = {
> > 	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
> > 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> > 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> > linux-6.12-rc1 $ 
> > 
> > I see no mention of bmi323_ext_reg_savestate[ i]. Is there a possible
> > cut'n'paste error in one of the two for loops ?
> > 
> > Regards
> > 
> > David Binderman
> 
> 
> I think that is a bug in clang:
> 
> https://bugs.llvm.org/show_bug.cgi?id=33068
> 
> That happens because clang sees that bmi323_ext_reg_savestate is not
> used but to gets its size, and that means for it that the variable is
> not needed. That does not happen for example with
> bmi323_ext_reg_savestate (right above bmi323_ext_reg_savestate) because
> that one is used beyond ARRAY_SIZE.
> 
> Safe to ignore?

As later comments in this thread point out, this is a bug in the code:

https://git.kernel.org/jic23/iio/c/506a1ac4c4464a61e4336e135841067dbc040aaa

That bug report is pretty misguided, as that is exactly the type of code
that warning tries to catch: the programmer has a static variable that
is only used in sizeof(), a compile time evaluation, so they won't get a
-Wunused-variable since it is used in that expression, but did they
intend to use it elsewhere? If they didn't, they can just slap
'__maybe_unused' / '__attribute__((unused))' on it or use
sizeof(<type>), which removes all ambiguity. Otherwise, the code should
be fixed, like in this case.

Cheers,
Nathan

