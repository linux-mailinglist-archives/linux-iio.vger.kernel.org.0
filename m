Return-Path: <linux-iio+bounces-8193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC6946970
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A059281D1A
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B314C5A1;
	Sat,  3 Aug 2024 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op8Vu+pE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871A4A2F;
	Sat,  3 Aug 2024 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683969; cv=none; b=smVrD1SNN5/B8lqt2xgDVVd+J4iOVl1Z5R3EXi/jdrRqUGDUWkx22V+jUDGb3oL8N8+6O4JU7lAkz2uY88bnnP8eyvOCy5jGB6XykIKujdwRZe1uhjt2InxXKliy56TrQoXbPbG1JgxC5ocLUt+WtPkuqLoNDL5rg4s/81FYNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683969; c=relaxed/simple;
	bh=lOyA1wRVsmt7cpKCQc6GLcc736lzfvw7xmQM/TV67KU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxwgs6bbClHb8ta5ituOvBp/UcA9uL/A2VhyQ2ALZql03zlcZ36lLpNTsVNTzqj/lUg2F4itrW+XGePFa1wXCVUufUa/yVCI+pNYCpNwI/YyiIqMlnXqQAZXCeeIpPj1nE8WNP7R44eT+t65lEXo+fqnhR3qEV+q1Zrmf2tFtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op8Vu+pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB12EC116B1;
	Sat,  3 Aug 2024 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722683968;
	bh=lOyA1wRVsmt7cpKCQc6GLcc736lzfvw7xmQM/TV67KU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Op8Vu+pEMuPnpuXP1QywYP78/2rnl2voJhIQM5KwJBAozUtkLWv2wv/3xYhLdZxDX
	 x1YuL9YPad9W2MLRuDOdHfE/UdLTe+SMJ6TzAqsOtAHdW/b8lyo5bC8A/F7vaIIwAy
	 v4Ln+OemHGKxMmf1j+vex7X+7ywuMZXU/dJjPAJZqFLuOVZBRboXtek9w17OZ120H0
	 ls2MNR1Pf3ColRuCZFeFd/hFX5LVH8/20tgEsqBGd6K6xdah7B55uEgApfygg4XTOg
	 hDo0E0AvlOsLO0k8FEm3RES12oOZHJmsrUYGJbeK+hjZc8iPHJjVURHCQ6yVKnora4
	 ESZD1t27qClig==
Date: Sat, 3 Aug 2024 12:19:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Joel Stanley <joel@jms.id.au>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: aspeed: Use of_property_present()
Message-ID: <20240803121920.19ab9947@jic23-huawei>
In-Reply-To: <3770677daec27d5cfa9c952ba03a77875bc24b56.camel@codeconstruct.com.au>
References: <20240731191312.1710417-5-robh@kernel.org>
	<3770677daec27d5cfa9c952ba03a77875bc24b56.camel@codeconstruct.com.au>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Aug 2024 11:13:50 +0930
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> On Wed, 2024-07-31 at 13:12 -0600, Rob Herring (Arm) wrote:
> > Use of_property_present() to test for property presence rather than
> > of_find_property(). This is part of a larger effort to remove callers
> > of of_find_property() and similar functions. of_find_property() leaks
> > the DT struct property and data pointers which is a problem for
> > dynamically allocated nodes which may be freed.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>  
> 
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 

Applied.

