Return-Path: <linux-iio+bounces-9093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7C696A73E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1923C1C214A6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11BA18FDCD;
	Tue,  3 Sep 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gabIxTUr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A64187561;
	Tue,  3 Sep 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391172; cv=none; b=BFfVmGfskDFOhMtWKp5Aw7VGKmwzO3gfEyvNlN1zAe4HQUuWcKzZ5FaYaFS3aAjRZTzgxiC3P8ppZJXs+HqKFY3pobf4XAxvi3ISJkvOIEvzubPCdntoeBlqOsB5cqoz6eqXN1d4lnv+aZmmIlybKVndEdn18PpkbulFGrA0CX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391172; c=relaxed/simple;
	bh=w05jtlmMkmyuyKKCUzlnQSurItAbXL57AbL7nn1XkWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgRQ+QgzQR8Eowe/uaVPn/pCd4fs19L3c7jezcwvFmcTKBHfSXzegLhQDiGc7SCHhr3Ok1VIhcfJkGoko7V7e1eTCuMyUZutAQRwtB/f6xrB7dELXn2aMOYozTi2gY8vAichbHPOoPL+WZhGhNINmw1SDTSf6PFifEOJhJwCfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gabIxTUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E696C4CEC4;
	Tue,  3 Sep 2024 19:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391171;
	bh=w05jtlmMkmyuyKKCUzlnQSurItAbXL57AbL7nn1XkWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gabIxTUrP+RBEu6qwpZOun2bJ5bGV4AWQLyJNQ+Zmqh/onHB2/sc3yx7cLS1QO8P6
	 m7q2/ErzmMPJtDbeeiKNQoRRkqmNGbIch/J265HRAero9K75E/uZ6iMEvDjSpjEMiq
	 XHlHPsEuqAmLEnwZWXgJuTzj4zMKo8ndL0TItJo66ireNKCqSD0NID0isEEH5htgcN
	 7IGBDbYEFC0p9GgQn/AqGzpyin34i206TZPg8kWkfkDb0I9k/Fy2ZzOzgBl/4Y+EYm
	 F5KMdII/DbWMISOxcJLOfsohLI0EPBDm2/tgeahOwacHhnw4b72cg5Ah6FKkE2vv7q
	 Es3/ne7DOKTOQ==
Date: Tue, 3 Sep 2024 20:19:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
Message-ID: <20240903201921.3406ee65@jic23-huawei>
In-Reply-To: <b305c86a-1dab-41ef-ad04-49526389dd97@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-5-b6da6015327a@baylibre.com>
	<20240831124847.5c679e55@jic23-huawei>
	<b305c86a-1dab-41ef-ad04-49526389dd97@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 18:15:43 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 31/08/24 1:48 PM, Jonathan Cameron wrote:
> > On Thu, 29 Aug 2024 14:32:03 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >  
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> >> is removed. Variables (arrays) that was used to call ad3552r_field_prep
> >> are removerd too.  
> > removed  
> fixed thanks.

For future reference, don't bother reply if you accept everything.
Just adds noise on the list.

My assumption is that you accept anything you 'don't' reply to ;)

Jonathan

> >
> > LGTM  
> 
> Regards,
> Angelo
> 


